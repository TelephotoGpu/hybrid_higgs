`timescale 10ps / 10ps

`default_nettype none


module duc_hb_interp_fir_h2 #(
    parameter integer WIDTH = 16
) (
    input  wire logic [WIDTH-1:0] i_inph_data,
    input  wire logic [WIDTH-1:0] i_quad_data,
    output wire logic             o_ready,
    output      logic [WIDTH-1:0] o_inph_data,
    output      logic [WIDTH-1:0] o_quad_data,
    input  wire logic             i_ready,
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
    end else if (i_ready == 1'b1) begin
        pp_toggle <= ~pp_toggle;
    end
end

assign o_ready = i_ready & ~pp_toggle;

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

logic signed [WIDTH-1:0]       inph_tdl0_reg64;
logic signed [WIDTH-1:0]       quad_tdl0_reg64;

logic signed [WIDTH-1:0]       inph_tdl0_reg65;
logic signed [WIDTH-1:0]       quad_tdl0_reg65;

logic signed [WIDTH-1:0]       inph_tdl0_reg66;
logic signed [WIDTH-1:0]       quad_tdl0_reg66;

logic signed [WIDTH-1:0]       inph_tdl0_reg67;
logic signed [WIDTH-1:0]       quad_tdl0_reg67;

logic signed [WIDTH-1:0]       inph_tdl0_reg68;
logic signed [WIDTH-1:0]       quad_tdl0_reg68;

logic signed [WIDTH-1:0]       inph_tdl0_reg69;
logic signed [WIDTH-1:0]       quad_tdl0_reg69;

logic signed [WIDTH-1:0]       inph_tdl0_reg70;
logic signed [WIDTH-1:0]       quad_tdl0_reg70;

logic signed [WIDTH-1:0]       inph_tdl0_reg71;
logic signed [WIDTH-1:0]       quad_tdl0_reg71;

logic signed [WIDTH-1:0]       inph_tdl0_reg72;
logic signed [WIDTH-1:0]       quad_tdl0_reg72;

logic signed [WIDTH-1:0]       inph_tdl0_reg73;
logic signed [WIDTH-1:0]       quad_tdl0_reg73;

logic signed [WIDTH-1:0]       inph_tdl0_reg74;
logic signed [WIDTH-1:0]       quad_tdl0_reg74;

logic signed [WIDTH-1:0]       inph_tdl0_reg75;
logic signed [WIDTH-1:0]       quad_tdl0_reg75;

logic signed [WIDTH-1:0]       inph_tdl0_reg76;
logic signed [WIDTH-1:0]       quad_tdl0_reg76;

logic signed [WIDTH-1:0]       inph_tdl0_reg77;
logic signed [WIDTH-1:0]       quad_tdl0_reg77;

logic signed [WIDTH-1:0]       inph_tdl0_reg78;
logic signed [WIDTH-1:0]       quad_tdl0_reg78;

logic signed [WIDTH-1:0]       inph_tdl0_reg79;
logic signed [WIDTH-1:0]       quad_tdl0_reg79;

logic signed [WIDTH-1:0]       inph_tdl0_reg80;
logic signed [WIDTH-1:0]       quad_tdl0_reg80;

logic signed [WIDTH-1:0]       inph_tdl0_reg81;
logic signed [WIDTH-1:0]       quad_tdl0_reg81;

logic signed [WIDTH-1:0]       inph_tdl0_reg82;
logic signed [WIDTH-1:0]       quad_tdl0_reg82;

logic signed [WIDTH-1:0]       inph_tdl0_reg83;
logic signed [WIDTH-1:0]       quad_tdl0_reg83;

logic signed [WIDTH-1:0]       inph_tdl0_reg84;
logic signed [WIDTH-1:0]       quad_tdl0_reg84;

logic signed [WIDTH-1:0]       inph_tdl0_reg85;
logic signed [WIDTH-1:0]       quad_tdl0_reg85;

logic signed [WIDTH-1:0]       inph_tdl0_reg86;
logic signed [WIDTH-1:0]       quad_tdl0_reg86;

logic signed [WIDTH-1:0]       inph_tdl0_reg87;
logic signed [WIDTH-1:0]       quad_tdl0_reg87;

logic signed [WIDTH-1:0]       inph_tdl0_reg88;
logic signed [WIDTH-1:0]       quad_tdl0_reg88;

logic signed [WIDTH-1:0]       inph_tdl0_reg89;
logic signed [WIDTH-1:0]       quad_tdl0_reg89;

logic signed [WIDTH-1:0]       inph_tdl0_reg90;
logic signed [WIDTH-1:0]       quad_tdl0_reg90;

logic signed [WIDTH-1:0]       inph_tdl0_reg91;
logic signed [WIDTH-1:0]       quad_tdl0_reg91;

logic signed [WIDTH-1:0]       inph_tdl0_reg92;
logic signed [WIDTH-1:0]       quad_tdl0_reg92;

logic signed [WIDTH-1:0]       inph_tdl0_reg93;
logic signed [WIDTH-1:0]       quad_tdl0_reg93;

logic signed [WIDTH-1:0]       inph_tdl0_reg94;
logic signed [WIDTH-1:0]       quad_tdl0_reg94;

logic signed [WIDTH-1:0]       inph_tdl0_reg95;
logic signed [WIDTH-1:0]       quad_tdl0_reg95;

logic signed [WIDTH-1:0]       inph_tdl0_reg96;
logic signed [WIDTH-1:0]       quad_tdl0_reg96;

logic signed [WIDTH-1:0]       inph_tdl0_reg97;
logic signed [WIDTH-1:0]       quad_tdl0_reg97;

logic signed [WIDTH-1:0]       inph_tdl0_reg98;
logic signed [WIDTH-1:0]       quad_tdl0_reg98;

logic signed [WIDTH-1:0]       inph_tdl0_reg99;
logic signed [WIDTH-1:0]       quad_tdl0_reg99;

logic signed [WIDTH-1:0]       inph_tdl0_reg100;
logic signed [WIDTH-1:0]       quad_tdl0_reg100;

logic signed [WIDTH-1:0]       inph_tdl0_reg101;
logic signed [WIDTH-1:0]       quad_tdl0_reg101;

logic signed [WIDTH-1:0]       inph_tdl0_reg102;
logic signed [WIDTH-1:0]       quad_tdl0_reg102;

logic signed [WIDTH-1:0]       inph_tdl0_reg103;
logic signed [WIDTH-1:0]       quad_tdl0_reg103;

logic signed [WIDTH-1:0]       inph_tdl0_reg104;
logic signed [WIDTH-1:0]       quad_tdl0_reg104;

logic signed [WIDTH-1:0]       inph_tdl0_reg105;
logic signed [WIDTH-1:0]       quad_tdl0_reg105;

logic signed [WIDTH-1:0]       inph_tdl0_reg106;
logic signed [WIDTH-1:0]       quad_tdl0_reg106;

logic signed [WIDTH-1:0]       inph_tdl0_reg107;
logic signed [WIDTH-1:0]       quad_tdl0_reg107;

logic signed [WIDTH-1:0]       inph_tdl0_reg108;
logic signed [WIDTH-1:0]       quad_tdl0_reg108;

logic signed [WIDTH-1:0]       inph_tdl0_reg109;
logic signed [WIDTH-1:0]       quad_tdl0_reg109;

logic signed [WIDTH-1:0]       inph_tdl0_reg110;
logic signed [WIDTH-1:0]       quad_tdl0_reg110;

logic signed [WIDTH-1:0]       inph_tdl0_reg111;
logic signed [WIDTH-1:0]       quad_tdl0_reg111;

logic signed [WIDTH-1:0]       inph_tdl0_reg112;
logic signed [WIDTH-1:0]       quad_tdl0_reg112;

logic signed [WIDTH-1:0]       inph_tdl0_reg113;
logic signed [WIDTH-1:0]       quad_tdl0_reg113;

logic signed [WIDTH-1:0]       inph_tdl0_reg114;
logic signed [WIDTH-1:0]       quad_tdl0_reg114;

logic signed [WIDTH-1:0]       inph_tdl0_reg115;
logic signed [WIDTH-1:0]       quad_tdl0_reg115;

logic signed [WIDTH-1:0]       inph_tdl0_reg116;
logic signed [WIDTH-1:0]       quad_tdl0_reg116;

logic signed [WIDTH-1:0]       inph_tdl0_reg117;
logic signed [WIDTH-1:0]       quad_tdl0_reg117;

logic signed [WIDTH-1:0]       inph_tdl0_reg118;
logic signed [WIDTH-1:0]       quad_tdl0_reg118;

logic signed [WIDTH-1:0]       inph_tdl0_reg119;
logic signed [WIDTH-1:0]       quad_tdl0_reg119;

logic signed [WIDTH-1:0]       inph_tdl0_reg120;
logic signed [WIDTH-1:0]       quad_tdl0_reg120;

logic signed [WIDTH-1:0]       inph_tdl0_reg121;
logic signed [WIDTH-1:0]       quad_tdl0_reg121;

logic signed [WIDTH-1:0]       inph_tdl0_reg122;
logic signed [WIDTH-1:0]       quad_tdl0_reg122;

logic signed [WIDTH-1:0]       inph_tdl0_reg123;
logic signed [WIDTH-1:0]       quad_tdl0_reg123;

logic signed [WIDTH-1:0]       inph_tdl0_reg124;
logic signed [WIDTH-1:0]       quad_tdl0_reg124;

logic signed [WIDTH-1:0]       inph_tdl0_reg125;
logic signed [WIDTH-1:0]       quad_tdl0_reg125;

logic signed [WIDTH-1:0]       inph_tdl0_reg126;
logic signed [WIDTH-1:0]       quad_tdl0_reg126;

logic signed [WIDTH-1:0]       inph_tdl0_reg127;
logic signed [WIDTH-1:0]       quad_tdl0_reg127;

always_ff @ (posedge i_clock) begin
    // Tap delay line for polyphase component zero and one
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
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
        inph_tdl0_reg64 <= inph_tdl0_reg63;
        quad_tdl0_reg64 <= quad_tdl0_reg63;
        inph_tdl0_reg65 <= inph_tdl0_reg64;
        quad_tdl0_reg65 <= quad_tdl0_reg64;
        inph_tdl0_reg66 <= inph_tdl0_reg65;
        quad_tdl0_reg66 <= quad_tdl0_reg65;
        inph_tdl0_reg67 <= inph_tdl0_reg66;
        quad_tdl0_reg67 <= quad_tdl0_reg66;
        inph_tdl0_reg68 <= inph_tdl0_reg67;
        quad_tdl0_reg68 <= quad_tdl0_reg67;
        inph_tdl0_reg69 <= inph_tdl0_reg68;
        quad_tdl0_reg69 <= quad_tdl0_reg68;
        inph_tdl0_reg70 <= inph_tdl0_reg69;
        quad_tdl0_reg70 <= quad_tdl0_reg69;
        inph_tdl0_reg71 <= inph_tdl0_reg70;
        quad_tdl0_reg71 <= quad_tdl0_reg70;
        inph_tdl0_reg72 <= inph_tdl0_reg71;
        quad_tdl0_reg72 <= quad_tdl0_reg71;
        inph_tdl0_reg73 <= inph_tdl0_reg72;
        quad_tdl0_reg73 <= quad_tdl0_reg72;
        inph_tdl0_reg74 <= inph_tdl0_reg73;
        quad_tdl0_reg74 <= quad_tdl0_reg73;
        inph_tdl0_reg75 <= inph_tdl0_reg74;
        quad_tdl0_reg75 <= quad_tdl0_reg74;
        inph_tdl0_reg76 <= inph_tdl0_reg75;
        quad_tdl0_reg76 <= quad_tdl0_reg75;
        inph_tdl0_reg77 <= inph_tdl0_reg76;
        quad_tdl0_reg77 <= quad_tdl0_reg76;
        inph_tdl0_reg78 <= inph_tdl0_reg77;
        quad_tdl0_reg78 <= quad_tdl0_reg77;
        inph_tdl0_reg79 <= inph_tdl0_reg78;
        quad_tdl0_reg79 <= quad_tdl0_reg78;
        inph_tdl0_reg80 <= inph_tdl0_reg79;
        quad_tdl0_reg80 <= quad_tdl0_reg79;
        inph_tdl0_reg81 <= inph_tdl0_reg80;
        quad_tdl0_reg81 <= quad_tdl0_reg80;
        inph_tdl0_reg82 <= inph_tdl0_reg81;
        quad_tdl0_reg82 <= quad_tdl0_reg81;
        inph_tdl0_reg83 <= inph_tdl0_reg82;
        quad_tdl0_reg83 <= quad_tdl0_reg82;
        inph_tdl0_reg84 <= inph_tdl0_reg83;
        quad_tdl0_reg84 <= quad_tdl0_reg83;
        inph_tdl0_reg85 <= inph_tdl0_reg84;
        quad_tdl0_reg85 <= quad_tdl0_reg84;
        inph_tdl0_reg86 <= inph_tdl0_reg85;
        quad_tdl0_reg86 <= quad_tdl0_reg85;
        inph_tdl0_reg87 <= inph_tdl0_reg86;
        quad_tdl0_reg87 <= quad_tdl0_reg86;
        inph_tdl0_reg88 <= inph_tdl0_reg87;
        quad_tdl0_reg88 <= quad_tdl0_reg87;
        inph_tdl0_reg89 <= inph_tdl0_reg88;
        quad_tdl0_reg89 <= quad_tdl0_reg88;
        inph_tdl0_reg90 <= inph_tdl0_reg89;
        quad_tdl0_reg90 <= quad_tdl0_reg89;
        inph_tdl0_reg91 <= inph_tdl0_reg90;
        quad_tdl0_reg91 <= quad_tdl0_reg90;
        inph_tdl0_reg92 <= inph_tdl0_reg91;
        quad_tdl0_reg92 <= quad_tdl0_reg91;
        inph_tdl0_reg93 <= inph_tdl0_reg92;
        quad_tdl0_reg93 <= quad_tdl0_reg92;
        inph_tdl0_reg94 <= inph_tdl0_reg93;
        quad_tdl0_reg94 <= quad_tdl0_reg93;
        inph_tdl0_reg95 <= inph_tdl0_reg94;
        quad_tdl0_reg95 <= quad_tdl0_reg94;
        inph_tdl0_reg96 <= inph_tdl0_reg95;
        quad_tdl0_reg96 <= quad_tdl0_reg95;
        inph_tdl0_reg97 <= inph_tdl0_reg96;
        quad_tdl0_reg97 <= quad_tdl0_reg96;
        inph_tdl0_reg98 <= inph_tdl0_reg97;
        quad_tdl0_reg98 <= quad_tdl0_reg97;
        inph_tdl0_reg99 <= inph_tdl0_reg98;
        quad_tdl0_reg99 <= quad_tdl0_reg98;
        inph_tdl0_reg100 <= inph_tdl0_reg99;
        quad_tdl0_reg100 <= quad_tdl0_reg99;
        inph_tdl0_reg101 <= inph_tdl0_reg100;
        quad_tdl0_reg101 <= quad_tdl0_reg100;
        inph_tdl0_reg102 <= inph_tdl0_reg101;
        quad_tdl0_reg102 <= quad_tdl0_reg101;
        inph_tdl0_reg103 <= inph_tdl0_reg102;
        quad_tdl0_reg103 <= quad_tdl0_reg102;
        inph_tdl0_reg104 <= inph_tdl0_reg103;
        quad_tdl0_reg104 <= quad_tdl0_reg103;
        inph_tdl0_reg105 <= inph_tdl0_reg104;
        quad_tdl0_reg105 <= quad_tdl0_reg104;
        inph_tdl0_reg106 <= inph_tdl0_reg105;
        quad_tdl0_reg106 <= quad_tdl0_reg105;
        inph_tdl0_reg107 <= inph_tdl0_reg106;
        quad_tdl0_reg107 <= quad_tdl0_reg106;
        inph_tdl0_reg108 <= inph_tdl0_reg107;
        quad_tdl0_reg108 <= quad_tdl0_reg107;
        inph_tdl0_reg109 <= inph_tdl0_reg108;
        quad_tdl0_reg109 <= quad_tdl0_reg108;
        inph_tdl0_reg110 <= inph_tdl0_reg109;
        quad_tdl0_reg110 <= quad_tdl0_reg109;
        inph_tdl0_reg111 <= inph_tdl0_reg110;
        quad_tdl0_reg111 <= quad_tdl0_reg110;
        inph_tdl0_reg112 <= inph_tdl0_reg111;
        quad_tdl0_reg112 <= quad_tdl0_reg111;
        inph_tdl0_reg113 <= inph_tdl0_reg112;
        quad_tdl0_reg113 <= quad_tdl0_reg112;
        inph_tdl0_reg114 <= inph_tdl0_reg113;
        quad_tdl0_reg114 <= quad_tdl0_reg113;
        inph_tdl0_reg115 <= inph_tdl0_reg114;
        quad_tdl0_reg115 <= quad_tdl0_reg114;
        inph_tdl0_reg116 <= inph_tdl0_reg115;
        quad_tdl0_reg116 <= quad_tdl0_reg115;
        inph_tdl0_reg117 <= inph_tdl0_reg116;
        quad_tdl0_reg117 <= quad_tdl0_reg116;
        inph_tdl0_reg118 <= inph_tdl0_reg117;
        quad_tdl0_reg118 <= quad_tdl0_reg117;
        inph_tdl0_reg119 <= inph_tdl0_reg118;
        quad_tdl0_reg119 <= quad_tdl0_reg118;
        inph_tdl0_reg120 <= inph_tdl0_reg119;
        quad_tdl0_reg120 <= quad_tdl0_reg119;
        inph_tdl0_reg121 <= inph_tdl0_reg120;
        quad_tdl0_reg121 <= quad_tdl0_reg120;
        inph_tdl0_reg122 <= inph_tdl0_reg121;
        quad_tdl0_reg122 <= quad_tdl0_reg121;
        inph_tdl0_reg123 <= inph_tdl0_reg122;
        quad_tdl0_reg123 <= quad_tdl0_reg122;
        inph_tdl0_reg124 <= inph_tdl0_reg123;
        quad_tdl0_reg124 <= quad_tdl0_reg123;
        inph_tdl0_reg125 <= inph_tdl0_reg124;
        quad_tdl0_reg125 <= quad_tdl0_reg124;
        inph_tdl0_reg126 <= inph_tdl0_reg125;
        quad_tdl0_reg126 <= quad_tdl0_reg125;
        inph_tdl0_reg127 <= inph_tdl0_reg126;
        quad_tdl0_reg127 <= quad_tdl0_reg126;
    end
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

logic signed [WIDTH-1:0]       inph_term_reg64;
logic signed [WIDTH-1:0]       quad_term_reg64;

logic signed [WIDTH-1:0]       inph_term_reg65;
logic signed [WIDTH-1:0]       quad_term_reg65;

logic signed [WIDTH-1:0]       inph_term_reg66;
logic signed [WIDTH-1:0]       quad_term_reg66;

logic signed [WIDTH-1:0]       inph_term_reg67;
logic signed [WIDTH-1:0]       quad_term_reg67;

logic signed [WIDTH-1:0]       inph_term_reg68;
logic signed [WIDTH-1:0]       quad_term_reg68;

logic signed [WIDTH-1:0]       inph_term_reg69;
logic signed [WIDTH-1:0]       quad_term_reg69;

logic signed [WIDTH-1:0]       inph_term_reg70;
logic signed [WIDTH-1:0]       quad_term_reg70;

logic signed [WIDTH-1:0]       inph_term_reg71;
logic signed [WIDTH-1:0]       quad_term_reg71;

logic signed [WIDTH-1:0]       inph_term_reg72;
logic signed [WIDTH-1:0]       quad_term_reg72;

logic signed [WIDTH-1:0]       inph_term_reg73;
logic signed [WIDTH-1:0]       quad_term_reg73;

logic signed [WIDTH-1:0]       inph_term_reg74;
logic signed [WIDTH-1:0]       quad_term_reg74;

logic signed [WIDTH-1:0]       inph_term_reg75;
logic signed [WIDTH-1:0]       quad_term_reg75;

logic signed [WIDTH-1:0]       inph_term_reg76;
logic signed [WIDTH-1:0]       quad_term_reg76;

logic signed [WIDTH-1:0]       inph_term_reg77;
logic signed [WIDTH-1:0]       quad_term_reg77;

logic signed [WIDTH-1:0]       inph_term_reg78;
logic signed [WIDTH-1:0]       quad_term_reg78;

logic signed [WIDTH-1:0]       inph_term_reg79;
logic signed [WIDTH-1:0]       quad_term_reg79;

logic signed [WIDTH-1:0]       inph_term_reg80;
logic signed [WIDTH-1:0]       quad_term_reg80;

logic signed [WIDTH-1:0]       inph_term_reg81;
logic signed [WIDTH-1:0]       quad_term_reg81;

logic signed [WIDTH-1:0]       inph_term_reg82;
logic signed [WIDTH-1:0]       quad_term_reg82;

logic signed [WIDTH-1:0]       inph_term_reg83;
logic signed [WIDTH-1:0]       quad_term_reg83;

logic signed [WIDTH-1:0]       inph_term_reg84;
logic signed [WIDTH-1:0]       quad_term_reg84;

logic signed [WIDTH-1:0]       inph_term_reg85;
logic signed [WIDTH-1:0]       quad_term_reg85;

logic signed [WIDTH-1:0]       inph_term_reg86;
logic signed [WIDTH-1:0]       quad_term_reg86;

logic signed [WIDTH-1:0]       inph_term_reg87;
logic signed [WIDTH-1:0]       quad_term_reg87;

logic signed [WIDTH-1:0]       inph_term_reg88;
logic signed [WIDTH-1:0]       quad_term_reg88;

logic signed [WIDTH-1:0]       inph_term_reg89;
logic signed [WIDTH-1:0]       quad_term_reg89;

logic signed [WIDTH-1:0]       inph_term_reg90;
logic signed [WIDTH-1:0]       quad_term_reg90;

logic signed [WIDTH-1:0]       inph_term_reg91;
logic signed [WIDTH-1:0]       quad_term_reg91;

logic signed [WIDTH-1:0]       inph_term_reg92;
logic signed [WIDTH-1:0]       quad_term_reg92;

logic signed [WIDTH-1:0]       inph_term_reg93;
logic signed [WIDTH-1:0]       quad_term_reg93;

logic signed [WIDTH-1:0]       inph_term_reg94;
logic signed [WIDTH-1:0]       quad_term_reg94;

logic signed [WIDTH-1:0]       inph_term_reg95;
logic signed [WIDTH-1:0]       quad_term_reg95;

logic signed [WIDTH-1:0]       inph_term_reg96;
logic signed [WIDTH-1:0]       quad_term_reg96;

logic signed [WIDTH-1:0]       inph_term_reg97;
logic signed [WIDTH-1:0]       quad_term_reg97;

logic signed [WIDTH-1:0]       inph_term_reg98;
logic signed [WIDTH-1:0]       quad_term_reg98;

logic signed [WIDTH-1:0]       inph_term_reg99;
logic signed [WIDTH-1:0]       quad_term_reg99;

logic signed [WIDTH-1:0]       inph_term_reg100;
logic signed [WIDTH-1:0]       quad_term_reg100;

logic signed [WIDTH-1:0]       inph_term_reg101;
logic signed [WIDTH-1:0]       quad_term_reg101;

logic signed [WIDTH-1:0]       inph_term_reg102;
logic signed [WIDTH-1:0]       quad_term_reg102;

logic signed [WIDTH-1:0]       inph_term_reg103;
logic signed [WIDTH-1:0]       quad_term_reg103;

logic signed [WIDTH-1:0]       inph_term_reg104;
logic signed [WIDTH-1:0]       quad_term_reg104;

logic signed [WIDTH-1:0]       inph_term_reg105;
logic signed [WIDTH-1:0]       quad_term_reg105;

logic signed [WIDTH-1:0]       inph_term_reg106;
logic signed [WIDTH-1:0]       quad_term_reg106;

logic signed [WIDTH-1:0]       inph_term_reg107;
logic signed [WIDTH-1:0]       quad_term_reg107;

logic signed [WIDTH-1:0]       inph_term_reg108;
logic signed [WIDTH-1:0]       quad_term_reg108;

logic signed [WIDTH-1:0]       inph_term_reg109;
logic signed [WIDTH-1:0]       quad_term_reg109;

logic signed [WIDTH-1:0]       inph_term_reg110;
logic signed [WIDTH-1:0]       quad_term_reg110;

logic signed [WIDTH-1:0]       inph_term_reg111;
logic signed [WIDTH-1:0]       quad_term_reg111;

logic signed [WIDTH-1:0]       inph_term_reg112;
logic signed [WIDTH-1:0]       quad_term_reg112;

logic signed [WIDTH-1:0]       inph_term_reg113;
logic signed [WIDTH-1:0]       quad_term_reg113;

logic signed [WIDTH-1:0]       inph_term_reg114;
logic signed [WIDTH-1:0]       quad_term_reg114;

logic signed [WIDTH-1:0]       inph_term_reg115;
logic signed [WIDTH-1:0]       quad_term_reg115;

logic signed [WIDTH-1:0]       inph_term_reg116;
logic signed [WIDTH-1:0]       quad_term_reg116;

logic signed [WIDTH-1:0]       inph_term_reg117;
logic signed [WIDTH-1:0]       quad_term_reg117;

logic signed [WIDTH-1:0]       inph_term_reg118;
logic signed [WIDTH-1:0]       quad_term_reg118;

logic signed [WIDTH-1:0]       inph_term_reg119;
logic signed [WIDTH-1:0]       quad_term_reg119;

logic signed [WIDTH-1:0]       inph_term_reg120;
logic signed [WIDTH-1:0]       quad_term_reg120;

logic signed [WIDTH-1:0]       inph_term_reg121;
logic signed [WIDTH-1:0]       quad_term_reg121;

logic signed [WIDTH-1:0]       inph_term_reg122;
logic signed [WIDTH-1:0]       quad_term_reg122;

logic signed [WIDTH-1:0]       inph_term_reg123;
logic signed [WIDTH-1:0]       quad_term_reg123;

logic signed [WIDTH-1:0]       inph_term_reg124;
logic signed [WIDTH-1:0]       quad_term_reg124;

logic signed [WIDTH-1:0]       inph_term_reg125;
logic signed [WIDTH-1:0]       quad_term_reg125;

logic signed [WIDTH-1:0]       inph_term_reg126;
logic signed [WIDTH-1:0]       quad_term_reg126;

logic signed [WIDTH-1:0]       inph_term_reg127;
logic signed [WIDTH-1:0]       quad_term_reg127;

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

logic signed [WIDTH:0] inph_sum_reg32;
logic signed [WIDTH:0] quad_sum_reg32;

logic signed [WIDTH:0] inph_sum_reg33;
logic signed [WIDTH:0] quad_sum_reg33;

logic signed [WIDTH:0] inph_sum_reg34;
logic signed [WIDTH:0] quad_sum_reg34;

logic signed [WIDTH:0] inph_sum_reg35;
logic signed [WIDTH:0] quad_sum_reg35;

logic signed [WIDTH:0] inph_sum_reg36;
logic signed [WIDTH:0] quad_sum_reg36;

logic signed [WIDTH:0] inph_sum_reg37;
logic signed [WIDTH:0] quad_sum_reg37;

logic signed [WIDTH:0] inph_sum_reg38;
logic signed [WIDTH:0] quad_sum_reg38;

logic signed [WIDTH:0] inph_sum_reg39;
logic signed [WIDTH:0] quad_sum_reg39;

logic signed [WIDTH:0] inph_sum_reg40;
logic signed [WIDTH:0] quad_sum_reg40;

logic signed [WIDTH:0] inph_sum_reg41;
logic signed [WIDTH:0] quad_sum_reg41;

logic signed [WIDTH:0] inph_sum_reg42;
logic signed [WIDTH:0] quad_sum_reg42;

logic signed [WIDTH:0] inph_sum_reg43;
logic signed [WIDTH:0] quad_sum_reg43;

logic signed [WIDTH:0] inph_sum_reg44;
logic signed [WIDTH:0] quad_sum_reg44;

logic signed [WIDTH:0] inph_sum_reg45;
logic signed [WIDTH:0] quad_sum_reg45;

logic signed [WIDTH:0] inph_sum_reg46;
logic signed [WIDTH:0] quad_sum_reg46;

logic signed [WIDTH:0] inph_sum_reg47;
logic signed [WIDTH:0] quad_sum_reg47;

logic signed [WIDTH:0] inph_sum_reg48;
logic signed [WIDTH:0] quad_sum_reg48;

logic signed [WIDTH:0] inph_sum_reg49;
logic signed [WIDTH:0] quad_sum_reg49;

logic signed [WIDTH:0] inph_sum_reg50;
logic signed [WIDTH:0] quad_sum_reg50;

logic signed [WIDTH:0] inph_sum_reg51;
logic signed [WIDTH:0] quad_sum_reg51;

logic signed [WIDTH:0] inph_sum_reg52;
logic signed [WIDTH:0] quad_sum_reg52;

logic signed [WIDTH:0] inph_sum_reg53;
logic signed [WIDTH:0] quad_sum_reg53;

logic signed [WIDTH:0] inph_sum_reg54;
logic signed [WIDTH:0] quad_sum_reg54;

logic signed [WIDTH:0] inph_sum_reg55;
logic signed [WIDTH:0] quad_sum_reg55;

logic signed [WIDTH:0] inph_sum_reg56;
logic signed [WIDTH:0] quad_sum_reg56;

logic signed [WIDTH:0] inph_sum_reg57;
logic signed [WIDTH:0] quad_sum_reg57;

logic signed [WIDTH:0] inph_sum_reg58;
logic signed [WIDTH:0] quad_sum_reg58;

logic signed [WIDTH:0] inph_sum_reg59;
logic signed [WIDTH:0] quad_sum_reg59;

logic signed [WIDTH:0] inph_sum_reg60;
logic signed [WIDTH:0] quad_sum_reg60;

logic signed [WIDTH:0] inph_sum_reg61;
logic signed [WIDTH:0] quad_sum_reg61;

logic signed [WIDTH:0] inph_sum_reg62;
logic signed [WIDTH:0] quad_sum_reg62;

logic signed [WIDTH:0] inph_sum_reg63;
logic signed [WIDTH:0] quad_sum_reg63;

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

logic signed [18+WIDTH:0] inph_prod_reg32;
logic signed [18+WIDTH:0] quad_prod_reg32;

logic signed [18+WIDTH:0] inph_prod_reg33;
logic signed [18+WIDTH:0] quad_prod_reg33;

logic signed [18+WIDTH:0] inph_prod_reg34;
logic signed [18+WIDTH:0] quad_prod_reg34;

logic signed [18+WIDTH:0] inph_prod_reg35;
logic signed [18+WIDTH:0] quad_prod_reg35;

logic signed [18+WIDTH:0] inph_prod_reg36;
logic signed [18+WIDTH:0] quad_prod_reg36;

logic signed [18+WIDTH:0] inph_prod_reg37;
logic signed [18+WIDTH:0] quad_prod_reg37;

logic signed [18+WIDTH:0] inph_prod_reg38;
logic signed [18+WIDTH:0] quad_prod_reg38;

logic signed [18+WIDTH:0] inph_prod_reg39;
logic signed [18+WIDTH:0] quad_prod_reg39;

logic signed [18+WIDTH:0] inph_prod_reg40;
logic signed [18+WIDTH:0] quad_prod_reg40;

logic signed [18+WIDTH:0] inph_prod_reg41;
logic signed [18+WIDTH:0] quad_prod_reg41;

logic signed [18+WIDTH:0] inph_prod_reg42;
logic signed [18+WIDTH:0] quad_prod_reg42;

logic signed [18+WIDTH:0] inph_prod_reg43;
logic signed [18+WIDTH:0] quad_prod_reg43;

logic signed [18+WIDTH:0] inph_prod_reg44;
logic signed [18+WIDTH:0] quad_prod_reg44;

logic signed [18+WIDTH:0] inph_prod_reg45;
logic signed [18+WIDTH:0] quad_prod_reg45;

logic signed [18+WIDTH:0] inph_prod_reg46;
logic signed [18+WIDTH:0] quad_prod_reg46;

logic signed [18+WIDTH:0] inph_prod_reg47;
logic signed [18+WIDTH:0] quad_prod_reg47;

logic signed [18+WIDTH:0] inph_prod_reg48;
logic signed [18+WIDTH:0] quad_prod_reg48;

logic signed [18+WIDTH:0] inph_prod_reg49;
logic signed [18+WIDTH:0] quad_prod_reg49;

logic signed [18+WIDTH:0] inph_prod_reg50;
logic signed [18+WIDTH:0] quad_prod_reg50;

logic signed [18+WIDTH:0] inph_prod_reg51;
logic signed [18+WIDTH:0] quad_prod_reg51;

logic signed [18+WIDTH:0] inph_prod_reg52;
logic signed [18+WIDTH:0] quad_prod_reg52;

logic signed [18+WIDTH:0] inph_prod_reg53;
logic signed [18+WIDTH:0] quad_prod_reg53;

logic signed [18+WIDTH:0] inph_prod_reg54;
logic signed [18+WIDTH:0] quad_prod_reg54;

logic signed [18+WIDTH:0] inph_prod_reg55;
logic signed [18+WIDTH:0] quad_prod_reg55;

logic signed [18+WIDTH:0] inph_prod_reg56;
logic signed [18+WIDTH:0] quad_prod_reg56;

logic signed [18+WIDTH:0] inph_prod_reg57;
logic signed [18+WIDTH:0] quad_prod_reg57;

logic signed [18+WIDTH:0] inph_prod_reg58;
logic signed [18+WIDTH:0] quad_prod_reg58;

logic signed [18+WIDTH:0] inph_prod_reg59;
logic signed [18+WIDTH:0] quad_prod_reg59;

logic signed [18+WIDTH:0] inph_prod_reg60;
logic signed [18+WIDTH:0] quad_prod_reg60;

logic signed [18+WIDTH:0] inph_prod_reg61;
logic signed [18+WIDTH:0] quad_prod_reg61;

logic signed [18+WIDTH:0] inph_prod_reg62;
logic signed [18+WIDTH:0] quad_prod_reg62;

logic signed [18+WIDTH:0] inph_prod_reg63;
logic signed [18+WIDTH:0] quad_prod_reg63;

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

logic signed [WIDTH-1:0] inph_del_reg9;
logic signed [WIDTH-1:0] quad_del_reg9;

always_ff @ (posedge i_clock) begin
    // Preadders for E0(z)
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        inph_term_reg0 <= i_inph_data;
        quad_term_reg0 <= i_quad_data;

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

        inph_term_reg64 <= inph_tdl0_reg64;
        quad_term_reg64 <= quad_tdl0_reg64;

        inph_term_reg65 <= inph_tdl0_reg65;
        quad_term_reg65 <= quad_tdl0_reg65;

        inph_term_reg66 <= inph_tdl0_reg66;
        quad_term_reg66 <= quad_tdl0_reg66;

        inph_term_reg67 <= inph_tdl0_reg67;
        quad_term_reg67 <= quad_tdl0_reg67;

        inph_term_reg68 <= inph_tdl0_reg68;
        quad_term_reg68 <= quad_tdl0_reg68;

        inph_term_reg69 <= inph_tdl0_reg69;
        quad_term_reg69 <= quad_tdl0_reg69;

        inph_term_reg70 <= inph_tdl0_reg70;
        quad_term_reg70 <= quad_tdl0_reg70;

        inph_term_reg71 <= inph_tdl0_reg71;
        quad_term_reg71 <= quad_tdl0_reg71;

        inph_term_reg72 <= inph_tdl0_reg72;
        quad_term_reg72 <= quad_tdl0_reg72;

        inph_term_reg73 <= inph_tdl0_reg73;
        quad_term_reg73 <= quad_tdl0_reg73;

        inph_term_reg74 <= inph_tdl0_reg74;
        quad_term_reg74 <= quad_tdl0_reg74;

        inph_term_reg75 <= inph_tdl0_reg75;
        quad_term_reg75 <= quad_tdl0_reg75;

        inph_term_reg76 <= inph_tdl0_reg76;
        quad_term_reg76 <= quad_tdl0_reg76;

        inph_term_reg77 <= inph_tdl0_reg77;
        quad_term_reg77 <= quad_tdl0_reg77;

        inph_term_reg78 <= inph_tdl0_reg78;
        quad_term_reg78 <= quad_tdl0_reg78;

        inph_term_reg79 <= inph_tdl0_reg79;
        quad_term_reg79 <= quad_tdl0_reg79;

        inph_term_reg80 <= inph_tdl0_reg80;
        quad_term_reg80 <= quad_tdl0_reg80;

        inph_term_reg81 <= inph_tdl0_reg81;
        quad_term_reg81 <= quad_tdl0_reg81;

        inph_term_reg82 <= inph_tdl0_reg82;
        quad_term_reg82 <= quad_tdl0_reg82;

        inph_term_reg83 <= inph_tdl0_reg83;
        quad_term_reg83 <= quad_tdl0_reg83;

        inph_term_reg84 <= inph_tdl0_reg84;
        quad_term_reg84 <= quad_tdl0_reg84;

        inph_term_reg85 <= inph_tdl0_reg85;
        quad_term_reg85 <= quad_tdl0_reg85;

        inph_term_reg86 <= inph_tdl0_reg86;
        quad_term_reg86 <= quad_tdl0_reg86;

        inph_term_reg87 <= inph_tdl0_reg87;
        quad_term_reg87 <= quad_tdl0_reg87;

        inph_term_reg88 <= inph_tdl0_reg88;
        quad_term_reg88 <= quad_tdl0_reg88;

        inph_term_reg89 <= inph_tdl0_reg89;
        quad_term_reg89 <= quad_tdl0_reg89;

        inph_term_reg90 <= inph_tdl0_reg90;
        quad_term_reg90 <= quad_tdl0_reg90;

        inph_term_reg91 <= inph_tdl0_reg91;
        quad_term_reg91 <= quad_tdl0_reg91;

        inph_term_reg92 <= inph_tdl0_reg92;
        quad_term_reg92 <= quad_tdl0_reg92;

        inph_term_reg93 <= inph_tdl0_reg93;
        quad_term_reg93 <= quad_tdl0_reg93;

        inph_term_reg94 <= inph_tdl0_reg94;
        quad_term_reg94 <= quad_tdl0_reg94;

        inph_term_reg95 <= inph_tdl0_reg95;
        quad_term_reg95 <= quad_tdl0_reg95;

        inph_term_reg96 <= inph_tdl0_reg96;
        quad_term_reg96 <= quad_tdl0_reg96;

        inph_term_reg97 <= inph_tdl0_reg97;
        quad_term_reg97 <= quad_tdl0_reg97;

        inph_term_reg98 <= inph_tdl0_reg98;
        quad_term_reg98 <= quad_tdl0_reg98;

        inph_term_reg99 <= inph_tdl0_reg99;
        quad_term_reg99 <= quad_tdl0_reg99;

        inph_term_reg100 <= inph_tdl0_reg100;
        quad_term_reg100 <= quad_tdl0_reg100;

        inph_term_reg101 <= inph_tdl0_reg101;
        quad_term_reg101 <= quad_tdl0_reg101;

        inph_term_reg102 <= inph_tdl0_reg102;
        quad_term_reg102 <= quad_tdl0_reg102;

        inph_term_reg103 <= inph_tdl0_reg103;
        quad_term_reg103 <= quad_tdl0_reg103;

        inph_term_reg104 <= inph_tdl0_reg104;
        quad_term_reg104 <= quad_tdl0_reg104;

        inph_term_reg105 <= inph_tdl0_reg105;
        quad_term_reg105 <= quad_tdl0_reg105;

        inph_term_reg106 <= inph_tdl0_reg106;
        quad_term_reg106 <= quad_tdl0_reg106;

        inph_term_reg107 <= inph_tdl0_reg107;
        quad_term_reg107 <= quad_tdl0_reg107;

        inph_term_reg108 <= inph_tdl0_reg108;
        quad_term_reg108 <= quad_tdl0_reg108;

        inph_term_reg109 <= inph_tdl0_reg109;
        quad_term_reg109 <= quad_tdl0_reg109;

        inph_term_reg110 <= inph_tdl0_reg110;
        quad_term_reg110 <= quad_tdl0_reg110;

        inph_term_reg111 <= inph_tdl0_reg111;
        quad_term_reg111 <= quad_tdl0_reg111;

        inph_term_reg112 <= inph_tdl0_reg112;
        quad_term_reg112 <= quad_tdl0_reg112;

        inph_term_reg113 <= inph_tdl0_reg113;
        quad_term_reg113 <= quad_tdl0_reg113;

        inph_term_reg114 <= inph_tdl0_reg114;
        quad_term_reg114 <= quad_tdl0_reg114;

        inph_term_reg115 <= inph_tdl0_reg115;
        quad_term_reg115 <= quad_tdl0_reg115;

        inph_term_reg116 <= inph_tdl0_reg116;
        quad_term_reg116 <= quad_tdl0_reg116;

        inph_term_reg117 <= inph_tdl0_reg117;
        quad_term_reg117 <= quad_tdl0_reg117;

        inph_term_reg118 <= inph_tdl0_reg118;
        quad_term_reg118 <= quad_tdl0_reg118;

        inph_term_reg119 <= inph_tdl0_reg119;
        quad_term_reg119 <= quad_tdl0_reg119;

        inph_term_reg120 <= inph_tdl0_reg120;
        quad_term_reg120 <= quad_tdl0_reg120;

        inph_term_reg121 <= inph_tdl0_reg121;
        quad_term_reg121 <= quad_tdl0_reg121;

        inph_term_reg122 <= inph_tdl0_reg122;
        quad_term_reg122 <= quad_tdl0_reg122;

        inph_term_reg123 <= inph_tdl0_reg123;
        quad_term_reg123 <= quad_tdl0_reg123;

        inph_term_reg124 <= inph_tdl0_reg124;
        quad_term_reg124 <= quad_tdl0_reg124;

        inph_term_reg125 <= inph_tdl0_reg125;
        quad_term_reg125 <= quad_tdl0_reg125;

        inph_term_reg126 <= inph_tdl0_reg126;
        quad_term_reg126 <= quad_tdl0_reg126;

        inph_term_reg127 <= inph_tdl0_reg127;
        quad_term_reg127 <= quad_tdl0_reg127;

        inph_sum_reg0 <= { inph_term_reg0[WIDTH-1], inph_term_reg0 } + { inph_term_reg127[WIDTH-1], inph_term_reg127 };
        quad_sum_reg0 <= { quad_term_reg0[WIDTH-1], quad_term_reg0 } + { quad_term_reg127[WIDTH-1], quad_term_reg127 };

        inph_sum_reg1 <= { inph_term_reg1[WIDTH-1], inph_term_reg1 } + { inph_term_reg126[WIDTH-1], inph_term_reg126 };
        quad_sum_reg1 <= { quad_term_reg1[WIDTH-1], quad_term_reg1 } + { quad_term_reg126[WIDTH-1], quad_term_reg126 };

        inph_sum_reg2 <= { inph_term_reg2[WIDTH-1], inph_term_reg2 } + { inph_term_reg125[WIDTH-1], inph_term_reg125 };
        quad_sum_reg2 <= { quad_term_reg2[WIDTH-1], quad_term_reg2 } + { quad_term_reg125[WIDTH-1], quad_term_reg125 };

        inph_sum_reg3 <= { inph_term_reg3[WIDTH-1], inph_term_reg3 } + { inph_term_reg124[WIDTH-1], inph_term_reg124 };
        quad_sum_reg3 <= { quad_term_reg3[WIDTH-1], quad_term_reg3 } + { quad_term_reg124[WIDTH-1], quad_term_reg124 };

        inph_sum_reg4 <= { inph_term_reg4[WIDTH-1], inph_term_reg4 } + { inph_term_reg123[WIDTH-1], inph_term_reg123 };
        quad_sum_reg4 <= { quad_term_reg4[WIDTH-1], quad_term_reg4 } + { quad_term_reg123[WIDTH-1], quad_term_reg123 };

        inph_sum_reg5 <= { inph_term_reg5[WIDTH-1], inph_term_reg5 } + { inph_term_reg122[WIDTH-1], inph_term_reg122 };
        quad_sum_reg5 <= { quad_term_reg5[WIDTH-1], quad_term_reg5 } + { quad_term_reg122[WIDTH-1], quad_term_reg122 };

        inph_sum_reg6 <= { inph_term_reg6[WIDTH-1], inph_term_reg6 } + { inph_term_reg121[WIDTH-1], inph_term_reg121 };
        quad_sum_reg6 <= { quad_term_reg6[WIDTH-1], quad_term_reg6 } + { quad_term_reg121[WIDTH-1], quad_term_reg121 };

        inph_sum_reg7 <= { inph_term_reg7[WIDTH-1], inph_term_reg7 } + { inph_term_reg120[WIDTH-1], inph_term_reg120 };
        quad_sum_reg7 <= { quad_term_reg7[WIDTH-1], quad_term_reg7 } + { quad_term_reg120[WIDTH-1], quad_term_reg120 };

        inph_sum_reg8 <= { inph_term_reg8[WIDTH-1], inph_term_reg8 } + { inph_term_reg119[WIDTH-1], inph_term_reg119 };
        quad_sum_reg8 <= { quad_term_reg8[WIDTH-1], quad_term_reg8 } + { quad_term_reg119[WIDTH-1], quad_term_reg119 };

        inph_sum_reg9 <= { inph_term_reg9[WIDTH-1], inph_term_reg9 } + { inph_term_reg118[WIDTH-1], inph_term_reg118 };
        quad_sum_reg9 <= { quad_term_reg9[WIDTH-1], quad_term_reg9 } + { quad_term_reg118[WIDTH-1], quad_term_reg118 };

        inph_sum_reg10 <= { inph_term_reg10[WIDTH-1], inph_term_reg10 } + { inph_term_reg117[WIDTH-1], inph_term_reg117 };
        quad_sum_reg10 <= { quad_term_reg10[WIDTH-1], quad_term_reg10 } + { quad_term_reg117[WIDTH-1], quad_term_reg117 };

        inph_sum_reg11 <= { inph_term_reg11[WIDTH-1], inph_term_reg11 } + { inph_term_reg116[WIDTH-1], inph_term_reg116 };
        quad_sum_reg11 <= { quad_term_reg11[WIDTH-1], quad_term_reg11 } + { quad_term_reg116[WIDTH-1], quad_term_reg116 };

        inph_sum_reg12 <= { inph_term_reg12[WIDTH-1], inph_term_reg12 } + { inph_term_reg115[WIDTH-1], inph_term_reg115 };
        quad_sum_reg12 <= { quad_term_reg12[WIDTH-1], quad_term_reg12 } + { quad_term_reg115[WIDTH-1], quad_term_reg115 };

        inph_sum_reg13 <= { inph_term_reg13[WIDTH-1], inph_term_reg13 } + { inph_term_reg114[WIDTH-1], inph_term_reg114 };
        quad_sum_reg13 <= { quad_term_reg13[WIDTH-1], quad_term_reg13 } + { quad_term_reg114[WIDTH-1], quad_term_reg114 };

        inph_sum_reg14 <= { inph_term_reg14[WIDTH-1], inph_term_reg14 } + { inph_term_reg113[WIDTH-1], inph_term_reg113 };
        quad_sum_reg14 <= { quad_term_reg14[WIDTH-1], quad_term_reg14 } + { quad_term_reg113[WIDTH-1], quad_term_reg113 };

        inph_sum_reg15 <= { inph_term_reg15[WIDTH-1], inph_term_reg15 } + { inph_term_reg112[WIDTH-1], inph_term_reg112 };
        quad_sum_reg15 <= { quad_term_reg15[WIDTH-1], quad_term_reg15 } + { quad_term_reg112[WIDTH-1], quad_term_reg112 };

        inph_sum_reg16 <= { inph_term_reg16[WIDTH-1], inph_term_reg16 } + { inph_term_reg111[WIDTH-1], inph_term_reg111 };
        quad_sum_reg16 <= { quad_term_reg16[WIDTH-1], quad_term_reg16 } + { quad_term_reg111[WIDTH-1], quad_term_reg111 };

        inph_sum_reg17 <= { inph_term_reg17[WIDTH-1], inph_term_reg17 } + { inph_term_reg110[WIDTH-1], inph_term_reg110 };
        quad_sum_reg17 <= { quad_term_reg17[WIDTH-1], quad_term_reg17 } + { quad_term_reg110[WIDTH-1], quad_term_reg110 };

        inph_sum_reg18 <= { inph_term_reg18[WIDTH-1], inph_term_reg18 } + { inph_term_reg109[WIDTH-1], inph_term_reg109 };
        quad_sum_reg18 <= { quad_term_reg18[WIDTH-1], quad_term_reg18 } + { quad_term_reg109[WIDTH-1], quad_term_reg109 };

        inph_sum_reg19 <= { inph_term_reg19[WIDTH-1], inph_term_reg19 } + { inph_term_reg108[WIDTH-1], inph_term_reg108 };
        quad_sum_reg19 <= { quad_term_reg19[WIDTH-1], quad_term_reg19 } + { quad_term_reg108[WIDTH-1], quad_term_reg108 };

        inph_sum_reg20 <= { inph_term_reg20[WIDTH-1], inph_term_reg20 } + { inph_term_reg107[WIDTH-1], inph_term_reg107 };
        quad_sum_reg20 <= { quad_term_reg20[WIDTH-1], quad_term_reg20 } + { quad_term_reg107[WIDTH-1], quad_term_reg107 };

        inph_sum_reg21 <= { inph_term_reg21[WIDTH-1], inph_term_reg21 } + { inph_term_reg106[WIDTH-1], inph_term_reg106 };
        quad_sum_reg21 <= { quad_term_reg21[WIDTH-1], quad_term_reg21 } + { quad_term_reg106[WIDTH-1], quad_term_reg106 };

        inph_sum_reg22 <= { inph_term_reg22[WIDTH-1], inph_term_reg22 } + { inph_term_reg105[WIDTH-1], inph_term_reg105 };
        quad_sum_reg22 <= { quad_term_reg22[WIDTH-1], quad_term_reg22 } + { quad_term_reg105[WIDTH-1], quad_term_reg105 };

        inph_sum_reg23 <= { inph_term_reg23[WIDTH-1], inph_term_reg23 } + { inph_term_reg104[WIDTH-1], inph_term_reg104 };
        quad_sum_reg23 <= { quad_term_reg23[WIDTH-1], quad_term_reg23 } + { quad_term_reg104[WIDTH-1], quad_term_reg104 };

        inph_sum_reg24 <= { inph_term_reg24[WIDTH-1], inph_term_reg24 } + { inph_term_reg103[WIDTH-1], inph_term_reg103 };
        quad_sum_reg24 <= { quad_term_reg24[WIDTH-1], quad_term_reg24 } + { quad_term_reg103[WIDTH-1], quad_term_reg103 };

        inph_sum_reg25 <= { inph_term_reg25[WIDTH-1], inph_term_reg25 } + { inph_term_reg102[WIDTH-1], inph_term_reg102 };
        quad_sum_reg25 <= { quad_term_reg25[WIDTH-1], quad_term_reg25 } + { quad_term_reg102[WIDTH-1], quad_term_reg102 };

        inph_sum_reg26 <= { inph_term_reg26[WIDTH-1], inph_term_reg26 } + { inph_term_reg101[WIDTH-1], inph_term_reg101 };
        quad_sum_reg26 <= { quad_term_reg26[WIDTH-1], quad_term_reg26 } + { quad_term_reg101[WIDTH-1], quad_term_reg101 };

        inph_sum_reg27 <= { inph_term_reg27[WIDTH-1], inph_term_reg27 } + { inph_term_reg100[WIDTH-1], inph_term_reg100 };
        quad_sum_reg27 <= { quad_term_reg27[WIDTH-1], quad_term_reg27 } + { quad_term_reg100[WIDTH-1], quad_term_reg100 };

        inph_sum_reg28 <= { inph_term_reg28[WIDTH-1], inph_term_reg28 } + { inph_term_reg99[WIDTH-1], inph_term_reg99 };
        quad_sum_reg28 <= { quad_term_reg28[WIDTH-1], quad_term_reg28 } + { quad_term_reg99[WIDTH-1], quad_term_reg99 };

        inph_sum_reg29 <= { inph_term_reg29[WIDTH-1], inph_term_reg29 } + { inph_term_reg98[WIDTH-1], inph_term_reg98 };
        quad_sum_reg29 <= { quad_term_reg29[WIDTH-1], quad_term_reg29 } + { quad_term_reg98[WIDTH-1], quad_term_reg98 };

        inph_sum_reg30 <= { inph_term_reg30[WIDTH-1], inph_term_reg30 } + { inph_term_reg97[WIDTH-1], inph_term_reg97 };
        quad_sum_reg30 <= { quad_term_reg30[WIDTH-1], quad_term_reg30 } + { quad_term_reg97[WIDTH-1], quad_term_reg97 };

        inph_sum_reg31 <= { inph_term_reg31[WIDTH-1], inph_term_reg31 } + { inph_term_reg96[WIDTH-1], inph_term_reg96 };
        quad_sum_reg31 <= { quad_term_reg31[WIDTH-1], quad_term_reg31 } + { quad_term_reg96[WIDTH-1], quad_term_reg96 };

        inph_sum_reg32 <= { inph_term_reg32[WIDTH-1], inph_term_reg32 } + { inph_term_reg95[WIDTH-1], inph_term_reg95 };
        quad_sum_reg32 <= { quad_term_reg32[WIDTH-1], quad_term_reg32 } + { quad_term_reg95[WIDTH-1], quad_term_reg95 };

        inph_sum_reg33 <= { inph_term_reg33[WIDTH-1], inph_term_reg33 } + { inph_term_reg94[WIDTH-1], inph_term_reg94 };
        quad_sum_reg33 <= { quad_term_reg33[WIDTH-1], quad_term_reg33 } + { quad_term_reg94[WIDTH-1], quad_term_reg94 };

        inph_sum_reg34 <= { inph_term_reg34[WIDTH-1], inph_term_reg34 } + { inph_term_reg93[WIDTH-1], inph_term_reg93 };
        quad_sum_reg34 <= { quad_term_reg34[WIDTH-1], quad_term_reg34 } + { quad_term_reg93[WIDTH-1], quad_term_reg93 };

        inph_sum_reg35 <= { inph_term_reg35[WIDTH-1], inph_term_reg35 } + { inph_term_reg92[WIDTH-1], inph_term_reg92 };
        quad_sum_reg35 <= { quad_term_reg35[WIDTH-1], quad_term_reg35 } + { quad_term_reg92[WIDTH-1], quad_term_reg92 };

        inph_sum_reg36 <= { inph_term_reg36[WIDTH-1], inph_term_reg36 } + { inph_term_reg91[WIDTH-1], inph_term_reg91 };
        quad_sum_reg36 <= { quad_term_reg36[WIDTH-1], quad_term_reg36 } + { quad_term_reg91[WIDTH-1], quad_term_reg91 };

        inph_sum_reg37 <= { inph_term_reg37[WIDTH-1], inph_term_reg37 } + { inph_term_reg90[WIDTH-1], inph_term_reg90 };
        quad_sum_reg37 <= { quad_term_reg37[WIDTH-1], quad_term_reg37 } + { quad_term_reg90[WIDTH-1], quad_term_reg90 };

        inph_sum_reg38 <= { inph_term_reg38[WIDTH-1], inph_term_reg38 } + { inph_term_reg89[WIDTH-1], inph_term_reg89 };
        quad_sum_reg38 <= { quad_term_reg38[WIDTH-1], quad_term_reg38 } + { quad_term_reg89[WIDTH-1], quad_term_reg89 };

        inph_sum_reg39 <= { inph_term_reg39[WIDTH-1], inph_term_reg39 } + { inph_term_reg88[WIDTH-1], inph_term_reg88 };
        quad_sum_reg39 <= { quad_term_reg39[WIDTH-1], quad_term_reg39 } + { quad_term_reg88[WIDTH-1], quad_term_reg88 };

        inph_sum_reg40 <= { inph_term_reg40[WIDTH-1], inph_term_reg40 } + { inph_term_reg87[WIDTH-1], inph_term_reg87 };
        quad_sum_reg40 <= { quad_term_reg40[WIDTH-1], quad_term_reg40 } + { quad_term_reg87[WIDTH-1], quad_term_reg87 };

        inph_sum_reg41 <= { inph_term_reg41[WIDTH-1], inph_term_reg41 } + { inph_term_reg86[WIDTH-1], inph_term_reg86 };
        quad_sum_reg41 <= { quad_term_reg41[WIDTH-1], quad_term_reg41 } + { quad_term_reg86[WIDTH-1], quad_term_reg86 };

        inph_sum_reg42 <= { inph_term_reg42[WIDTH-1], inph_term_reg42 } + { inph_term_reg85[WIDTH-1], inph_term_reg85 };
        quad_sum_reg42 <= { quad_term_reg42[WIDTH-1], quad_term_reg42 } + { quad_term_reg85[WIDTH-1], quad_term_reg85 };

        inph_sum_reg43 <= { inph_term_reg43[WIDTH-1], inph_term_reg43 } + { inph_term_reg84[WIDTH-1], inph_term_reg84 };
        quad_sum_reg43 <= { quad_term_reg43[WIDTH-1], quad_term_reg43 } + { quad_term_reg84[WIDTH-1], quad_term_reg84 };

        inph_sum_reg44 <= { inph_term_reg44[WIDTH-1], inph_term_reg44 } + { inph_term_reg83[WIDTH-1], inph_term_reg83 };
        quad_sum_reg44 <= { quad_term_reg44[WIDTH-1], quad_term_reg44 } + { quad_term_reg83[WIDTH-1], quad_term_reg83 };

        inph_sum_reg45 <= { inph_term_reg45[WIDTH-1], inph_term_reg45 } + { inph_term_reg82[WIDTH-1], inph_term_reg82 };
        quad_sum_reg45 <= { quad_term_reg45[WIDTH-1], quad_term_reg45 } + { quad_term_reg82[WIDTH-1], quad_term_reg82 };

        inph_sum_reg46 <= { inph_term_reg46[WIDTH-1], inph_term_reg46 } + { inph_term_reg81[WIDTH-1], inph_term_reg81 };
        quad_sum_reg46 <= { quad_term_reg46[WIDTH-1], quad_term_reg46 } + { quad_term_reg81[WIDTH-1], quad_term_reg81 };

        inph_sum_reg47 <= { inph_term_reg47[WIDTH-1], inph_term_reg47 } + { inph_term_reg80[WIDTH-1], inph_term_reg80 };
        quad_sum_reg47 <= { quad_term_reg47[WIDTH-1], quad_term_reg47 } + { quad_term_reg80[WIDTH-1], quad_term_reg80 };

        inph_sum_reg48 <= { inph_term_reg48[WIDTH-1], inph_term_reg48 } + { inph_term_reg79[WIDTH-1], inph_term_reg79 };
        quad_sum_reg48 <= { quad_term_reg48[WIDTH-1], quad_term_reg48 } + { quad_term_reg79[WIDTH-1], quad_term_reg79 };

        inph_sum_reg49 <= { inph_term_reg49[WIDTH-1], inph_term_reg49 } + { inph_term_reg78[WIDTH-1], inph_term_reg78 };
        quad_sum_reg49 <= { quad_term_reg49[WIDTH-1], quad_term_reg49 } + { quad_term_reg78[WIDTH-1], quad_term_reg78 };

        inph_sum_reg50 <= { inph_term_reg50[WIDTH-1], inph_term_reg50 } + { inph_term_reg77[WIDTH-1], inph_term_reg77 };
        quad_sum_reg50 <= { quad_term_reg50[WIDTH-1], quad_term_reg50 } + { quad_term_reg77[WIDTH-1], quad_term_reg77 };

        inph_sum_reg51 <= { inph_term_reg51[WIDTH-1], inph_term_reg51 } + { inph_term_reg76[WIDTH-1], inph_term_reg76 };
        quad_sum_reg51 <= { quad_term_reg51[WIDTH-1], quad_term_reg51 } + { quad_term_reg76[WIDTH-1], quad_term_reg76 };

        inph_sum_reg52 <= { inph_term_reg52[WIDTH-1], inph_term_reg52 } + { inph_term_reg75[WIDTH-1], inph_term_reg75 };
        quad_sum_reg52 <= { quad_term_reg52[WIDTH-1], quad_term_reg52 } + { quad_term_reg75[WIDTH-1], quad_term_reg75 };

        inph_sum_reg53 <= { inph_term_reg53[WIDTH-1], inph_term_reg53 } + { inph_term_reg74[WIDTH-1], inph_term_reg74 };
        quad_sum_reg53 <= { quad_term_reg53[WIDTH-1], quad_term_reg53 } + { quad_term_reg74[WIDTH-1], quad_term_reg74 };

        inph_sum_reg54 <= { inph_term_reg54[WIDTH-1], inph_term_reg54 } + { inph_term_reg73[WIDTH-1], inph_term_reg73 };
        quad_sum_reg54 <= { quad_term_reg54[WIDTH-1], quad_term_reg54 } + { quad_term_reg73[WIDTH-1], quad_term_reg73 };

        inph_sum_reg55 <= { inph_term_reg55[WIDTH-1], inph_term_reg55 } + { inph_term_reg72[WIDTH-1], inph_term_reg72 };
        quad_sum_reg55 <= { quad_term_reg55[WIDTH-1], quad_term_reg55 } + { quad_term_reg72[WIDTH-1], quad_term_reg72 };

        inph_sum_reg56 <= { inph_term_reg56[WIDTH-1], inph_term_reg56 } + { inph_term_reg71[WIDTH-1], inph_term_reg71 };
        quad_sum_reg56 <= { quad_term_reg56[WIDTH-1], quad_term_reg56 } + { quad_term_reg71[WIDTH-1], quad_term_reg71 };

        inph_sum_reg57 <= { inph_term_reg57[WIDTH-1], inph_term_reg57 } + { inph_term_reg70[WIDTH-1], inph_term_reg70 };
        quad_sum_reg57 <= { quad_term_reg57[WIDTH-1], quad_term_reg57 } + { quad_term_reg70[WIDTH-1], quad_term_reg70 };

        inph_sum_reg58 <= { inph_term_reg58[WIDTH-1], inph_term_reg58 } + { inph_term_reg69[WIDTH-1], inph_term_reg69 };
        quad_sum_reg58 <= { quad_term_reg58[WIDTH-1], quad_term_reg58 } + { quad_term_reg69[WIDTH-1], quad_term_reg69 };

        inph_sum_reg59 <= { inph_term_reg59[WIDTH-1], inph_term_reg59 } + { inph_term_reg68[WIDTH-1], inph_term_reg68 };
        quad_sum_reg59 <= { quad_term_reg59[WIDTH-1], quad_term_reg59 } + { quad_term_reg68[WIDTH-1], quad_term_reg68 };

        inph_sum_reg60 <= { inph_term_reg60[WIDTH-1], inph_term_reg60 } + { inph_term_reg67[WIDTH-1], inph_term_reg67 };
        quad_sum_reg60 <= { quad_term_reg60[WIDTH-1], quad_term_reg60 } + { quad_term_reg67[WIDTH-1], quad_term_reg67 };

        inph_sum_reg61 <= { inph_term_reg61[WIDTH-1], inph_term_reg61 } + { inph_term_reg66[WIDTH-1], inph_term_reg66 };
        quad_sum_reg61 <= { quad_term_reg61[WIDTH-1], quad_term_reg61 } + { quad_term_reg66[WIDTH-1], quad_term_reg66 };

        inph_sum_reg62 <= { inph_term_reg62[WIDTH-1], inph_term_reg62 } + { inph_term_reg65[WIDTH-1], inph_term_reg65 };
        quad_sum_reg62 <= { quad_term_reg62[WIDTH-1], quad_term_reg62 } + { quad_term_reg65[WIDTH-1], quad_term_reg65 };

        inph_sum_reg63 <= { inph_term_reg63[WIDTH-1], inph_term_reg63 } + { inph_term_reg64[WIDTH-1], inph_term_reg64 };
        quad_sum_reg63 <= { quad_term_reg63[WIDTH-1], quad_term_reg63 } + { quad_term_reg64[WIDTH-1], quad_term_reg64 };

        inph_prod_reg0 <= $signed(18'sb000000000000000000) * $signed(inph_sum_reg0);
        quad_prod_reg0 <= $signed(18'sb000000000000000000) * $signed(quad_sum_reg0);

        inph_prod_reg1 <= $signed(18'sb000000000000000000) * $signed(inph_sum_reg1);
        quad_prod_reg1 <= $signed(18'sb000000000000000000) * $signed(quad_sum_reg1);

        inph_prod_reg2 <= $signed(18'sb111111111111111111) * $signed(inph_sum_reg2);
        quad_prod_reg2 <= $signed(18'sb111111111111111111) * $signed(quad_sum_reg2);

        inph_prod_reg3 <= $signed(18'sb000000000000000001) * $signed(inph_sum_reg3);
        quad_prod_reg3 <= $signed(18'sb000000000000000001) * $signed(quad_sum_reg3);

        inph_prod_reg4 <= $signed(18'sb111111111111111110) * $signed(inph_sum_reg4);
        quad_prod_reg4 <= $signed(18'sb111111111111111110) * $signed(quad_sum_reg4);

        inph_prod_reg5 <= $signed(18'sb000000000000000010) * $signed(inph_sum_reg5);
        quad_prod_reg5 <= $signed(18'sb000000000000000010) * $signed(quad_sum_reg5);

        inph_prod_reg6 <= $signed(18'sb111111111111111101) * $signed(inph_sum_reg6);
        quad_prod_reg6 <= $signed(18'sb111111111111111101) * $signed(quad_sum_reg6);

        inph_prod_reg7 <= $signed(18'sb000000000000000100) * $signed(inph_sum_reg7);
        quad_prod_reg7 <= $signed(18'sb000000000000000100) * $signed(quad_sum_reg7);

        inph_prod_reg8 <= $signed(18'sb111111111111111011) * $signed(inph_sum_reg8);
        quad_prod_reg8 <= $signed(18'sb111111111111111011) * $signed(quad_sum_reg8);

        inph_prod_reg9 <= $signed(18'sb000000000000000111) * $signed(inph_sum_reg9);
        quad_prod_reg9 <= $signed(18'sb000000000000000111) * $signed(quad_sum_reg9);

        inph_prod_reg10 <= $signed(18'sb111111111111110111) * $signed(inph_sum_reg10);
        quad_prod_reg10 <= $signed(18'sb111111111111110111) * $signed(quad_sum_reg10);

        inph_prod_reg11 <= $signed(18'sb000000000000001011) * $signed(inph_sum_reg11);
        quad_prod_reg11 <= $signed(18'sb000000000000001011) * $signed(quad_sum_reg11);

        inph_prod_reg12 <= $signed(18'sb111111111111110010) * $signed(inph_sum_reg12);
        quad_prod_reg12 <= $signed(18'sb111111111111110010) * $signed(quad_sum_reg12);

        inph_prod_reg13 <= $signed(18'sb000000000000010001) * $signed(inph_sum_reg13);
        quad_prod_reg13 <= $signed(18'sb000000000000010001) * $signed(quad_sum_reg13);

        inph_prod_reg14 <= $signed(18'sb111111111111101011) * $signed(inph_sum_reg14);
        quad_prod_reg14 <= $signed(18'sb111111111111101011) * $signed(quad_sum_reg14);

        inph_prod_reg15 <= $signed(18'sb000000000000011010) * $signed(inph_sum_reg15);
        quad_prod_reg15 <= $signed(18'sb000000000000011010) * $signed(quad_sum_reg15);

        inph_prod_reg16 <= $signed(18'sb111111111111100001) * $signed(inph_sum_reg16);
        quad_prod_reg16 <= $signed(18'sb111111111111100001) * $signed(quad_sum_reg16);

        inph_prod_reg17 <= $signed(18'sb000000000000100101) * $signed(inph_sum_reg17);
        quad_prod_reg17 <= $signed(18'sb000000000000100101) * $signed(quad_sum_reg17);

        inph_prod_reg18 <= $signed(18'sb111111111111010011) * $signed(inph_sum_reg18);
        quad_prod_reg18 <= $signed(18'sb111111111111010011) * $signed(quad_sum_reg18);

        inph_prod_reg19 <= $signed(18'sb000000000000110110) * $signed(inph_sum_reg19);
        quad_prod_reg19 <= $signed(18'sb000000000000110110) * $signed(quad_sum_reg19);

        inph_prod_reg20 <= $signed(18'sb111111111111000000) * $signed(inph_sum_reg20);
        quad_prod_reg20 <= $signed(18'sb111111111111000000) * $signed(quad_sum_reg20);

        inph_prod_reg21 <= $signed(18'sb000000000001001011) * $signed(inph_sum_reg21);
        quad_prod_reg21 <= $signed(18'sb000000000001001011) * $signed(quad_sum_reg21);

        inph_prod_reg22 <= $signed(18'sb111111111110101000) * $signed(inph_sum_reg22);
        quad_prod_reg22 <= $signed(18'sb111111111110101000) * $signed(quad_sum_reg22);

        inph_prod_reg23 <= $signed(18'sb000000000001100111) * $signed(inph_sum_reg23);
        quad_prod_reg23 <= $signed(18'sb000000000001100111) * $signed(quad_sum_reg23);

        inph_prod_reg24 <= $signed(18'sb111111111110001001) * $signed(inph_sum_reg24);
        quad_prod_reg24 <= $signed(18'sb111111111110001001) * $signed(quad_sum_reg24);

        inph_prod_reg25 <= $signed(18'sb000000000010001010) * $signed(inph_sum_reg25);
        quad_prod_reg25 <= $signed(18'sb000000000010001010) * $signed(quad_sum_reg25);

        inph_prod_reg26 <= $signed(18'sb111111111101100001) * $signed(inph_sum_reg26);
        quad_prod_reg26 <= $signed(18'sb111111111101100001) * $signed(quad_sum_reg26);

        inph_prod_reg27 <= $signed(18'sb000000000010110111) * $signed(inph_sum_reg27);
        quad_prod_reg27 <= $signed(18'sb000000000010110111) * $signed(quad_sum_reg27);

        inph_prod_reg28 <= $signed(18'sb111111111100101110) * $signed(inph_sum_reg28);
        quad_prod_reg28 <= $signed(18'sb111111111100101110) * $signed(quad_sum_reg28);

        inph_prod_reg29 <= $signed(18'sb000000000011101111) * $signed(inph_sum_reg29);
        quad_prod_reg29 <= $signed(18'sb000000000011101111) * $signed(quad_sum_reg29);

        inph_prod_reg30 <= $signed(18'sb111111111011110000) * $signed(inph_sum_reg30);
        quad_prod_reg30 <= $signed(18'sb111111111011110000) * $signed(quad_sum_reg30);

        inph_prod_reg31 <= $signed(18'sb000000000100110101) * $signed(inph_sum_reg31);
        quad_prod_reg31 <= $signed(18'sb000000000100110101) * $signed(quad_sum_reg31);

        inph_prod_reg32 <= $signed(18'sb111111111010100010) * $signed(inph_sum_reg32);
        quad_prod_reg32 <= $signed(18'sb111111111010100010) * $signed(quad_sum_reg32);

        inph_prod_reg33 <= $signed(18'sb000000000110001010) * $signed(inph_sum_reg33);
        quad_prod_reg33 <= $signed(18'sb000000000110001010) * $signed(quad_sum_reg33);

        inph_prod_reg34 <= $signed(18'sb111111111001000100) * $signed(inph_sum_reg34);
        quad_prod_reg34 <= $signed(18'sb111111111001000100) * $signed(quad_sum_reg34);

        inph_prod_reg35 <= $signed(18'sb000000000111110010) * $signed(inph_sum_reg35);
        quad_prod_reg35 <= $signed(18'sb000000000111110010) * $signed(quad_sum_reg35);

        inph_prod_reg36 <= $signed(18'sb111111110111010010) * $signed(inph_sum_reg36);
        quad_prod_reg36 <= $signed(18'sb111111110111010010) * $signed(quad_sum_reg36);

        inph_prod_reg37 <= $signed(18'sb000000001001110000) * $signed(inph_sum_reg37);
        quad_prod_reg37 <= $signed(18'sb000000001001110000) * $signed(quad_sum_reg37);

        inph_prod_reg38 <= $signed(18'sb111111110101001000) * $signed(inph_sum_reg38);
        quad_prod_reg38 <= $signed(18'sb111111110101001000) * $signed(quad_sum_reg38);

        inph_prod_reg39 <= $signed(18'sb000000001100001000) * $signed(inph_sum_reg39);
        quad_prod_reg39 <= $signed(18'sb000000001100001000) * $signed(quad_sum_reg39);

        inph_prod_reg40 <= $signed(18'sb111111110010100001) * $signed(inph_sum_reg40);
        quad_prod_reg40 <= $signed(18'sb111111110010100001) * $signed(quad_sum_reg40);

        inph_prod_reg41 <= $signed(18'sb000000001110111111) * $signed(inph_sum_reg41);
        quad_prod_reg41 <= $signed(18'sb000000001110111111) * $signed(quad_sum_reg41);

        inph_prod_reg42 <= $signed(18'sb111111101111010111) * $signed(inph_sum_reg42);
        quad_prod_reg42 <= $signed(18'sb111111101111010111) * $signed(quad_sum_reg42);

        inph_prod_reg43 <= $signed(18'sb000000010010011101) * $signed(inph_sum_reg43);
        quad_prod_reg43 <= $signed(18'sb000000010010011101) * $signed(quad_sum_reg43);

        inph_prod_reg44 <= $signed(18'sb111111101011100011) * $signed(inph_sum_reg44);
        quad_prod_reg44 <= $signed(18'sb111111101011100011) * $signed(quad_sum_reg44);

        inph_prod_reg45 <= $signed(18'sb000000010110101010) * $signed(inph_sum_reg45);
        quad_prod_reg45 <= $signed(18'sb000000010110101010) * $signed(quad_sum_reg45);

        inph_prod_reg46 <= $signed(18'sb111111100110111000) * $signed(inph_sum_reg46);
        quad_prod_reg46 <= $signed(18'sb111111100110111000) * $signed(quad_sum_reg46);

        inph_prod_reg47 <= $signed(18'sb000000011011110110) * $signed(inph_sum_reg47);
        quad_prod_reg47 <= $signed(18'sb000000011011110110) * $signed(quad_sum_reg47);

        inph_prod_reg48 <= $signed(18'sb111111100001000110) * $signed(inph_sum_reg48);
        quad_prod_reg48 <= $signed(18'sb111111100001000110) * $signed(quad_sum_reg48);

        inph_prod_reg49 <= $signed(18'sb000000100010010110) * $signed(inph_sum_reg49);
        quad_prod_reg49 <= $signed(18'sb000000100010010110) * $signed(quad_sum_reg49);

        inph_prod_reg50 <= $signed(18'sb111111011001110000) * $signed(inph_sum_reg50);
        quad_prod_reg50 <= $signed(18'sb111111011001110000) * $signed(quad_sum_reg50);

        inph_prod_reg51 <= $signed(18'sb000000101010101110) * $signed(inph_sum_reg51);
        quad_prod_reg51 <= $signed(18'sb000000101010101110) * $signed(quad_sum_reg51);

        inph_prod_reg52 <= $signed(18'sb111111010000000111) * $signed(inph_sum_reg52);
        quad_prod_reg52 <= $signed(18'sb111111010000000111) * $signed(quad_sum_reg52);

        inph_prod_reg53 <= $signed(18'sb000000110101111101) * $signed(inph_sum_reg53);
        quad_prod_reg53 <= $signed(18'sb000000110101111101) * $signed(quad_sum_reg53);

        inph_prod_reg54 <= $signed(18'sb111111000010110100) * $signed(inph_sum_reg54);
        quad_prod_reg54 <= $signed(18'sb111111000010110100) * $signed(quad_sum_reg54);

        inph_prod_reg55 <= $signed(18'sb000001000101111110) * $signed(inph_sum_reg55);
        quad_prod_reg55 <= $signed(18'sb000001000101111110) * $signed(quad_sum_reg55);

        inph_prod_reg56 <= $signed(18'sb111110101111000100) * $signed(inph_sum_reg56);
        quad_prod_reg56 <= $signed(18'sb111110101111000100) * $signed(quad_sum_reg56);

        inph_prod_reg57 <= $signed(18'sb000001011111000100) * $signed(inph_sum_reg57);
        quad_prod_reg57 <= $signed(18'sb000001011111000100) * $signed(quad_sum_reg57);

        inph_prod_reg58 <= $signed(18'sb111110001101111100) * $signed(inph_sum_reg58);
        quad_prod_reg58 <= $signed(18'sb111110001101111100) * $signed(quad_sum_reg58);

        inph_prod_reg59 <= $signed(18'sb000010001101001101) * $signed(inph_sum_reg59);
        quad_prod_reg59 <= $signed(18'sb000010001101001101) * $signed(quad_sum_reg59);

        inph_prod_reg60 <= $signed(18'sb111101001000100111) * $signed(inph_sum_reg60);
        quad_prod_reg60 <= $signed(18'sb111101001000100111) * $signed(quad_sum_reg60);

        inph_prod_reg61 <= $signed(18'sb000100000010101101) * $signed(inph_sum_reg61);
        quad_prod_reg61 <= $signed(18'sb000100000010101101) * $signed(quad_sum_reg61);

        inph_prod_reg62 <= $signed(18'sb111001001110101001) * $signed(inph_sum_reg62);
        quad_prod_reg62 <= $signed(18'sb111001001110101001) * $signed(quad_sum_reg62);

        inph_prod_reg63 <= $signed(18'sb010100010111011001) * $signed(inph_sum_reg63);
        quad_prod_reg63 <= $signed(18'sb010100010111011001) * $signed(quad_sum_reg63);


        // Pipeline delays for E1(z)
        inph_del_reg0 <= inph_tdl0_reg63;
        quad_del_reg0 <= quad_tdl0_reg63;

        inph_del_reg1 <= inph_del_reg0;
        quad_del_reg1 <= quad_del_reg0;

        inph_del_reg2 <= inph_del_reg1;
        quad_del_reg2 <= quad_del_reg1;

        inph_del_reg3 <= inph_del_reg2;
        quad_del_reg3 <= quad_del_reg2;

    end
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

logic signed [53:0] inph_accum0_reg16;
logic signed [53:0] quad_accum0_reg16;

logic signed [53:0] inph_accum0_reg17;
logic signed [53:0] quad_accum0_reg17;

logic signed [53:0] inph_accum0_reg18;
logic signed [53:0] quad_accum0_reg18;

logic signed [53:0] inph_accum0_reg19;
logic signed [53:0] quad_accum0_reg19;

logic signed [53:0] inph_accum0_reg20;
logic signed [53:0] quad_accum0_reg20;

logic signed [53:0] inph_accum0_reg21;
logic signed [53:0] quad_accum0_reg21;

logic signed [53:0] inph_accum0_reg22;
logic signed [53:0] quad_accum0_reg22;

logic signed [53:0] inph_accum0_reg23;
logic signed [53:0] quad_accum0_reg23;

logic signed [53:0] inph_accum0_reg24;
logic signed [53:0] quad_accum0_reg24;

logic signed [53:0] inph_accum0_reg25;
logic signed [53:0] quad_accum0_reg25;

logic signed [53:0] inph_accum0_reg26;
logic signed [53:0] quad_accum0_reg26;

logic signed [53:0] inph_accum0_reg27;
logic signed [53:0] quad_accum0_reg27;

logic signed [53:0] inph_accum0_reg28;
logic signed [53:0] quad_accum0_reg28;

logic signed [53:0] inph_accum0_reg29;
logic signed [53:0] quad_accum0_reg29;

logic signed [53:0] inph_accum0_reg30;
logic signed [53:0] quad_accum0_reg30;

logic signed [53:0] inph_accum0_reg31;
logic signed [53:0] quad_accum0_reg31;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        // Adder trees for FIR filter
        inph_accum0_reg0 <= { {(54-(19+WIDTH)){inph_prod_reg0[18+WIDTH]}}, inph_prod_reg0 } + { {(54-(19+WIDTH)){inph_prod_reg1[18+WIDTH]}}, inph_prod_reg1 };
        quad_accum0_reg0 <= { {(54-(19+WIDTH)){quad_prod_reg0[18+WIDTH]}}, quad_prod_reg0 } + { {(54-(19+WIDTH)){quad_prod_reg1[18+WIDTH]}}, quad_prod_reg1 };

        inph_accum0_reg1 <= { {(54-(19+WIDTH)){inph_prod_reg2[18+WIDTH]}}, inph_prod_reg2 } + { {(54-(19+WIDTH)){inph_prod_reg3[18+WIDTH]}}, inph_prod_reg3 };
        quad_accum0_reg1 <= { {(54-(19+WIDTH)){quad_prod_reg2[18+WIDTH]}}, quad_prod_reg2 } + { {(54-(19+WIDTH)){quad_prod_reg3[18+WIDTH]}}, quad_prod_reg3 };

        inph_accum0_reg2 <= { {(54-(19+WIDTH)){inph_prod_reg4[18+WIDTH]}}, inph_prod_reg4 } + { {(54-(19+WIDTH)){inph_prod_reg5[18+WIDTH]}}, inph_prod_reg5 };
        quad_accum0_reg2 <= { {(54-(19+WIDTH)){quad_prod_reg4[18+WIDTH]}}, quad_prod_reg4 } + { {(54-(19+WIDTH)){quad_prod_reg5[18+WIDTH]}}, quad_prod_reg5 };

        inph_accum0_reg3 <= { {(54-(19+WIDTH)){inph_prod_reg6[18+WIDTH]}}, inph_prod_reg6 } + { {(54-(19+WIDTH)){inph_prod_reg7[18+WIDTH]}}, inph_prod_reg7 };
        quad_accum0_reg3 <= { {(54-(19+WIDTH)){quad_prod_reg6[18+WIDTH]}}, quad_prod_reg6 } + { {(54-(19+WIDTH)){quad_prod_reg7[18+WIDTH]}}, quad_prod_reg7 };

        inph_accum0_reg4 <= { {(54-(19+WIDTH)){inph_prod_reg8[18+WIDTH]}}, inph_prod_reg8 } + { {(54-(19+WIDTH)){inph_prod_reg9[18+WIDTH]}}, inph_prod_reg9 };
        quad_accum0_reg4 <= { {(54-(19+WIDTH)){quad_prod_reg8[18+WIDTH]}}, quad_prod_reg8 } + { {(54-(19+WIDTH)){quad_prod_reg9[18+WIDTH]}}, quad_prod_reg9 };

        inph_accum0_reg5 <= { {(54-(19+WIDTH)){inph_prod_reg10[18+WIDTH]}}, inph_prod_reg10 } + { {(54-(19+WIDTH)){inph_prod_reg11[18+WIDTH]}}, inph_prod_reg11 };
        quad_accum0_reg5 <= { {(54-(19+WIDTH)){quad_prod_reg10[18+WIDTH]}}, quad_prod_reg10 } + { {(54-(19+WIDTH)){quad_prod_reg11[18+WIDTH]}}, quad_prod_reg11 };

        inph_accum0_reg6 <= { {(54-(19+WIDTH)){inph_prod_reg12[18+WIDTH]}}, inph_prod_reg12 } + { {(54-(19+WIDTH)){inph_prod_reg13[18+WIDTH]}}, inph_prod_reg13 };
        quad_accum0_reg6 <= { {(54-(19+WIDTH)){quad_prod_reg12[18+WIDTH]}}, quad_prod_reg12 } + { {(54-(19+WIDTH)){quad_prod_reg13[18+WIDTH]}}, quad_prod_reg13 };

        inph_accum0_reg7 <= { {(54-(19+WIDTH)){inph_prod_reg14[18+WIDTH]}}, inph_prod_reg14 } + { {(54-(19+WIDTH)){inph_prod_reg15[18+WIDTH]}}, inph_prod_reg15 };
        quad_accum0_reg7 <= { {(54-(19+WIDTH)){quad_prod_reg14[18+WIDTH]}}, quad_prod_reg14 } + { {(54-(19+WIDTH)){quad_prod_reg15[18+WIDTH]}}, quad_prod_reg15 };

        inph_accum0_reg8 <= { {(54-(19+WIDTH)){inph_prod_reg16[18+WIDTH]}}, inph_prod_reg16 } + { {(54-(19+WIDTH)){inph_prod_reg17[18+WIDTH]}}, inph_prod_reg17 };
        quad_accum0_reg8 <= { {(54-(19+WIDTH)){quad_prod_reg16[18+WIDTH]}}, quad_prod_reg16 } + { {(54-(19+WIDTH)){quad_prod_reg17[18+WIDTH]}}, quad_prod_reg17 };

        inph_accum0_reg9 <= { {(54-(19+WIDTH)){inph_prod_reg18[18+WIDTH]}}, inph_prod_reg18 } + { {(54-(19+WIDTH)){inph_prod_reg19[18+WIDTH]}}, inph_prod_reg19 };
        quad_accum0_reg9 <= { {(54-(19+WIDTH)){quad_prod_reg18[18+WIDTH]}}, quad_prod_reg18 } + { {(54-(19+WIDTH)){quad_prod_reg19[18+WIDTH]}}, quad_prod_reg19 };

        inph_accum0_reg10 <= { {(54-(19+WIDTH)){inph_prod_reg20[18+WIDTH]}}, inph_prod_reg20 } + { {(54-(19+WIDTH)){inph_prod_reg21[18+WIDTH]}}, inph_prod_reg21 };
        quad_accum0_reg10 <= { {(54-(19+WIDTH)){quad_prod_reg20[18+WIDTH]}}, quad_prod_reg20 } + { {(54-(19+WIDTH)){quad_prod_reg21[18+WIDTH]}}, quad_prod_reg21 };

        inph_accum0_reg11 <= { {(54-(19+WIDTH)){inph_prod_reg22[18+WIDTH]}}, inph_prod_reg22 } + { {(54-(19+WIDTH)){inph_prod_reg23[18+WIDTH]}}, inph_prod_reg23 };
        quad_accum0_reg11 <= { {(54-(19+WIDTH)){quad_prod_reg22[18+WIDTH]}}, quad_prod_reg22 } + { {(54-(19+WIDTH)){quad_prod_reg23[18+WIDTH]}}, quad_prod_reg23 };

        inph_accum0_reg12 <= { {(54-(19+WIDTH)){inph_prod_reg24[18+WIDTH]}}, inph_prod_reg24 } + { {(54-(19+WIDTH)){inph_prod_reg25[18+WIDTH]}}, inph_prod_reg25 };
        quad_accum0_reg12 <= { {(54-(19+WIDTH)){quad_prod_reg24[18+WIDTH]}}, quad_prod_reg24 } + { {(54-(19+WIDTH)){quad_prod_reg25[18+WIDTH]}}, quad_prod_reg25 };

        inph_accum0_reg13 <= { {(54-(19+WIDTH)){inph_prod_reg26[18+WIDTH]}}, inph_prod_reg26 } + { {(54-(19+WIDTH)){inph_prod_reg27[18+WIDTH]}}, inph_prod_reg27 };
        quad_accum0_reg13 <= { {(54-(19+WIDTH)){quad_prod_reg26[18+WIDTH]}}, quad_prod_reg26 } + { {(54-(19+WIDTH)){quad_prod_reg27[18+WIDTH]}}, quad_prod_reg27 };

        inph_accum0_reg14 <= { {(54-(19+WIDTH)){inph_prod_reg28[18+WIDTH]}}, inph_prod_reg28 } + { {(54-(19+WIDTH)){inph_prod_reg29[18+WIDTH]}}, inph_prod_reg29 };
        quad_accum0_reg14 <= { {(54-(19+WIDTH)){quad_prod_reg28[18+WIDTH]}}, quad_prod_reg28 } + { {(54-(19+WIDTH)){quad_prod_reg29[18+WIDTH]}}, quad_prod_reg29 };

        inph_accum0_reg15 <= { {(54-(19+WIDTH)){inph_prod_reg30[18+WIDTH]}}, inph_prod_reg30 } + { {(54-(19+WIDTH)){inph_prod_reg31[18+WIDTH]}}, inph_prod_reg31 };
        quad_accum0_reg15 <= { {(54-(19+WIDTH)){quad_prod_reg30[18+WIDTH]}}, quad_prod_reg30 } + { {(54-(19+WIDTH)){quad_prod_reg31[18+WIDTH]}}, quad_prod_reg31 };

        inph_accum0_reg16 <= { {(54-(19+WIDTH)){inph_prod_reg32[18+WIDTH]}}, inph_prod_reg32 } + { {(54-(19+WIDTH)){inph_prod_reg33[18+WIDTH]}}, inph_prod_reg33 };
        quad_accum0_reg16 <= { {(54-(19+WIDTH)){quad_prod_reg32[18+WIDTH]}}, quad_prod_reg32 } + { {(54-(19+WIDTH)){quad_prod_reg33[18+WIDTH]}}, quad_prod_reg33 };

        inph_accum0_reg17 <= { {(54-(19+WIDTH)){inph_prod_reg34[18+WIDTH]}}, inph_prod_reg34 } + { {(54-(19+WIDTH)){inph_prod_reg35[18+WIDTH]}}, inph_prod_reg35 };
        quad_accum0_reg17 <= { {(54-(19+WIDTH)){quad_prod_reg34[18+WIDTH]}}, quad_prod_reg34 } + { {(54-(19+WIDTH)){quad_prod_reg35[18+WIDTH]}}, quad_prod_reg35 };

        inph_accum0_reg18 <= { {(54-(19+WIDTH)){inph_prod_reg36[18+WIDTH]}}, inph_prod_reg36 } + { {(54-(19+WIDTH)){inph_prod_reg37[18+WIDTH]}}, inph_prod_reg37 };
        quad_accum0_reg18 <= { {(54-(19+WIDTH)){quad_prod_reg36[18+WIDTH]}}, quad_prod_reg36 } + { {(54-(19+WIDTH)){quad_prod_reg37[18+WIDTH]}}, quad_prod_reg37 };

        inph_accum0_reg19 <= { {(54-(19+WIDTH)){inph_prod_reg38[18+WIDTH]}}, inph_prod_reg38 } + { {(54-(19+WIDTH)){inph_prod_reg39[18+WIDTH]}}, inph_prod_reg39 };
        quad_accum0_reg19 <= { {(54-(19+WIDTH)){quad_prod_reg38[18+WIDTH]}}, quad_prod_reg38 } + { {(54-(19+WIDTH)){quad_prod_reg39[18+WIDTH]}}, quad_prod_reg39 };

        inph_accum0_reg20 <= { {(54-(19+WIDTH)){inph_prod_reg40[18+WIDTH]}}, inph_prod_reg40 } + { {(54-(19+WIDTH)){inph_prod_reg41[18+WIDTH]}}, inph_prod_reg41 };
        quad_accum0_reg20 <= { {(54-(19+WIDTH)){quad_prod_reg40[18+WIDTH]}}, quad_prod_reg40 } + { {(54-(19+WIDTH)){quad_prod_reg41[18+WIDTH]}}, quad_prod_reg41 };

        inph_accum0_reg21 <= { {(54-(19+WIDTH)){inph_prod_reg42[18+WIDTH]}}, inph_prod_reg42 } + { {(54-(19+WIDTH)){inph_prod_reg43[18+WIDTH]}}, inph_prod_reg43 };
        quad_accum0_reg21 <= { {(54-(19+WIDTH)){quad_prod_reg42[18+WIDTH]}}, quad_prod_reg42 } + { {(54-(19+WIDTH)){quad_prod_reg43[18+WIDTH]}}, quad_prod_reg43 };

        inph_accum0_reg22 <= { {(54-(19+WIDTH)){inph_prod_reg44[18+WIDTH]}}, inph_prod_reg44 } + { {(54-(19+WIDTH)){inph_prod_reg45[18+WIDTH]}}, inph_prod_reg45 };
        quad_accum0_reg22 <= { {(54-(19+WIDTH)){quad_prod_reg44[18+WIDTH]}}, quad_prod_reg44 } + { {(54-(19+WIDTH)){quad_prod_reg45[18+WIDTH]}}, quad_prod_reg45 };

        inph_accum0_reg23 <= { {(54-(19+WIDTH)){inph_prod_reg46[18+WIDTH]}}, inph_prod_reg46 } + { {(54-(19+WIDTH)){inph_prod_reg47[18+WIDTH]}}, inph_prod_reg47 };
        quad_accum0_reg23 <= { {(54-(19+WIDTH)){quad_prod_reg46[18+WIDTH]}}, quad_prod_reg46 } + { {(54-(19+WIDTH)){quad_prod_reg47[18+WIDTH]}}, quad_prod_reg47 };

        inph_accum0_reg24 <= { {(54-(19+WIDTH)){inph_prod_reg48[18+WIDTH]}}, inph_prod_reg48 } + { {(54-(19+WIDTH)){inph_prod_reg49[18+WIDTH]}}, inph_prod_reg49 };
        quad_accum0_reg24 <= { {(54-(19+WIDTH)){quad_prod_reg48[18+WIDTH]}}, quad_prod_reg48 } + { {(54-(19+WIDTH)){quad_prod_reg49[18+WIDTH]}}, quad_prod_reg49 };

        inph_accum0_reg25 <= { {(54-(19+WIDTH)){inph_prod_reg50[18+WIDTH]}}, inph_prod_reg50 } + { {(54-(19+WIDTH)){inph_prod_reg51[18+WIDTH]}}, inph_prod_reg51 };
        quad_accum0_reg25 <= { {(54-(19+WIDTH)){quad_prod_reg50[18+WIDTH]}}, quad_prod_reg50 } + { {(54-(19+WIDTH)){quad_prod_reg51[18+WIDTH]}}, quad_prod_reg51 };

        inph_accum0_reg26 <= { {(54-(19+WIDTH)){inph_prod_reg52[18+WIDTH]}}, inph_prod_reg52 } + { {(54-(19+WIDTH)){inph_prod_reg53[18+WIDTH]}}, inph_prod_reg53 };
        quad_accum0_reg26 <= { {(54-(19+WIDTH)){quad_prod_reg52[18+WIDTH]}}, quad_prod_reg52 } + { {(54-(19+WIDTH)){quad_prod_reg53[18+WIDTH]}}, quad_prod_reg53 };

        inph_accum0_reg27 <= { {(54-(19+WIDTH)){inph_prod_reg54[18+WIDTH]}}, inph_prod_reg54 } + { {(54-(19+WIDTH)){inph_prod_reg55[18+WIDTH]}}, inph_prod_reg55 };
        quad_accum0_reg27 <= { {(54-(19+WIDTH)){quad_prod_reg54[18+WIDTH]}}, quad_prod_reg54 } + { {(54-(19+WIDTH)){quad_prod_reg55[18+WIDTH]}}, quad_prod_reg55 };

        inph_accum0_reg28 <= { {(54-(19+WIDTH)){inph_prod_reg56[18+WIDTH]}}, inph_prod_reg56 } + { {(54-(19+WIDTH)){inph_prod_reg57[18+WIDTH]}}, inph_prod_reg57 };
        quad_accum0_reg28 <= { {(54-(19+WIDTH)){quad_prod_reg56[18+WIDTH]}}, quad_prod_reg56 } + { {(54-(19+WIDTH)){quad_prod_reg57[18+WIDTH]}}, quad_prod_reg57 };

        inph_accum0_reg29 <= { {(54-(19+WIDTH)){inph_prod_reg58[18+WIDTH]}}, inph_prod_reg58 } + { {(54-(19+WIDTH)){inph_prod_reg59[18+WIDTH]}}, inph_prod_reg59 };
        quad_accum0_reg29 <= { {(54-(19+WIDTH)){quad_prod_reg58[18+WIDTH]}}, quad_prod_reg58 } + { {(54-(19+WIDTH)){quad_prod_reg59[18+WIDTH]}}, quad_prod_reg59 };

        inph_accum0_reg30 <= { {(54-(19+WIDTH)){inph_prod_reg60[18+WIDTH]}}, inph_prod_reg60 } + { {(54-(19+WIDTH)){inph_prod_reg61[18+WIDTH]}}, inph_prod_reg61 };
        quad_accum0_reg30 <= { {(54-(19+WIDTH)){quad_prod_reg60[18+WIDTH]}}, quad_prod_reg60 } + { {(54-(19+WIDTH)){quad_prod_reg61[18+WIDTH]}}, quad_prod_reg61 };

        inph_accum0_reg31 <= { {(54-(19+WIDTH)){inph_prod_reg62[18+WIDTH]}}, inph_prod_reg62 } + { {(54-(19+WIDTH)){inph_prod_reg63[18+WIDTH]}}, inph_prod_reg63 };
        quad_accum0_reg31 <= { {(54-(19+WIDTH)){quad_prod_reg62[18+WIDTH]}}, quad_prod_reg62 } + { {(54-(19+WIDTH)){quad_prod_reg63[18+WIDTH]}}, quad_prod_reg63 };

        inph_del_reg4 <= inph_del_reg3;
        quad_del_reg4 <= quad_del_reg3;
    end
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

logic signed [53:0] inph_accum1_reg8;
logic signed [53:0] quad_accum1_reg8;

logic signed [53:0] inph_accum1_reg9;
logic signed [53:0] quad_accum1_reg9;

logic signed [53:0] inph_accum1_reg10;
logic signed [53:0] quad_accum1_reg10;

logic signed [53:0] inph_accum1_reg11;
logic signed [53:0] quad_accum1_reg11;

logic signed [53:0] inph_accum1_reg12;
logic signed [53:0] quad_accum1_reg12;

logic signed [53:0] inph_accum1_reg13;
logic signed [53:0] quad_accum1_reg13;

logic signed [53:0] inph_accum1_reg14;
logic signed [53:0] quad_accum1_reg14;

logic signed [53:0] inph_accum1_reg15;
logic signed [53:0] quad_accum1_reg15;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
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

        inph_accum1_reg8 <= inph_accum0_reg16 + inph_accum0_reg17;
        quad_accum1_reg8 <= quad_accum0_reg16 + quad_accum0_reg17;

        inph_accum1_reg9 <= inph_accum0_reg18 + inph_accum0_reg19;
        quad_accum1_reg9 <= quad_accum0_reg18 + quad_accum0_reg19;

        inph_accum1_reg10 <= inph_accum0_reg20 + inph_accum0_reg21;
        quad_accum1_reg10 <= quad_accum0_reg20 + quad_accum0_reg21;

        inph_accum1_reg11 <= inph_accum0_reg22 + inph_accum0_reg23;
        quad_accum1_reg11 <= quad_accum0_reg22 + quad_accum0_reg23;

        inph_accum1_reg12 <= inph_accum0_reg24 + inph_accum0_reg25;
        quad_accum1_reg12 <= quad_accum0_reg24 + quad_accum0_reg25;

        inph_accum1_reg13 <= inph_accum0_reg26 + inph_accum0_reg27;
        quad_accum1_reg13 <= quad_accum0_reg26 + quad_accum0_reg27;

        inph_accum1_reg14 <= inph_accum0_reg28 + inph_accum0_reg29;
        quad_accum1_reg14 <= quad_accum0_reg28 + quad_accum0_reg29;

        inph_accum1_reg15 <= inph_accum0_reg30 + inph_accum0_reg31;
        quad_accum1_reg15 <= quad_accum0_reg30 + quad_accum0_reg31;

        inph_del_reg5 <= inph_del_reg4;
        quad_del_reg5 <= quad_del_reg4;
    end
end

logic signed [53:0] inph_accum2_reg0;
logic signed [53:0] quad_accum2_reg0;

logic signed [53:0] inph_accum2_reg1;
logic signed [53:0] quad_accum2_reg1;

logic signed [53:0] inph_accum2_reg2;
logic signed [53:0] quad_accum2_reg2;

logic signed [53:0] inph_accum2_reg3;
logic signed [53:0] quad_accum2_reg3;

logic signed [53:0] inph_accum2_reg4;
logic signed [53:0] quad_accum2_reg4;

logic signed [53:0] inph_accum2_reg5;
logic signed [53:0] quad_accum2_reg5;

logic signed [53:0] inph_accum2_reg6;
logic signed [53:0] quad_accum2_reg6;

logic signed [53:0] inph_accum2_reg7;
logic signed [53:0] quad_accum2_reg7;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        // Adder trees for FIR filter
        inph_accum2_reg0 <= inph_accum1_reg0 + inph_accum1_reg1;
        quad_accum2_reg0 <= quad_accum1_reg0 + quad_accum1_reg1;

        inph_accum2_reg1 <= inph_accum1_reg2 + inph_accum1_reg3;
        quad_accum2_reg1 <= quad_accum1_reg2 + quad_accum1_reg3;

        inph_accum2_reg2 <= inph_accum1_reg4 + inph_accum1_reg5;
        quad_accum2_reg2 <= quad_accum1_reg4 + quad_accum1_reg5;

        inph_accum2_reg3 <= inph_accum1_reg6 + inph_accum1_reg7;
        quad_accum2_reg3 <= quad_accum1_reg6 + quad_accum1_reg7;

        inph_accum2_reg4 <= inph_accum1_reg8 + inph_accum1_reg9;
        quad_accum2_reg4 <= quad_accum1_reg8 + quad_accum1_reg9;

        inph_accum2_reg5 <= inph_accum1_reg10 + inph_accum1_reg11;
        quad_accum2_reg5 <= quad_accum1_reg10 + quad_accum1_reg11;

        inph_accum2_reg6 <= inph_accum1_reg12 + inph_accum1_reg13;
        quad_accum2_reg6 <= quad_accum1_reg12 + quad_accum1_reg13;

        inph_accum2_reg7 <= inph_accum1_reg14 + inph_accum1_reg15;
        quad_accum2_reg7 <= quad_accum1_reg14 + quad_accum1_reg15;

        inph_del_reg6 <= inph_del_reg5;
        quad_del_reg6 <= quad_del_reg5;
    end
end

logic signed [53:0] inph_accum3_reg0;
logic signed [53:0] quad_accum3_reg0;

logic signed [53:0] inph_accum3_reg1;
logic signed [53:0] quad_accum3_reg1;

logic signed [53:0] inph_accum3_reg2;
logic signed [53:0] quad_accum3_reg2;

logic signed [53:0] inph_accum3_reg3;
logic signed [53:0] quad_accum3_reg3;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        // Adder trees for FIR filter
        inph_accum3_reg0 <= inph_accum2_reg0 + inph_accum2_reg1;
        quad_accum3_reg0 <= quad_accum2_reg0 + quad_accum2_reg1;

        inph_accum3_reg1 <= inph_accum2_reg2 + inph_accum2_reg3;
        quad_accum3_reg1 <= quad_accum2_reg2 + quad_accum2_reg3;

        inph_accum3_reg2 <= inph_accum2_reg4 + inph_accum2_reg5;
        quad_accum3_reg2 <= quad_accum2_reg4 + quad_accum2_reg5;

        inph_accum3_reg3 <= inph_accum2_reg6 + inph_accum2_reg7;
        quad_accum3_reg3 <= quad_accum2_reg6 + quad_accum2_reg7;

        inph_del_reg7 <= inph_del_reg6;
        quad_del_reg7 <= quad_del_reg6;
    end
end

logic signed [53:0] inph_accum4_reg0;
logic signed [53:0] quad_accum4_reg0;

logic signed [53:0] inph_accum4_reg1;
logic signed [53:0] quad_accum4_reg1;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        // Adder trees for FIR filter
        inph_accum4_reg0 <= inph_accum3_reg0 + inph_accum3_reg1;
        quad_accum4_reg0 <= quad_accum3_reg0 + quad_accum3_reg1;

        inph_accum4_reg1 <= inph_accum3_reg2 + inph_accum3_reg3;
        quad_accum4_reg1 <= quad_accum3_reg2 + quad_accum3_reg3;

        inph_del_reg8 <= inph_del_reg7;
        quad_del_reg8 <= quad_del_reg7;
    end
end

logic signed [53:0] inph_accum5_reg0;
logic signed [53:0] quad_accum5_reg0;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        // Adder trees for FIR filter
        inph_accum5_reg0 <= inph_accum4_reg0 + inph_accum4_reg1;
        quad_accum5_reg0 <= quad_accum4_reg0 + quad_accum4_reg1;

        inph_del_reg9 <= inph_del_reg8;
        quad_del_reg9 <= quad_del_reg8;
    end
end

logic signed [53:0] concatenated_inph_delay;
logic signed [53:0] concatenated_quad_delay;
logic signed [53:0] inph_output_reg;
logic signed [53:0] quad_output_reg;

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        inph_output_reg <= inph_accum5_reg0;
        quad_output_reg <= quad_accum5_reg0;
    end
end

always_ff @ (posedge i_clock) begin
    if ((i_ready == 1'b1) && (pp_toggle == 1'b1)) begin
        if ($signed(inph_output_reg[53:WIDTH+18-1]) > 0) begin
            o_inph_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(inph_output_reg[53:WIDTH+18-1]) < -1) begin
            o_inph_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_inph_data <= $signed(inph_output_reg[WIDTH+18-1:18]);
        end
        if ($signed(quad_output_reg[53:WIDTH+18-1]) > 0) begin
            o_quad_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(quad_output_reg[53:WIDTH+18-1]) < -1) begin
            o_quad_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_quad_data <= $signed(quad_output_reg[WIDTH+18-1:18]);
        end
    end else if ((i_ready == 1'b1) && (pp_toggle == 1'b0)) begin
        concatenated_inph_delay = {
            {(54-17-WIDTH){inph_del_reg9[WIDTH-1]}},
            inph_del_reg9,
            1'b1, // For round half-up algorithm
            16'b0
        };
        concatenated_quad_delay = {
            {(54-17-WIDTH){quad_del_reg9[WIDTH-1]}},
            quad_del_reg9,
            1'b1, // For round half-up algorithm
            16'b0
        };
        if ($signed(concatenated_inph_delay[53:WIDTH+18-1]) > 0) begin
            o_inph_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(concatenated_inph_delay[53:WIDTH+18-1]) < -1) begin
            o_inph_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_inph_data <= concatenated_inph_delay[WIDTH+18-1:18];
        end
        if ($signed(concatenated_quad_delay[53:WIDTH+18-1]) > 0) begin
            o_quad_data <= {1'b0, {(WIDTH-1){1'b1}}};
        end else if ($signed(concatenated_quad_delay[53:WIDTH+18-1]) < -1) begin
            o_quad_data <= {1'b1, {(WIDTH-1){1'b0}}};
        end else begin
            o_quad_data <= concatenated_quad_delay[WIDTH+18-1:18];
        end
    end
end

endmodule: duc_hb_interp_fir_h2


`default_nettype wire
