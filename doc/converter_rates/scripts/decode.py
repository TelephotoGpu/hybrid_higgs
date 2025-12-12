import re, sys

def decode_coeff_file(path, width=18):
    """Extract the ordered list of signed Verilog literal coefficients
    (e.g. 18'sb...) used as FIR multiplier constants in these generated
    halfband filter files. Returns list of (register_name, int_value)."""
    pat = re.compile(r"(\w+)\s*<=\s*\$signed\(%d'sb([01]+)\)\s*\*" % width)
    out = []
    seen = set()
    with open(path) as f:
        for line in f:
            m = pat.search(line)
            if m:
                reg, bits = m.group(1), m.group(2)
                if reg in seen:
                    continue
                seen.add(reg)
                val = int(bits, 2)
                if val >= (1 << (width-1)):
                    val -= (1 << width)
                out.append((reg, val))
    return out

if __name__ == '__main__':
    for p in sys.argv[1:]:
        coeffs = decode_coeff_file(p)
        print(p, '->', len(coeffs), 'taps')
        for reg, val in coeffs:
            print('  ', reg, val)
