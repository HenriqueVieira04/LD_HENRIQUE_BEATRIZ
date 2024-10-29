library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fsm_p1 is
    PORT(
        CLOCK : IN std_logic;
        RESET : IN std_logic;
        W : IN std_logic;
        Z : OUT std_logic;
		  LED_ADVISOR : OUT std_logic_VECTOR(8 DOWNTO 0)
    );
end entity;

architecture behavioral of fsm_p1 is

    signal state : std_logic_vector(8 downto 0) := (others => '0');
    signal next_state : std_logic_vector(8 downto 0);
    
begin

    -- Flip-Flops to store the current state
    process(CLOCK, RESET) is
    begin
        if RESET = '0' AND rising_edge(CLOCK) then
            state <= "000000001";  -- Estado inicial A
        elsif rising_edge(CLOCK) then
            state <= next_state;  -- Atualiza para o próximo estado
        end if;
    end process;

    -- Lógica para definir o próximo estado
    process(state, W) is
    begin
        case state is
            when "000000001" =>  -- Estado A
                if W = '1' then
                    next_state <= "001000000";  -- Transição para F
                    Z <= '0';
                else
                    next_state <= "000000010";  -- Transição para B
                    Z <= '0';
                end if;
            when "000000010" =>  -- Estado B
                if W = '1' then
                    next_state <= "001000000";  -- Transição para F
                    Z <= '0';
                else
                    next_state <= "000000100";  -- Transição para C
                    Z <= '0';
                end if;
            when "000000100" =>  -- Estado C
                if W = '1' then
                    next_state <= "001000000";  -- Transição para D
                    Z <= '0';
                else
                    next_state <= "000001000";  -- Transição para D
                    Z <= '0';
                end if;
            when "000001000" =>  -- Estado D
                if W = '1' then
                    next_state <= "001000000";  -- Transição para F
                    Z <= '0';
                else
                    next_state <= "000010000";  -- Transição para E
                    Z <= '0';
                end if;
            when "000010000" =>  -- Estado E
                if W = '1' then
                    next_state <= "001000000";  -- Transição para F
                    Z <= '0';
                else
                    next_state <= "000010000";  -- Permanece em E
                    Z <= '1';
                end if;
            when "000100000" =>  -- Estado F
                if W = '1' then
                    next_state <= "001000000";  -- Transição para G
                    Z <= '0';
                else
                    next_state <= "000000010";  -- Volta para B
                    Z <= '0';
                end if;
            when "001000000" =>  -- Estado G
                if W = '1' then
                    next_state <= "010000000";  -- Transição para H
                    Z <= '0';
                else
                    next_state <= "000000010";  -- Volta para B
                    Z <= '0';
                end if;
            when "010000000" =>  -- Estado H
                if W = '1' then
                    next_state <= "100000000";  -- Transição para I
                    Z <= '0';  -- Quatro 1s detectados
                else
                    next_state <= "000000010";  -- Volta para B
                    Z <= '0';
                end if;
            when "100000000" =>  -- Estado I
                if W = '1' then
                    next_state <= "100000000";  -- (ciclo)
                    Z <= '1';  -- Quatro 1s detectados
                else
                    next_state <= "000000010";  -- Volta para B
                    Z <= '0';
                end if;
            when others =>
                next_state <= "000000001";  -- Estado de reset
                Z <= '0';
        end case;
    end process;
	 
	 LED_ADVISOR <= state;

end architecture;
