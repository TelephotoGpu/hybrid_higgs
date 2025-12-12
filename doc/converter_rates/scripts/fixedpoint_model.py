#!/usr/bin/env python3
import math
from pathlib import Path
from typing import List, Sequence, Tuple

try:
    from decode import decode_coeff_file
except ImportError:
    from .decode import decode_coeff_file

REPO_ROOT = Path(__file__).resolve().parents[3]
DDC_HDL = REPO_ROOT / "libs" / "ip-library" / "downconverter" / "hdl"
DUC_HDL = REPO_ROOT / "libs" / "ip-library" / "upconverter" / "hdl"

WIDTH = 16
COEFF_WIDTH = 18
ROM_WIDTH = 36
ACC_WIDTH = 54

DDC_PAIR_COUNT = 1536
DDC_ACTIVE_START_PAIR = 768
DDC_ACTIVE_PAIRS = 128
DDC_POST_PAIRS = DDC_PAIR_COUNT - DDC_ACTIVE_START_PAIR - DDC_ACTIVE_PAIRS

DUC_SAMPLE_COUNT = 640
DUC_ACTIVE_START = 256
DUC_ACTIVE_COUNT = 96
DUC_POST_COUNT = DUC_SAMPLE_COUNT - DUC_ACTIVE_START - DUC_ACTIVE_COUNT


def mask(width: int) -> int:
    return (1 << width) - 1


def wrap_unsigned(value: int, width: int) -> int:
    return value & mask(width)


def wrap_signed(value: int, width: int) -> int:
    value &= mask(width)
    if value & (1 << (width - 1)):
        value -= 1 << width
    return value


def signed_slice(value: int, total_width: int, hi: int, lo: int) -> int:
    width = hi - lo + 1
    return wrap_signed((wrap_unsigned(value, total_width) >> lo) & mask(width), width)


def unsigned_slice(value: int, total_width: int, hi: int, lo: int) -> int:
    width = hi - lo + 1
    return (wrap_unsigned(value, total_width) >> lo) & mask(width)


def sat_extract_54(value: int, width: int = WIDTH) -> int:
    upper = signed_slice(value, ACC_WIDTH, ACC_WIDTH - 1, width + COEFF_WIDTH - 1)
    if upper > 0:
        return (1 << (width - 1)) - 1
    if upper < -1:
        return -(1 << (width - 1))
    return wrap_signed(unsigned_slice(value, ACC_WIDTH, width + COEFF_WIDTH - 1, COEFF_WIDTH), width)


def concat_delay(delay_value: int, width: int = WIDTH) -> int:
    delay_value = wrap_signed(delay_value, width)
    return wrap_signed((delay_value << 17) + (1 << 16), ACC_WIDTH)


def read_binary_rom(path: Path, width: int = ROM_WIDTH) -> List[Tuple[int, int]]:
    rows: List[Tuple[int, int]] = []
    with path.open() as handle:
        for raw in handle:
            bits = raw.strip()
            if not bits:
                continue
            if any(ch not in "01" for ch in bits):
                continue
            if len(bits) != 2 * width:
                raise ValueError(f"Unexpected ROM width in {path}: {len(bits)}")
            sine_bits = int(bits[:width], 2)
            cosine_bits = int(bits[width:], 2)
            rows.append((wrap_signed(sine_bits, width), wrap_signed(cosine_bits, width)))
    return rows


def int16_clip(value: int) -> int:
    return max(-(1 << 15), min((1 << 15) - 1, value))


def int16_to_hex(value: int) -> str:
    return f"{wrap_unsigned(value, 16):04x}"


class FixedDDSX2:
    def __init__(self, rom: Sequence[Tuple[int, int]]):
        self.rom = list(rom)
        self.phase_accum = 0
        self.phase_accum_delay = 1
        self.sincos_reg0 = (0, 0)
        self.sincos_delay_reg0 = (0, 0)
        self.cosine_reg1 = 0
        self.sine_reg1 = 0
        self.cosine_delay_reg1 = 0
        self.sine_delay_reg1 = 0
        self.cosine_reg2 = 0
        self.sine_reg2 = 0
        self.cosine_delay_reg2 = 0
        self.sine_delay_reg2 = 0
        self.o_cosine_data = 0
        self.o_sine_data = 0
        self.o_cosine_delay_data = 0
        self.o_sine_delay_data = 0

    def tick(self, i_ready: int) -> None:
        old_phase = self.phase_accum
        old_phase_delay = self.phase_accum_delay
        old_sincos = self.sincos_reg0
        old_sincos_delay = self.sincos_delay_reg0
        old_cos1 = self.cosine_reg1
        old_sin1 = self.sine_reg1
        old_cosd1 = self.cosine_delay_reg1
        old_sind1 = self.sine_delay_reg1
        old_cos2 = self.cosine_reg2
        old_sin2 = self.sine_reg2
        old_cosd2 = self.cosine_delay_reg2
        old_sind2 = self.sine_delay_reg2

        if i_ready:
            self.sincos_reg0 = self.rom[old_phase]
            self.sincos_delay_reg0 = self.rom[old_phase_delay]
            self.cosine_reg1 = old_sincos[1]
            self.sine_reg1 = old_sincos[0]
            self.cosine_delay_reg1 = old_sincos_delay[1]
            self.sine_delay_reg1 = old_sincos_delay[0]
            self.cosine_reg2 = old_cos1
            self.sine_reg2 = old_sin1
            self.cosine_delay_reg2 = old_cosd1
            self.sine_delay_reg2 = old_sind1
            self.o_cosine_data = old_cos2
            self.o_sine_data = old_sin2
            self.o_cosine_delay_data = old_cosd2
            self.o_sine_delay_data = old_sind2

            if old_phase == len(self.rom) - 2:
                self.phase_accum = 0
            else:
                self.phase_accum = old_phase + 2
            if old_phase_delay == len(self.rom) - 1:
                self.phase_accum_delay = 1
            else:
                self.phase_accum_delay = old_phase_delay + 2


