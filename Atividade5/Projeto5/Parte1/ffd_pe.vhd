library ieee;
use ieee.std_logic_1164.all;

entity ffd_pe is
    PORT(
        clock, d : IN std_logic;
        q, qn : buffer std_logic 
    );
end entity;

architecture behavior of ffd_pe is
begin
    process(clock)
    begin
        if rising_edge(clock) then
            q <= d;
            qn <= not q;
        end if;
    end process;
end architecture;