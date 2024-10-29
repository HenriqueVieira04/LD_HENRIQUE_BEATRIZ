library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4sign is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        d1, d2, d3, d4 : out std_logic_vector (0 to 6)
    );
end entity;

architecture behavioral of counter4sign is

    -- Sinal do clock dividido
    signal clk_out : std_logic := '0';
    signal counter : integer := 0;
    constant DIVISOR : integer := 50000000; -- Para um clock de 50 MHz

    -- Contador de 2 bits
    signal count : integer := 0; -- Contador de 0 a 3

begin
    -- Divisor de clock
    process(clock, clear)
    begin
        if clear = '1' then
            clk_out <= '0';
            counter <= 0;
        elsif rising_edge(clock) then
            if counter = DIVISOR - 1 then
                clk_out <= not clk_out; -- Inverte o sinal de saída
                counter <= 0; -- Reinicia o contador
            else
                counter <= counter + 1; -- Incrementa o contador
            end if;
        end if;
    end process;

    -- Contador normal
    process(clk_out, clear)
    begin
        if clear = '1' then
            count <= 0; -- Reinicia o contador
        elsif rising_edge(clk_out) and enable = '1' then
            count <= (count + 1) mod 4; -- Contador de 2 bits (0 a 3)
        end if;
    end process;

    process(count)
    begin
        case count is
            when 0 =>
                d4 <= "1111111"; -- 0
                d3 <= "1000010"; -- 1
                d2 <= "0110000"; -- 2
                d1 <= "0000001"; -- 3
            when 1 =>
                d4 <= "1000010"; -- 1
                d3 <= "0110000"; -- 2
                d2 <= "0000001"; -- 3
                d1 <= "1111111"; -- 0        
            when 2 =>
                d4 <= "0110000"; -- 2
                d3 <= "0000001"; -- 3
                d2 <= "1111111"; -- 0
                d1 <= "1000010"; -- 1
            when others =>
                d4 <= "0000001"; -- 3
                d3 <= "1111111"; -- 0
                d2 <= "1000010"; -- 1
                d1 <= "0110000"; -- 2
        end case;
    end process;

end architecture;
