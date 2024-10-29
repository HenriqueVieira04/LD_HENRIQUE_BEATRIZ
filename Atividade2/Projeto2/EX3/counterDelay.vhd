library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counterDelay is
    port(
        clock : in std_logic;
        bd1display : out std_logic_vector(6 downto 0)
    );
end entity;
-- 
architecture behavioral of counterDelay is

    component display7 IS 
    port(
        SW3 :  IN  STD_LOGIC;
        SW2 :  IN  STD_LOGIC;
        SW1 :  IN  STD_LOGIC;
        SW0 :  IN  STD_LOGIC;
        as :  OUT  STD_LOGIC;
        cs :  OUT  STD_LOGIC;
        es :  OUT  STD_LOGIC;
        gs :  OUT  STD_LOGIC;
        fs :  OUT  STD_LOGIC;
        ds :  OUT  STD_LOGIC;
        bs :  OUT  STD_LOGIC
        );
    END component;
	 
	 component counter4 is
        port(
            enable : in std_logic;
				clock : in std_logic;
				clear : in std_logic;
				q : out std_logic_vector (0 to 3)
        );
    end component;

    signal count1 : std_logic_vector(25 downto 0) := "00000000000000000000000001";	-- para demorar 1 seg para o contador mudar de 0 para 1
	 signal count2 : std_logic_vector(3 downto 0) := (others => '0');
	 signal trigger : std_logic := '0';
    signal bd1 : std_logic_vector(6 downto 0);

begin
		
	 process(clock)
    begin
		if rising_edge(clock) then
			count1 <= std_logic_vector(unsigned(count1) + 1);
			if count1 = "11001010001011011101000000" then	-- verifica se chegou a 50M de ciclos ~ 1 seg
				 count1 <= (others => '0'); -- reseta
				 trigger <= '1';
			else
				trigger <= '0';
			end if;
		end if;
    end process;
	 
    c4: counter4 port map(trigger, clock, '1', count2);
    d7_1: display7 port map(count2(3), count2(2), count2(1), count2(0), bd1(0), bd1(2), bd1(4), bd1(6), bd1(5), bd1(3), bd1(1));

    bd1display <= bd1;

end architecture;