class DucFixedDDS:
    def __init__(self, rom: Sequence[Tuple[int, int]], lut_period: int = 500):
        self.rom = list(rom)
        self.lut_period = lut_period
        self.phase_accum = 0
        self.sincos_reg0 = (0, 0)
        self.cosine_reg1 = 0
        self.sine_reg1 = 0
        self.cosine_reg2 = 0
        self.sine_reg2 = 0
        self.o_cosine_data = 0
        self.o_sine_data = 0

    def tick(self, i_ready: int) -> None:
        old_phase = self.phase_accum
        old_sincos = self.sincos_reg0
        old_cos1 = self.cosine_reg1
        old_sin1 = self.sine_reg1
        old_cos2 = self.cosine_reg2
        old_sin2 = self.sine_reg2

        if i_ready:
            self.sincos_reg0 = self.rom[old_phase]
            old_sine, old_cosine = old_sincos
            self.cosine_reg1 = old_cosine
            self.sine_reg1 = wrap_signed(-old_sine, ROM_WIDTH)
            self.cosine_reg2 = old_cos1
            self.sine_reg2 = old_sin1
            self.o_cosine_data = old_cos2
            self.o_sine_data = old_sin2
            if old_phase == self.lut_period - 1:
                self.phase_accum = 0
            else:
                self.phase_accum = old_phase + 1


