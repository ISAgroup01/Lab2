library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity gen_2nd is
	Port( ivect0  : IN  std_logic_vector(64-1 downto 0);
	      ivect1  : IN  std_logic_vector(64-1 downto 0);
	      ivect2  : IN  std_logic_vector(64-1 downto 0);
			ivect3  : IN  std_logic_vector(64-1 downto 0);
			ivect4  : IN  std_logic_vector(64-1 downto 0);
			ivect5  : IN  std_logic_vector(64-1 downto 0);
			ivect6  : IN  std_logic_vector(64-1 downto 0);
			ivect7  : IN  std_logic_vector(64-1 downto 0);
			ivect8  : IN  std_logic_vector(64-1 downto 0);
			ivect9  : IN  std_logic_vector(64-1 downto 0);
			ivect10 : IN  std_logic_vector(64-1 downto 0);
			ivect11 : IN  std_logic_vector(64-1 downto 0);
			ivect12 : IN  std_logic_vector(64-1 downto 0);
			ivect13 : IN  std_logic_vector(64-1 downto 0);
			ivect14 : IN  std_logic_vector(64-1 downto 0);
			ivect15 : IN  std_logic_vector(64-1 downto 0);
			ivect16 : IN  std_logic_vector(64-1 downto 0);
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0);
			ovect3  : OUT std_logic_vector(64-1 downto 0);
			ovect4  : OUT std_logic_vector(64-1 downto 0);
			ovect5  : OUT std_logic_vector(64-1 downto 0);
			ovect6  : OUT std_logic_vector(64-1 downto 0);
			ovect7  : OUT std_logic_vector(64-1 downto 0);
			ovect8  : OUT std_logic_vector(64-1 downto 0);
			ovect9  : OUT std_logic_vector(64-1 downto 0);
			ovect10 : OUT std_logic_vector(64-1 downto 0);
			ovect11 : OUT std_logic_vector(64-1 downto 0);
			ovect12 : OUT std_logic_vector(64-1 downto 0)
			);
end gen_2nd;

architecture struc of gen_2nd is
component FA
	Port( A    :  IN  std_logic;
	      B    :  IN  std_logic;
			Cin  :  IN  std_logic;
			Cout :  OUT std_logic;
			S    :  OUT std_logic);
end component;
component HA
	Port( A    :  IN  std_logic;
	      B    :  IN  std_logic;
			Cout :  OUT std_logic;
			S    :  OUT std_logic);
end component;
type type_level1 is array (17-1 downto 0) of std_logic_vector(64-1 downto 0); -- array 17*64
type type_level2 is array (13-1 downto 0) of std_logic_vector(64-1 downto 0); -- array 13*64
signal matrix1 : type_level1 := (others => (others => '0')); --matrix level 1 
signal matrix2 : type_level2 := (others => (others => '0')); --matrix level 2
begin
	matrix1(0)  <= ivect0;
	matrix1(1)  <= ivect1;
	matrix1(2)  <= ivect2;
	matrix1(3)  <= ivect3;
	matrix1(4)  <= ivect4;
	matrix1(5)  <= ivect5;
	matrix1(6)  <= ivect6;
	matrix1(7)  <= ivect7;
	matrix1(8)  <= ivect8;
	matrix1(9)  <= ivect9;
	matrix1(10) <= ivect10;
	matrix1(11) <= ivect11;
	matrix1(12) <= ivect12;
	matrix1(13) <= ivect13;
	matrix1(14) <= ivect14;
	matrix1(15) <= ivect15;
	matrix1(16) <= ivect16;
