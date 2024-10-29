library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter8 is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        q : out std_logic_vector (0 to 7)
    );
end entity;

architecture behavioral of counter8 is

    component fft_pe is
        port(
            T, CLK, CLEAR : in std_logic;
            Q : out std_logic
        );
    end component;

    signal count : std_logic_vector(0 to 7);
    signal t : std_logic_vector(0 to 7);

begin
    t <= (enable, enable and count(0), t(1) and count(1), t(2) and count(2), t(3) and count(3), t(4) and count(4), t(5) and count(5),
    t(6) and count(6));  
    
    fft0 : fft_pe port map(t(0), clock, clear, count(0));
    fft1 : fft_pe port map(t(1), clock, clear, count(1));
    fft2 : fft_pe port map(t(2), clock, clear, count(2));
    fft3 : fft_pe port map(t(3), clock, clear, count(3));
    fft4 : fft_pe port map(t(4), clock, clear, count(4));
    fft5 : fft_pe port map(t(5), clock, clear, count(5));
    fft6 : fft_pe port map(t(6), clock, clear, count(6));
    fft7 : fft_pe port map(t(7), clock, clear, count(7));

    q <= count;

end architecture;