class DdcHalfbandDecimator:
    def __init__(self, coeffs: Sequence[int], first_stage: bool):
        self.coeffs = list(coeffs)
        self.first_stage = first_stage
        self.n_pairs = len(self.coeffs)
        self.delay_regs_len = int(math.log2(self.n_pairs)) + 4
        self.pp_toggle = 0
        self.tdl0_i = [0] * (2 * self.n_pairs)
        self.tdl0_q = [0] * (2 * self.n_pairs)
        self.tdl1_i = [0] * self.n_pairs
        self.tdl1_q = [0] * self.n_pairs
        self.term_i = [0] * (2 * self.n_pairs)
        self.term_q = [0] * (2 * self.n_pairs)
        self.sum_i = [0] * self.n_pairs
        self.sum_q = [0] * self.n_pairs
        self.prod_i = [0] * self.n_pairs
        self.prod_q = [0] * self.n_pairs
        layer_len = self.n_pairs // 2
        self.accum_i: List[List[int]] = []
        self.accum_q: List[List[int]] = []
        while layer_len:
            self.accum_i.append([0] * layer_len)
            self.accum_q.append([0] * layer_len)
            layer_len //= 2
        self.delay_i = [0] * self.delay_regs_len
        self.delay_q = [0] * self.delay_regs_len
        self.valid0 = 0
        self.valid1 = [0] * self.delay_regs_len
        self.valid2 = 0
        self.output_i = 0
        self.output_q = 0
        self.o_inph_data = 0
        self.o_quad_data = 0
        self.o_valid = 0

    def tick(self, i_inph: int, i_quad: int, i_valid: int,
             i_inph_delay: int = 0, i_quad_delay: int = 0) -> None:
        old_pp = self.pp_toggle
        old_tdl0_i = self.tdl0_i[:]
        old_tdl0_q = self.tdl0_q[:]
        old_tdl1_i = self.tdl1_i[:]
        old_tdl1_q = self.tdl1_q[:]
        old_term_i = self.term_i[:]
        old_term_q = self.term_q[:]
        old_sum_i = self.sum_i[:]
        old_sum_q = self.sum_q[:]
        old_prod_i = self.prod_i[:]
        old_prod_q = self.prod_q[:]
        old_accum_i = [layer[:] for layer in self.accum_i]
        old_accum_q = [layer[:] for layer in self.accum_q]
        old_delay_i = self.delay_i[:]
        old_delay_q = self.delay_q[:]
        old_valid0 = self.valid0
        old_valid1 = self.valid1[:]
        old_valid2 = self.valid2
        old_output_i = self.output_i
        old_output_q = self.output_q

        enable0 = bool(i_valid) if self.first_stage else bool(i_valid and old_pp == 0)
        enable1 = bool(i_valid) if self.first_stage else bool(i_valid and old_pp == 1)

        if not self.first_stage and i_valid:
            self.pp_toggle = 1 - old_pp

        if enable0:
            self.tdl0_i = [wrap_signed(i_inph, WIDTH)] + old_tdl0_i[:-1]
            self.tdl0_q = [wrap_signed(i_quad, WIDTH)] + old_tdl0_q[:-1]
        if enable1:
            src_i = wrap_signed(i_inph_delay if self.first_stage else i_inph, WIDTH)
            src_q = wrap_signed(i_quad_delay if self.first_stage else i_quad, WIDTH)
            self.tdl1_i = [src_i] + old_tdl1_i[:-1]
            self.tdl1_q = [src_q] + old_tdl1_q[:-1]
        self.valid0 = int(enable0)

        if enable0:
            self.term_i[0] = wrap_signed(i_inph, WIDTH)
            self.term_q[0] = wrap_signed(i_quad, WIDTH)
        for idx in range(1, 2 * self.n_pairs):
            self.term_i[idx] = old_tdl0_i[idx]
            self.term_q[idx] = old_tdl0_q[idx]
        for idx in range(self.n_pairs):
            lo = idx
            hi = 2 * self.n_pairs - 1 - idx
            self.sum_i[idx] = wrap_signed(old_term_i[lo] + old_term_i[hi], WIDTH + 1)
            self.sum_q[idx] = wrap_signed(old_term_q[lo] + old_term_q[hi], WIDTH + 1)
            self.prod_i[idx] = wrap_signed(self.coeffs[idx] * old_sum_i[idx], COEFF_WIDTH + WIDTH + 1)
            self.prod_q[idx] = wrap_signed(self.coeffs[idx] * old_sum_q[idx], COEFF_WIDTH + WIDTH + 1)

        src_delay_i = old_tdl1_i[self.n_pairs - 1]
        src_delay_q = old_tdl1_q[self.n_pairs - 1]
        self.delay_i = [src_delay_i] + old_delay_i[:-1]
        self.delay_q = [src_delay_q] + old_delay_q[:-1]
        self.valid1 = [old_valid0] + old_valid1[:-1]

        for layer_idx, layer in enumerate(self.accum_i):
            src_i = old_prod_i if layer_idx == 0 else old_accum_i[layer_idx - 1]
            src_q = old_prod_q if layer_idx == 0 else old_accum_q[layer_idx - 1]
            for idx in range(len(layer)):
                self.accum_i[layer_idx][idx] = wrap_signed(src_i[2 * idx] + src_i[2 * idx + 1], ACC_WIDTH)
                self.accum_q[layer_idx][idx] = wrap_signed(src_q[2 * idx] + src_q[2 * idx + 1], ACC_WIDTH)

        total_i = wrap_signed(old_accum_i[-1][0] + concat_delay(old_delay_i[-1]), ACC_WIDTH)
        total_q = wrap_signed(old_accum_q[-1][0] + concat_delay(old_delay_q[-1]), ACC_WIDTH)
        self.output_i = total_i
        self.output_q = total_q
        self.valid2 = old_valid1[-1]

        if old_valid2:
            self.o_inph_data = sat_extract_54(old_output_i)
            self.o_quad_data = sat_extract_54(old_output_q)
        self.o_valid = old_valid2


