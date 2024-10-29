LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Display7 is
    port (
        SWvec   : IN std_logic_vector(3 downto 0);

        HEXvec  : OUT std_logic_vector(6 downto 0)
    );
end entity Display7;

architecture rtl of Display7 is
    
begin

        HEXvec <= "1000000" when SWvec = "0000"
           else "1111001" when SWvec = "0001"
           else "0100100" when SWvec = "0010"
           else "0110000" when SWvec = "0011"
           else "0011001" when SWvec = "0100"
           else "0010010" when SWvec = "0101"
           else "0000010" when SWvec = "0110"
           else "1111000" when SWvec = "0111"
           else "0000000" when SWvec = "1000"
           else "0010000" when SWvec = "1001"
           else "0001000" when SWvec = "1010"
           else "0000011" when SWvec = "1011"
           else "1000110" when SWvec = "1100"
           else "0100001" when SWvec = "1101"
           else "0000110" when SWvec = "1110"
           else "0001110" when SWvec = "1111"
           else (Others => '1');    

end architecture rtl;