---------------------------------------------------------------------------------------------------	
	--matrix2(0 to 12)(23 downto 0)  <= matrix1(0 to 12)(23 downto 0);  --right unchanged part
	matrix2(0)(23 downto 0)   <= matrix1(0)(23 downto 0);
	matrix2(1)(23 downto 0)   <= matrix1(1)(23 downto 0);
	matrix2(2)(23 downto 0)   <= matrix1(2)(23 downto 0);
	matrix2(3)(23 downto 0)   <= matrix1(3)(23 downto 0);
	matrix2(4)(23 downto 0)   <= matrix1(4)(23 downto 0);
	matrix2(5)(23 downto 0)   <= matrix1(5)(23 downto 0);
	matrix2(6)(23 downto 0)   <= matrix1(6)(23 downto 0);
	matrix2(7)(23 downto 0)   <= matrix1(7)(23 downto 0);
	matrix2(8)(23 downto 0)   <= matrix1(8)(23 downto 0);
	matrix2(9)(23 downto 0)   <= matrix1(9)(23 downto 0);
	matrix2(10)(23 downto 0)  <= matrix1(10)(23 downto 0);
	matrix2(11)(23 downto 0)  <= matrix1(11)(23 downto 0);
	matrix2(12)(23 downto 0)  <= matrix1(12)(23 downto 0);
	--matrix2(0 to 12)(63 downto 42) <= matrix1(4 to 16)(63 downto 42); --left unchanged part
	matrix2(0)(63 downto 42)  <= matrix1(4)(63 downto 42);
	matrix2(1)(63 downto 42)  <= matrix1(5)(63 downto 42);
	matrix2(2)(63 downto 42)  <= matrix1(6)(63 downto 42);
	matrix2(3)(63 downto 42)  <= matrix1(7)(63 downto 42);
	matrix2(4)(63 downto 42)  <= matrix1(8)(63 downto 42);
	matrix2(5)(63 downto 42)  <= matrix1(9)(63 downto 42);
	matrix2(6)(63 downto 42)  <= matrix1(10)(63 downto 42);
	matrix2(7)(63 downto 42)  <= matrix1(11)(63 downto 42);
	matrix2(8)(63 downto 42)  <= matrix1(12)(63 downto 42);
	matrix2(9)(63 downto 42)  <= matrix1(13)(63 downto 42);
	matrix2(10)(63 downto 42) <= matrix1(14)(63 downto 42);
	matrix2(11)(63 downto 42) <= matrix1(15)(63 downto 42);
	matrix2(12)(63 downto 42) <= matrix1(16)(63 downto 42);
	--matrix2(1 to 12)(24) <= matrix1(2 to 13)(24);
	a0 : for i in 1 to 12 generate
		matrix2(i)(24)  <= matrix1(i+1)(24);
	end generate;
	--matrix2(2 to 12)(25) <= matrix1(2 to 12)(25);
	a1 : for i in 2 to 12 generate
		matrix2(i)(25)  <= matrix1(i)(25);
	end generate;
	--matrix2(3 to 12)(26) <= matrix1(5 to 14)(26);
	a2 : for i in 3 to 12 generate
		matrix2(i)(26) <= matrix1(i+2)(26);
	end generate;
	--matrix2(4 to 12)(27) <= matrix1(5 to 13)(27);
	a3 : for i in 4 to 12 generate
		matrix2(i)(27) <= matrix1(i+1)(27);
	end generate;
	--matrix2(5 to 12)(28) <= matrix1(8 to 15)(28);
	a4 : for i in 5 to 12 generate
		matrix2(i)(28) <= matrix1(i+3)(28);
	end generate;
	--matrix2(6 to 12)(29) <= matrix1(8 to 14)(29);
	a5 : for i in 6 to 12 generate
		matrix2(i)(29) <= matrix1(i+2)(29);
	end generate;
	--matrix2(7 to 12)(30) <= matrix1(11 to 16)(30);
	a6 : for i in 7 to 12 generate
		matrix2(i)(30) <= matrix1(i+4)(30);
	end generate;
	--matrix2(8 to 12)(36 downto 31) <= matrix1(11 to 15)(36 downto 31);
	matrix2(8)(36 downto 31)  <= matrix1(11)(36 downto 31);
	matrix2(9)(36 downto 31)  <= matrix1(12)(36 downto 31);
	matrix2(10)(36 downto 31) <= matrix1(13)(36 downto 31);
	matrix2(11)(36 downto 31) <= matrix1(14)(36 downto 31);
	matrix2(12)(36 downto 31) <= matrix1(15)(36 downto 31);
	--matrix2(7 to 12)(37) <= matrix1(10 to 15)(37);
	a7 : for i in 7 to 12 generate
		matrix2(i)(37) <= matrix1(i+3)(37);
	end generate;
	--matrix2(6 to 12)(38) <= matrix1(9 to 15) (38);
	a8 : for i in 6 to 12 generate
		matrix2(i)(38) <= matrix1(i+3) (38);
	end generate;
	--matrix2(5 to 12)(39) <= matrix1(8 to 15) (39);
	a9 : for i in 5 to 12 generate
		matrix2(i)(39) <= matrix1(i+3) (39);
	end generate;
	--matrix2(3 to 12)(40) <= matrix1(6 to 15) (40);
	a10 : for i in 3 to 12 generate
		matrix2(i)(40) <= matrix1(i+3) (40);
	end generate;
	--matrix2(1 to 12)(41) <= matrix1(4 to 15) (41);
	a11 : for i in 1 to 12 generate
		matrix2(i)(41) <= matrix1(i+3) (41);
	end generate;
	HA_24_0 : HA Port Map(A => matrix1(0)(24), B => matrix1(1)(24), Cout => matrix2(0)(25), S => matrix2(0)(24));
	HA_25_0 : HA Port Map(A => matrix1(0)(25), B => matrix1(1)(25), Cout => matrix2(0)(26), S => matrix2(1)(25));
	gen_26t35_0 : for i in 26 to 35 generate
		FA_1 : FA Port Map(A => matrix1(0)(i), B => matrix1(1)(i), Cin => matrix1(2)(i), Cout => matrix2(0)(i+1), S => matrix2(1)(i));
	end generate;
	HA_36_1 : HA Port Map(A => matrix1(1)(36), B => matrix1(2)(36), Cout => matrix2(0)(37), S => matrix2(1)(36));
	
	HA_26_3 : HA Port Map(A => matrix1(3)(26), B => matrix1(4)(26), Cout => matrix2(2)(27), S => matrix2(2)(26));
	HA_27_3 : HA Port Map(A => matrix1(3)(27), B => matrix1(4)(27), Cout => matrix2(2)(28), S => matrix2(3)(27));
	gen28t36_3 : for i in 28 to 36 generate
		FA_2 : FA Port Map(A => matrix1(3)(i), B => matrix1(4)(i), Cin => matrix1(5)(i), Cout => matrix2(2)(i+1), S => matrix2(3)(i));
	end generate;
	
	HA_28_6 : HA Port Map(A => matrix1(6)(28), B => matrix1(7)(28), Cout => matrix2(4)(29), S => matrix2(4)(28));
	HA_29_6 : HA Port Map(A => matrix1(6)(29), B => matrix1(7)(29), Cout => matrix2(4)(30), S => matrix2(5)(29));
	gen30t36_6 : for i in 30 to 36 generate
		FA_3 : FA Port Map(A => matrix1(6)(i), B => matrix1(7)(i), Cin => matrix1(8)(i), Cout => matrix2(4)(i+1), S => matrix2(5)(i));
	end generate;
	HA_30_9 : HA Port Map(A => matrix1(9)(30), B => matrix1(10)(30), Cout => matrix2(6)(31), S => matrix2(6)(30));
	gen31t36_9 : for i in 31 to 36 generate
		HA_1 : HA Port Map(A => matrix1(9)(i), B => matrix1(10)(i), Cout => matrix2(6)(i+1), S => matrix2(7)(i));
	end generate;
	FA_37_2 : FA Port Map(A => matrix1(2)(37), B => matrix1(3)(37), Cin => matrix1(4)(37), Cout => matrix2(0)(38), S => matrix2(1)(37));
	FA_37_5 : FA Port Map(A => matrix1(5)(37), B => matrix1(6)(37), Cin => matrix1(7)(37), Cout => matrix2(1)(38), S => matrix2(3)(37));
	FA_38_2 : FA Port Map(A => matrix1(2)(38), B => matrix1(3)(38), Cin => matrix1(4)(38), Cout => matrix2(0)(39), S => matrix2(2)(38));
	FA_39_3 : FA Port Map(A => matrix1(3)(39), B => matrix1(4)(39), Cin => matrix1(5)(39), Cout => matrix2(0)(40), S => matrix2(1)(39));
	FA_40_3 : FA Port Map(A => matrix1(3)(40), B => matrix1(4)(40), Cin => matrix1(5)(40), Cout => matrix2(0)(41), S => matrix2(1)(40));
	HA_37_8 : HA Port Map(A => matrix1(8)(37), B => matrix1(9)(37), Cout => matrix2(3)(38), S => matrix2(5)(37));
	HA_38_5 : HA Port Map(A => matrix1(5)(38), B => matrix1(6)(38), Cout => matrix2(2)(39), S => matrix2(4)(38));
	HA_38_7 : HA Port Map(A => matrix1(7)(38), B => matrix1(8)(38), Cout => matrix2(3)(39), S => matrix2(5)(38));
	HA_39_6 : HA Port Map(A => matrix1(6)(39), B => matrix1(7)(39), Cout => matrix2(2)(40), S => matrix2(4)(39));
-----------------------------------------------------------------------------------------------------------------------------------
	ovect0  <= matrix2(0);
	ovect1  <= matrix2(1);
	ovect2  <= matrix2(2);
	ovect3  <= matrix2(3);
	ovect4  <= matrix2(4);
	ovect5  <= matrix2(5);
	ovect6  <= matrix2(6);
	ovect7  <= matrix2(7);
	ovect8  <= matrix2(8);
	ovect9  <= matrix2(9);
	ovect10 <= matrix2(10);
	ovect11 <= matrix2(11);
	ovect12 <= matrix2(12);
	
end architecture;