class DucHalfbandInterpolator:
    def __init__(self, coeffs: Sequence[int]):
        self.coeffs = list(coeffs)
        self.n_pairs = len(self.coeffs)
        self.delay_regs_len = int(math.log2(self.n_pairs)) + 4
        self.downstream_ready = 0
        self.pp_toggle = 0
        self.tdl_i = [0] * (2 * self.n_pairs)
        self.tdl_q = [0] * (2 * self.n_pairs)
        self.term_i = [0] * (2 * self.n_pairs)
        self.term_q = [0] * (2 * self.n_pairs)
        self.sum_i = [0] * self.n_pairs
        self.sum_q = [0] * self.n_pairs
        self.prod_i = [0] * self.n_pairs
        self.prod_q = [0] * self.n_pairs
        layer_len = self.n_pairs // 2
        self.accum_i: List[List[int]] = []
        self.accum_q: List[List[int]] = []
        while layer_len:
            self.accum_i.append([0] * layer_len)
            self.accum_q.append([0] * layer_len)
            layer_len //= 2
        self.delay_i = [0] * self.delay_regs_len
        self.delay_q = [0] * self.delay_regs_len
        self.output_i = 0
        self.output_q = 0
        self.o_inph_data = 0
        self.o_quad_data = 0

    @property
    def o_ready(self) -> int:
        return self.downstream_ready & (1 - self.pp_toggle)

    def tick(self, i_inph: int, i_quad: int, i_ready: int) -> None:
        old_pp = self.pp_toggle
        old_tdl_i = self.tdl_i[:]
        old_tdl_q = self.tdl_q[:]
        old_term_i = self.term_i[:]
        old_term_q = self.term_q[:]
        old_sum_i = self.sum_i[:]
        old_sum_q = self.sum_q[:]
        old_prod_i = self.prod_i[:]
        old_prod_q = self.prod_q[:]
        old_accum_i = [layer[:] for layer in self.accum_i]
        old_accum_q = [layer[:] for layer in self.accum_q]
        old_delay_i = self.delay_i[:]
        old_delay_q = self.delay_q[:]
        old_output_i = self.output_i
        old_output_q = self.output_q

        even_phase = bool(i_ready and old_pp == 0)
        odd_phase = bool(i_ready and old_pp == 1)
        self.downstream_ready = int(bool(i_ready))

        if i_ready:
            self.pp_toggle = 1 - old_pp

        if even_phase:
            self.tdl_i = [wrap_signed(i_inph, WIDTH)] + old_tdl_i[:-1]
            self.tdl_q = [wrap_signed(i_quad, WIDTH)] + old_tdl_q[:-1]

            self.term_i[0] = wrap_signed(i_inph, WIDTH)
            self.term_q[0] = wrap_signed(i_quad, WIDTH)
            for idx in range(1, 2 * self.n_pairs):
                self.term_i[idx] = old_tdl_i[idx]
                self.term_q[idx] = old_tdl_q[idx]
            for idx in range(self.n_pairs):
                lo = idx
                hi = 2 * self.n_pairs - 1 - idx
                self.sum_i[idx] = wrap_signed(old_term_i[lo] + old_term_i[hi], WIDTH + 1)
                self.sum_q[idx] = wrap_signed(old_term_q[lo] + old_term_q[hi], WIDTH + 1)
                self.prod_i[idx] = wrap_signed(self.coeffs[idx] * old_sum_i[idx], COEFF_WIDTH + WIDTH + 1)
                self.prod_q[idx] = wrap_signed(self.coeffs[idx] * old_sum_q[idx], COEFF_WIDTH + WIDTH + 1)

            self.delay_i = [old_tdl_i[self.n_pairs - 1]] + old_delay_i[:-1]
            self.delay_q = [old_tdl_q[self.n_pairs - 1]] + old_delay_q[:-1]

            for layer_idx, layer in enumerate(self.accum_i):
                src_i = old_prod_i if layer_idx == 0 else old_accum_i[layer_idx - 1]
                src_q = old_prod_q if layer_idx == 0 else old_accum_q[layer_idx - 1]
                for idx in range(len(layer)):
                    self.accum_i[layer_idx][idx] = wrap_signed(src_i[2 * idx] + src_i[2 * idx + 1], ACC_WIDTH)
                    self.accum_q[layer_idx][idx] = wrap_signed(src_q[2 * idx] + src_q[2 * idx + 1], ACC_WIDTH)

            self.output_i = old_accum_i[-1][0]
            self.output_q = old_accum_q[-1][0]
            self.o_inph_data = sat_extract_54(concat_delay(old_delay_i[-1]))
            self.o_quad_data = sat_extract_54(concat_delay(old_delay_q[-1]))
        elif odd_phase:
            self.o_inph_data = sat_extract_54(old_output_i)
            self.o_quad_data = sat_extract_54(old_output_q)


class DucSkid:
    ST_START = 0
    ST_IDLE = 1
    ST_PASSTHRU = 2
    ST_HALT = 3

    def __init__(self):
        self.curr_state = self.ST_START
        self.out_data = (0, 0)
        self.skid_data = (0, 0)
        self.o_in_ready = 0

    def tick(self, i_in_data: Tuple[int, int], i_out_ready: int) -> None:
        if self.curr_state == self.ST_IDLE:
            next_out_data = i_in_data
            next_skid_data = (0, 0)
            next_in_ready = 1
            next_state = self.ST_PASSTHRU
        elif self.curr_state == self.ST_PASSTHRU:
            if i_out_ready:
                next_out_data = i_in_data
                next_skid_data = i_in_data
                next_in_ready = 1
                next_state = self.ST_PASSTHRU
            else:
                next_out_data = self.out_data
                next_skid_data = i_in_data
                next_in_ready = 0
                next_state = self.ST_HALT
        elif self.curr_state == self.ST_HALT:
            next_out_data = self.skid_data if i_out_ready else self.out_data
            next_skid_data = self.skid_data
            next_in_ready = int(bool(i_out_ready))
            next_state = self.ST_PASSTHRU if i_out_ready else self.ST_HALT
        else:
            next_out_data = (0, 0)
            next_skid_data = (0, 0)
            next_in_ready = 1
            next_state = self.ST_IDLE

        self.curr_state = next_state
        self.out_data = next_out_data
        self.skid_data = next_skid_data
        self.o_in_ready = next_in_ready


