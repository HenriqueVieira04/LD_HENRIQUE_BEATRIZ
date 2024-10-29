library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4 is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        q : out std_logic_vector (0 to 3)
    );
end entity;

architecture behavioral of counter4 is

    component fft_pe is
        port(
            T, CLK, CLEAR : in std_logic;
            Q : out std_logic
        );
    end component;

    signal count : std_logic_vector(0 to 3);
    signal t : std_logic_vector(0 to 3);

begin
    t <= (enable, enable and count(0), t(1) and count(1), t(2) and count(2)); 
    
    fft0 : fft_pe port map(t(0), clock, clear, count(0));
    fft1 : fft_pe port map(t(1), clock, clear, count(1));
    fft2 : fft_pe port map(t(2), clock, clear, count(2));
    fft3 : fft_pe port map(t(3), clock, clear, count(3));
    
    q <= count;

end architecture;
