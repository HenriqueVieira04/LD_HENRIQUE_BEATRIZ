library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter8display_noff is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        --q : out std_logic_vector (15 downto 0);
        bd1display : out std_logic_vector(6 downto 0);
        bd2display : out std_logic_vector(6 downto 0);
        bd3display : out std_logic_vector(6 downto 0);
        bd4display : out std_logic_vector(6 downto 0)
    );
end entity;
-- 
architecture behavioral of counter8display_noff is

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

    signal count : std_logic_vector(15 downto 0) := (others => '0');
    signal nclear : std_logic;
    signal bd1 : std_logic_vector(6 downto 0);
    signal bd2 : std_logic_vector(6 downto 0);
    signal bd3 : std_logic_vector(6 downto 0);
    signal bd4 : std_logic_vector(6 downto 0);

begin
    nclear <= not clear;

    process(clock, nclear)
    begin
        if nclear = '1' then
            count <= (others => '0');
        elsif rising_edge(clock) then
            if enable = '1' then
                count <= std_logic_vector(unsigned(count) + 1);
            end if;
        end if;
    end process;

    d7_1: display7 port map(count(3), count(2), count(1), count(0), bd1(0), bd1(2), bd1(4), bd1(6), bd1(5), bd1(3), bd1(1));
    d7_2: display7 port map(count(7), count(6), count(5), count(4), bd2(0), bd2(2), bd2(4), bd2(6), bd2(5), bd2(3), bd2(1));
    d7_3: display7 port map(count(11), count(10), count(9), count(8), bd3(0), bd3(2), bd3(4), bd3(6), bd3(5), bd3(3), bd3(1));
    d7_4: display7 port map(count(15), count(14), count(13), count(12), bd4(0), bd4(2), bd4(4), bd4(6), bd4(5), bd4(3), bd4(1));

    bd1display <= bd1;
    bd2display <= bd2;
    bd3display <= bd3;
    bd4display <= bd4; 

   --q <= count;

end architecture;