class DownconverterModel:
    def __init__(self, ratio: int = 8):
        if ratio not in (2, 4, 8, 16):
            raise ValueError(f"Unsupported downconverter ratio {ratio}; supported ratios are 2, 4, 8, 16")
        self.ratio = ratio
        rom = read_binary_rom(DDC_HDL / "ddc_sincos.mif")
        self.dds = FixedDDSX2(rom)
        self.stages = [
            DdcHalfbandDecimator(load_coeffs(DDC_HDL / "ddc_hb_decim_firx2_h0.sv"), first_stage=True),
            DdcHalfbandDecimator(load_coeffs(DDC_HDL / "ddc_hb_decim_fir_h1.sv"), first_stage=False),
            DdcHalfbandDecimator(load_coeffs(DDC_HDL / "ddc_hb_decim_fir_h2.sv"), first_stage=False),
            DdcHalfbandDecimator(load_coeffs(DDC_HDL / "ddc_hb_decim_fir_h3.sv"), first_stage=False),
        ][: int(math.log2(ratio))]
        self.inph_data_reg0 = 0
        self.inph_data_delay_reg0 = 0
        self.cosine_reg0 = 0
        self.sine_reg0 = 0
        self.cosine_delay_reg0 = 0
        self.sine_delay_reg0 = 0
        self.valid_reg0 = 0
        self.inph_data_reg1 = 0
        self.quad_data_reg1 = 0
        self.inph_data_delay_reg1 = 0
        self.quad_data_delay_reg1 = 0
        self.valid_reg1 = 0
        self.inph_data_reg2 = 0
        self.quad_data_reg2 = 0
        self.inph_data_delay_reg2 = 0
        self.quad_data_delay_reg2 = 0
        self.valid_reg2 = 0
        self.inph_data_reg3 = 0
        self.quad_data_reg3 = 0
        self.inph_data_delay_reg3 = 0
        self.quad_data_delay_reg3 = 0
        self.valid_reg3 = 0

    def tick(self, i_inph_data: int, i_inph_delay_data: int, i_valid: int) -> List[Tuple[int, int]]:
        old_dds = (
            self.dds.o_cosine_data,
            self.dds.o_sine_data,
            self.dds.o_cosine_delay_data,
            self.dds.o_sine_delay_data,
        )

        self.dds.tick(i_valid)
        stage_inputs = (self.inph_data_reg3, self.quad_data_reg3, self.valid_reg3)
        first_stage_delay = (self.inph_data_delay_reg3, self.quad_data_delay_reg3)
        prior_outputs = [(stage.o_inph_data, stage.o_quad_data, stage.o_valid) for stage in self.stages]
        for idx, stage in enumerate(self.stages):
            if idx == 0:
                stage.tick(stage_inputs[0], stage_inputs[1], stage_inputs[2], first_stage_delay[0], first_stage_delay[1])
            else:
                prev = prior_outputs[idx - 1]
                stage.tick(prev[0], prev[1], prev[2])

        old_reg0_i = self.inph_data_reg0
        old_reg0_id = self.inph_data_delay_reg0
        old_cos0 = self.cosine_reg0
        old_sin0 = self.sine_reg0
        old_cosd0 = self.cosine_delay_reg0
        old_sind0 = self.sine_delay_reg0
        old_valid0 = self.valid_reg0
        old_reg1_i = self.inph_data_reg1
        old_reg1_q = self.quad_data_reg1
        old_reg1_id = self.inph_data_delay_reg1
        old_reg1_qd = self.quad_data_delay_reg1
        old_valid1 = self.valid_reg1
        old_reg2_i = self.inph_data_reg2
        old_reg2_q = self.quad_data_reg2
        old_reg2_id = self.inph_data_delay_reg2
        old_reg2_qd = self.quad_data_delay_reg2
        old_valid2 = self.valid_reg2

        self.inph_data_reg0 = wrap_signed(i_inph_data, WIDTH)
        self.inph_data_delay_reg0 = wrap_signed(i_inph_delay_data, WIDTH)
        self.cosine_reg0 = old_dds[0]
        self.sine_reg0 = old_dds[1]
        self.cosine_delay_reg0 = old_dds[2]
        self.sine_delay_reg0 = old_dds[3]
        self.valid_reg0 = int(bool(i_valid))

        self.inph_data_reg1 = wrap_signed(old_reg0_i * old_cos0, WIDTH + ROM_WIDTH)
        self.quad_data_reg1 = wrap_signed(old_reg0_i * old_sin0, WIDTH + ROM_WIDTH)
        self.inph_data_delay_reg1 = wrap_signed(old_reg0_id * old_cosd0, WIDTH + ROM_WIDTH)
        self.quad_data_delay_reg1 = wrap_signed(old_reg0_id * old_sind0, WIDTH + ROM_WIDTH)
        self.valid_reg1 = old_valid0

        self.inph_data_reg2 = ddc_stage2_round(old_reg1_i)
        self.quad_data_reg2 = ddc_stage2_round(old_reg1_q)
        self.inph_data_delay_reg2 = ddc_stage2_round(old_reg1_id)
        self.quad_data_delay_reg2 = ddc_stage2_round(old_reg1_qd)
        self.valid_reg2 = old_valid1

        self.inph_data_reg3 = ddc_stage3_inph(old_reg2_i)
        self.quad_data_reg3 = ddc_stage3_quad(old_reg2_q)
        self.inph_data_delay_reg3 = ddc_stage3_inph(old_reg2_id)
        self.quad_data_delay_reg3 = ddc_stage3_quad(old_reg2_qd)
        self.valid_reg3 = old_valid2

        outputs: List[Tuple[int, int]] = []
        final_stage = self.stages[-1]
        if final_stage.o_valid:
            outputs.append((final_stage.o_inph_data, final_stage.o_quad_data))
        return outputs

    def run(self, real_samples: Sequence[int]) -> List[Tuple[int, int]]:
        assert len(real_samples) % 2 == 0
        outputs: List[Tuple[int, int]] = []
        pairs = [(real_samples[idx], real_samples[idx + 1]) for idx in range(0, len(real_samples), 2)]
        current_inph, current_delay = pairs[0] if pairs else (0, 0)
        current_valid = 1 if pairs else 0
        pair_index = 1
        total_cycles = len(pairs) + 256
        for _ in range(total_cycles):
            outputs.extend(self.tick(current_inph, current_delay, current_valid))
            if pair_index < len(pairs):
                current_inph, current_delay = pairs[pair_index]
                current_valid = 1
                pair_index += 1
            else:
                current_inph, current_delay, current_valid = 0, 0, 0
        return outputs


