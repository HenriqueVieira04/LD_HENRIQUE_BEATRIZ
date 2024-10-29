LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY part3_2008 IS
PORT ( Clk, D: IN STD_LOGIC;
       Q : OUT STD_LOGIC);
END part3_2008;

ARCHITECTURE Structural OF part3_2008 IS
SIGNAL Clkm, Rgm, Sgm, Qam, Qbm, Ds, Clks, Rgs, Sgs, Qas, Qbs : STD_LOGIC ;
ATTRIBUTE KEEP : BOOLEAN;
ATTRIBUTE KEEP OF Clkm, Rgm, Sgm, Qam, Qbm, Ds, Clks, Rgs, Sgs, Qas, Qbs : SIGNAL IS TRUE;

BEGIN
    Clkm <= NOT Clk;
    Rgm <= NOT(Clkm AND NOT D);
    Sgm <= NOT(Clkm AND D);
    Qam <= NOT(Sgm AND Qbm);
    Qbm <= NOT(Rgm AND Qam);

    Ds <= Qam;
    Clks <= Clk;
    Rgs <= NOT(Clks AND NOT Ds);
    Sgs <= NOT(Clks AND Ds);
    Qas <= NOT(Sgs AND Qbs);
    Qbs <= NOT(Rgs AND Qas);

    Q <= Qas;

END Structural;
