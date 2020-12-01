library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity gen_3rd is
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
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0);
			ovect3  : OUT std_logic_vector(64-1 downto 0);
			ovect4  : OUT std_logic_vector(64-1 downto 0);
			ovect5  : OUT std_logic_vector(64-1 downto 0);
			ovect6  : OUT std_logic_vector(64-1 downto 0);
			ovect7  : OUT std_logic_vector(64-1 downto 0);
			ovect8  : OUT std_logic_vector(64-1 downto 0)
			);
end gen_3rd;

architecture struc of gen_3rd is
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
type type_level2 is array (13-1 downto 0) of std_logic_vector(64-1 downto 0); -- array 13*64
type type_level3 is array (9-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 9*64
signal matrix2 : type_level2 := (others => (others => '0')); --matrix level 2
signal matrix3 : type_level3 := (others => (others => '0')); --matrix level 3
begin
	matrix2(0)  <= ivect0;
	matrix2(1)  <= ivect1;
	matrix2(2)  <= ivect2;
	matrix2(3)  <= ivect3;
	matrix2(4)  <= ivect4;
	matrix2(5)  <= ivect5;
	matrix2(6)  <= ivect6;
	matrix2(7)  <= ivect7;
	matrix2(8)  <= ivect8;
	matrix2(9)  <= ivect9;
	matrix2(10) <= ivect10;
	matrix2(11) <= ivect11;
	matrix2(12) <= ivect12;
-----------------------------------------------------------------------------------------------------------------------------	
	--matrix3(0 to 8)(15 downto 0)  <= matrix2(0 to 8)(15 downto 0); --Right unchanged part
	matrix3(0)(15 downto 0)  <= matrix2(0)(15 downto 0);
	matrix3(1)(15 downto 0)  <= matrix2(1)(15 downto 0);
	matrix3(2)(15 downto 0)  <= matrix2(2)(15 downto 0);
	matrix3(3)(15 downto 0)  <= matrix2(3)(15 downto 0);
	matrix3(4)(15 downto 0)  <= matrix2(4)(15 downto 0);
	matrix3(5)(15 downto 0)  <= matrix2(5)(15 downto 0);
	matrix3(6)(15 downto 0)  <= matrix2(6)(15 downto 0);
	matrix3(7)(15 downto 0)  <= matrix2(7)(15 downto 0);
	matrix3(8)(15 downto 0)  <= matrix2(8)(15 downto 0);
	--matrix3(0 to 8)(63 downto 50) <= matrix2(4 to 12)(63 downto 50); --Left unchanged part
	matrix3(0)(63 downto 50) <= matrix2(4)(63 downto 50);
	matrix3(1)(63 downto 50) <= matrix2(5)(63 downto 50);
	matrix3(2)(63 downto 50) <= matrix2(6)(63 downto 50);
	matrix3(3)(63 downto 50) <= matrix2(7)(63 downto 50);
	matrix3(4)(63 downto 50) <= matrix2(8)(63 downto 50);
	matrix3(5)(63 downto 50) <= matrix2(9)(63 downto 50);
	matrix3(6)(63 downto 50) <= matrix2(10)(63 downto 50);
	matrix3(7)(63 downto 50) <= matrix2(11)(63 downto 50);
	matrix3(8)(63 downto 50) <= matrix2(12)(63 downto 50);
	--matrix3(1 to 8)(16) <= matrix2(2 to 9)(16);
	matrix3(1)(16) <= matrix2(2)(16);
	matrix3(2)(16) <= matrix2(3)(16);
	matrix3(3)(16) <= matrix2(4)(16);
	matrix3(4)(16) <= matrix2(5)(16);
	matrix3(5)(16) <= matrix2(6)(16);
	matrix3(6)(16) <= matrix2(7)(16);
	matrix3(7)(16) <= matrix2(8)(16);
	matrix3(8)(16) <= matrix2(9)(16);
	--matrix3(2 to 8)(17) <= matrix2(2 to 8)(17);
	matrix3(2)(17) <= matrix2(2)(17);
	matrix3(3)(17) <= matrix2(3)(17);
	matrix3(4)(17) <= matrix2(4)(17);
	matrix3(5)(17) <= matrix2(5)(17);
	matrix3(6)(17) <= matrix2(6)(17);
	matrix3(7)(17) <= matrix2(7)(17);
	matrix3(8)(17) <= matrix2(8)(17);
	--matrix3(3 to 8)(18) <= matrix2(5 to 10)(18);
	matrix3(3)(18) <= matrix2(5)(18);
	matrix3(4)(18) <= matrix2(6)(18);
	matrix3(5)(18) <= matrix2(7)(18);
	matrix3(6)(18) <= matrix2(8)(18);
	matrix3(7)(18) <= matrix2(9)(18);
	matrix3(8)(18) <= matrix2(10)(18);
	--matrix3(4 to 8)(19) <= matrix2(5 to 9)(19);
	matrix3(4)(19) <= matrix2(5)(19);
	matrix3(5)(19) <= matrix2(6)(19);
	matrix3(6)(19) <= matrix2(7)(19);
	matrix3(7)(19) <= matrix2(8)(19);
	matrix3(8)(19) <= matrix2(9)(19);
	--matrix3(5 to 8)(20) <= matrix2(8 to 11)(20);
	matrix3(5)(20) <= matrix2(8)(20);
	matrix3(6)(20) <= matrix2(9)(20);
	matrix3(7)(20) <= matrix2(10)(20);
	matrix3(8)(20) <= matrix2(11)(20);
	--matrix3(6 to 8)(21) <= matrix2(8 to 10)(21);
	matrix3(6)(21) <= matrix2(8)(21);
	matrix3(7)(21) <= matrix2(9)(21);
	matrix3(8)(21) <= matrix2(10)(21);
	--matrix3(7 to 8)(22) <= matrix2(11 to 12)(22);
	matrix3(7)(22) <= matrix2(11)(22);
	matrix3(8)(22) <= matrix2(12)(22);
	matrix3(8)(23) <= matrix2(11)(23);
	matrix3(8)(41 downto 24) <= matrix2(12)(41 downto 24);
	matrix3(8)(42) <= matrix2(11)(42);
	--matrix3(7 to 8)(43) <= matrix2(10 to 11)(43);
	matrix3(7)(43) <= matrix2(10)(43);
	matrix3(8)(43) <= matrix2(11)(43);
	--matrix3(6 to 8)(44) <= matrix2(9 to 11)(44);
	matrix3(6)(44) <= matrix2(9)(44);
	matrix3(7)(44) <= matrix2(10)(44);
	matrix3(8)(44) <= matrix2(11)(44);
	--matrix3(5 to 8)(45) <= matrix2(8 to 11)(45);
	matrix3(5)(45) <= matrix2(8)(45);
	matrix3(6)(45) <= matrix2(9)(45);
	matrix3(7)(45) <= matrix2(10)(45);
	matrix3(8)(45) <= matrix2(11)(45);
	--matrix3(4 to 8)(46) <= matrix2(7 to 11)(46);
	matrix3(4)(46) <= matrix2(7)(46);
	matrix3(5)(46) <= matrix2(8)(46);
	matrix3(6)(46) <= matrix2(9)(46);
	matrix3(7)(46) <= matrix2(10)(46);
	matrix3(8)(46) <= matrix2(11)(46);
	--matrix3(3 to 8)(47) <= matrix2(6 to 11)(47);
	matrix3(3)(47) <= matrix2(6)(47);
	matrix3(4)(47) <= matrix2(7)(47);
	matrix3(5)(47) <= matrix2(8)(47);
	matrix3(6)(47) <= matrix2(9)(47);
	matrix3(7)(47) <= matrix2(10)(47);
	matrix3(8)(47) <= matrix2(11)(47);
	--matrix3(2 to 8)(48) <= matrix2(5 to 11)(48);
	matrix3(2)(48) <= matrix2(5)(48);
	matrix3(3)(48) <= matrix2(6)(48);
	matrix3(4)(48) <= matrix2(7)(48);
	matrix3(5)(48) <= matrix2(8)(48);
	matrix3(6)(48) <= matrix2(9)(48);
	matrix3(7)(48) <= matrix2(10)(48);
	matrix3(8)(48) <= matrix2(11)(48);
	--matrix3(1 to 8)(49) <= matrix2(4 to 11)(49);
	matrix3(1)(49) <= matrix2(4)(49);
	matrix3(2)(49) <= matrix2(5)(49);
	matrix3(3)(49) <= matrix2(6)(49);
	matrix3(4)(49) <= matrix2(7)(49);
	matrix3(5)(49) <= matrix2(8)(49);
	matrix3(6)(49) <= matrix2(9)(49);
	matrix3(7)(49) <= matrix2(10)(49);
	matrix3(8)(49) <= matrix2(11)(49);
	HA_16_0 : HA Port Map(A => matrix2(0)(16), B => matrix2(1)(16), Cout => matrix3(0)(17), S => matrix3(0)(16));
	HA_17_0 : HA Port Map(A => matrix2(0)(17), B => matrix2(1)(17), Cout => matrix3(0)(18), S => matrix3(1)(17));
	gen_18t42_0 : for i in 18 to 42 generate
		FA_1 : FA Port Map(A => matrix2(0)(i), B => matrix2(1)(i), Cin => matrix2(2)(i), Cout => matrix3(0)(i+1), S => matrix3(1)(i));
	end generate;
	HA_18_3 : HA Port Map(A => matrix2(3)(18), B => matrix2(4)(18), Cout => matrix3(2)(19), S => matrix3(2)(18));
	HA_19_3 : HA Port Map(A => matrix2(3)(19), B => matrix2(4)(19), Cout => matrix3(2)(20), S => matrix3(3)(19));
	gen_20t42_3 : for i in 20 to 42 generate
		FA_2 : FA Port Map(A => matrix2(3)(i), B => matrix2(4)(i), Cin => matrix2(5)(i), Cout => matrix3(2)(i+1), S => matrix3(3)(i));
	end generate;
	HA_20_6 : HA Port Map(A => matrix2(6)(20), B => matrix2(7)(20), Cout => matrix3(4)(21), S => matrix3(4)(20));
	HA_21_6 : HA Port Map(A => matrix2(6)(21), B => matrix2(7)(21), Cout => matrix3(4)(22), S => matrix3(5)(21));
	gen_22t42_6 : for i in 22 to 42 generate
		FA_3 : FA Port Map(A => matrix2(6)(i), B => matrix2(7)(i), Cin => matrix2(8)(i), Cout => matrix3(4)(i+1), S => matrix3(5)(i));
	end generate;
	HA_22_9 : HA Port Map(A => matrix2(9)(22), B => matrix2(10)(22), Cout => matrix3(6)(23), S => matrix3(6)(22));
	HA_23_9 : HA Port Map(A => matrix2(9)(23), B => matrix2(10)(23), Cout => matrix3(6)(24), S => matrix3(7)(23));
	gen_24t41_9 : for i in 24 to 41 generate
		FA_4 : FA Port Map(A => matrix2(9)(i), B => matrix2(10)(i), Cin => matrix2(11)(i), Cout => matrix3(6)(i+1), S => matrix3(7)(i));
	end generate;
	HA_42_9 : HA Port Map(A => matrix2(9)(42), B => matrix2(10)(42), Cout => matrix3(6)(43), S => matrix3(7)(42));
	FA_43_1 : FA Port Map(A => matrix2(1)(43), B => matrix2(2)(43), Cin => matrix2(3)(43), Cout => matrix3(0)(44), S => matrix3(1)(43));
	FA_44_1 : FA Port Map(A => matrix2(1)(44), B => matrix2(2)(44), Cin => matrix2(3)(44), Cout => matrix3(0)(45), S => matrix3(1)(44));
	FA_45_2 : FA Port Map(A => matrix2(2)(45), B => matrix2(3)(45), Cin => matrix2(4)(45), Cout => matrix3(0)(46), S => matrix3(1)(45));
	FA_46_2 : FA Port Map(A => matrix2(2)(46), B => matrix2(3)(46), Cin => matrix2(4)(46), Cout => matrix3(0)(47), S => matrix3(1)(46));
	FA_47_3 : FA Port Map(A => matrix2(3)(47), B => matrix2(4)(47), Cin => matrix2(5)(47), Cout => matrix3(0)(48), S => matrix3(1)(47));
	FA_43_4 : FA Port Map(A => matrix2(4)(43), B => matrix2(5)(43), Cin => matrix2(6)(43), Cout => matrix3(2)(44), S => matrix3(3)(43));
	FA_44_4 : FA Port Map(A => matrix2(4)(44), B => matrix2(5)(44), Cin => matrix2(6)(44), Cout => matrix3(2)(45), S => matrix3(3)(44));
	FA_45_5 : FA Port Map(A => matrix2(5)(45), B => matrix2(6)(45), Cin => matrix2(7)(45), Cout => matrix3(2)(46), S => matrix3(3)(45));
	FA_43_7 : FA Port Map(A => matrix2(7)(43), B => matrix2(8)(43), Cin => matrix2(9)(43), Cout => matrix3(4)(44), S => matrix3(5)(43));
	HA_44_7 : HA Port Map(A => matrix2(7)(44), B => matrix2(8)(44), Cout => matrix3(4)(45), S => matrix3(5)(44));
	HA_46_5 : HA Port Map(A => matrix2(5)(46), B => matrix2(6)(46), Cout => matrix3(2)(47), S => matrix3(3)(46));
	HA_48_3 : HA Port Map(A => matrix2(3)(48), B => matrix2(4)(48), Cout => matrix3(0)(49), S => matrix3(1)(48));	
-----------------------------------------------------------------------------------------------------------------------------------
	ovect0  <= matrix3(0);
	ovect1  <= matrix3(1);
	ovect2  <= matrix3(2);
	ovect3  <= matrix3(3);
	ovect4  <= matrix3(4);
	ovect5  <= matrix3(5);
	ovect6  <= matrix3(6);
	ovect7  <= matrix3(7);
	ovect8  <= matrix3(8);
	
end architecture;
