library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoryBlock is
    port(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
end entity;
-- 
architecture behavioral of memoryBlock is

    component ram32x4 is
    port(
		address		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
	 
	end component;

begin
		memoria: ram32x4 port map(address, clock, data, wren, q);
	 

end architecture;