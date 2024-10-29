LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY part4_2008 IS
    PORT (
        D, Clk : IN STD_LOGIC ;
        Qa, Qb, Qc: OUT STD_LOGIC
    ) ;
END part4_2008;

ARCHITECTURE Behavior OF part4_2008 IS
BEGIN
    PROCESS (Clk)
    BEGIN
        IF (Clk) = '1' THEN
            Qa <= D; 
        END IF;
    END PROCESS;

    PROCESS (Clk)
    BEGIN
        IF rising_edge(Clk) THEN
            Qb <= D; 
        END IF;
    END PROCESS;

    PROCESS (Clk)
    BEGIN
        IF falling_edge(Clk) THEN
            Qc <= D;
        END IF;
    END PROCESS;

END Behavior ;


