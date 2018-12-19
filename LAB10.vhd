entity watch is
	Port ( iClk : in STD_LOGIC;
		   oaAN : out STD_LOGIC_VECTOR (3 downto 0); -- Anozi
		   oaSEG : out STD_LOGIC_VECTOR (6 downto 0)); -- Segmente
end watch;

architecture Behavioral of watch is
	constant n : integer := 8; -- 8 in simulare
	
	signal saDat : STD_LOGIC_VECTOR (15 downto 0);
	signal saQ_Cnt : STD_LOGIC_VECTOR (19 downto 1) := (others => '0');
	signal saDgt : STD_LOGIC_VECTOR (3 downto 0);
	
	signal saQ_Dv : STD_LOGIC_VECTOR (25 downto 0) := (others => '0');
	signal sTC_Dv : STD_LOGIC;
	
	signal saQ_S : STD_LOGIC_VECTOR (3 downto 0) := "0000";
	signal saQ_S10 : STD_LOGIC_VECTOR (2 downto 0) := "101";
	
	signal saQ_M : STD_LOGIC_VECTOR (3 downto 0) := "1001";
	signal saQ_M10 : STD_LOGIC_VECTOR (2 downto 0) := "101";
	
begin

	process (iClk)
		begin
			if rising_edge (iClk) then
				saQ_Cnt <= saQ_Cnt + 1;
			end if;
	end process;
	
	with saQ_Cnt (19 downto 18) select
	oaAN <= "0111" when "00",
			"1011" when "01",
			"1101" when "10",
			"1110" when others;
	
	with saQ_Cnt (19 downto 18) select
	saDgt <= saDat (3 downto 0) when "00",
			 saDat (7 downto 4) when "01",
			 saDat (11 downto 8) when "10",
			 saDat (15 downto 12) when others;
			 
	with saDgt select
	oaSEG <= "1111001" when "0001", --1
			 "0100100" when "0010", --2
			 "0110000" when "0011", --3
			 "0011001" when "0100", --4
			 "0010010" when "0101", --5
			 "0000010" when "0110", --6
			 "1111000" when "0111", --7
			 "0000000" when "1000", --8
			 "0010000" when "1001", --9
			 "0001000" when "1010", --A
			 "0000011" when "1011", --B
			 "1000110" when "1100", --C
			 "0100001" when "1101", --D
			 "0000110" when "1110", --E
			 "0001110" when "1111", --F
			 "1000000" when others; --0

	process (iClk)
		begin
			if rising_edge (iClk) then
				if saQ_Dv(3) = '1' then
				   saQ_Dv <= conv_std_logic_vector(n-2, 27);
				else
				   saQ_Dv <= saQ_Dv - 1;
				end if;
			end if;
	end process;
	
	sTC_Dv <=  saQ_Dv(26);
	
	process (iClk)
		begin
			if rising_edge (iClk) then
			
				if sTC_Dv = '1' then
				   saQ_S <= saQ_S + 1;
					
					if saQ_S = 9 then
					   saQ_S <= "0000";
					   saQ_S10 < = saQ_S10 + 1;
						
						if saQ_S10 = 5 then
						   saQ_S10 <= "000";
						   saQ_M <= SaQ_M + 1;
						   
							if saQ_M = 9 then
							   saQ_M <= "0000";
							   saQ_M10 <= saQ_M10 + 1;
							  
								if saQ_M10 = 5 then
								   saQ_M10 <= "000";
								end if;
							
							end if;
							
						end if;
					
					end if;
				
				end if;
				
			end if;
			
	end process;
	
	saDat <= '0' & saQ_M10 & saQ_M & '0' & saQ_S10 & saQ_S;

end Behavioral;	
							  
							

			 