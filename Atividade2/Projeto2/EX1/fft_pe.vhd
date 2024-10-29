library ieee;
use ieee.std_logic_1164.all;

entity fft_pe is
    port(
        T, CLK, CLEAR : in std_logic;
        Q : buffer std_logic
    );
end entity;

architecture dataflow of fft_pe is
    signal qact, qprx : std_logic;

begin
    process(CLK, CLEAR)
    begin
        if CLEAR = '0' then
            qact <= '0';
        elsif rising_edge(CLK) then
            qact <= qprx;
        end if;
    end process;
    
    qprx <= qact when T = '0' else
    not qact;

    q <= qact; 

end architecture;
