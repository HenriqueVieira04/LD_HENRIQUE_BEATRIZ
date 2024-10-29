library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4 is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        q : out std_logic_vector (3 downto 0)
    );
end entity;
-- 
architecture behavioral of counter4 is

    signal count : std_logic_vector(3 downto 0) := (others => '0');
    signal nclear : std_logic;

begin
	nclear <= not clear;

	process(clock, nclear)
	begin
		if nclear = '1' then
			count <= (others => '0');
		elsif rising_edge(clock) then
			if enable = '1' then
				count <= std_logic_vector(unsigned(count) + 1);
				if count = "1001" then	-- limita a contagem até 9
					count <= (others => '0');
				end if;
			end if;
		end if;
	end process;

   q <= count;

end architecture;
