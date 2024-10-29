library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parte4 is
    port(
		enderecoEscrita		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		clock		: IN STD_LOGIC;
		reset		: IN STD_LOGIC;
		DataInput		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Escrita		: IN STD_LOGIC ;
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0  : OUT std_logic_vector(6 downto 0)
    );
end entity;
-- 
architecture behavioral of parte4 is

    component ram32x4 IS
		PORT
		(
			clock		: IN STD_LOGIC;
			data		: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			rdaddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			wraddress		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			wren		: IN STD_LOGIC  := '0';
			q		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
		END component;
	 
	component Display7 is
        port (
            SWvec   : IN std_logic_vector(3 downto 0);
            HEXvec  : OUT std_logic_vector(6 downto 0)
        );
    end component Display7;
	 
	--signal counter : integer := 0; --contador para 1 seg
	signal counter: std_logic_vector(25 downto 0);
	signal addressCount: std_logic_vector(4 downto 0) := (others => '0'); --contador para percorrer as posições da memória
	signal last_addressCount: std_logic_vector(3 downto 0);
	
	signal Data_Output_signal, last_enderecoEscrita : std_logic_vector(3 downto 0);
	signal escrever : std_logic := '0';	-- para enviar o sinal ao bloco de memória de forma síncrona
	signal q : std_logic_vector(3 downto 0) := (others =>'0');
	
BEGIN
	
    PROCESS (Clock, reset)
    BEGIN
        IF rising_edge(clock) THEN
				if reset = '0' then		-- isso aq n funciona, tbm testei com 1 :/
					counter <= (others => '0');
				end if;
					
				--if counter = 25000000 then	--contar 1 seg
				if counter = "01011111010111100001000000" then
					counter <= (others => '0');
					addressCount <= std_logic_vector(unsigned(addressCount) + 1);
				end if;
				
				
				if(addressCount = "1111") then
					addressCount <= "0000";
				end if;
				
				escrever <= Escrita;
				
				counter <= std_logic_vector(unsigned(counter) + 1);
				
            --IF (Escrita = '1') THEN
					--escrever = '1'
					--mem_vec(to_integer(unsigned(Ender))) <= DataInput;
					--Data_Output_signal <= mem_vec(to_integer(unsigned(Ender)));
					
            --END IF;
        END IF;
    END PROCESS;
	 
	 

    last_enderecoEscrita <= "000" & enderecoEscrita(4);
	 last_addressCount <= "000" & addressCount(4);

    Display_AddressW1: Display7 PORT MAP (enderecoEscrita (3 downto 0), HEX4);	-- display para endereço de escrita
    Display_AddressW2: Display7 PORT MAP (last_enderecoEscrita, HEX5);
	 
	 Display_AddressR1: Display7 PORT MAP (addressCount (3 downto 0), HEX2);	-- display para endereço de leitura
    Display_AddressR2: Display7 PORT MAP (last_addressCount, HEX3);
	 
    Display_Data_IN : Display7 PORT MAP (DataInput, HEX1);		-- display para input
	 
	 Display_Data_OUT : Display7 PORT MAP (q, HEX0);		-- display para dados
	
			
	 ram32x4inst: ram32x4 port map (clock, DataInput, addressCount, enderecoEscrita, Escrita, q);

	 
	 
end architecture;