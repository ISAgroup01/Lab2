library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity gen_4th is
	Port( ivect0  : IN  std_logic_vector(64-1 downto 0);
	      ivect1  : IN  std_logic_vector(64-1 downto 0);
	      ivect2  : IN  std_logic_vector(64-1 downto 0);
			ivect3  : IN  std_logic_vector(64-1 downto 0);
			ivect4  : IN  std_logic_vector(64-1 downto 0);
			ivect5  : IN  std_logic_vector(64-1 downto 0);
			ivect6  : IN  std_logic_vector(64-1 downto 0);
			ivect7  : IN  std_logic_vector(64-1 downto 0);
			ivect8  : IN  std_logic_vector(64-1 downto 0);
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0);
			ovect3  : OUT std_logic_vector(64-1 downto 0);
			ovect4  : OUT std_logic_vector(64-1 downto 0);
			ovect5  : OUT std_logic_vector(64-1 downto 0)
			);
end gen_4th;

architecture struc of gen_4th is
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
type type_level3 is array (9-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 9*64
type type_level4 is array (6-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 6*64
signal matrix3 : type_level3;-- := (others => (others => '0')); --matrix level 3
signal matrix4 : type_level4;-- := (others => (others => '0')); --matrix level 4
begin
	matrix3(0)  <= ivect0;
	matrix3(1)  <= ivect1;
	matrix3(2)  <= ivect2;
	matrix3(3)  <= ivect3;
	matrix3(4)  <= ivect4;
	matrix3(5)  <= ivect5;
	matrix3(6)  <= ivect6;
	matrix3(7)  <= ivect7;
	matrix3(8)  <= ivect8;
-----------------------------------------------------------------------------------------------------------------------------	
	--matrix4(0 to 5)(9 downto 0) <= matrix3(0 to 5)(9 downto 0);
	matrix4(0)(9 downto 0) <= matrix3(0)(9 downto 0);
	matrix4(1)(9 downto 0) <= matrix3(1)(9 downto 0);
	matrix4(2)(9 downto 0) <= matrix3(2)(9 downto 0);
	matrix4(3)(9 downto 0) <= matrix3(3)(9 downto 0);
	matrix4(4)(9 downto 0) <= matrix3(4)(9 downto 0);
	matrix4(5)(9 downto 0) <= matrix3(5)(9 downto 0);
	--matrix4(0 to 5)(63 downto 56) <= matrix3(3 to 8)(63 downto 56);
	matrix4(0)(63 downto 56) <= matrix3(3)(63 downto 56);
	matrix4(1)(63 downto 56) <= matrix3(4)(63 downto 56);
	matrix4(2)(63 downto 56) <= matrix3(5)(63 downto 56);
	matrix4(3)(63 downto 56) <= matrix3(6)(63 downto 56);
	matrix4(4)(63 downto 56) <= matrix3(7)(63 downto 56);
	matrix4(5)(63 downto 56) <= matrix3(8)(63 downto 56);
	--matrix4(1 to 5)(10) <= matrix3(2 to 6)(10);
	matrix4(1)(10) <= matrix3(2)(10);
	matrix4(2)(10) <= matrix3(3)(10);
	matrix4(3)(10) <= matrix3(4)(10);
	matrix4(4)(10) <= matrix3(5)(10);
	matrix4(5)(10) <= matrix3(6)(10);
	--matrix4(2 to 5)(11) <= matrix3(2 to 5)(11);
	matrix4(2)(11) <= matrix3(2)(11);
	matrix4(3)(11) <= matrix3(3)(11);
	matrix4(4)(11) <= matrix3(4)(11);
	matrix4(5)(11) <= matrix3(5)(11);
	--matrix4(3 to 5)(12) <= matrix3(5 to 7)(12);
	matrix4(3)(12) <= matrix3(5)(12);
	matrix4(4)(12) <= matrix3(6)(12);
	matrix4(5)(12) <= matrix3(7)(12);
	--matrix4(4 to 5)(13) <= matrix3(5 to 6)(13);
	matrix4(4)(13) <= matrix3(5)(13);
	matrix4(5)(13) <= matrix3(6)(13);
	matrix4(5)(14) <= matrix3(8)(14);
	matrix4(5)(51) <= matrix3(7)(51);
	--matrix4(4 to 5)(52) <= matrix3(6 to 7)(52);
	matrix4(4)(52) <= matrix3(6)(52);
	matrix4(5)(52) <= matrix3(7)(52);
	--matrix4(3 to 5)(53) <= matrix3(5 to 7)(53);
	matrix4(3)(53) <= matrix3(5)(53);
	matrix4(4)(53) <= matrix3(6)(53);
	matrix4(5)(53) <= matrix3(7)(53);
	--matrix4(2 to 5)(54) <= matrix3(4 to 7)(54);
	matrix4(2)(54) <= matrix3(4)(54);
	matrix4(3)(54) <= matrix3(5)(54);
	matrix4(4)(54) <= matrix3(6)(54);
	matrix4(5)(54) <= matrix3(7)(54);
	--matrix4(1 to 5)(55) <= matrix3(3 to 7)(55);
	matrix4(1)(55) <= matrix3(3)(55);
	matrix4(2)(55) <= matrix3(4)(55);
	matrix4(3)(55) <= matrix3(5)(55);
	matrix4(4)(55) <= matrix3(6)(55);
	matrix4(5)(55) <= matrix3(7)(55);
	HA_10_0 : HA Port Map(A => matrix3(0)(10), B => matrix3(1)(10), Cout => matrix4(0)(11), S => matrix4(0)(10));
	HA_11_0 : HA Port Map(A => matrix3(0)(11), B => matrix3(1)(11), Cout => matrix4(0)(12), S => matrix4(1)(11));
	gen12t50_0 : for i in 12 to 50 generate
		FA_1 : FA Port Map(A => matrix3(0)(i), B => matrix3(1)(i), Cin => matrix3(2)(i), Cout => matrix4(0)(i+1), S => matrix4(1)(i));
	end generate;
	HA_12_3 : HA Port Map(A => matrix3(3)(12), B => matrix3(4)(12), Cout => matrix4(2)(13), S => matrix4(2)(12));
	HA_13_3 : HA Port Map(A => matrix3(3)(13), B => matrix3(4)(13), Cout => matrix4(2)(14), S => matrix4(3)(13));
	gen14t50_3 : for i in 14 to 50 generate
		FA_2 : FA Port Map(A => matrix3(3)(i), B => matrix3(4)(i), Cin => matrix3(5)(i), Cout => matrix4(2)(i+1), S => matrix4(3)(i));
	end generate;
	HA_14_6 : HA Port Map(A => matrix3(6)(14), B => matrix3(7)(14), Cout => matrix4(4)(15), S => matrix4(4)(14));
	HA_15_6 : HA Port Map(A => matrix3(6)(15), B => matrix3(7)(15), Cout => matrix4(4)(16), S => matrix4(5)(15));
	gen16t29_6 : for i in 16 to 49 generate
		FA_3 : FA Port Map(A => matrix3(6)(i), B => matrix3(7)(i), Cin => matrix3(8)(i), Cout => matrix4(4)(i+1), S => matrix4(5)(i));
	end generate;
	HA_50_6 : HA Port Map(A => matrix3(6)(50), B => matrix3(7)(50), Cout => matrix4(4)(51), S => matrix4(5)(50));
	FA_51_1 : FA Port Map(A => matrix3(1)(51), B => matrix3(2)(51), Cin => matrix3(3)(51), Cout => matrix4(0)(52), S => matrix4(1)(51));
	FA_52_1 : FA Port Map(A => matrix3(1)(52), B => matrix3(2)(52), Cin => matrix3(3)(52), Cout => matrix4(0)(53), S => matrix4(1)(52));
	FA_53_2 : FA Port Map(A => matrix3(2)(53), B => matrix3(3)(53), Cin => matrix3(4)(53), Cout => matrix4(0)(54), S => matrix4(1)(53));
	FA_51_4 : FA Port Map(A => matrix3(4)(51), B => matrix3(5)(51), Cin => matrix3(6)(51), Cout => matrix4(2)(52), S => matrix4(3)(51));
	HA_52_4 : HA Port Map(A => matrix3(4)(52), B => matrix3(5)(52), Cout => matrix4(2)(53), S => matrix4(3)(52));
	HA_54_2 : HA Port Map(A => matrix3(2)(54), B => matrix3(3)(54), Cout => matrix4(0)(55), S => matrix4(1)(54));
-----------------------------------------------------------------------------------------------------------------------------------
	ovect0  <= matrix4(0);
	ovect1  <= matrix4(1);
	ovect2  <= matrix4(2);
	ovect3  <= matrix4(3);
	ovect4  <= matrix4(4);
	ovect5  <= matrix4(5);
end architecture;
