library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter8display is
    port(
        enable : in std_logic;
        clock : in std_logic;
        clear : in std_logic;
        q : out std_logic_vector (0 to 7);
        bd1counter: out std_logic_vector (0 to 6);
        bd2counter: out std_logic_vector (0 to 6)
    );
end entity;

architecture behavioral of counter8display is

    component fft_pe is
        port(
            T, CLK, CLEAR : in std_logic;
            Q : out std_logic
        );
    end component;

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

    signal count : std_logic_vector(0 to 7);
    signal t : std_logic_vector(0 to 7);
    signal bd1 : std_logic_vector(0 to 6);
    signal bd2 : std_logic_vector(0 to 6);

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

    d7_1: display7 port map(count(3), count(2), count(1), count(0), bd1(0), bd1(2), bd1(4), bd1(6), bd1(5), bd1(3), bd1(1));
    d7_2: display7 port map(count(7), count(6), count(5), count(4), bd2(0), bd2(2), bd2(4), bd2(6), bd2(5), bd2(3), bd2(1));

    q <= count;
    bd1counter <= bd1;
    bd2counter <= bd2;

end architecture;