class UpconverterModel:
    def __init__(self, ratio: int = 4):
        if ratio not in (2, 4, 8, 16):
            raise ValueError(f"Unsupported upconverter ratio {ratio}; supported ratios are 2, 4, 8, 16")
        self.ratio = ratio
        rom = read_binary_rom(DUC_HDL / "duc_sincos.mif")
        stage_coeff_files = [
            DUC_HDL / "duc_hb_interp_fir_h0.sv",
            DUC_HDL / "duc_hb_interp_fir_h0.sv",
            DUC_HDL / "duc_hb_interp_fir_h1.sv",
            DUC_HDL / "duc_hb_interp_fir_h2.sv",
        ]
        self.stages = [
            DucHalfbandInterpolator(load_coeffs(path))
            for path in stage_coeff_files[: int(math.log2(ratio))]
        ]
        self.skids = [DucSkid() for _ in range(max(0, len(self.stages) - 1))]
        self.dds = DucFixedDDS(rom)
        self.inph_data_reg0 = 0
        self.quad_data_reg0 = 0
        self.cosine_reg0 = 0
        self.sine_reg0 = 0
        self.inph_inph_data_reg1 = 0
        self.inph_quad_data_reg1 = 0
        self.quad_inph_data_reg1 = 0
        self.quad_quad_data_reg1 = 0
        self.inph_data_reg2 = 0
        self.quad_data_reg2 = 0
        self.inph_data_reg3 = 0
        self.quad_data_reg3 = 0
        self.inph_data_reg4 = 0
        self.quad_data_reg4 = 0
    @property
    def o_ready(self) -> int:
        stage0_ready = 1 - self.stages[0].pp_toggle
        if not self.skids:
            return stage0_ready
        return self.skids[0].o_in_ready & stage0_ready

    def tick(self, current_input: Tuple[int, int]) -> Tuple[int, int]:
        old_stage_outs = [(stage.o_inph_data, stage.o_quad_data) for stage in self.stages]
        old_skid_outs = [skid.out_data for skid in self.skids]
        old_skid_readies = [skid.o_in_ready for skid in self.skids]
        old_stage_i_readies = [
            old_skid_readies[idx] if idx < len(self.skids) else 1
            for idx in range(len(self.stages))
        ]
        old_stage_readies = [
            old_stage_i_readies[idx] & (1 - stage.pp_toggle)
            for idx, stage in enumerate(self.stages)
        ]
        old_dds = (self.dds.o_cosine_data, self.dds.o_sine_data)
        old_reg0_i = self.inph_data_reg0
        old_reg0_q = self.quad_data_reg0
        old_cos0 = self.cosine_reg0
        old_sin0 = self.sine_reg0
        old_reg1_ii = self.inph_inph_data_reg1
        old_reg1_iq = self.inph_quad_data_reg1
        old_reg1_qi = self.quad_inph_data_reg1
        old_reg1_qq = self.quad_quad_data_reg1
        old_reg2_i = self.inph_data_reg2
        old_reg2_q = self.quad_data_reg2
        old_reg3_i = self.inph_data_reg3
        old_reg3_q = self.quad_data_reg3

        for idx, stage in enumerate(self.stages):
            if idx == 0:
                stage_ready = old_skid_readies[0] if self.skids else 1
                stage.tick(current_input[0], current_input[1], stage_ready)
            else:
                stage_ready = 1 if idx == len(self.stages) - 1 else old_skid_readies[idx]
                stage.tick(old_skid_outs[idx - 1][0], old_skid_outs[idx - 1][1], stage_ready)
        for idx, skid in enumerate(self.skids):
            skid.tick(old_stage_outs[idx], old_stage_readies[idx + 1])
        self.dds.tick(1)

        final_stage_out = old_stage_outs[-1]
        self.inph_data_reg0 = final_stage_out[0]
        self.quad_data_reg0 = final_stage_out[1]
        self.cosine_reg0 = old_dds[0]
        self.sine_reg0 = old_dds[1]

        self.inph_inph_data_reg1 = wrap_signed(old_reg0_i * old_cos0, WIDTH + ROM_WIDTH)
        self.inph_quad_data_reg1 = wrap_signed(old_reg0_i * old_sin0, WIDTH + ROM_WIDTH)
        self.quad_inph_data_reg1 = wrap_signed(old_reg0_q * old_cos0, WIDTH + ROM_WIDTH)
        self.quad_quad_data_reg1 = wrap_signed(old_reg0_q * old_sin0, WIDTH + ROM_WIDTH)

        self.inph_data_reg2 = wrap_signed(old_reg1_ii + old_reg1_qq, WIDTH + ROM_WIDTH + 1)
        self.quad_data_reg2 = wrap_signed(old_reg1_qi - old_reg1_iq, WIDTH + ROM_WIDTH + 1)

        self.inph_data_reg3 = duc_stage3_round_gain(old_reg2_i)
        self.quad_data_reg3 = duc_stage3_round_gain(old_reg2_q)

        self.inph_data_reg4 = ddc_stage3_inph(old_reg3_i)
        self.quad_data_reg4 = duc_stage4_quad(old_reg3_q)
        return self.inph_data_reg4, self.quad_data_reg4

    def run(self, iq_samples: Sequence[Tuple[int, int]]) -> List[Tuple[int, int]]:
        outputs: List[Tuple[int, int]] = []
        total_cycles = len(iq_samples) * self.ratio + 512
        current_input = (0, 0)
        sample_index = 0
        for _ in range(total_cycles):
            outputs.append(self.tick(current_input))
            if self.o_ready and sample_index < len(iq_samples):
                current_input = iq_samples[sample_index]
                sample_index += 1
            elif self.o_ready:
                current_input = (0, 0)
        return outputs


