library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity gen_5th is
	Port( ivect0  : IN  std_logic_vector(64-1 downto 0);
	      ivect1  : IN  std_logic_vector(64-1 downto 0);
	      ivect2  : IN  std_logic_vector(64-1 downto 0);
			ivect3  : IN  std_logic_vector(64-1 downto 0);
			ivect4  : IN  std_logic_vector(64-1 downto 0);
			ivect5  : IN  std_logic_vector(64-1 downto 0);
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0);
			ovect3  : OUT std_logic_vector(64-1 downto 0)
			);
end gen_5th;

architecture struc of gen_5th is
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
type type_level4 is array (6-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 6*64
type type_level5 is array (4-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 4*64
signal matrix4 : type_level4;-- := (others => (others => '0')); --matrix level 4
signal matrix5 : type_level5;-- := (others => (others => '0')); --matrix level 5
begin
	matrix4(0)  <= ivect0;
	matrix4(1)  <= ivect1;
	matrix4(2)  <= ivect2;
	matrix4(3)  <= ivect3;
	matrix4(4)  <= ivect4;
	matrix4(5)  <= ivect5;
-----------------------------------------------------------------------------------------------------------------------------	
   --matrix5(0 to 3)(5 downto 0)   <= matrix4(0 to 3)(5 downto 0);
	matrix5(0)(5 downto 0)   <= matrix4(0)(5 downto 0);
	matrix5(1)(5 downto 0)   <= matrix4(1)(5 downto 0);
	matrix5(2)(5 downto 0)   <= matrix4(2)(5 downto 0);
	matrix5(3)(5 downto 0)   <= matrix4(3)(5 downto 0);
	--matrix5(0 to 3)(63 downto 60) <= matrix4(0 to 3)(63 downto 60);
	matrix5(0)(63 downto 60) <= matrix4(0)(63 downto 60);
	matrix5(1)(63 downto 60) <= matrix4(1)(63 downto 60);
	matrix5(2)(63 downto 60) <= matrix4(2)(63 downto 60);
	matrix5(3)(63 downto 60) <= matrix4(3)(63 downto 60);
	--matrix5(1 to 3)(6) <= matrix4(2 to 4)(6);
	matrix5(1)(6) <= matrix4(2)(6);
	matrix5(2)(6) <= matrix4(3)(6);
	matrix5(3)(6) <= matrix4(4)(6);
	--matrix5(2 to 3)(7) <= matrix4(2 to 3)(7);
	matrix5(2)(7) <= matrix4(2)(7);
	matrix5(3)(7) <= matrix4(3)(7);
	matrix5(3)(8) <= matrix4(5)(8);
	matrix5(3)(57) <= matrix4(3)(57);
	--matrix5(2 to 3)(58) <= matrix4(2 to 3)(58);
	matrix5(2)(58) <= matrix4(2)(58);
	matrix5(3)(58) <= matrix4(3)(58);
	--matrix5(1 to 3)(59) <= matrix4(0 to 2)(59);
	matrix5(1)(59) <= matrix4(0)(59);
	matrix5(2)(59) <= matrix4(1)(59);
	matrix5(3)(59) <= matrix4(2)(59);
	HA_6_0 : HA Port Map(A => matrix4(0)(6), B => matrix4(1)(6), Cout => matrix5(0)(7), S => matrix5(0)(6));
	HA_7_0 : HA Port Map(A => matrix4(0)(7), B => matrix4(1)(7), Cout => matrix5(0)(8), S => matrix5(1)(7));
	gen8t57_0 : for i in 8 to 57 generate
		FA_1 : FA Port Map(A => matrix4(0)(i), B => matrix4(1)(i), Cin => matrix4(2)(i), Cout => matrix5(0)(i+1), S => matrix5(1)(i));
	end generate;
	HA_58_0 : HA Port Map(A => matrix4(0)(58), B => matrix4(1)(58), Cout => matrix5(0)(59), S => matrix5(1)(58));
	HA_8_3 : HA Port Map(A => matrix4(3)(8), B => matrix4(4)(8), Cout => matrix5(2)(9), S => matrix5(2)(8));
	HA_9_3 : HA Port Map(A => matrix4(3)(9), B => matrix4(4)(9), Cout => matrix5(2)(10), S => matrix5(3)(9));
	gen10t55_3 : for i in 10 to 55 generate
		FA_2 : FA Port Map(A => matrix4(3)(i), B => matrix4(4)(i), Cin => matrix4(5)(i), Cout => matrix5(2)(i+1), S => matrix5(3)(i));
	end generate;
	HA_56_3 : HA Port Map(A => matrix4(3)(56), B => matrix4(4)(56), Cout => matrix5(2)(57), S => matrix5(3)(56));
-----------------------------------------------------------------------------------------------------------------------------------
	ovect0  <= matrix5(0);
	ovect1  <= matrix5(1);
	ovect2  <= matrix5(2);
	ovect3  <= matrix5(3);
end architecture;
