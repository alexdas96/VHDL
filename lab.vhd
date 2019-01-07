entity cop2n is
	generic (
		n: integer := 2
	);
	Port ( iaI : in STD_LOGIC_VECTOR (2**n-1 downto 0);
		   oaC : out STD_LOGIC_VECTOR (n-1 downto 0);
		   oVld : out STD_LOGIC);
end cop2n;

architecture Behavioral of cop2n is
	signal saMax : integer;
begin

	process(iaI)
	begin
		for i in 0 to 2**n-1 loop
			if iaI(i) = '1' then
				saMax <= i;
			else
				saMax <= 0;
			end if;
			
		end loop;
	end process
	
	oaC <= conv_std_logic_vector(saMax, n);
	oVld <= '0' when conv_integer(iaI) = 0 else '1';
	
end Behavioral;