library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Parte4 is
    Port(
        clock : in std_logic;   -- PIN_M9
        trigger : in std_logic; -- KEY 1
        reset : in std_logic;   -- KEY 0
        morse_code : in std_logic_vector (2 downto 0);  -- SW 2-0
        led : out std_logic
    );
end Parte4;

architecture Behavioral of Parte4 is
    type tipo_estado is (esperaInput, ponto, traco, pausa);
    signal estado, prox_estado: tipo_estado;

    signal duracao_ponto : integer := 40000000; -- 0,5 seg
    signal duracao_traco : integer := 80000000; -- 1,5 seg
    signal duracao_pausa : integer := 40000000; -- 0,5 seg
    signal timer : integer := 0;
    signal led_on : std_logic; -- sinal interno para controlar o LED

    type vetor_inteiro is array (0 to 4) of integer;
    type array_morse is array (0 to 7) of vetor_inteiro;	-- define um tipo array de 7 elementos de códigos morse (vetores de até 4 elementos)
    constant morse_correspondente : array_morse := (
        (0, 1, 3, 0, 0),  -- A: .-      
        (1, 0, 0, 0, 3),  -- B: -...    
        (1, 0, 1, 0, 3),  -- C: -.-.    
        (1, 0, 0, 3, 0),  -- D: -..     
        (0, 3, 0, 0, 0),  -- E: .
        (0, 0, 1, 0, 3),  -- F: ..-.
        (1, 1, 0, 3, 0),  -- G: --.
        (0, 0, 0, 0, 3)   -- H: ....
    );

    signal morse_atual : vetor_inteiro; -- armazena o código morse da letra atual
    signal morse_index : integer := 0; -- posição no vetor do código morse atual

begin

    
    process(clock, reset)
    begin
        if(reset = '0') then	-- reset
            led_on <= '0';
            timer <= 0;
            prox_estado <= esperaInput;
            morse_index <= 0; 
				
        elsif rising_edge(clock) then
            estado <= prox_estado;	-- lógica da máquina de estado

            -- Lógica do próximo estado
            case estado is
                when esperaInput =>
                    led_on <= '0';
                    timer <= 0;
                    morse_index <= 1;  -- reseta o índice do código morse
						  
                    if(trigger = '0') then
                        morse_atual <= morse_correspondente(to_integer(unsigned(morse_code)));
                        if morse_atual(0) = 1 then
                            prox_estado <= traco;
                        else
                            prox_estado <= ponto;
                        end if;
                    else
                        prox_estado <= esperaInput;
                    end if;

                when ponto =>
                    led_on <= '1'; 
                    if timer < duracao_ponto then
                        timer <= timer + 1;
                    else
                        timer <= 0;
                        prox_estado <= pausa;
                    end if;

                when traco =>
                    led_on <= '1'; 
                    if timer < duracao_traco then
                        timer <= timer + 1;
                    else
                        timer <= 0;
                        prox_estado <= pausa; 
                    end if;

                when pausa =>
                    led_on <= '0'; 
                    if timer < duracao_pausa then
                        timer <= timer + 1;
                    else
                        timer <= 0;
                        morse_index <= morse_index + 1; 
                        if morse_atual(morse_index) = 1 then
                            prox_estado <= traco;
                        elsif morse_atual(morse_index) = 0 then
                            prox_estado <= ponto;
                        else
                            prox_estado <= esperaInput; -- fim do código morse
                        end if;
                    end if;

                when others =>
                    prox_estado <= esperaInput;
            end case;
        end if;
    end process;

    led <= led_on;

end Behavioral;
