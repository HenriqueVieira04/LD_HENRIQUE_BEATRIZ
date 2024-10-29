-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"
-- CREATED		"Wed Aug 21 15:30:06 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY aula2 IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		D :  IN  STD_LOGIC;
		Q :  OUT  STD_LOGIC;
		notQ :  OUT  STD_LOGIC
	);
END aula2;

ARCHITECTURE Structural OF aula2 IS 

	SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
	ATTRIBUTE KEEP : BOOLEAN;
	ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;


BEGIN 

SYNTHESIZED_WIRE_14 <= NOT(CLK);

SYNTHESIZED_WIRE_5 <= NOT(SYNTHESIZED_WIRE_14 AND D);


SYNTHESIZED_WIRE_6 <= NOT(SYNTHESIZED_WIRE_1 AND SYNTHESIZED_WIRE_14);

SYNTHESIZED_WIRE_4 <= NOT(SYNTHESIZED_WIRE_6 AND SYNTHESIZED_WIRE_15);

SYNTHESIZED_WIRE_15 <= NOT(SYNTHESIZED_WIRE_4 AND SYNTHESIZED_WIRE_5);


SYNTHESIZED_WIRE_8 <= NOT(SYNTHESIZED_WIRE_15);





SYNTHESIZED_WIRE_1 <= NOT(D);


SYNTHESIZED_WIRE_12 <= NOT(SYNTHESIZED_WIRE_8 AND CLK);


SYNTHESIZED_WIRE_13 <= NOT(SYNTHESIZED_WIRE_9 AND SYNTHESIZED_WIRE_10);


SYNTHESIZED_WIRE_10 <= NOT(CLK AND SYNTHESIZED_WIRE_15);


SYNTHESIZED_WIRE_9 <= NOT(SYNTHESIZED_WIRE_12 AND SYNTHESIZED_WIRE_13);


Q <= SYNTHESIZED_WIRE_13;
notQ <= SYNTHESIZED_WIRE_9;

END bdf_type;