def load_coeffs(path: Path) -> List[int]:
    coeff_pairs = decode_coeff_file(str(path))
    return [value for index, (_, value) in enumerate(coeff_pairs) if index % 2 == 0]


def ddc_stage2_round(value: int) -> int:
    uvalue = wrap_unsigned(value, WIDTH + ROM_WIDTH)
    cat = (((uvalue >> (WIDTH + ROM_WIDTH - 1)) & 1) << 18) | ((uvalue >> 34) & mask(18))
    rounded = (cat + 1) >> 1
    return wrap_signed(rounded, WIDTH + 1)


def ddc_stage3_inph(value: int) -> int:
    value = wrap_signed(value, WIDTH + 1)
    sign = (wrap_unsigned(value, WIDTH + 1) >> WIDTH) & 1
    msb = (wrap_unsigned(value, WIDTH + 1) >> (WIDTH - 1)) & 1
    if sign != msb:
        return -(1 << (WIDTH - 1)) if sign else (1 << (WIDTH - 1)) - 1
    return wrap_signed(value, WIDTH)


def ddc_stage3_quad(value: int) -> int:
    value = wrap_signed(value, WIDTH + 1)
    sign = (wrap_unsigned(value, WIDTH + 1) >> WIDTH) & 1
    msb = (wrap_unsigned(value, WIDTH + 1) >> (WIDTH - 1)) & 1
    if sign != msb:
        return (1 << (WIDTH - 1)) - 1 if sign else -(1 << (WIDTH - 1))
    return wrap_signed(-value, WIDTH)


