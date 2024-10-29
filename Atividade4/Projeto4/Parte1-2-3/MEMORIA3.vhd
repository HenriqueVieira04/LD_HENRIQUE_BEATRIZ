LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY MEMORIA3 IS
	PORT
	(
		Ender		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Clock		: IN STD_LOGIC  := '1';
		DataInput	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Escrita		: IN STD_LOGIC ;
		--DataOutput	: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

        	HEX5, HEX4, HEX2, HEX0  : OUT std_logic_vector(6 downto 0) 
	);
END MEMORIA3;

ARCHITECTURE Behaviour OF MEMORIA3 IS
    TYPE mem IS ARRAY(0 TO 31) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mem_vec : mem := (others => (others => '0'));
    signal Data_Output_signal, Ender_signal : std_logic_vector(3 downto 0);
	 

    component Display7 is
        port (
            SWvec   : IN std_logic_vector(3 downto 0);
    
            HEXvec  : OUT std_logic_vector(6 downto 0)
        );
    end component Display7;

BEGIN
	
    PROCESS (Clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (Escrita = '1') THEN
					mem_vec(to_integer(unsigned(Ender))) <= DataInput;
					Data_Output_signal <= mem_vec(to_integer(unsigned(Ender)));
				ELSE
					Data_Output_signal <= mem_vec(to_integer(unsigned(Ender)));
            END IF;
        END IF;
    END PROCESS;
	 
    --DataOutput <= Data_Output_signal;

    Ender_signal <= "000" & Ender(4);

    Display_Address1: Display7 PORT MAP (Ender (3 downto 0), HEX4);
    Display_Address2: Display7 PORT MAP (Ender_signal, HEX5);
    Display_Data_IN : Display7 PORT MAP (DataInput, HEX2);
    Display_Data_OUT: Display7 PORT MAP (Data_Output_signal, HEX0);
END Behaviour;