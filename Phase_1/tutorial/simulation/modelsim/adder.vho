-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"

-- DATE "01/18/2026 15:43:11"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	RCAdd IS
    PORT (
	A : IN std_logic_vector(7 DOWNTO 0);
	B : IN std_logic_vector(7 DOWNTO 0);
	Result : OUT std_logic_vector(7 DOWNTO 0)
	);
END RCAdd;

-- Design Ports Information
-- Result[0]	=>  Location: PIN_AB15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[1]	=>  Location: PIN_AA12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[2]	=>  Location: PIN_Y11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[3]	=>  Location: PIN_AB13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[4]	=>  Location: PIN_Y15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[5]	=>  Location: PIN_AA15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[6]	=>  Location: PIN_P9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Result[7]	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_Y16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_AB21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_AB18,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_V15,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_AB17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_V13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_U13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_Y17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[4]	=>  Location: PIN_AA13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[4]	=>  Location: PIN_AB12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[5]	=>  Location: PIN_V14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[5]	=>  Location: PIN_T12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[6]	=>  Location: PIN_AB20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[6]	=>  Location: PIN_AA14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[7]	=>  Location: PIN_Y14,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[7]	=>  Location: PIN_T13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF RCAdd IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_A : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_Result : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \Result~0_combout\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \Result~1_combout\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \Result~2_combout\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \RippleCarryAdder:LocalCarry[3]~0_combout\ : std_logic;
SIGNAL \Result~3_combout\ : std_logic;
SIGNAL \A[4]~input_o\ : std_logic;
SIGNAL \B[4]~input_o\ : std_logic;
SIGNAL \Result~4_combout\ : std_logic;
SIGNAL \A[5]~input_o\ : std_logic;
SIGNAL \B[5]~input_o\ : std_logic;
SIGNAL \Result~5_combout\ : std_logic;
SIGNAL \Result~6_combout\ : std_logic;
SIGNAL \B[6]~input_o\ : std_logic;
SIGNAL \RippleCarryAdder:LocalCarry[5]~0_combout\ : std_logic;
SIGNAL \A[6]~input_o\ : std_logic;
SIGNAL \Result~7_combout\ : std_logic;
SIGNAL \B[7]~input_o\ : std_logic;
SIGNAL \A[7]~input_o\ : std_logic;
SIGNAL \Result~8_combout\ : std_logic;
SIGNAL \Result~9_combout\ : std_logic;
SIGNAL \ALT_INV_B[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_B[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_A[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_Result~8_combout\ : std_logic;
SIGNAL \ALT_INV_RippleCarryAdder:LocalCarry[5]~0_combout\ : std_logic;
SIGNAL \ALT_INV_Result~5_combout\ : std_logic;
SIGNAL \ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\ : std_logic;

BEGIN

ww_A <= A;
ww_B <= B;
Result <= ww_Result;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_B[7]~input_o\ <= NOT \B[7]~input_o\;
\ALT_INV_A[7]~input_o\ <= NOT \A[7]~input_o\;
\ALT_INV_B[6]~input_o\ <= NOT \B[6]~input_o\;
\ALT_INV_A[6]~input_o\ <= NOT \A[6]~input_o\;
\ALT_INV_B[5]~input_o\ <= NOT \B[5]~input_o\;
\ALT_INV_A[5]~input_o\ <= NOT \A[5]~input_o\;
\ALT_INV_B[4]~input_o\ <= NOT \B[4]~input_o\;
\ALT_INV_A[4]~input_o\ <= NOT \A[4]~input_o\;
\ALT_INV_B[3]~input_o\ <= NOT \B[3]~input_o\;
\ALT_INV_A[3]~input_o\ <= NOT \A[3]~input_o\;
\ALT_INV_B[2]~input_o\ <= NOT \B[2]~input_o\;
\ALT_INV_A[2]~input_o\ <= NOT \A[2]~input_o\;
\ALT_INV_B[1]~input_o\ <= NOT \B[1]~input_o\;
\ALT_INV_A[1]~input_o\ <= NOT \A[1]~input_o\;
\ALT_INV_B[0]~input_o\ <= NOT \B[0]~input_o\;
\ALT_INV_A[0]~input_o\ <= NOT \A[0]~input_o\;
\ALT_INV_Result~8_combout\ <= NOT \Result~8_combout\;
\ALT_INV_RippleCarryAdder:LocalCarry[5]~0_combout\ <= NOT \RippleCarryAdder:LocalCarry[5]~0_combout\;
\ALT_INV_Result~5_combout\ <= NOT \Result~5_combout\;
\ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\ <= NOT \RippleCarryAdder:LocalCarry[3]~0_combout\;

-- Location: IOOBUF_X36_Y0_N53
\Result[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~0_combout\,
	devoe => ww_devoe,
	o => ww_Result(0));

-- Location: IOOBUF_X29_Y0_N36
\Result[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~1_combout\,
	devoe => ww_devoe,
	o => ww_Result(1));

-- Location: IOOBUF_X29_Y0_N53
\Result[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~2_combout\,
	devoe => ww_devoe,
	o => ww_Result(2));

-- Location: IOOBUF_X33_Y0_N93
\Result[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~3_combout\,
	devoe => ww_devoe,
	o => ww_Result(3));

-- Location: IOOBUF_X36_Y0_N2
\Result[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~4_combout\,
	devoe => ww_devoe,
	o => ww_Result(4));

-- Location: IOOBUF_X36_Y0_N36
\Result[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~6_combout\,
	devoe => ww_devoe,
	o => ww_Result(5));

-- Location: IOOBUF_X29_Y0_N19
\Result[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~7_combout\,
	devoe => ww_devoe,
	o => ww_Result(6));

-- Location: IOOBUF_X29_Y0_N2
\Result[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Result~9_combout\,
	devoe => ww_devoe,
	o => ww_Result(7));

-- Location: IOIBUF_X40_Y0_N58
\A[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: IOIBUF_X40_Y0_N75
\B[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: MLABCELL_X34_Y1_N0
\Result~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~0_combout\ = ( !\A[0]~input_o\ & ( \B[0]~input_o\ ) ) # ( \A[0]~input_o\ & ( !\B[0]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111111111111111111110000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datae => \ALT_INV_A[0]~input_o\,
	dataf => \ALT_INV_B[0]~input_o\,
	combout => \Result~0_combout\);

-- Location: IOIBUF_X38_Y0_N1
\B[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: IOIBUF_X38_Y0_N35
\A[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: MLABCELL_X34_Y1_N39
\Result~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~1_combout\ = ( \A[0]~input_o\ & ( \B[0]~input_o\ & ( !\B[1]~input_o\ $ (\A[1]~input_o\) ) ) ) # ( !\A[0]~input_o\ & ( \B[0]~input_o\ & ( !\B[1]~input_o\ $ (!\A[1]~input_o\) ) ) ) # ( \A[0]~input_o\ & ( !\B[0]~input_o\ & ( !\B[1]~input_o\ $ 
-- (!\A[1]~input_o\) ) ) ) # ( !\A[0]~input_o\ & ( !\B[0]~input_o\ & ( !\B[1]~input_o\ $ (!\A[1]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010110101010010101011010101001010101101010101010101001010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[1]~input_o\,
	datad => \ALT_INV_A[1]~input_o\,
	datae => \ALT_INV_A[0]~input_o\,
	dataf => \ALT_INV_B[0]~input_o\,
	combout => \Result~1_combout\);

-- Location: IOIBUF_X33_Y0_N58
\B[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: IOIBUF_X38_Y0_N52
\A[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: MLABCELL_X34_Y1_N12
\Result~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~2_combout\ = ( \A[2]~input_o\ & ( \B[0]~input_o\ & ( !\B[2]~input_o\ $ (((!\A[1]~input_o\ & (\B[1]~input_o\ & \A[0]~input_o\)) # (\A[1]~input_o\ & ((\A[0]~input_o\) # (\B[1]~input_o\))))) ) ) ) # ( !\A[2]~input_o\ & ( \B[0]~input_o\ & ( 
-- !\B[2]~input_o\ $ (((!\A[1]~input_o\ & ((!\B[1]~input_o\) # (!\A[0]~input_o\))) # (\A[1]~input_o\ & (!\B[1]~input_o\ & !\A[0]~input_o\)))) ) ) ) # ( \A[2]~input_o\ & ( !\B[0]~input_o\ & ( !\B[2]~input_o\ $ (((\A[1]~input_o\ & \B[1]~input_o\))) ) ) ) # ( 
-- !\A[2]~input_o\ & ( !\B[0]~input_o\ & ( !\B[2]~input_o\ $ (((!\A[1]~input_o\) # (!\B[1]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011011000110110110010011100100100110110011011001100100110010011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_A[1]~input_o\,
	datab => \ALT_INV_B[2]~input_o\,
	datac => \ALT_INV_B[1]~input_o\,
	datad => \ALT_INV_A[0]~input_o\,
	datae => \ALT_INV_A[2]~input_o\,
	dataf => \ALT_INV_B[0]~input_o\,
	combout => \Result~2_combout\);

-- Location: IOIBUF_X40_Y0_N41
\B[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: IOIBUF_X33_Y0_N41
\A[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: MLABCELL_X34_Y1_N48
\RippleCarryAdder:LocalCarry[3]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RippleCarryAdder:LocalCarry[3]~0_combout\ = ( \A[2]~input_o\ & ( \B[0]~input_o\ & ( ((!\A[1]~input_o\ & (\B[1]~input_o\ & \A[0]~input_o\)) # (\A[1]~input_o\ & ((\A[0]~input_o\) # (\B[1]~input_o\)))) # (\B[2]~input_o\) ) ) ) # ( !\A[2]~input_o\ & ( 
-- \B[0]~input_o\ & ( (\B[2]~input_o\ & ((!\A[1]~input_o\ & (\B[1]~input_o\ & \A[0]~input_o\)) # (\A[1]~input_o\ & ((\A[0]~input_o\) # (\B[1]~input_o\))))) ) ) ) # ( \A[2]~input_o\ & ( !\B[0]~input_o\ & ( ((\A[1]~input_o\ & \B[1]~input_o\)) # 
-- (\B[2]~input_o\) ) ) ) # ( !\A[2]~input_o\ & ( !\B[0]~input_o\ & ( (\A[1]~input_o\ & (\B[2]~input_o\ & \B[1]~input_o\)) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100000001001101110011011100000001000100110011011101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_A[1]~input_o\,
	datab => \ALT_INV_B[2]~input_o\,
	datac => \ALT_INV_B[1]~input_o\,
	datad => \ALT_INV_A[0]~input_o\,
	datae => \ALT_INV_A[2]~input_o\,
	dataf => \ALT_INV_B[0]~input_o\,
	combout => \RippleCarryAdder:LocalCarry[3]~0_combout\);

-- Location: MLABCELL_X34_Y1_N54
\Result~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~3_combout\ = ( \A[3]~input_o\ & ( \RippleCarryAdder:LocalCarry[3]~0_combout\ & ( \B[3]~input_o\ ) ) ) # ( !\A[3]~input_o\ & ( \RippleCarryAdder:LocalCarry[3]~0_combout\ & ( !\B[3]~input_o\ ) ) ) # ( \A[3]~input_o\ & ( 
-- !\RippleCarryAdder:LocalCarry[3]~0_combout\ & ( !\B[3]~input_o\ ) ) ) # ( !\A[3]~input_o\ & ( !\RippleCarryAdder:LocalCarry[3]~0_combout\ & ( \B[3]~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101101010101010101010101010101010100101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[3]~input_o\,
	datae => \ALT_INV_A[3]~input_o\,
	dataf => \ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\,
	combout => \Result~3_combout\);

-- Location: IOIBUF_X34_Y0_N35
\A[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(4),
	o => \A[4]~input_o\);

-- Location: IOIBUF_X33_Y0_N75
\B[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(4),
	o => \B[4]~input_o\);

-- Location: MLABCELL_X34_Y1_N33
\Result~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~4_combout\ = ( \B[3]~input_o\ & ( \A[3]~input_o\ & ( !\A[4]~input_o\ $ (\B[4]~input_o\) ) ) ) # ( !\B[3]~input_o\ & ( \A[3]~input_o\ & ( !\A[4]~input_o\ $ (!\B[4]~input_o\ $ (\RippleCarryAdder:LocalCarry[3]~0_combout\)) ) ) ) # ( \B[3]~input_o\ & 
-- ( !\A[3]~input_o\ & ( !\A[4]~input_o\ $ (!\B[4]~input_o\ $ (\RippleCarryAdder:LocalCarry[3]~0_combout\)) ) ) ) # ( !\B[3]~input_o\ & ( !\A[3]~input_o\ & ( !\A[4]~input_o\ $ (!\B[4]~input_o\) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101101001011010010110101010010101011010101001011010010110100101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_A[4]~input_o\,
	datac => \ALT_INV_B[4]~input_o\,
	datad => \ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\,
	datae => \ALT_INV_B[3]~input_o\,
	dataf => \ALT_INV_A[3]~input_o\,
	combout => \Result~4_combout\);

-- Location: IOIBUF_X38_Y0_N18
\A[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(5),
	o => \A[5]~input_o\);

-- Location: IOIBUF_X34_Y0_N18
\B[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(5),
	o => \B[5]~input_o\);

-- Location: MLABCELL_X34_Y1_N9
\Result~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~5_combout\ = ( \B[5]~input_o\ & ( !\A[5]~input_o\ ) ) # ( !\B[5]~input_o\ & ( \A[5]~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111111111111000000001111111100000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \ALT_INV_A[5]~input_o\,
	dataf => \ALT_INV_B[5]~input_o\,
	combout => \Result~5_combout\);

-- Location: MLABCELL_X34_Y1_N42
\Result~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~6_combout\ = ( \B[3]~input_o\ & ( \A[3]~input_o\ & ( !\Result~5_combout\ $ (((!\B[4]~input_o\ & !\A[4]~input_o\))) ) ) ) # ( !\B[3]~input_o\ & ( \A[3]~input_o\ & ( !\Result~5_combout\ $ (((!\RippleCarryAdder:LocalCarry[3]~0_combout\ & 
-- ((!\B[4]~input_o\) # (!\A[4]~input_o\))) # (\RippleCarryAdder:LocalCarry[3]~0_combout\ & (!\B[4]~input_o\ & !\A[4]~input_o\)))) ) ) ) # ( \B[3]~input_o\ & ( !\A[3]~input_o\ & ( !\Result~5_combout\ $ (((!\RippleCarryAdder:LocalCarry[3]~0_combout\ & 
-- ((!\B[4]~input_o\) # (!\A[4]~input_o\))) # (\RippleCarryAdder:LocalCarry[3]~0_combout\ & (!\B[4]~input_o\ & !\A[4]~input_o\)))) ) ) ) # ( !\B[3]~input_o\ & ( !\A[3]~input_o\ & ( !\Result~5_combout\ $ (((!\B[4]~input_o\) # (!\A[4]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000001111111100000101111110100000010111111010000011111111000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\,
	datab => \ALT_INV_B[4]~input_o\,
	datac => \ALT_INV_A[4]~input_o\,
	datad => \ALT_INV_Result~5_combout\,
	datae => \ALT_INV_B[3]~input_o\,
	dataf => \ALT_INV_A[3]~input_o\,
	combout => \Result~6_combout\);

-- Location: IOIBUF_X34_Y0_N52
\B[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(6),
	o => \B[6]~input_o\);

-- Location: MLABCELL_X34_Y1_N6
\RippleCarryAdder:LocalCarry[5]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \RippleCarryAdder:LocalCarry[5]~0_combout\ = ( \RippleCarryAdder:LocalCarry[3]~0_combout\ & ( (!\B[4]~input_o\ & (\A[4]~input_o\ & ((\B[3]~input_o\) # (\A[3]~input_o\)))) # (\B[4]~input_o\ & (((\A[4]~input_o\) # (\B[3]~input_o\)) # (\A[3]~input_o\))) ) ) 
-- # ( !\RippleCarryAdder:LocalCarry[3]~0_combout\ & ( (!\B[4]~input_o\ & (\A[3]~input_o\ & (\B[3]~input_o\ & \A[4]~input_o\))) # (\B[4]~input_o\ & (((\A[3]~input_o\ & \B[3]~input_o\)) # (\A[4]~input_o\))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000100110111000000010011011100010011011111110001001101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_A[3]~input_o\,
	datab => \ALT_INV_B[4]~input_o\,
	datac => \ALT_INV_B[3]~input_o\,
	datad => \ALT_INV_A[4]~input_o\,
	dataf => \ALT_INV_RippleCarryAdder:LocalCarry[3]~0_combout\,
	combout => \RippleCarryAdder:LocalCarry[5]~0_combout\);

-- Location: IOIBUF_X40_Y0_N92
\A[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(6),
	o => \A[6]~input_o\);

-- Location: MLABCELL_X34_Y1_N18
\Result~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~7_combout\ = ( \A[6]~input_o\ & ( !\B[6]~input_o\ $ (((!\RippleCarryAdder:LocalCarry[5]~0_combout\ & (\B[5]~input_o\ & \A[5]~input_o\)) # (\RippleCarryAdder:LocalCarry[5]~0_combout\ & ((\A[5]~input_o\) # (\B[5]~input_o\))))) ) ) # ( 
-- !\A[6]~input_o\ & ( !\B[6]~input_o\ $ (((!\RippleCarryAdder:LocalCarry[5]~0_combout\ & ((!\B[5]~input_o\) # (!\A[5]~input_o\))) # (\RippleCarryAdder:LocalCarry[5]~0_combout\ & (!\B[5]~input_o\ & !\A[5]~input_o\)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101011001101010010101100110101010101001100101011010100110010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[6]~input_o\,
	datab => \ALT_INV_RippleCarryAdder:LocalCarry[5]~0_combout\,
	datac => \ALT_INV_B[5]~input_o\,
	datad => \ALT_INV_A[5]~input_o\,
	dataf => \ALT_INV_A[6]~input_o\,
	combout => \Result~7_combout\);

-- Location: IOIBUF_X34_Y0_N1
\B[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(7),
	o => \B[7]~input_o\);

-- Location: IOIBUF_X36_Y0_N18
\A[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(7),
	o => \A[7]~input_o\);

-- Location: MLABCELL_X34_Y1_N21
\Result~8\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~8_combout\ = !\B[7]~input_o\ $ (!\A[7]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111111110000000011111111000000001111111100000000111111110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_B[7]~input_o\,
	datad => \ALT_INV_A[7]~input_o\,
	combout => \Result~8_combout\);

-- Location: MLABCELL_X34_Y1_N24
\Result~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Result~9_combout\ = ( \A[5]~input_o\ & ( \A[6]~input_o\ & ( !\Result~8_combout\ $ (((!\B[6]~input_o\ & (!\RippleCarryAdder:LocalCarry[5]~0_combout\ & !\B[5]~input_o\)))) ) ) ) # ( !\A[5]~input_o\ & ( \A[6]~input_o\ & ( !\Result~8_combout\ $ 
-- (((!\B[6]~input_o\ & ((!\RippleCarryAdder:LocalCarry[5]~0_combout\) # (!\B[5]~input_o\))))) ) ) ) # ( \A[5]~input_o\ & ( !\A[6]~input_o\ & ( !\Result~8_combout\ $ (((!\B[6]~input_o\) # ((!\RippleCarryAdder:LocalCarry[5]~0_combout\ & !\B[5]~input_o\)))) ) 
-- ) ) # ( !\A[5]~input_o\ & ( !\A[6]~input_o\ & ( !\Result~8_combout\ $ (((!\B[6]~input_o\) # ((!\RippleCarryAdder:LocalCarry[5]~0_combout\) # (!\B[5]~input_o\)))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100011110000111100101101001011010011110000111100011110000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_B[6]~input_o\,
	datab => \ALT_INV_RippleCarryAdder:LocalCarry[5]~0_combout\,
	datac => \ALT_INV_Result~8_combout\,
	datad => \ALT_INV_B[5]~input_o\,
	datae => \ALT_INV_A[5]~input_o\,
	dataf => \ALT_INV_A[6]~input_o\,
	combout => \Result~9_combout\);

-- Location: LABCELL_X36_Y35_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


