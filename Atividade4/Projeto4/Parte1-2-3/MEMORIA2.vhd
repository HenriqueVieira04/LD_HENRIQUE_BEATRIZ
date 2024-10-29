LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY MEMORIA2 IS
	PORT
	(
		Ender		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Clock		: IN STD_LOGIC  := '1';
		DataInput		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Escrita		: IN STD_LOGIC ;
		--DataOutput		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
	
      HEX5, HEX4, HEX2, HEX0  : OUT std_logic_vector(6 downto 0) 
	);
END MEMORIA2;


ARCHITECTURE STRUCTURAL OF MEMORIA2 IS
    COMPONENT ram32x4
    PORT
    (
        address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
        clock		: IN STD_LOGIC  := '1';
        data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        wren		: IN STD_LOGIC ;
        q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
    END COMPONENT;

    component Display7 is
        port (
            SWvec   : IN std_logic_vector(3 downto 0);
            HEXvec  : OUT std_logic_vector(6 downto 0)
        );
    end component Display7;

    signal Data_Output_signal, Ender_signal : std_logic_vector(3 downto 0);
BEGIN
	
ram32x4_inst: ram32x4 port map (address => Ender, clock => Clock, data => DataInput, wren =>	Escrita, q => Data_Output_signal);

--DataOutput <= Data_Output_signal;

Ender_signal <= "000" & Ender(4);

Display_Address1: Display7 PORT MAP (Ender (3 downto 0), HEX4);
Display_Address2: Display7 PORT MAP (Ender_signal, HEX5);
Display_Data_IN : Display7 PORT MAP (DataInput, HEX2);
Display_Data_OUT: Display7 PORT MAP (Data_Output_signal, HEX0);


END STRUCTURAL;