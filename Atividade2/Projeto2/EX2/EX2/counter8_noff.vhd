library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter8_noff is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        q : out std_logic_vector (15 downto 0)
    );
end entity;

architecture behavioral of counter8_noff is
    signal count : std_logic_vector(15 downto 0) := (others => '0');
	 signal p : std_logic_vector(0 to 15) := (others => '0');

begin

    process(clock, clear)
    begin
        if clear = '0' then
            count <= (others => '0');
        elsif rising_edge(clock) then
            if enable = '1' then
                count <= std_logic_vector(unsigned(count) + 1);
            end if;
        end if;
		  
	 q <= count;
	 
    end process;


end architecture;
