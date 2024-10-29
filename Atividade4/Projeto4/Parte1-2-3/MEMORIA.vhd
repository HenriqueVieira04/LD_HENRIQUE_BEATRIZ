library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Usando para operações aritméticas

entity MEMORIA is
    port (
        sw4, sw3, sw2, sw1, clock, qesc : in std_logic;
        led1 : out std_logic
    ); 
end entity;

architecture behavior of MEMORIA is
    signal entrada : std_logic_vector (3 downto 0);
    signal saida : std_logic_vector (3 downto 0);
    constant adr : std_logic_vector (4 downto 0) := "00000";  -- Endereço fixo

    component ram32x4 IS
        PORT (
            address : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            clock : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            wren : IN STD_LOGIC;
            q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    end component;

begin
    entrada <= sw4 & sw3 & sw2 & sw1;  -- Atribuição contínua

    ram1 : ram32x4
        port map (
            address => adr,         -- Endereço fixo
            clock => clock,
            data => entrada,
            wren => qesc,
            q => saida
        );

    process(clock)
    begin
        if rising_edge(clock) then
            -- Lógica de escrita se qesc estiver ativo
            if qesc = '1' then
                -- A RAM irá armazenar os dados em adr (que é sempre "00000")
            end if;

            -- Lê a saída 'q' da RAM
            if saida = "1111" then
                led1 <= '1';  -- Acende o LED se a saída for "1111"
            else
                led1 <= '0';  -- Apaga o LED caso contrário
            end if;
        end if;
    end process;

end architecture;