def duc_stage3_round_gain(value: int) -> int:
    total_width = WIDTH + ROM_WIDTH + 1
    slice_u = unsigned_slice(value, total_width, WIDTH + ROM_WIDTH, 34)
    rounded = (slice_u + 1) & mask(19)
    shifted = (rounded << 2) & mask(19)
    return wrap_signed(shifted, WIDTH + 1)


def duc_stage4_quad(value: int) -> int:
    value = wrap_signed(value, WIDTH + 1)
    sign = (wrap_unsigned(value, WIDTH + 1) >> WIDTH) & 1
    msb = (wrap_unsigned(value, WIDTH + 1) >> (WIDTH - 1)) & 1
    if sign != msb:
        return (1 << (WIDTH - 1)) - 1 if sign else -(1 << (WIDTH - 1))
    return wrap_signed(value, WIDTH)


def deterministic_downconverter_real_samples() -> List[int]:
    samples: List[int] = []
    for n in range(DDC_ACTIVE_START_PAIR * 2):
        samples.append(0)
    for n in range(DDC_ACTIVE_PAIRS * 2):
        tone_a = 11000.0 * math.sin(2.0 * math.pi * 7.0 * n / 97.0)
        tone_b = 7000.0 * math.cos(2.0 * math.pi * 19.0 * n / 59.0)
        chirp = 3500.0 * math.sin(2.0 * math.pi * (n * n) / 521.0)
        ramp = 48.0 * ((n % 23) - 11)
        impulse = 0.0
        if n in (9, 57, 111, 167, 201):
            impulse += 12000.0 if (n // 3) % 2 == 0 else -12000.0
        samples.append(int16_clip(int(round(tone_a + tone_b + chirp + ramp + impulse))))
    for n in range(DDC_POST_PAIRS * 2):
        samples.append(0)
    return samples


def deterministic_upconverter_iq_samples() -> List[Tuple[int, int]]:
    samples: List[Tuple[int, int]] = []
    for _ in range(DUC_ACTIVE_START):
        samples.append((0, 0))
    for n in range(DUC_ACTIVE_COUNT):
        inph = (
            9000.0 * math.cos(2.0 * math.pi * 5.0 * n / 41.0)
            + 4200.0 * math.sin(2.0 * math.pi * 9.0 * n / 73.0)
            + 36.0 * ((n % 19) - 9)
        )
        quad = (
            8400.0 * math.sin(2.0 * math.pi * 7.0 * n / 53.0)
            - 3600.0 * math.cos(2.0 * math.pi * 11.0 * n / 67.0)
            + 44.0 * ((n % 17) - 8)
        )
        if n in (6, 17, 43, 64, 81):
            inph += 8000.0 if n % 2 else -8000.0
        if n in (12, 35, 58, 77):
            quad += -7000.0 if n % 2 else 7000.0
        samples.append((int16_clip(int(round(inph))), int16_clip(int(round(quad)))))
    for _ in range(DUC_POST_COUNT):
        samples.append((0, 0))
    return samples


def write_downconverter_vectors(out_dir: Path = DDC_HDL) -> None:
    real_samples = deterministic_downconverter_real_samples()
    even = real_samples[0::2]
    odd = real_samples[1::2]
    (out_dir / "i_inph_data.mif").write_text("\n".join(int16_to_hex(v) for v in even) + "\n")
    (out_dir / "i_inph_delay_data.mif").write_text("\n".join(int16_to_hex(v) for v in odd) + "\n")


def write_upconverter_vectors(out_dir: Path = DUC_HDL) -> None:
    iq_samples = deterministic_upconverter_iq_samples()
    (out_dir / "i_inph_data.mif").write_text("\n".join(int16_to_hex(i) for i, _ in iq_samples) + "\n")
    (out_dir / "i_quad_data.mif").write_text("\n".join(int16_to_hex(q) for _, q in iq_samples) + "\n")


def downconverter_expected_outputs(ratio: int = 8) -> List[Tuple[int, int]]:
    return DownconverterModel(ratio=ratio).run(deterministic_downconverter_real_samples())


def upconverter_expected_outputs(ratio: int = 4) -> List[Tuple[int, int]]:
    return UpconverterModel(ratio=ratio).run(deterministic_upconverter_iq_samples())


def leading_nonzero_index(samples: Sequence[Tuple[int, int]]) -> int:
    for index, (a_val, b_val) in enumerate(samples):
        if a_val != 0 or b_val != 0:
            return index
    return len(samples)


def _self_test() -> None:
    write_downconverter_vectors()
    write_upconverter_vectors()
    ddc = downconverter_expected_outputs()
    duc = upconverter_expected_outputs()
    print(f"downconverter outputs={len(ddc)} first_nonzero={leading_nonzero_index(ddc)} first5={ddc[:5]}")
    print(f"upconverter outputs={len(duc)} first_nonzero={leading_nonzero_index(duc)} first5={duc[:5]}")


if __name__ == "__main__":
    _self_test()
