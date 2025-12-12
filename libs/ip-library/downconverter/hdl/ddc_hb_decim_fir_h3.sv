`timescale 10ps / 10ps

`default_nettype none


module ddc_hb_decim_fir_h3 #(
    parameter integer WIDTH = 16
) (
    input  wire logic [WIDTH-1:0] i_inph_data,
    input  wire logic [WIDTH-1:0] i_quad_data,
    input  wire logic             i_valid,
    output      logic [WIDTH-1:0] o_inph_data,
    output      logic [WIDTH-1:0] o_quad_data,
    output      logic             o_valid,
    input  wire logic             i_clock,
    input  wire logic             i_reset
);

// Toggles on/off to indicate which polyphase component
// the next sample should go to (0/1) [[ Commutator ]]
logic pp_toggle;

always @(posedge i_clock) begin
    // Reset the toggler so we start with the zeroth polyphase component
    if (i_reset == 1'b1) begin
        pp_toggle <= 1'b0;
    end else if (i_valid == 1'b1) begin
        pp_toggle <= ~pp_toggle;
    end
end

// Tap delay line registers

logic signed [WIDTH-1:0]       inph_tdl0_reg0;
logic signed [WIDTH-1:0]       quad_tdl0_reg0;

logic signed [WIDTH-1:0]       inph_tdl0_reg1;
logic signed [WIDTH-1:0]       quad_tdl0_reg1;

logic signed [WIDTH-1:0]       inph_tdl0_reg2;
logic signed [WIDTH-1:0]       quad_tdl0_reg2;

logic signed [WIDTH-1:0]       inph_tdl0_reg3;
logic signed [WIDTH-1:0]       quad_tdl0_reg3;

logic signed [WIDTH-1:0]       inph_tdl0_reg4;
logic signed [WIDTH-1:0]       quad_tdl0_reg4;

logic signed [WIDTH-1:0]       inph_tdl0_reg5;
logic signed [WIDTH-1:0]       quad_tdl0_reg5;

logic signed [WIDTH-1:0]       inph_tdl0_reg6;
logic signed [WIDTH-1:0]       quad_tdl0_reg6;

logic signed [WIDTH-1:0]       inph_tdl0_reg7;
logic signed [WIDTH-1:0]       quad_tdl0_reg7;

logic signed [WIDTH-1:0]       inph_tdl0_reg8;
logic signed [WIDTH-1:0]       quad_tdl0_reg8;

logic signed [WIDTH-1:0]       inph_tdl0_reg9;
logic signed [WIDTH-1:0]       quad_tdl0_reg9;

logic signed [WIDTH-1:0]       inph_tdl0_reg10;
logic signed [WIDTH-1:0]       quad_tdl0_reg10;

logic signed [WIDTH-1:0]       inph_tdl0_reg11;
logic signed [WIDTH-1:0]       quad_tdl0_reg11;

logic signed [WIDTH-1:0]       inph_tdl0_reg12;
logic signed [WIDTH-1:0]       quad_tdl0_reg12;

logic signed [WIDTH-1:0]       inph_tdl0_reg13;
logic signed [WIDTH-1:0]       quad_tdl0_reg13;

logic signed [WIDTH-1:0]       inph_tdl0_reg14;
logic signed [WIDTH-1:0]       quad_tdl0_reg14;

logic signed [WIDTH-1:0]       inph_tdl0_reg15;
logic signed [WIDTH-1:0]       quad_tdl0_reg15;

logic signed [WIDTH-1:0]       inph_tdl0_reg16;
logic signed [WIDTH-1:0]       quad_tdl0_reg16;

logic signed [WIDTH-1:0]       inph_tdl0_reg17;
logic signed [WIDTH-1:0]       quad_tdl0_reg17;

logic signed [WIDTH-1:0]       inph_tdl0_reg18;
logic signed [WIDTH-1:0]       quad_tdl0_reg18;

logic signed [WIDTH-1:0]       inph_tdl0_reg19;
logic signed [WIDTH-1:0]       quad_tdl0_reg19;

logic signed [WIDTH-1:0]       inph_tdl0_reg20;
logic signed [WIDTH-1:0]       quad_tdl0_reg20;

logic signed [WIDTH-1:0]       inph_tdl0_reg21;
logic signed [WIDTH-1:0]       quad_tdl0_reg21;

logic signed [WIDTH-1:0]       inph_tdl0_reg22;
logic signed [WIDTH-1:0]       quad_tdl0_reg22;

logic signed [WIDTH-1:0]       inph_tdl0_reg23;
logic signed [WIDTH-1:0]       quad_tdl0_reg23;

logic signed [WIDTH-1:0]       inph_tdl0_reg24;
logic signed [WIDTH-1:0]       quad_tdl0_reg24;

logic signed [WIDTH-1:0]       inph_tdl0_reg25;
logic signed [WIDTH-1:0]       quad_tdl0_reg25;

logic signed [WIDTH-1:0]       inph_tdl0_reg26;
logic signed [WIDTH-1:0]       quad_tdl0_reg26;

logic signed [WIDTH-1:0]       inph_tdl0_reg27;
logic signed [WIDTH-1:0]       quad_tdl0_reg27;

logic signed [WIDTH-1:0]       inph_tdl0_reg28;
logic signed [WIDTH-1:0]       quad_tdl0_reg28;

logic signed [WIDTH-1:0]       inph_tdl0_reg29;
logic signed [WIDTH-1:0]       quad_tdl0_reg29;

logic signed [WIDTH-1:0]       inph_tdl0_reg30;
logic signed [WIDTH-1:0]       quad_tdl0_reg30;

logic signed [WIDTH-1:0]       inph_tdl0_reg31;
logic signed [WIDTH-1:0]       quad_tdl0_reg31;

logic signed [WIDTH-1:0]       inph_tdl0_reg32;
logic signed [WIDTH-1:0]       quad_tdl0_reg32;

logic signed [WIDTH-1:0]       inph_tdl0_reg33;
logic signed [WIDTH-1:0]       quad_tdl0_reg33;

logic signed [WIDTH-1:0]       inph_tdl0_reg34;
logic signed [WIDTH-1:0]       quad_tdl0_reg34;

logic signed [WIDTH-1:0]       inph_tdl0_reg35;
logic signed [WIDTH-1:0]       quad_tdl0_reg35;

logic signed [WIDTH-1:0]       inph_tdl0_reg36;
logic signed [WIDTH-1:0]       quad_tdl0_reg36;

logic signed [WIDTH-1:0]       inph_tdl0_reg37;
logic signed [WIDTH-1:0]       quad_tdl0_reg37;

logic signed [WIDTH-1:0]       inph_tdl0_reg38;
logic signed [WIDTH-1:0]       quad_tdl0_reg38;

logic signed [WIDTH-1:0]       inph_tdl0_reg39;
logic signed [WIDTH-1:0]       quad_tdl0_reg39;

logic signed [WIDTH-1:0]       inph_tdl0_reg40;
logic signed [WIDTH-1:0]       quad_tdl0_reg40;

logic signed [WIDTH-1:0]       inph_tdl0_reg41;
logic signed [WIDTH-1:0]       quad_tdl0_reg41;

logic signed [WIDTH-1:0]       inph_tdl0_reg42;
logic signed [WIDTH-1:0]       quad_tdl0_reg42;

logic signed [WIDTH-1:0]       inph_tdl0_reg43;
logic signed [WIDTH-1:0]       quad_tdl0_reg43;

logic signed [WIDTH-1:0]       inph_tdl0_reg44;
logic signed [WIDTH-1:0]       quad_tdl0_reg44;

logic signed [WIDTH-1:0]       inph_tdl0_reg45;
logic signed [WIDTH-1:0]       quad_tdl0_reg45;

logic signed [WIDTH-1:0]       inph_tdl0_reg46;
logic signed [WIDTH-1:0]       quad_tdl0_reg46;

logic signed [WIDTH-1:0]       inph_tdl0_reg47;
logic signed [WIDTH-1:0]       quad_tdl0_reg47;

logic signed [WIDTH-1:0]       inph_tdl0_reg48;
logic signed [WIDTH-1:0]       quad_tdl0_reg48;

logic signed [WIDTH-1:0]       inph_tdl0_reg49;
logic signed [WIDTH-1:0]       quad_tdl0_reg49;

logic signed [WIDTH-1:0]       inph_tdl0_reg50;
logic signed [WIDTH-1:0]       quad_tdl0_reg50;

logic signed [WIDTH-1:0]       inph_tdl0_reg51;
logic signed [WIDTH-1:0]       quad_tdl0_reg51;

logic signed [WIDTH-1:0]       inph_tdl0_reg52;
logic signed [WIDTH-1:0]       quad_tdl0_reg52;

logic signed [WIDTH-1:0]       inph_tdl0_reg53;
logic signed [WIDTH-1:0]       quad_tdl0_reg53;

logic signed [WIDTH-1:0]       inph_tdl0_reg54;
logic signed [WIDTH-1:0]       quad_tdl0_reg54;

logic signed [WIDTH-1:0]       inph_tdl0_reg55;
logic signed [WIDTH-1:0]       quad_tdl0_reg55;

logic signed [WIDTH-1:0]       inph_tdl0_reg56;
logic signed [WIDTH-1:0]       quad_tdl0_reg56;

logic signed [WIDTH-1:0]       inph_tdl0_reg57;
logic signed [WIDTH-1:0]       quad_tdl0_reg57;

logic signed [WIDTH-1:0]       inph_tdl0_reg58;
logic signed [WIDTH-1:0]       quad_tdl0_reg58;

logic signed [WIDTH-1:0]       inph_tdl0_reg59;
logic signed [WIDTH-1:0]       quad_tdl0_reg59;

logic signed [WIDTH-1:0]       inph_tdl0_reg60;
logic signed [WIDTH-1:0]       quad_tdl0_reg60;

logic signed [WIDTH-1:0]       inph_tdl0_reg61;
logic signed [WIDTH-1:0]       quad_tdl0_reg61;

logic signed [WIDTH-1:0]       inph_tdl0_reg62;
logic signed [WIDTH-1:0]       quad_tdl0_reg62;

logic signed [WIDTH-1:0]       inph_tdl0_reg63;
logic signed [WIDTH-1:0]       quad_tdl0_reg63;

logic signed [WIDTH-1:0]       inph_tdl1_reg0;
logic signed [WIDTH-1:0]       quad_tdl1_reg0;

logic signed [WIDTH-1:0]       inph_tdl1_reg1;
logic signed [WIDTH-1:0]       quad_tdl1_reg1;

logic signed [WIDTH-1:0]       inph_tdl1_reg2;
logic signed [WIDTH-1:0]       quad_tdl1_reg2;

logic signed [WIDTH-1:0]       inph_tdl1_reg3;
logic signed [WIDTH-1:0]       quad_tdl1_reg3;

logic signed [WIDTH-1:0]       inph_tdl1_reg4;
logic signed [WIDTH-1:0]       quad_tdl1_reg4;

logic signed [WIDTH-1:0]       inph_tdl1_reg5;
logic signed [WIDTH-1:0]       quad_tdl1_reg5;

logic signed [WIDTH-1:0]       inph_tdl1_reg6;
logic signed [WIDTH-1:0]       quad_tdl1_reg6;

logic signed [WIDTH-1:0]       inph_tdl1_reg7;
logic signed [WIDTH-1:0]       quad_tdl1_reg7;

logic signed [WIDTH-1:0]       inph_tdl1_reg8;
logic signed [WIDTH-1:0]       quad_tdl1_reg8;

logic signed [WIDTH-1:0]       inph_tdl1_reg9;
logic signed [WIDTH-1:0]       quad_tdl1_reg9;

logic signed [WIDTH-1:0]       inph_tdl1_reg10;
logic signed [WIDTH-1:0]       quad_tdl1_reg10;

logic signed [WIDTH-1:0]       inph_tdl1_reg11;
logic signed [WIDTH-1:0]       quad_tdl1_reg11;

logic signed [WIDTH-1:0]       inph_tdl1_reg12;
logic signed [WIDTH-1:0]       quad_tdl1_reg12;

logic signed [WIDTH-1:0]       inph_tdl1_reg13;
logic signed [WIDTH-1:0]       quad_tdl1_reg13;

logic signed [WIDTH-1:0]       inph_tdl1_reg14;
logic signed [WIDTH-1:0]       quad_tdl1_reg14;

logic signed [WIDTH-1:0]       inph_tdl1_reg15;
logic signed [WIDTH-1:0]       quad_tdl1_reg15;

logic signed [WIDTH-1:0]       inph_tdl1_reg16;
logic signed [WIDTH-1:0]       quad_tdl1_reg16;

logic signed [WIDTH-1:0]       inph_tdl1_reg17;
logic signed [WIDTH-1:0]       quad_tdl1_reg17;

logic signed [WIDTH-1:0]       inph_tdl1_reg18;
logic signed [WIDTH-1:0]       quad_tdl1_reg18;

logic signed [WIDTH-1:0]       inph_tdl1_reg19;
logic signed [WIDTH-1:0]       quad_tdl1_reg19;

logic signed [WIDTH-1:0]       inph_tdl1_reg20;
logic signed [WIDTH-1:0]       quad_tdl1_reg20;

logic signed [WIDTH-1:0]       inph_tdl1_reg21;
logic signed [WIDTH-1:0]       quad_tdl1_reg21;

logic signed [WIDTH-1:0]       inph_tdl1_reg22;
logic signed [WIDTH-1:0]       quad_tdl1_reg22;

logic signed [WIDTH-1:0]       inph_tdl1_reg23;
logic signed [WIDTH-1:0]       quad_tdl1_reg23;

logic signed [WIDTH-1:0]       inph_tdl1_reg24;
logic signed [WIDTH-1:0]       quad_tdl1_reg24;

logic signed [WIDTH-1:0]       inph_tdl1_reg25;
logic signed [WIDTH-1:0]       quad_tdl1_reg25;

logic signed [WIDTH-1:0]       inph_tdl1_reg26;
logic signed [WIDTH-1:0]       quad_tdl1_reg26;

logic signed [WIDTH-1:0]       inph_tdl1_reg27;
logic signed [WIDTH-1:0]       quad_tdl1_reg27;

logic signed [WIDTH-1:0]       inph_tdl1_reg28;
logic signed [WIDTH-1:0]       quad_tdl1_reg28;

logic signed [WIDTH-1:0]       inph_tdl1_reg29;
logic signed [WIDTH-1:0]       quad_tdl1_reg29;

logic signed [WIDTH-1:0]       inph_tdl1_reg30;
logic signed [WIDTH-1:0]       quad_tdl1_reg30;

logic signed [WIDTH-1:0]       inph_tdl1_reg31;
logic signed [WIDTH-1:0]       quad_tdl1_reg31;

logic valid0_reg0;

always_ff @ (posedge i_clock) begin
    // Tap delay line for polyphase component zero
    if ((i_valid == 1'b1) && (pp_toggle == 1'b0)) begin
        inph_tdl0_reg0 <= i_inph_data;
        quad_tdl0_reg0 <= i_quad_data;
        inph_tdl0_reg1 <= inph_tdl0_reg0;
        quad_tdl0_reg1 <= quad_tdl0_reg0;
        inph_tdl0_reg2 <= inph_tdl0_reg1;
        quad_tdl0_reg2 <= quad_tdl0_reg1;
        inph_tdl0_reg3 <= inph_tdl0_reg2;
        quad_tdl0_reg3 <= quad_tdl0_reg2;
        inph_tdl0_reg4 <= inph_tdl0_reg3;
        quad_tdl0_reg4 <= quad_tdl0_reg3;
        inph_tdl0_reg5 <= inph_tdl0_reg4;
        quad_tdl0_reg5 <= quad_tdl0_reg4;
        inph_tdl0_reg6 <= inph_tdl0_reg5;
        quad_tdl0_reg6 <= quad_tdl0_reg5;
        inph_tdl0_reg7 <= inph_tdl0_reg6;
        quad_tdl0_reg7 <= quad_tdl0_reg6;
        inph_tdl0_reg8 <= inph_tdl0_reg7;
        quad_tdl0_reg8 <= quad_tdl0_reg7;
        inph_tdl0_reg9 <= inph_tdl0_reg8;
        quad_tdl0_reg9 <= quad_tdl0_reg8;
        inph_tdl0_reg10 <= inph_tdl0_reg9;
        quad_tdl0_reg10 <= quad_tdl0_reg9;
        inph_tdl0_reg11 <= inph_tdl0_reg10;
        quad_tdl0_reg11 <= quad_tdl0_reg10;
        inph_tdl0_reg12 <= inph_tdl0_reg11;
        quad_tdl0_reg12 <= quad_tdl0_reg11;
        inph_tdl0_reg13 <= inph_tdl0_reg12;
        quad_tdl0_reg13 <= quad_tdl0_reg12;
        inph_tdl0_reg14 <= inph_tdl0_reg13;
        quad_tdl0_reg14 <= quad_tdl0_reg13;
        inph_tdl0_reg15 <= inph_tdl0_reg14;
        quad_tdl0_reg15 <= quad_tdl0_reg14;
        inph_tdl0_reg16 <= inph_tdl0_reg15;
        quad_tdl0_reg16 <= quad_tdl0_reg15;
        inph_tdl0_reg17 <= inph_tdl0_reg16;
        quad_tdl0_reg17 <= quad_tdl0_reg16;
        inph_tdl0_reg18 <= inph_tdl0_reg17;
        quad_tdl0_reg18 <= quad_tdl0_reg17;
        inph_tdl0_reg19 <= inph_tdl0_reg18;
        quad_tdl0_reg19 <= quad_tdl0_reg18;
        inph_tdl0_reg20 <= inph_tdl0_reg19;
        quad_tdl0_reg20 <= quad_tdl0_reg19;
        inph_tdl0_reg21 <= inph_tdl0_reg20;
        quad_tdl0_reg21 <= quad_tdl0_reg20;
        inph_tdl0_reg22 <= inph_tdl0_reg21;
        quad_tdl0_reg22 <= quad_tdl0_reg21;
        inph_tdl0_reg23 <= inph_tdl0_reg22;
        quad_tdl0_reg23 <= quad_tdl0_reg22;
        inph_tdl0_reg24 <= inph_tdl0_reg23;
        quad_tdl0_reg24 <= quad_tdl0_reg23;
        inph_tdl0_reg25 <= inph_tdl0_reg24;
        quad_tdl0_reg25 <= quad_tdl0_reg24;
        inph_tdl0_reg26 <= inph_tdl0_reg25;
        quad_tdl0_reg26 <= quad_tdl0_reg25;
        inph_tdl0_reg27 <= inph_tdl0_reg26;
        quad_tdl0_reg27 <= quad_tdl0_reg26;
        inph_tdl0_reg28 <= inph_tdl0_reg27;
        quad_tdl0_reg28 <= quad_tdl0_reg27;
        inph_tdl0_reg29 <= inph_tdl0_reg28;
        quad_tdl0_reg29 <= quad_tdl0_reg28;
        inph_tdl0_reg30 <= inph_tdl0_reg29;
        quad_tdl0_reg30 <= quad_tdl0_reg29;
        inph_tdl0_reg31 <= inph_tdl0_reg30;
        quad_tdl0_reg31 <= quad_tdl0_reg30;
        inph_tdl0_reg32 <= inph_tdl0_reg31;
        quad_tdl0_reg32 <= quad_tdl0_reg31;
        inph_tdl0_reg33 <= inph_tdl0_reg32;
        quad_tdl0_reg33 <= quad_tdl0_reg32;
        inph_tdl0_reg34 <= inph_tdl0_reg33;
        quad_tdl0_reg34 <= quad_tdl0_reg33;
        inph_tdl0_reg35 <= inph_tdl0_reg34;
        quad_tdl0_reg35 <= quad_tdl0_reg34;
        inph_tdl0_reg36 <= inph_tdl0_reg35;
        quad_tdl0_reg36 <= quad_tdl0_reg35;
        inph_tdl0_reg37 <= inph_tdl0_reg36;
        quad_tdl0_reg37 <= quad_tdl0_reg36;
        inph_tdl0_reg38 <= inph_tdl0_reg37;
        quad_tdl0_reg38 <= quad_tdl0_reg37;
        inph_tdl0_reg39 <= inph_tdl0_reg38;
        quad_tdl0_reg39 <= quad_tdl0_reg38;
        inph_tdl0_reg40 <= inph_tdl0_reg39;
        quad_tdl0_reg40 <= quad_tdl0_reg39;
        inph_tdl0_reg41 <= inph_tdl0_reg40;
        quad_tdl0_reg41 <= quad_tdl0_reg40;
        inph_tdl0_reg42 <= inph_tdl0_reg41;
        quad_tdl0_reg42 <= quad_tdl0_reg41;
        inph_tdl0_reg43 <= inph_tdl0_reg42;
        quad_tdl0_reg43 <= quad_tdl0_reg42;
        inph_tdl0_reg44 <= inph_tdl0_reg43;
        quad_tdl0_reg44 <= quad_tdl0_reg43;
        inph_tdl0_reg45 <= inph_tdl0_reg44;
        quad_tdl0_reg45 <= quad_tdl0_reg44;
        inph_tdl0_reg46 <= inph_tdl0_reg45;
        quad_tdl0_reg46 <= quad_tdl0_reg45;
        inph_tdl0_reg47 <= inph_tdl0_reg46;
        quad_tdl0_reg47 <= quad_tdl0_reg46;
        inph_tdl0_reg48 <= inph_tdl0_reg47;
        quad_tdl0_reg48 <= quad_tdl0_reg47;
        inph_tdl0_reg49 <= inph_tdl0_reg48;
        quad_tdl0_reg49 <= quad_tdl0_reg48;
        inph_tdl0_reg50 <= inph_tdl0_reg49;
        quad_tdl0_reg50 <= quad_tdl0_reg49;
        inph_tdl0_reg51 <= inph_tdl0_reg50;
        quad_tdl0_reg51 <= quad_tdl0_reg50;
        inph_tdl0_reg52 <= inph_tdl0_reg51;
        quad_tdl0_reg52 <= quad_tdl0_reg51;
        inph_tdl0_reg53 <= inph_tdl0_reg52;
        quad_tdl0_reg53 <= quad_tdl0_reg52;
        inph_tdl0_reg54 <= inph_tdl0_reg53;
        quad_tdl0_reg54 <= quad_tdl0_reg53;
        inph_tdl0_reg55 <= inph_tdl0_reg54;
        quad_tdl0_reg55 <= quad_tdl0_reg54;
        inph_tdl0_reg56 <= inph_tdl0_reg55;
        quad_tdl0_reg56 <= quad_tdl0_reg55;
        inph_tdl0_reg57 <= inph_tdl0_reg56;
        quad_tdl0_reg57 <= quad_tdl0_reg56;
        inph_tdl0_reg58 <= inph_tdl0_reg57;
        quad_tdl0_reg58 <= quad_tdl0_reg57;
        inph_tdl0_reg59 <= inph_tdl0_reg58;
        quad_tdl0_reg59 <= quad_tdl0_reg58;
        inph_tdl0_reg60 <= inph_tdl0_reg59;
        quad_tdl0_reg60 <= quad_tdl0_reg59;
        inph_tdl0_reg61 <= inph_tdl0_reg60;
        quad_tdl0_reg61 <= quad_tdl0_reg60;
        inph_tdl0_reg62 <= inph_tdl0_reg61;
        quad_tdl0_reg62 <= quad_tdl0_reg61;
        inph_tdl0_reg63 <= inph_tdl0_reg62;
        quad_tdl0_reg63 <= quad_tdl0_reg62;
    end
    // Tap delay line for polyphase component one (delay + shift)
    if ((i_valid == 1'b1) && (pp_toggle == 1'b1)) begin
        inph_tdl1_reg0 <= i_inph_data;
        quad_tdl1_reg0 <= i_quad_data;
        inph_tdl1_reg1 <= inph_tdl1_reg0;
        quad_tdl1_reg1 <= quad_tdl1_reg0;
        inph_tdl1_reg2 <= inph_tdl1_reg1;
        quad_tdl1_reg2 <= quad_tdl1_reg1;
        inph_tdl1_reg3 <= inph_tdl1_reg2;
        quad_tdl1_reg3 <= quad_tdl1_reg2;
        inph_tdl1_reg4 <= inph_tdl1_reg3;
        quad_tdl1_reg4 <= quad_tdl1_reg3;
        inph_tdl1_reg5 <= inph_tdl1_reg4;
        quad_tdl1_reg5 <= quad_tdl1_reg4;
        inph_tdl1_reg6 <= inph_tdl1_reg5;
        quad_tdl1_reg6 <= quad_tdl1_reg5;
        inph_tdl1_reg7 <= inph_tdl1_reg6;
        quad_tdl1_reg7 <= quad_tdl1_reg6;
        inph_tdl1_reg8 <= inph_tdl1_reg7;
        quad_tdl1_reg8 <= quad_tdl1_reg7;
        inph_tdl1_reg9 <= inph_tdl1_reg8;
        quad_tdl1_reg9 <= quad_tdl1_reg8;
        inph_tdl1_reg10 <= inph_tdl1_reg9;
        quad_tdl1_reg10 <= quad_tdl1_reg9;
        inph_tdl1_reg11 <= inph_tdl1_reg10;
        quad_tdl1_reg11 <= quad_tdl1_reg10;
        inph_tdl1_reg12 <= inph_tdl1_reg11;
        quad_tdl1_reg12 <= quad_tdl1_reg11;
        inph_tdl1_reg13 <= inph_tdl1_reg12;
        quad_tdl1_reg13 <= quad_tdl1_reg12;
        inph_tdl1_reg14 <= inph_tdl1_reg13;
        quad_tdl1_reg14 <= quad_tdl1_reg13;
        inph_tdl1_reg15 <= inph_tdl1_reg14;
        quad_tdl1_reg15 <= quad_tdl1_reg14;
        inph_tdl1_reg16 <= inph_tdl1_reg15;
        quad_tdl1_reg16 <= quad_tdl1_reg15;
        inph_tdl1_reg17 <= inph_tdl1_reg16;
        quad_tdl1_reg17 <= quad_tdl1_reg16;
        inph_tdl1_reg18 <= inph_tdl1_reg17;
        quad_tdl1_reg18 <= quad_tdl1_reg17;
        inph_tdl1_reg19 <= inph_tdl1_reg18;
        quad_tdl1_reg19 <= quad_tdl1_reg18;
        inph_tdl1_reg20 <= inph_tdl1_reg19;
        quad_tdl1_reg20 <= quad_tdl1_reg19;
        inph_tdl1_reg21 <= inph_tdl1_reg20;
        quad_tdl1_reg21 <= quad_tdl1_reg20;
        inph_tdl1_reg22 <= inph_tdl1_reg21;
        quad_tdl1_reg22 <= quad_tdl1_reg21;
        inph_tdl1_reg23 <= inph_tdl1_reg22;
        quad_tdl1_reg23 <= quad_tdl1_reg22;
        inph_tdl1_reg24 <= inph_tdl1_reg23;
        quad_tdl1_reg24 <= quad_tdl1_reg23;
        inph_tdl1_reg25 <= inph_tdl1_reg24;
        quad_tdl1_reg25 <= quad_tdl1_reg24;
        inph_tdl1_reg26 <= inph_tdl1_reg25;
        quad_tdl1_reg26 <= quad_tdl1_reg25;
        inph_tdl1_reg27 <= inph_tdl1_reg26;
        quad_tdl1_reg27 <= quad_tdl1_reg26;
        inph_tdl1_reg28 <= inph_tdl1_reg27;
        quad_tdl1_reg28 <= quad_tdl1_reg27;
        inph_tdl1_reg29 <= inph_tdl1_reg28;
        quad_tdl1_reg29 <= quad_tdl1_reg28;
        inph_tdl1_reg30 <= inph_tdl1_reg29;
        quad_tdl1_reg30 <= quad_tdl1_reg29;
        inph_tdl1_reg31 <= inph_tdl1_reg30;
        quad_tdl1_reg31 <= quad_tdl1_reg30;
    end
    // Compute an output for this input
    valid0_reg0 <= i_valid & ~pp_toggle;
end

logic signed [WIDTH-1:0]       inph_term_reg0;
logic signed [WIDTH-1:0]       quad_term_reg0;

logic signed [WIDTH-1:0]       inph_term_reg1;
logic signed [WIDTH-1:0]       quad_term_reg1;

logic signed [WIDTH-1:0]       inph_term_reg2;
logic signed [WIDTH-1:0]       quad_term_reg2;

logic signed [WIDTH-1:0]       inph_term_reg3;
logic signed [WIDTH-1:0]       quad_term_reg3;

logic signed [WIDTH-1:0]       inph_term_reg4;
logic signed [WIDTH-1:0]       quad_term_reg4;

logic signed [WIDTH-1:0]       inph_term_reg5;
logic signed [WIDTH-1:0]       quad_term_reg5;

logic signed [WIDTH-1:0]       inph_term_reg6;
logic signed [WIDTH-1:0]       quad_term_reg6;

logic signed [WIDTH-1:0]       inph_term_reg7;
logic signed [WIDTH-1:0]       quad_term_reg7;

logic signed [WIDTH-1:0]       inph_term_reg8;
logic signed [WIDTH-1:0]       quad_term_reg8;

logic signed [WIDTH-1:0]       inph_term_reg9;
logic signed [WIDTH-1:0]       quad_term_reg9;

logic signed [WIDTH-1:0]       inph_term_reg10;
logic signed [WIDTH-1:0]       quad_term_reg10;

logic signed [WIDTH-1:0]       inph_term_reg11;
logic signed [WIDTH-1:0]       quad_term_reg11;

logic signed [WIDTH-1:0]       inph_term_reg12;
logic signed [WIDTH-1:0]       quad_term_reg12;

logic signed [WIDTH-1:0]       inph_term_reg13;
logic signed [WIDTH-1:0]       quad_term_reg13;

logic signed [WIDTH-1:0]       inph_term_reg14;
logic signed [WIDTH-1:0]       quad_term_reg14;

logic signed [WIDTH-1:0]       inph_term_reg15;
logic signed [WIDTH-1:0]       quad_term_reg15;

logic signed [WIDTH-1:0]       inph_term_reg16;
logic signed [WIDTH-1:0]       quad_term_reg16;

logic signed [WIDTH-1:0]       inph_term_reg17;
logic signed [WIDTH-1:0]       quad_term_reg17;

logic signed [WIDTH-1:0]       inph_term_reg18;
logic signed [WIDTH-1:0]       quad_term_reg18;

logic signed [WIDTH-1:0]       inph_term_reg19;
logic signed [WIDTH-1:0]       quad_term_reg19;

logic signed [WIDTH-1:0]       inph_term_reg20;
logic signed [WIDTH-1:0]       quad_term_reg20;

logic signed [WIDTH-1:0]       inph_term_reg21;
logic signed [WIDTH-1:0]       quad_term_reg21;

logic signed [WIDTH-1:0]       inph_term_reg22;
logic signed [WIDTH-1:0]       quad_term_reg22;

logic signed [WIDTH-1:0]       inph_term_reg23;
logic signed [WIDTH-1:0]       quad_term_reg23;

logic signed [WIDTH-1:0]       inph_term_reg24;
logic signed [WIDTH-1:0]       quad_term_reg24;

logic signed [WIDTH-1:0]       inph_term_reg25;
logic signed [WIDTH-1:0]       quad_term_reg25;

logic signed [WIDTH-1:0]       inph_term_reg26;
logic signed [WIDTH-1:0]       quad_term_reg26;

logic signed [WIDTH-1:0]       inph_term_reg27;
logic signed [WIDTH-1:0]       quad_term_reg27;

logic signed [WIDTH-1:0]       inph_term_reg28;
logic signed [WIDTH-1:0]       quad_term_reg28;

logic signed [WIDTH-1:0]       inph_term_reg29;
logic signed [WIDTH-1:0]       quad_term_reg29;

logic signed [WIDTH-1:0]       inph_term_reg30;
logic signed [WIDTH-1:0]       quad_term_reg30;

logic signed [WIDTH-1:0]       inph_term_reg31;
logic signed [WIDTH-1:0]       quad_term_reg31;

logic signed [WIDTH-1:0]       inph_term_reg32;
logic signed [WIDTH-1:0]       quad_term_reg32;

logic signed [WIDTH-1:0]       inph_term_reg33;
logic signed [WIDTH-1:0]       quad_term_reg33;

logic signed [WIDTH-1:0]       inph_term_reg34;
logic signed [WIDTH-1:0]       quad_term_reg34;

logic signed [WIDTH-1:0]       inph_term_reg35;
logic signed [WIDTH-1:0]       quad_term_reg35;

logic signed [WIDTH-1:0]       inph_term_reg36;
logic signed [WIDTH-1:0]       quad_term_reg36;

logic signed [WIDTH-1:0]       inph_term_reg37;
logic signed [WIDTH-1:0]       quad_term_reg37;

logic signed [WIDTH-1:0]       inph_term_reg38;
logic signed [WIDTH-1:0]       quad_term_reg38;

logic signed [WIDTH-1:0]       inph_term_reg39;
logic signed [WIDTH-1:0]       quad_term_reg39;

logic signed [WIDTH-1:0]       inph_term_reg40;
logic signed [WIDTH-1:0]       quad_term_reg40;

logic signed [WIDTH-1:0]       inph_term_reg41;
logic signed [WIDTH-1:0]       quad_term_reg41;

logic signed [WIDTH-1:0]       inph_term_reg42;
logic signed [WIDTH-1:0]       quad_term_reg42;

logic signed [WIDTH-1:0]       inph_term_reg43;
logic signed [WIDTH-1:0]       quad_term_reg43;

logic signed [WIDTH-1:0]       inph_term_reg44;
logic signed [WIDTH-1:0]       quad_term_reg44;

logic signed [WIDTH-1:0]       inph_term_reg45;
logic signed [WIDTH-1:0]       quad_term_reg45;

logic signed [WIDTH-1:0]       inph_term_reg46;
logic signed [WIDTH-1:0]       quad_term_reg46;

logic signed [WIDTH-1:0]       inph_term_reg47;
logic signed [WIDTH-1:0]       quad_term_reg47;

logic signed [WIDTH-1:0]       inph_term_reg48;
logic signed [WIDTH-1:0]       quad_term_reg48;

logic signed [WIDTH-1:0]       inph_term_reg49;
logic signed [WIDTH-1:0]       quad_term_reg49;

logic signed [WIDTH-1:0]       inph_term_reg50;
logic signed [WIDTH-1:0]       quad_term_reg50;

logic signed [WIDTH-1:0]       inph_term_reg51;
logic signed [WIDTH-1:0]       quad_term_reg51;

logic signed [WIDTH-1:0]       inph_term_reg52;
logic signed [WIDTH-1:0]       quad_term_reg52;

logic signed [WIDTH-1:0]       inph_term_reg53;
logic signed [WIDTH-1:0]       quad_term_reg53;

logic signed [WIDTH-1:0]       inph_term_reg54;
logic signed [WIDTH-1:0]       quad_term_reg54;

logic signed [WIDTH-1:0]       inph_term_reg55;
logic signed [WIDTH-1:0]       quad_term_reg55;

logic signed [WIDTH-1:0]       inph_term_reg56;
logic signed [WIDTH-1:0]       quad_term_reg56;

logic signed [WIDTH-1:0]       inph_term_reg57;
logic signed [WIDTH-1:0]       quad_term_reg57;

logic signed [WIDTH-1:0]       inph_term_reg58;
logic signed [WIDTH-1:0]       quad_term_reg58;

logic signed [WIDTH-1:0]       inph_term_reg59;
logic signed [WIDTH-1:0]       quad_term_reg59;

logic signed [WIDTH-1:0]       inph_term_reg60;
logic signed [WIDTH-1:0]       quad_term_reg60;

logic signed [WIDTH-1:0]       inph_term_reg61;
logic signed [WIDTH-1:0]       quad_term_reg61;

logic signed [WIDTH-1:0]       inph_term_reg62;
logic signed [WIDTH-1:0]       quad_term_reg62;

logic signed [WIDTH-1:0]       inph_term_reg63;
logic signed [WIDTH-1:0]       quad_term_reg63;

logic signed [WIDTH:0] inph_sum_reg0;
logic signed [WIDTH:0] quad_sum_reg0;

logic signed [WIDTH:0] inph_sum_reg1;
logic signed [WIDTH:0] quad_sum_reg1;

logic signed [WIDTH:0] inph_sum_reg2;
logic signed [WIDTH:0] quad_sum_reg2;

logic signed [WIDTH:0] inph_sum_reg3;
logic signed [WIDTH:0] quad_sum_reg3;

logic signed [WIDTH:0] inph_sum_reg4;
logic signed [WIDTH:0] quad_sum_reg4;

logic signed [WIDTH:0] inph_sum_reg5;
logic signed [WIDTH:0] quad_sum_reg5;

logic signed [WIDTH:0] inph_sum_reg6;
logic signed [WIDTH:0] quad_sum_reg6;

logic signed [WIDTH:0] inph_sum_reg7;
logic signed [WIDTH:0] quad_sum_reg7;

logic signed [WIDTH:0] inph_sum_reg8;
logic signed [WIDTH:0] quad_sum_reg8;

logic signed [WIDTH:0] inph_sum_reg9;
logic signed [WIDTH:0] quad_sum_reg9;

logic signed [WIDTH:0] inph_sum_reg10;
logic signed [WIDTH:0] quad_sum_reg10;

logic signed [WIDTH:0] inph_sum_reg11;
logic signed [WIDTH:0] quad_sum_reg11;

logic signed [WIDTH:0] inph_sum_reg12;
logic signed [WIDTH:0] quad_sum_reg12;

logic signed [WIDTH:0] inph_sum_reg13;
logic signed [WIDTH:0] quad_sum_reg13;

logic signed [WIDTH:0] inph_sum_reg14;
logic signed [WIDTH:0] quad_sum_reg14;

logic signed [WIDTH:0] inph_sum_reg15;
logic signed [WIDTH:0] quad_sum_reg15;

logic signed [WIDTH:0] inph_sum_reg16;
logic signed [WIDTH:0] quad_sum_reg16;

logic signed [WIDTH:0] inph_sum_reg17;
logic signed [WIDTH:0] quad_sum_reg17;

logic signed [WIDTH:0] inph_sum_reg18;
logic signed [WIDTH:0] quad_sum_reg18;

logic signed [WIDTH:0] inph_sum_reg19;
logic signed [WIDTH:0] quad_sum_reg19;

logic signed [WIDTH:0] inph_sum_reg20;
logic signed [WIDTH:0] quad_sum_reg20;

logic signed [WIDTH:0] inph_sum_reg21;
logic signed [WIDTH:0] quad_sum_reg21;

logic signed [WIDTH:0] inph_sum_reg22;
logic signed [WIDTH:0] quad_sum_reg22;

logic signed [WIDTH:0] inph_sum_reg23;
logic signed [WIDTH:0] quad_sum_reg23;

logic signed [WIDTH:0] inph_sum_reg24;
logic signed [WIDTH:0] quad_sum_reg24;

logic signed [WIDTH:0] inph_sum_reg25;
logic signed [WIDTH:0] quad_sum_reg25;

logic signed [WIDTH:0] inph_sum_reg26;
logic signed [WIDTH:0] quad_sum_reg26;

logic signed [WIDTH:0] inph_sum_reg27;
logic signed [WIDTH:0] quad_sum_reg27;

logic signed [WIDTH:0] inph_sum_reg28;
logic signed [WIDTH:0] quad_sum_reg28;

logic signed [WIDTH:0] inph_sum_reg29;
logic signed [WIDTH:0] quad_sum_reg29;

logic signed [WIDTH:0] inph_sum_reg30;
logic signed [WIDTH:0] quad_sum_reg30;

logic signed [WIDTH:0] inph_sum_reg31;
logic signed [WIDTH:0] quad_sum_reg31;

logic signed [18+WIDTH:0] inph_prod_reg0;
logic signed [18+WIDTH:0] quad_prod_reg0;

logic signed [18+WIDTH:0] inph_prod_reg1;
logic signed [18+WIDTH:0] quad_prod_reg1;

logic signed [18+WIDTH:0] inph_prod_reg2;
logic signed [18+WIDTH:0] quad_prod_reg2;

logic signed [18+WIDTH:0] inph_prod_reg3;
logic signed [18+WIDTH:0] quad_prod_reg3;

logic signed [18+WIDTH:0] inph_prod_reg4;
logic signed [18+WIDTH:0] quad_prod_reg4;

logic signed [18+WIDTH:0] inph_prod_reg5;
logic signed [18+WIDTH:0] quad_prod_reg5;

logic signed [18+WIDTH:0] inph_prod_reg6;
logic signed [18+WIDTH:0] quad_prod_reg6;

logic signed [18+WIDTH:0] inph_prod_reg7;
logic signed [18+WIDTH:0] quad_prod_reg7;

logic signed [18+WIDTH:0] inph_prod_reg8;
logic signed [18+WIDTH:0] quad_prod_reg8;

logic signed [18+WIDTH:0] inph_prod_reg9;
logic signed [18+WIDTH:0] quad_prod_reg9;

logic signed [18+WIDTH:0] inph_prod_reg10;
logic signed [18+WIDTH:0] quad_prod_reg10;

logic signed [18+WIDTH:0] inph_prod_reg11;
logic signed [18+WIDTH:0] quad_prod_reg11;

logic signed [18+WIDTH:0] inph_prod_reg12;
logic signed [18+WIDTH:0] quad_prod_reg12;

logic signed [18+WIDTH:0] inph_prod_reg13;
logic signed [18+WIDTH:0] quad_prod_reg13;

logic signed [18+WIDTH:0] inph_prod_reg14;
logic signed [18+WIDTH:0] quad_prod_reg14;

logic signed [18+WIDTH:0] inph_prod_reg15;
logic signed [18+WIDTH:0] quad_prod_reg15;

logic signed [18+WIDTH:0] inph_prod_reg16;
logic signed [18+WIDTH:0] quad_prod_reg16;

logic signed [18+WIDTH:0] inph_prod_reg17;
logic signed [18+WIDTH:0] quad_prod_reg17;

logic signed [18+WIDTH:0] inph_prod_reg18;
logic signed [18+WIDTH:0] quad_prod_reg18;

logic signed [18+WIDTH:0] inph_prod_reg19;
logic signed [18+WIDTH:0] quad_prod_reg19;

logic signed [18+WIDTH:0] inph_prod_reg20;
logic signed [18+WIDTH:0] quad_prod_reg20;

logic signed [18+WIDTH:0] inph_prod_reg21;
logic signed [18+WIDTH:0] quad_prod_reg21;

logic signed [18+WIDTH:0] inph_prod_reg22;
logic signed [18+WIDTH:0] quad_prod_reg22;

logic signed [18+WIDTH:0] inph_prod_reg23;
logic signed [18+WIDTH:0] quad_prod_reg23;

logic signed [18+WIDTH:0] inph_prod_reg24;
logic signed [18+WIDTH:0] quad_prod_reg24;

logic signed [18+WIDTH:0] inph_prod_reg25;
logic signed [18+WIDTH:0] quad_prod_reg25;

logic signed [18+WIDTH:0] inph_prod_reg26;
logic signed [18+WIDTH:0] quad_prod_reg26;

logic signed [18+WIDTH:0] inph_prod_reg27;
logic signed [18+WIDTH:0] quad_prod_reg27;

logic signed [18+WIDTH:0] inph_prod_reg28;
logic signed [18+WIDTH:0] quad_prod_reg28;

logic signed [18+WIDTH:0] inph_prod_reg29;
logic signed [18+WIDTH:0] quad_prod_reg29;

logic signed [18+WIDTH:0] inph_prod_reg30;
logic signed [18+WIDTH:0] quad_prod_reg30;

logic signed [18+WIDTH:0] inph_prod_reg31;
logic signed [18+WIDTH:0] quad_prod_reg31;

logic signed [WIDTH-1:0] inph_del_reg0;
logic signed [WIDTH-1:0] quad_del_reg0;

logic signed [WIDTH-1:0] inph_del_reg1;
logic signed [WIDTH-1:0] quad_del_reg1;

logic signed [WIDTH-1:0] inph_del_reg2;
logic signed [WIDTH-1:0] quad_del_reg2;

logic signed [WIDTH-1:0] inph_del_reg3;
logic signed [WIDTH-1:0] quad_del_reg3;

logic signed [WIDTH-1:0] inph_del_reg4;
logic signed [WIDTH-1:0] quad_del_reg4;

logic signed [WIDTH-1:0] inph_del_reg5;
logic signed [WIDTH-1:0] quad_del_reg5;

logic signed [WIDTH-1:0] inph_del_reg6;
logic signed [WIDTH-1:0] quad_del_reg6;

logic signed [WIDTH-1:0] inph_del_reg7;
logic signed [WIDTH-1:0] quad_del_reg7;

logic signed [WIDTH-1:0] inph_del_reg8;
logic signed [WIDTH-1:0] quad_del_reg8;

logic valid1_reg0;
logic valid1_reg1;
logic valid1_reg2;
logic valid1_reg3;
logic valid1_reg4;
logic valid1_reg5;
logic valid1_reg6;
logic valid1_reg7;
logic valid1_reg8;

always_ff @ (posedge i_clock) begin
    // Preadders for E0(z)
    if ((i_valid == 1'b1) && (pp_toggle == 1'b0)) begin
        inph_term_reg0 <= i_inph_data;
        quad_term_reg0 <= i_quad_data;
    end

    inph_term_reg1 <= inph_tdl0_reg1;
    quad_term_reg1 <= quad_tdl0_reg1;

    inph_term_reg2 <= inph_tdl0_reg2;
    quad_term_reg2 <= quad_tdl0_reg2;

    inph_term_reg3 <= inph_tdl0_reg3;
    quad_term_reg3 <= quad_tdl0_reg3;

    inph_term_reg4 <= inph_tdl0_reg4;
    quad_term_reg4 <= quad_tdl0_reg4;

    inph_term_reg5 <= inph_tdl0_reg5;
    quad_term_reg5 <= quad_tdl0_reg5;

    inph_term_reg6 <= inph_tdl0_reg6;
    quad_term_reg6 <= quad_tdl0_reg6;

    inph_term_reg7 <= inph_tdl0_reg7;
    quad_term_reg7 <= quad_tdl0_reg7;

    inph_term_reg8 <= inph_tdl0_reg8;
    quad_term_reg8 <= quad_tdl0_reg8;

    inph_term_reg9 <= inph_tdl0_reg9;
    quad_term_reg9 <= quad_tdl0_reg9;

    inph_term_reg10 <= inph_tdl0_reg10;
    quad_term_reg10 <= quad_tdl0_reg10;

    inph_term_reg11 <= inph_tdl0_reg11;
    quad_term_reg11 <= quad_tdl0_reg11;

    inph_term_reg12 <= inph_tdl0_reg12;
    quad_term_reg12 <= quad_tdl0_reg12;

    inph_term_reg13 <= inph_tdl0_reg13;
    quad_term_reg13 <= quad_tdl0_reg13;

    inph_term_reg14 <= inph_tdl0_reg14;
    quad_term_reg14 <= quad_tdl0_reg14;

    inph_term_reg15 <= inph_tdl0_reg15;
    quad_term_reg15 <= quad_tdl0_reg15;

    inph_term_reg16 <= inph_tdl0_reg16;
    quad_term_reg16 <= quad_tdl0_reg16;

    inph_term_reg17 <= inph_tdl0_reg17;
    quad_term_reg17 <= quad_tdl0_reg17;

    inph_term_reg18 <= inph_tdl0_reg18;
    quad_term_reg18 <= quad_tdl0_reg18;

    inph_term_reg19 <= inph_tdl0_reg19;
    quad_term_reg19 <= quad_tdl0_reg19;

    inph_term_reg20 <= inph_tdl0_reg20;
    quad_term_reg20 <= quad_tdl0_reg20;

    inph_term_reg21 <= inph_tdl0_reg21;
    quad_term_reg21 <= quad_tdl0_reg21;

    inph_term_reg22 <= inph_tdl0_reg22;
    quad_term_reg22 <= quad_tdl0_reg22;

    inph_term_reg23 <= inph_tdl0_reg23;
    quad_term_reg23 <= quad_tdl0_reg23;

    inph_term_reg24 <= inph_tdl0_reg24;
    quad_term_reg24 <= quad_tdl0_reg24;

    inph_term_reg25 <= inph_tdl0_reg25;
    quad_term_reg25 <= quad_tdl0_reg25;

    inph_term_reg26 <= inph_tdl0_reg26;
    quad_term_reg26 <= quad_tdl0_reg26;

    inph_term_reg27 <= inph_tdl0_reg27;
    quad_term_reg27 <= quad_tdl0_reg27;

    inph_term_reg28 <= inph_tdl0_reg28;
    quad_term_reg28 <= quad_tdl0_reg28;

    inph_term_reg29 <= inph_tdl0_reg29;
    quad_term_reg29 <= quad_tdl0_reg29;

    inph_term_reg30 <= inph_tdl0_reg30;
    quad_term_reg30 <= quad_tdl0_reg30;

    inph_term_reg31 <= inph_tdl0_reg31;
    quad_term_reg31 <= quad_tdl0_reg31;

    inph_term_reg32 <= inph_tdl0_reg32;
    quad_term_reg32 <= quad_tdl0_reg32;

    inph_term_reg33 <= inph_tdl0_reg33;
    quad_term_reg33 <= quad_tdl0_reg33;

    inph_term_reg34 <= inph_tdl0_reg34;
    quad_term_reg34 <= quad_tdl0_reg34;

    inph_term_reg35 <= inph_tdl0_reg35;
    quad_term_reg35 <= quad_tdl0_reg35;

    inph_term_reg36 <= inph_tdl0_reg36;
    quad_term_reg36 <= quad_tdl0_reg36;

    inph_term_reg37 <= inph_tdl0_reg37;
    quad_term_reg37 <= quad_tdl0_reg37;

    inph_term_reg38 <= inph_tdl0_reg38;
    quad_term_reg38 <= quad_tdl0_reg38;

    inph_term_reg39 <= inph_tdl0_reg39;
    quad_term_reg39 <= quad_tdl0_reg39;

    inph_term_reg40 <= inph_tdl0_reg40;
    quad_term_reg40 <= quad_tdl0_reg40;

    inph_term_reg41 <= inph_tdl0_reg41;
    quad_term_reg41 <= quad_tdl0_reg41;

    inph_term_reg42 <= inph_tdl0_reg42;
    quad_term_reg42 <= quad_tdl0_reg42;

    inph_term_reg43 <= inph_tdl0_reg43;
    quad_term_reg43 <= quad_tdl0_reg43;

    inph_term_reg44 <= inph_tdl0_reg44;
    quad_term_reg44 <= quad_tdl0_reg44;

    inph_term_reg45 <= inph_tdl0_reg45;
    quad_term_reg45 <= quad_tdl0_reg45;

    inph_term_reg46 <= inph_tdl0_reg46;
    quad_term_reg46 <= quad_tdl0_reg46;

    inph_term_reg47 <= inph_tdl0_reg47;
    quad_term_reg47 <= quad_tdl0_reg47;

    inph_term_reg48 <= inph_tdl0_reg48;
    quad_term_reg48 <= quad_tdl0_reg48;

    inph_term_reg49 <= inph_tdl0_reg49;
    quad_term_reg49 <= quad_tdl0_reg49;

    inph_term_reg50 <= inph_tdl0_reg50;
    quad_term_reg50 <= quad_tdl0_reg50;

    inph_term_reg51 <= inph_tdl0_reg51;
    quad_term_reg51 <= quad_tdl0_reg51;

    inph_term_reg52 <= inph_tdl0_reg52;
    quad_term_reg52 <= quad_tdl0_reg52;

    inph_term_reg53 <= inph_tdl0_reg53;
    quad_term_reg53 <= quad_tdl0_reg53;

    inph_term_reg54 <= inph_tdl0_reg54;
    quad_term_reg54 <= quad_tdl0_reg54;

    inph_term_reg55 <= inph_tdl0_reg55;
    quad_term_reg55 <= quad_tdl0_reg55;

    inph_term_reg56 <= inph_tdl0_reg56;
    quad_term_reg56 <= quad_tdl0_reg56;

    inph_term_reg57 <= inph_tdl0_reg57;
    quad_term_reg57 <= quad_tdl0_reg57;

    inph_term_reg58 <= inph_tdl0_reg58;
    quad_term_reg58 <= quad_tdl0_reg58;

    inph_term_reg59 <= inph_tdl0_reg59;
    quad_term_reg59 <= quad_tdl0_reg59;

    inph_term_reg60 <= inph_tdl0_reg60;
    quad_term_reg60 <= quad_tdl0_reg60;

    inph_term_reg61 <= inph_tdl0_reg61;
    quad_term_reg61 <= quad_tdl0_reg61;

    inph_term_reg62 <= inph_tdl0_reg62;
    quad_term_reg62 <= quad_tdl0_reg62;

    inph_term_reg63 <= inph_tdl0_reg63;
    quad_term_reg63 <= quad_tdl0_reg63;

    // Preadder addition
    inph_sum_reg0 <= { inph_term_reg0[WIDTH-1], inph_term_reg0 } + { inph_term_reg63[WIDTH-1], inph_term_reg63 };
    quad_sum_reg0 <= { quad_term_reg0[WIDTH-1], quad_term_reg0 } + { quad_term_reg63[WIDTH-1], quad_term_reg63 };

    inph_sum_reg1 <= { inph_term_reg1[WIDTH-1], inph_term_reg1 } + { inph_term_reg62[WIDTH-1], inph_term_reg62 };
    quad_sum_reg1 <= { quad_term_reg1[WIDTH-1], quad_term_reg1 } + { quad_term_reg62[WIDTH-1], quad_term_reg62 };

    inph_sum_reg2 <= { inph_term_reg2[WIDTH-1], inph_term_reg2 } + { inph_term_reg61[WIDTH-1], inph_term_reg61 };
    quad_sum_reg2 <= { quad_term_reg2[WIDTH-1], quad_term_reg2 } + { quad_term_reg61[WIDTH-1], quad_term_reg61 };

    inph_sum_reg3 <= { inph_term_reg3[WIDTH-1], inph_term_reg3 } + { inph_term_reg60[WIDTH-1], inph_term_reg60 };
    quad_sum_reg3 <= { quad_term_reg3[WIDTH-1], quad_term_reg3 } + { quad_term_reg60[WIDTH-1], quad_term_reg60 };

    inph_sum_reg4 <= { inph_term_reg4[WIDTH-1], inph_term_reg4 } + { inph_term_reg59[WIDTH-1], inph_term_reg59 };
    quad_sum_reg4 <= { quad_term_reg4[WIDTH-1], quad_term_reg4 } + { quad_term_reg59[WIDTH-1], quad_term_reg59 };

    inph_sum_reg5 <= { inph_term_reg5[WIDTH-1], inph_term_reg5 } + { inph_term_reg58[WIDTH-1], inph_term_reg58 };
    quad_sum_reg5 <= { quad_term_reg5[WIDTH-1], quad_term_reg5 } + { quad_term_reg58[WIDTH-1], quad_term_reg58 };

    inph_sum_reg6 <= { inph_term_reg6[WIDTH-1], inph_term_reg6 } + { inph_term_reg57[WIDTH-1], inph_term_reg57 };
    quad_sum_reg6 <= { quad_term_reg6[WIDTH-1], quad_term_reg6 } + { quad_term_reg57[WIDTH-1], quad_term_reg57 };

    inph_sum_reg7 <= { inph_term_reg7[WIDTH-1], inph_term_reg7 } + { inph_term_reg56[WIDTH-1], inph_term_reg56 };
    quad_sum_reg7 <= { quad_term_reg7[WIDTH-1], quad_term_reg7 } + { quad_term_reg56[WIDTH-1], quad_term_reg56 };

    inph_sum_reg8 <= { inph_term_reg8[WIDTH-1], inph_term_reg8 } + { inph_term_reg55[WIDTH-1], inph_term_reg55 };
    quad_sum_reg8 <= { quad_term_reg8[WIDTH-1], quad_term_reg8 } + { quad_term_reg55[WIDTH-1], quad_term_reg55 };

    inph_sum_reg9 <= { inph_term_reg9[WIDTH-1], inph_term_reg9 } + { inph_term_reg54[WIDTH-1], inph_term_reg54 };
    quad_sum_reg9 <= { quad_term_reg9[WIDTH-1], quad_term_reg9 } + { quad_term_reg54[WIDTH-1], quad_term_reg54 };

    inph_sum_reg10 <= { inph_term_reg10[WIDTH-1], inph_term_reg10 } + { inph_term_reg53[WIDTH-1], inph_term_reg53 };
    quad_sum_reg10 <= { quad_term_reg10[WIDTH-1], quad_term_reg10 } + { quad_term_reg53[WIDTH-1], quad_term_reg53 };

    inph_sum_reg11 <= { inph_term_reg11[WIDTH-1], inph_term_reg11 } + { inph_term_reg52[WIDTH-1], inph_term_reg52 };
    quad_sum_reg11 <= { quad_term_reg11[WIDTH-1], quad_term_reg11 } + { quad_term_reg52[WIDTH-1], quad_term_reg52 };

    inph_sum_reg12 <= { inph_term_reg12[WIDTH-1], inph_term_reg12 } + { inph_term_reg51[WIDTH-1], inph_term_reg51 };
    quad_sum_reg12 <= { quad_term_reg12[WIDTH-1], quad_term_reg12 } + { quad_term_reg51[WIDTH-1], quad_term_reg51 };

    inph_sum_reg13 <= { inph_term_reg13[WIDTH-1], inph_term_reg13 } + { inph_term_reg50[WIDTH-1], inph_term_reg50 };
    quad_sum_reg13 <= { quad_term_reg13[WIDTH-1], quad_term_reg13 } + { quad_term_reg50[WIDTH-1], quad_term_reg50 };

    inph_sum_reg14 <= { inph_term_reg14[WIDTH-1], inph_term_reg14 } + { inph_term_reg49[WIDTH-1], inph_term_reg49 };
    quad_sum_reg14 <= { quad_term_reg14[WIDTH-1], quad_term_reg14 } + { quad_term_reg49[WIDTH-1], quad_term_reg49 };

    inph_sum_reg15 <= { inph_term_reg15[WIDTH-1], inph_term_reg15 } + { inph_term_reg48[WIDTH-1], inph_term_reg48 };
    quad_sum_reg15 <= { quad_term_reg15[WIDTH-1], quad_term_reg15 } + { quad_term_reg48[WIDTH-1], quad_term_reg48 };

    inph_sum_reg16 <= { inph_term_reg16[WIDTH-1], inph_term_reg16 } + { inph_term_reg47[WIDTH-1], inph_term_reg47 };
    quad_sum_reg16 <= { quad_term_reg16[WIDTH-1], quad_term_reg16 } + { quad_term_reg47[WIDTH-1], quad_term_reg47 };

    inph_sum_reg17 <= { inph_term_reg17[WIDTH-1], inph_term_reg17 } + { inph_term_reg46[WIDTH-1], inph_term_reg46 };
    quad_sum_reg17 <= { quad_term_reg17[WIDTH-1], quad_term_reg17 } + { quad_term_reg46[WIDTH-1], quad_term_reg46 };

    inph_sum_reg18 <= { inph_term_reg18[WIDTH-1], inph_term_reg18 } + { inph_term_reg45[WIDTH-1], inph_term_reg45 };
    quad_sum_reg18 <= { quad_term_reg18[WIDTH-1], quad_term_reg18 } + { quad_term_reg45[WIDTH-1], quad_term_reg45 };

    inph_sum_reg19 <= { inph_term_reg19[WIDTH-1], inph_term_reg19 } + { inph_term_reg44[WIDTH-1], inph_term_reg44 };
    quad_sum_reg19 <= { quad_term_reg19[WIDTH-1], quad_term_reg19 } + { quad_term_reg44[WIDTH-1], quad_term_reg44 };

    inph_sum_reg20 <= { inph_term_reg20[WIDTH-1], inph_term_reg20 } + { inph_term_reg43[WIDTH-1], inph_term_reg43 };
    quad_sum_reg20 <= { quad_term_reg20[WIDTH-1], quad_term_reg20 } + { quad_term_reg43[WIDTH-1], quad_term_reg43 };

    inph_sum_reg21 <= { inph_term_reg21[WIDTH-1], inph_term_reg21 } + { inph_term_reg42[WIDTH-1], inph_term_reg42 };
    quad_sum_reg21 <= { quad_term_reg21[WIDTH-1], quad_term_reg21 } + { quad_term_reg42[WIDTH-1], quad_term_reg42 };

    inph_sum_reg22 <= { inph_term_reg22[WIDTH-1], inph_term_reg22 } + { inph_term_reg41[WIDTH-1], inph_term_reg41 };
    quad_sum_reg22 <= { quad_term_reg22[WIDTH-1], quad_term_reg22 } + { quad_term_reg41[WIDTH-1], quad_term_reg41 };

    inph_sum_reg23 <= { inph_term_reg23[WIDTH-1], inph_term_reg23 } + { inph_term_reg40[WIDTH-1], inph_term_reg40 };
    quad_sum_reg23 <= { quad_term_reg23[WIDTH-1], quad_term_reg23 } + { quad_term_reg40[WIDTH-1], quad_term_reg40 };

    inph_sum_reg24 <= { inph_term_reg24[WIDTH-1], inph_term_reg24 } + { inph_term_reg39[WIDTH-1], inph_term_reg39 };
    quad_sum_reg24 <= { quad_term_reg24[WIDTH-1], quad_term_reg24 } + { quad_term_reg39[WIDTH-1], quad_term_reg39 };

    inph_sum_reg25 <= { inph_term_reg25[WIDTH-1], inph_term_reg25 } + { inph_term_reg38[WIDTH-1], inph_term_reg38 };
    quad_sum_reg25 <= { quad_term_reg25[WIDTH-1], quad_term_reg25 } + { quad_term_reg38[WIDTH-1], quad_term_reg38 };

    inph_sum_reg26 <= { inph_term_reg26[WIDTH-1], inph_term_reg26 } + { inph_term_reg37[WIDTH-1], inph_term_reg37 };
    quad_sum_reg26 <= { quad_term_reg26[WIDTH-1], quad_term_reg26 } + { quad_term_reg37[WIDTH-1], quad_term_reg37 };

    inph_sum_reg27 <= { inph_term_reg27[WIDTH-1], inph_term_reg27 } + { inph_term_reg36[WIDTH-1], inph_term_reg36 };
    quad_sum_reg27 <= { quad_term_reg27[WIDTH-1], quad_term_reg27 } + { quad_term_reg36[WIDTH-1], quad_term_reg36 };

    inph_sum_reg28 <= { inph_term_reg28[WIDTH-1], inph_term_reg28 } + { inph_term_reg35[WIDTH-1], inph_term_reg35 };
    quad_sum_reg28 <= { quad_term_reg28[WIDTH-1], quad_term_reg28 } + { quad_term_reg35[WIDTH-1], quad_term_reg35 };

    inph_sum_reg29 <= { inph_term_reg29[WIDTH-1], inph_term_reg29 } + { inph_term_reg34[WIDTH-1], inph_term_reg34 };
    quad_sum_reg29 <= { quad_term_reg29[WIDTH-1], quad_term_reg29 } + { quad_term_reg34[WIDTH-1], quad_term_reg34 };

    inph_sum_reg30 <= { inph_term_reg30[WIDTH-1], inph_term_reg30 } + { inph_term_reg33[WIDTH-1], inph_term_reg33 };
    quad_sum_reg30 <= { quad_term_reg30[WIDTH-1], quad_term_reg30 } + { quad_term_reg33[WIDTH-1], quad_term_reg33 };

    inph_sum_reg31 <= { inph_term_reg31[WIDTH-1], inph_term_reg31 } + { inph_term_reg32[WIDTH-1], inph_term_reg32 };
    quad_sum_reg31 <= { quad_term_reg31[WIDTH-1], quad_term_reg31 } + { quad_term_reg32[WIDTH-1], quad_term_reg32 };

    inph_prod_reg0 <= $signed(18'sb000000000000000000) * $signed(inph_sum_reg0);
    quad_prod_reg0 <= $signed(18'sb000000000000000000) * $signed(quad_sum_reg0);

    inph_prod_reg1 <= $signed(18'sb000000000000000001) * $signed(inph_sum_reg1);
    quad_prod_reg1 <= $signed(18'sb000000000000000001) * $signed(quad_sum_reg1);

    inph_prod_reg2 <= $signed(18'sb111111111111111110) * $signed(inph_sum_reg2);
    quad_prod_reg2 <= $signed(18'sb111111111111111110) * $signed(quad_sum_reg2);

    inph_prod_reg3 <= $signed(18'sb000000000000000100) * $signed(inph_sum_reg3);
    quad_prod_reg3 <= $signed(18'sb000000000000000100) * $signed(quad_sum_reg3);

    inph_prod_reg4 <= $signed(18'sb111111111111111000) * $signed(inph_sum_reg4);
    quad_prod_reg4 <= $signed(18'sb111111111111111000) * $signed(quad_sum_reg4);

    inph_prod_reg5 <= $signed(18'sb000000000000001101) * $signed(inph_sum_reg5);
    quad_prod_reg5 <= $signed(18'sb000000000000001101) * $signed(quad_sum_reg5);

    inph_prod_reg6 <= $signed(18'sb111111111111101010) * $signed(inph_sum_reg6);
    quad_prod_reg6 <= $signed(18'sb111111111111101010) * $signed(quad_sum_reg6);

    inph_prod_reg7 <= $signed(18'sb000000000000100010) * $signed(inph_sum_reg7);
    quad_prod_reg7 <= $signed(18'sb000000000000100010) * $signed(quad_sum_reg7);

    inph_prod_reg8 <= $signed(18'sb111111111111001100) * $signed(inph_sum_reg8);
    quad_prod_reg8 <= $signed(18'sb111111111111001100) * $signed(quad_sum_reg8);

    inph_prod_reg9 <= $signed(18'sb000000000001001101) * $signed(inph_sum_reg9);
    quad_prod_reg9 <= $signed(18'sb000000000001001101) * $signed(quad_sum_reg9);

    inph_prod_reg10 <= $signed(18'sb111111111110010001) * $signed(inph_sum_reg10);
    quad_prod_reg10 <= $signed(18'sb111111111110010001) * $signed(quad_sum_reg10);

    inph_prod_reg11 <= $signed(18'sb000000000010011100) * $signed(inph_sum_reg11);
    quad_prod_reg11 <= $signed(18'sb000000000010011100) * $signed(quad_sum_reg11);

    inph_prod_reg12 <= $signed(18'sb111111111100101000) * $signed(inph_sum_reg12);
    quad_prod_reg12 <= $signed(18'sb111111111100101000) * $signed(quad_sum_reg12);

    inph_prod_reg13 <= $signed(18'sb000000000100100101) * $signed(inph_sum_reg13);
    quad_prod_reg13 <= $signed(18'sb000000000100100101) * $signed(quad_sum_reg13);

    inph_prod_reg14 <= $signed(18'sb111111111001111001) * $signed(inph_sum_reg14);
    quad_prod_reg14 <= $signed(18'sb111111111001111001) * $signed(quad_sum_reg14);

    inph_prod_reg15 <= $signed(18'sb000000001000000011) * $signed(inph_sum_reg15);
    quad_prod_reg15 <= $signed(18'sb000000001000000011) * $signed(quad_sum_reg15);

    inph_prod_reg16 <= $signed(18'sb111111110101100011) * $signed(inph_sum_reg16);
    quad_prod_reg16 <= $signed(18'sb111111110101100011) * $signed(quad_sum_reg16);

    inph_prod_reg17 <= $signed(18'sb000000001101011011) * $signed(inph_sum_reg17);
    quad_prod_reg17 <= $signed(18'sb000000001101011011) * $signed(quad_sum_reg17);

    inph_prod_reg18 <= $signed(18'sb111111101110111100) * $signed(inph_sum_reg18);
    quad_prod_reg18 <= $signed(18'sb111111101110111100) * $signed(quad_sum_reg18);

    inph_prod_reg19 <= $signed(18'sb000000010101100000) * $signed(inph_sum_reg19);
    quad_prod_reg19 <= $signed(18'sb000000010101100000) * $signed(quad_sum_reg19);

    inph_prod_reg20 <= $signed(18'sb111111100101000111) * $signed(inph_sum_reg20);
    quad_prod_reg20 <= $signed(18'sb111111100101000111) * $signed(quad_sum_reg20);

    inph_prod_reg21 <= $signed(18'sb000000100001011101) * $signed(inph_sum_reg21);
    quad_prod_reg21 <= $signed(18'sb000000100001011101) * $signed(quad_sum_reg21);

    inph_prod_reg22 <= $signed(18'sb111111010110100010) * $signed(inph_sum_reg22);
    quad_prod_reg22 <= $signed(18'sb111111010110100010) * $signed(quad_sum_reg22);

    inph_prod_reg23 <= $signed(18'sb000000110011010101) * $signed(inph_sum_reg23);
    quad_prod_reg23 <= $signed(18'sb000000110011010101) * $signed(quad_sum_reg23);

    inph_prod_reg24 <= $signed(18'sb111111000000010110) * $signed(inph_sum_reg24);
    quad_prod_reg24 <= $signed(18'sb111111000000010110) * $signed(quad_sum_reg24);

    inph_prod_reg25 <= $signed(18'sb000001001111011100) * $signed(inph_sum_reg25);
    quad_prod_reg25 <= $signed(18'sb000001001111011100) * $signed(quad_sum_reg25);

    inph_prod_reg26 <= $signed(18'sb111110011011101010) * $signed(inph_sum_reg26);
    quad_prod_reg26 <= $signed(18'sb111110011011101010) * $signed(quad_sum_reg26);

    inph_prod_reg27 <= $signed(18'sb000010000001101000) * $signed(inph_sum_reg27);
    quad_prod_reg27 <= $signed(18'sb000010000001101000) * $signed(quad_sum_reg27);

    inph_prod_reg28 <= $signed(18'sb111101010001110110) * $signed(inph_sum_reg28);
    quad_prod_reg28 <= $signed(18'sb111101010001110110) * $signed(quad_sum_reg28);

    inph_prod_reg29 <= $signed(18'sb000011111011111111) * $signed(inph_sum_reg29);
    quad_prod_reg29 <= $signed(18'sb000011111011111111) * $signed(quad_sum_reg29);

    inph_prod_reg30 <= $signed(18'sb111001010010101110) * $signed(inph_sum_reg30);
    quad_prod_reg30 <= $signed(18'sb111001010010101110) * $signed(quad_sum_reg30);

    inph_prod_reg31 <= $signed(18'sb010100010110000001) * $signed(inph_sum_reg31);
    quad_prod_reg31 <= $signed(18'sb010100010110000001) * $signed(quad_sum_reg31);


    // Pipeline delays for E1(z)
    inph_del_reg0 <= inph_tdl1_reg31;
    quad_del_reg0 <= quad_tdl1_reg31;

    inph_del_reg1 <= inph_del_reg0;
    quad_del_reg1 <= quad_del_reg0;

    inph_del_reg2 <= inph_del_reg1;
    quad_del_reg2 <= quad_del_reg1;

    inph_del_reg3 <= inph_del_reg2;
    quad_del_reg3 <= quad_del_reg2;

    valid1_reg0 <= valid0_reg0;
    valid1_reg1 <= valid1_reg0;
    valid1_reg2 <= valid1_reg1;
    valid1_reg3 <= valid1_reg2;
end

logic signed [53:0] inph_accum0_reg0;
logic signed [53:0] quad_accum0_reg0;

logic signed [53:0] inph_accum0_reg1;
logic signed [53:0] quad_accum0_reg1;

logic signed [53:0] inph_accum0_reg2;
logic signed [53:0] quad_accum0_reg2;

logic signed [53:0] inph_accum0_reg3;
logic signed [53:0] quad_accum0_reg3;

logic signed [53:0] inph_accum0_reg4;
logic signed [53:0] quad_accum0_reg4;

logic signed [53:0] inph_accum0_reg5;
logic signed [53:0] quad_accum0_reg5;

logic signed [53:0] inph_accum0_reg6;
logic signed [53:0] quad_accum0_reg6;

logic signed [53:0] inph_accum0_reg7;
logic signed [53:0] quad_accum0_reg7;

logic signed [53:0] inph_accum0_reg8;
logic signed [53:0] quad_accum0_reg8;

logic signed [53:0] inph_accum0_reg9;
logic signed [53:0] quad_accum0_reg9;

logic signed [53:0] inph_accum0_reg10;
logic signed [53:0] quad_accum0_reg10;

logic signed [53:0] inph_accum0_reg11;
logic signed [53:0] quad_accum0_reg11;

logic signed [53:0] inph_accum0_reg12;
logic signed [53:0] quad_accum0_reg12;

logic signed [53:0] inph_accum0_reg13;
logic signed [53:0] quad_accum0_reg13;

logic signed [53:0] inph_accum0_reg14;
logic signed [53:0] quad_accum0_reg14;

logic signed [53:0] inph_accum0_reg15;
logic signed [53:0] quad_accum0_reg15;

always_ff @ (posedge i_clock) begin
    // Adder trees for FIR filter
    inph_accum0_reg0 <= inph_prod_reg0 + inph_prod_reg1;
    quad_accum0_reg0 <= quad_prod_reg0 + quad_prod_reg1;

    inph_accum0_reg1 <= inph_prod_reg2 + inph_prod_reg3;
    quad_accum0_reg1 <= quad_prod_reg2 + quad_prod_reg3;

    inph_accum0_reg2 <= inph_prod_reg4 + inph_prod_reg5;
    quad_accum0_reg2 <= quad_prod_reg4 + quad_prod_reg5;

    inph_accum0_reg3 <= inph_prod_reg6 + inph_prod_reg7;
    quad_accum0_reg3 <= quad_prod_reg6 + quad_prod_reg7;

    inph_accum0_reg4 <= inph_prod_reg8 + inph_prod_reg9;
    quad_accum0_reg4 <= quad_prod_reg8 + quad_prod_reg9;

    inph_accum0_reg5 <= inph_prod_reg10 + inph_prod_reg11;
    quad_accum0_reg5 <= quad_prod_reg10 + quad_prod_reg11;

    inph_accum0_reg6 <= inph_prod_reg12 + inph_prod_reg13;
    quad_accum0_reg6 <= quad_prod_reg12 + quad_prod_reg13;

    inph_accum0_reg7 <= inph_prod_reg14 + inph_prod_reg15;
    quad_accum0_reg7 <= quad_prod_reg14 + quad_prod_reg15;

    inph_accum0_reg8 <= inph_prod_reg16 + inph_prod_reg17;
    quad_accum0_reg8 <= quad_prod_reg16 + quad_prod_reg17;

    inph_accum0_reg9 <= inph_prod_reg18 + inph_prod_reg19;
    quad_accum0_reg9 <= quad_prod_reg18 + quad_prod_reg19;

    inph_accum0_reg10 <= inph_prod_reg20 + inph_prod_reg21;
    quad_accum0_reg10 <= quad_prod_reg20 + quad_prod_reg21;

    inph_accum0_reg11 <= inph_prod_reg22 + inph_prod_reg23;
    quad_accum0_reg11 <= quad_prod_reg22 + quad_prod_reg23;

    inph_accum0_reg12 <= inph_prod_reg24 + inph_prod_reg25;
    quad_accum0_reg12 <= quad_prod_reg24 + quad_prod_reg25;

    inph_accum0_reg13 <= inph_prod_reg26 + inph_prod_reg27;
    quad_accum0_reg13 <= quad_prod_reg26 + quad_prod_reg27;

    inph_accum0_reg14 <= inph_prod_reg28 + inph_prod_reg29;
    quad_accum0_reg14 <= quad_prod_reg28 + quad_prod_reg29;

    inph_accum0_reg15 <= inph_prod_reg30 + inph_prod_reg31;
    quad_accum0_reg15 <= quad_prod_reg30 + quad_prod_reg31;

    inph_del_reg4 <= inph_del_reg3;
    quad_del_reg4 <= quad_del_reg3;

    valid1_reg4 <= valid1_reg3;
end

logic signed [53:0] inph_accum1_reg0;
logic signed [53:0] quad_accum1_reg0;

logic signed [53:0] inph_accum1_reg1;
logic signed [53:0] quad_accum1_reg1;

logic signed [53:0] inph_accum1_reg2;
logic signed [53:0] quad_accum1_reg2;

logic signed [53:0] inph_accum1_reg3;
logic signed [53:0] quad_accum1_reg3;

logic signed [53:0] inph_accum1_reg4;
logic signed [53:0] quad_accum1_reg4;

logic signed [53:0] inph_accum1_reg5;
logic signed [53:0] quad_accum1_reg5;

logic signed [53:0] inph_accum1_reg6;
logic signed [53:0] quad_accum1_reg6;

logic signed [53:0] inph_accum1_reg7;
logic signed [53:0] quad_accum1_reg7;

always_ff @ (posedge i_clock) begin
    // Adder trees for FIR filter
    inph_accum1_reg0 <= inph_accum0_reg0 + inph_accum0_reg1;
    quad_accum1_reg0 <= quad_accum0_reg0 + quad_accum0_reg1;

    inph_accum1_reg1 <= inph_accum0_reg2 + inph_accum0_reg3;
    quad_accum1_reg1 <= quad_accum0_reg2 + quad_accum0_reg3;

    inph_accum1_reg2 <= inph_accum0_reg4 + inph_accum0_reg5;
    quad_accum1_reg2 <= quad_accum0_reg4 + quad_accum0_reg5;

    inph_accum1_reg3 <= inph_accum0_reg6 + inph_accum0_reg7;
    quad_accum1_reg3 <= quad_accum0_reg6 + quad_accum0_reg7;

    inph_accum1_reg4 <= inph_accum0_reg8 + inph_accum0_reg9;
    quad_accum1_reg4 <= quad_accum0_reg8 + quad_accum0_reg9;

    inph_accum1_reg5 <= inph_accum0_reg10 + inph_accum0_reg11;
    quad_accum1_reg5 <= quad_accum0_reg10 + quad_accum0_reg11;

    inph_accum1_reg6 <= inph_accum0_reg12 + inph_accum0_reg13;
    quad_accum1_reg6 <= quad_accum0_reg12 + quad_accum0_reg13;

    inph_accum1_reg7 <= inph_accum0_reg14 + inph_accum0_reg15;
    quad_accum1_reg7 <= quad_accum0_reg14 + quad_accum0_reg15;

    inph_del_reg5 <= inph_del_reg4;
    quad_del_reg5 <= quad_del_reg4;

    valid1_reg5 <= valid1_reg4;
end

logic signed [53:0] inph_accum2_reg0;
logic signed [53:0] quad_accum2_reg0;

logic signed [53:0] inph_accum2_reg1;
logic signed [53:0] quad_accum2_reg1;

logic signed [53:0] inph_accum2_reg2;
logic signed [53:0] quad_accum2_reg2;

logic signed [53:0] inph_accum2_reg3;
logic signed [53:0] quad_accum2_reg3;

always_ff @ (posedge i_clock) begin
    // Adder trees for FIR filter
    inph_accum2_reg0 <= inph_accum1_reg0 + inph_accum1_reg1;
    quad_accum2_reg0 <= quad_accum1_reg0 + quad_accum1_reg1;

    inph_accum2_reg1 <= inph_accum1_reg2 + inph_accum1_reg3;
    quad_accum2_reg1 <= quad_accum1_reg2 + quad_accum1_reg3;

    inph_accum2_reg2 <= inph_accum1_reg4 + inph_accum1_reg5;
    quad_accum2_reg2 <= quad_accum1_reg4 + quad_accum1_reg5;

    inph_accum2_reg3 <= inph_accum1_reg6 + inph_accum1_reg7;
    quad_accum2_reg3 <= quad_accum1_reg6 + quad_accum1_reg7;

    inph_del_reg6 <= inph_del_reg5;
    quad_del_reg6 <= quad_del_reg5;

    valid1_reg6 <= valid1_reg5;
end

logic signed [53:0] inph_accum3_reg0;
logic signed [53:0] quad_accum3_reg0;

logic signed [53:0] inph_accum3_reg1;
logic signed [53:0] quad_accum3_reg1;

always_ff @ (posedge i_clock) begin
    // Adder trees for FIR filter
    inph_accum3_reg0 <= inph_accum2_reg0 + inph_accum2_reg1;
    quad_accum3_reg0 <= quad_accum2_reg0 + quad_accum2_reg1;

    inph_accum3_reg1 <= inph_accum2_reg2 + inph_accum2_reg3;
    quad_accum3_reg1 <= quad_accum2_reg2 + quad_accum2_reg3;

    inph_del_reg7 <= inph_del_reg6;
    quad_del_reg7 <= quad_del_reg6;

    valid1_reg7 <= valid1_reg6;
end

logic signed [53:0] inph_accum4_reg0;
logic signed [53:0] quad_accum4_reg0;

always_ff @ (posedge i_clock) begin
    // Adder trees for FIR filter
    inph_accum4_reg0 <= inph_accum3_reg0 + inph_accum3_reg1;
    quad_accum4_reg0 <= quad_accum3_reg0 + quad_accum3_reg1;

    inph_del_reg8 <= inph_del_reg7;
    quad_del_reg8 <= quad_del_reg7;

    valid1_reg8 <= valid1_reg7;
end

logic signed [53:0] concatenated_inph_delay;
logic signed [53:0] concatenated_quad_delay;
logic signed [53:0] inph_output_reg;
logic signed [53:0] quad_output_reg;

logic valid2_reg0;

always_ff @ (posedge i_clock) begin
    concatenated_inph_delay = {
        {(54-17-WIDTH){inph_del_reg8[WIDTH-1]}},
        inph_del_reg8,
        1'b1, // For round half-up algorithm
        16'b0
    };
    concatenated_quad_delay = {
        {(54-17-WIDTH){quad_del_reg8[WIDTH-1]}},
        quad_del_reg8,
        1'b1, // For round half-up algorithm
        16'b0
    };
    inph_output_reg <= inph_accum4_reg0 + concatenated_inph_delay;
    quad_output_reg <= quad_accum4_reg0 + concatenated_quad_delay;

    valid2_reg0 <= valid1_reg8;
end

always_ff @ (posedge i_clock) begin
    if (valid2_reg0 == 1'b1) begin
        if ($signed(inph_output_reg[53:WIDTH+18-1]) > 0) begin
            o_inph_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(inph_output_reg[53:WIDTH+18-1]) < -1) begin
            o_inph_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_inph_data <= inph_output_reg[WIDTH+18-1:18];
        end
        if ($signed(quad_output_reg[53:WIDTH+18-1]) > 0) begin
            o_quad_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(quad_output_reg[53:WIDTH+18-1]) < -1) begin
            o_quad_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_quad_data <= quad_output_reg[WIDTH+18-1:18];
        end
    end

    o_valid <= valid2_reg0;
end

endmodule: ddc_hb_decim_fir_h3


`default_nettype wire
