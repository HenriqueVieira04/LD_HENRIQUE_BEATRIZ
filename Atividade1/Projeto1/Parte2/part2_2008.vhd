
LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY part2_2008 IS
PORT ( Clk, D: IN STD_LOGIC;
Q : OUT STD_LOGIC);
END part2_2008;

ARCHITECTURE Structural OF part2_2008 IS
SIGNAL R, R_g, S_g, Qa, Qb : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;


BEGIN
R_g <= NOT(Clk AND NOT D);
S_g <= NOT(Clk AND D);
Qa <= NOT(S_g AND Qb);
Qb <= NOT(R_g AND Qa);
Q <= Qa;

END Structural;