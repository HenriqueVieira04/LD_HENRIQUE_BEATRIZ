library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter6sign is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        d1, d2, d3, d4, d5, d6 : out std_logic_vector (0 to 6)
    );
end entity;

architecture behavioral of counter6sign is

    -- Sinal do clock dividido
    signal clk_out : std_logic := '0';
    signal counter : integer := 0;
    constant DIVISOR : integer := 50000000;

    -- Contador de 3 bits
    signal count : integer := 0; -- Contador de 0 a 5

begin
    -- Divisor de clock
    process(clock, clear)
    begin
        if clear = '0' then
            clk_out <= '0';
            counter <= 0;
        elsif rising_edge(clock) then
            if counter = DIVISOR - 1 then
                clk_out <= not clk_out;
                counter <= 0;
            else
                counter <= counter + 1; -- Incrementa o contador
            end if;
        end if;
    end process;

    -- Contador normal
    process(clk_out, clear)
    begin
        if clear = '0' then
            count <= 0; 
        elsif rising_edge(clk_out) and enable = '1' then
            count <= (count + 1) mod 6; -- Contador de 3 bits (0 a 5)
        end if;
    end process;

    process(count)
    begin
        case count is
            when 0 =>
                d6 <= "1111111"; -- null
                d5 <= "1111111"; -- null
                d4 <= "1111111"; -- null
                d3 <= "1000010"; -- d
                d2 <= "0110000"; -- e
                d1 <= "0000001"; -- 0
            when 1 =>
                d6 <= "1111111"; -- null
                d5 <= "1111111"; -- null
                d4 <= "1000010"; -- d
                d3 <= "0110000"; -- e
                d2 <= "0000001"; -- 0
                d1 <= "1111111"; -- null       
            when 2 =>
                d6 <= "1111111"; -- null
                d5 <= "1000010"; -- d
                d4 <= "0110000"; -- e
                d3 <= "0000001"; -- 0
                d2 <= "1111111"; -- null
                d1 <= "1111111"; -- null
            when 3 =>
                d6 <= "1000010"; -- d
                d5 <= "0110000"; -- e
                d4 <= "0000001"; -- 0
                d3 <= "1111111"; -- null
                d2 <= "1111111"; -- null
                d1 <= "1111111"; -- null
            when 4 =>
                d6 <= "0110000"; -- e
                d5 <= "0000001"; -- 0
                d4 <= "1111111"; -- null
                d3 <= "1111111"; -- null
                d2 <= "1111111"; -- null
                d1 <= "1000010"; -- d
            when 5 =>
                d6 <= "0000001"; -- 0
                d5 <= "1111111"; -- null
                d4 <= "1111111"; -- null
                d3 <= "1111111"; -- null
                d2 <= "1000010"; -- d
                d1 <= "0110000"; -- e
            when others =>
                d6 <= "1111111"; -- null
                d5 <= "1111111"; -- null
                d4 <= "1111111"; -- null
                d3 <= "1000010"; -- d
                d2 <= "0110000"; -- e
                d1 <= "0000001"; -- 0
        end case;
    end process;

end architecture;
