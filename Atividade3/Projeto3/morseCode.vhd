library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity morseCode is
    port(
		clock   : in std_logic;
		trigger : in std_logic;
		reset : in std_logic;
		letra : in std_logic_vector(2 downto 0);
		led 	  : out std_logic
    );
end entity;
-- 
architecture behavioral of morseCode is

    signal count : std_logic_vector(26 downto 0) := (others => '0'); -- inicializa em 0
	 signal ordem : integer := 0;
	 signal enable : std_logic := '0';

begin
		
	 process(trigger, clock, reset)
    begin
		
		if trigger = '0' then
			enable <= '1';
		elsif reset = '0' then
			enable <= '0';
		end if;
		
		if enable = '1' then
			if rising_Edge(clock) then
				case letra is
					-- A
					when "000" => -- Funcionamento: ordem ímpares equivalem à espera de 0,5 seg entre dois sinais.
					
						if (count <= "001100011001011101010000000" and ordem = 0) then -- incrementa por ~ 0,5 seg (26M) - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and ordem = 1) then -- incrementa por ~ 0,5 seg (26M) - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "100110001001011010000000000" and ordem = 2) then -- incrementa por ~ 1,5 seg (80M) - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 3) then -- incrementa por ~ 2 seg (100M) - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							--ordem <= (ordem + 1) mod 4;	-- garante um loop do código morse correnpondente
							if ordem < 4 then
								ordem <= ordem + 1;
							end if;
							count <= (others => '0');
							
						end if;
					
					-- B 
					when "001" => 
					
						if (count <= "100110001001011010000000000" and ordem = 0) then -- 1,5 seg  - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3 or ordem = 5)) then -- 0,5 seg  - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 2 or ordem = 4 or ordem = 6)) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 7) then -- 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 8 then
								ordem <= ordem + 1;
							end if;	
							count <= (others => '0');
							
						end if;
						
					-- C
					when "010" => 
					
						if (count <= "100110001001011010000000000" and (ordem = 0 or ordem = 4)) then -- 1,5 seg  - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3 or ordem = 5)) then -- 0,5 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 2 or ordem = 6)) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 7) then -- 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 8 then
								ordem <= ordem + 1;
							end if;
							count <= (others => '0');
							
						end if;
						
					-- D
					when "011" => 
					
						if (count <= "100110001001011010000000000" and ordem = 0) then -- 1,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3)) then -- 0,5 seg  - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 2 or ordem = 4)) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 5) then -- 2 seg  - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 6 then
								ordem <= ordem + 1;
							end if;
							count <= (others => '0');
							
						end if;
						
					-- E
					when "100" => 
					
						if (count <= "001100011001011101010000000" and ordem = 0) then -- incrementa por ~ 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 1) then -- incrementa por ~ 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 2 then
								ordem <= ordem + 1;
							end if;	
							count <= (others => '0');
							
						end if;
					
					-- F
					when "101" => 
					
						if (count <= "001100011001011101010000000" and (ordem = 0 or ordem = 2 or ordem = 6)) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3 or ordem = 5)) then -- 0,5 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "100110001001011010000000000" and ordem = 4) then --  1,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 7) then -- 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 8 then
								ordem <= ordem + 1;
							end if;	
							count <= (others => '0');
							
						end if;
					
					-- G
					when "110" => 
					
						if (count <= "100110001001011010000000000" and (ordem = 0 or ordem = 2)) then -- 1,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3)) then -- 0,5 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "001100011001011101010000000" and ordem = 4) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "101111101011110000100000000" and ordem = 5) then -- 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 6 then
								ordem <= ordem + 1;
							end if;	
							count <= (others => '0');
							
						end if;
					
					-- H
					when "111" => 
					
						if (count <= "001100011001011101010000000" and (ordem = 0 or ordem = 2 or ordem = 4 or ordem = 6)) then -- 0,5 seg - ACESO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '1';
							
						elsif (count <= "001100011001011101010000000" and (ordem = 1 or ordem = 3 or ordem = 5)) then -- 0,5 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						elsif (count <= "101111101011110000100000000" and ordem = 7) then -- 2 seg - APAGADO
							count <= std_logic_vector(unsigned(count) + 1);
							led <= '0';
							
						else
							if ordem < 8 then
								ordem <= ordem + 1;
							end if;
							count <= (others => '0');
							
						end if;
						
					when others =>
					
				end case;
			end if;
		
		else 					-- enable = 0
			led <= '0';
			count <= (others => '0');
			ordem <= 0;
		end if;
		
    end process;

end architecture;