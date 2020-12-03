-------------------------------------------------
--Tree of CSA implemnted with Dadda algorithm
-------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity Dadda is
	Port (PP0      : IN   std_logic_vector(32 downto 0);
		   PP1      : IN   std_logic_vector(32 downto 0);
		   PP2      : IN   std_logic_vector(32 downto 0);
			PP3      : IN   std_logic_vector(32 downto 0);
			PP4      : IN   std_logic_vector(32 downto 0);
			PP5      : IN   std_logic_vector(32 downto 0);
			PP6      : IN   std_logic_vector(32 downto 0);
			PP7      : IN   std_logic_vector(32 downto 0);
			PP8      : IN   std_logic_vector(32 downto 0);
			PP9      : IN   std_logic_vector(32 downto 0);
			PP10     : IN   std_logic_vector(32 downto 0);
			PP11     : IN   std_logic_vector(32 downto 0);
			PP12     : IN   std_logic_vector(32 downto 0);
			PP13     : IN   std_logic_vector(32 downto 0);
			PP14     : IN   std_logic_vector(32 downto 0);
			PP15     : IN   std_logic_vector(32 downto 0);
			E        : IN   std_logic_vector(16-1 downto 0);
			S        : IN   std_logic_vector(16-1 downto 0);
			PRODUCT1 : OUT  std_logic_vector(64-1 downto 0);
			PRODUCT2 : OUT  std_logic_vector(64-1 downto 0));
end Dadda;

architecture behavioral of Dadda is
type type_level1 is array (17-1 downto 0) of std_logic_vector(64-1 downto 0); -- array 17*64
type type_level2 is array (13-1 downto 0) of std_logic_vector(64-1 downto 0); -- array 13*64
type type_level3 is array (9-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 9*64
type type_level4 is array (6-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 6*64
type type_level5 is array (4-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 4*64
type type_level6 is array (3-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 3*64
type type_level7 is array (2-1  downto 0) of std_logic_vector(64-1 downto 0); -- array 2*64
signal matrix1 : type_level1; --matrix level 1 
signal matrix2 : type_level2 := (others => (others => '0')); --matrix level 2
signal matrix3 : type_level3 := (others => (others => '0')); --matrix level 3
signal matrix4 : type_level4 := (others => (others => '0')); --matrix level 4
signal matrix5 : type_level5 := (others => (others => '0')); --matrix level 5
signal matrix6 : type_level6 := (others => (others => '0')); --matrix level 6
signal matrix7 : type_level7 := (others => (others => '0')); --matrix level 7

--Component
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
component gen_2nd
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
			ovect12 : OUT std_logic_vector(64-1 downto 0));
end component;
component gen_3rd
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
			ovect8  : OUT std_logic_vector(64-1 downto 0));
end component;
component gen_4th
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
			ovect5  : OUT std_logic_vector(64-1 downto 0));
end component;

component gen_5th
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
			ovect3  : OUT std_logic_vector(64-1 downto 0));
end component;


component gen_6th
	Port( ivect0  : IN  std_logic_vector(64-1 downto 0);
	      ivect1  : IN  std_logic_vector(64-1 downto 0);
	      ivect2  : IN  std_logic_vector(64-1 downto 0);
			ivect3  : IN  std_logic_vector(64-1 downto 0);
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0));
end component;
begin
-----------------------First level-----------------------------------------------------------------------------------------------------------
	matrix1(0)  <= "0000000000000000000000000000" & E(0)  & (not E(0)) & (not E(0)) & PP0;
	matrix1(1)  <= "0000000000000000000000000001" & E(1)  & PP1  & '0' & S(0);
	matrix1(2)  <= "00000000000000000000000001" & E(2)  & PP2  & '0' & S(1)  & "00";
	matrix1(3)  <= "000000000000000000000001" & E(3)  & PP3  & '0' & S(2)  & "0000";
	matrix1(4)  <= "0000000000000000000001" & E(4)  & PP4  & '0' & S(3)  & "000000";
	matrix1(5)  <= "00000000000000000001" & E(5)  & PP5  & '0' & S(4)  & "00000000";
	matrix1(6)  <= "000000000000000001" & E(6)  & PP6  & '0' & S(5)  & "0000000000";
	matrix1(7)  <= "0000000000000001" & E(7)  & PP7  & '0' & S(6)  & "000000000000";
	matrix1(8)  <= "00000000000001" & E(8)  & PP8  & '0' & S(7)  & "00000000000000";
	matrix1(9)  <= "000000000001" & E(9)  & PP9  & '0' & S(8)  & "0000000000000000";
	matrix1(10) <= "0000000001" & E(10) & PP10 & '0' & S(9)  & "000000000000000000";
	matrix1(11) <= "00000001" & E(11) & PP11 & '0' & S(10) & "00000000000000000000";
	matrix1(12) <= "000001" & E(12) & PP12 & '0' & S(11) & "0000000000000000000000";
	matrix1(13) <= "0001" & E(13) & PP13 & '0' & S(12) & "000000000000000000000000";
	matrix1(14) <= "01" & E(14) & PP14 & '0' & S(13) & "00000000000000000000000000";
	matrix1(15) <= E(15) & PP15 & '0' & S(14) & "0000000000000000000000000000";
	matrix1(16) <= "000000000000000000000000000000000" & S(15) & "000000000000000000000000000000";
 
-----------------------Second level-----------------------------------------------------------------------------------------------------------
second_level: gen_2nd Port Map(
	      ivect0  => matrix1(0),
	      ivect1  => matrix1(1), 
	      ivect2  => matrix1(2),
			ivect3  => matrix1(3), 
			ivect4  => matrix1(4), 
			ivect5  => matrix1(5), 
			ivect6  => matrix1(6), 
			ivect7  => matrix1(7), 
			ivect8  => matrix1(8), 
			ivect9  => matrix1(9), 
			ivect10 => matrix1(10),
			ivect11 => matrix1(11),
			ivect12 => matrix1(12),
			ivect13 => matrix1(13),
			ivect14 => matrix1(14),
			ivect15 => matrix1(15),
			ivect16 => matrix1(16),
			-- Output vector
			ovect0  => matrix2(0),
			ovect1  => matrix2(1),
			ovect2  => matrix2(2), 
			ovect3  => matrix2(3), 
			ovect4  => matrix2(4), 
			ovect5  => matrix2(5), 
			ovect6  => matrix2(6), 
			ovect7  => matrix2(7), 
			ovect8  => matrix2(8), 
			ovect9  => matrix2(9), 
			ovect10 => matrix2(10), 
			ovect11 => matrix2(11), 
			ovect12 => matrix2(12));
			
-----------------------Third level------------------------------------------------------------------------------------------------------------
third_level: gen_3rd Port Map(
	      ivect0  => matrix2(0),
	      ivect1  => matrix2(1), 
	      ivect2  => matrix2(2),
			ivect3  => matrix2(3), 
			ivect4  => matrix2(4), 
			ivect5  => matrix2(5), 
			ivect6  => matrix2(6), 
			ivect7  => matrix2(7), 
			ivect8  => matrix2(8), 
			ivect9  => matrix2(9), 
			ivect10 => matrix2(10),
			ivect11 => matrix2(11),
			ivect12 => matrix2(12),
			-- Output vector
			ovect0  => matrix3(0),
			ovect1  => matrix3(1),
			ovect2  => matrix3(2), 
			ovect3  => matrix3(3), 
			ovect4  => matrix3(4), 
			ovect5  => matrix3(5), 
			ovect6  => matrix3(6), 
			ovect7  => matrix3(7), 
			ovect8  => matrix3(8));	
			
-----------------------Fourth level------------------------------------------------------------------------------------------------------------
fourth_level: gen_4th Port Map(
	      ivect0  => matrix3(0),
	      ivect1  => matrix3(1), 
	      ivect2  => matrix3(2),
			ivect3  => matrix3(3), 
			ivect4  => matrix3(4), 
			ivect5  => matrix3(5), 
			ivect6  => matrix3(6), 
			ivect7  => matrix3(7), 
			ivect8  => matrix3(8),
		   -- Output vector	
			ovect0  => matrix4(0),
			ovect1  => matrix4(1),
			ovect2  => matrix4(2), 
			ovect3  => matrix4(3), 
			ovect4  => matrix4(4), 
			ovect5  => matrix4(5));
			
-----------------------Fifth level------------------------------------------------------------------------------------------------------------
fifth_level: gen_5th Port Map(
	      ivect0  => matrix4(0),
	      ivect1  => matrix4(1), 
	      ivect2  => matrix4(2),
			ivect3  => matrix4(3), 
			ivect4  => matrix4(4), 
			ivect5  => matrix4(5),
		   -- Output vector	
			ovect0  => matrix5(0),
			ovect1  => matrix5(1),
			ovect2  => matrix5(2), 
			ovect3  => matrix5(3));
-----------------------Sixth level------------------------------------------------------------------------------------------------------------
sixth_level: gen_6th Port Map(
	      ivect0  => matrix5(0),
	      ivect1  => matrix5(1), 
	      ivect2  => matrix5(2),
			ivect3  => matrix5(3),
		   -- Output vector	
			ovect0  => matrix6(0),
			ovect1  => matrix6(1),
			ovect2  => matrix6(2));
-----------------------Seventh level------------------------------------------------------------------------------------------------------------
	matrix7(0)(1 downto 0) <= matrix6(0)(1 downto 0);
	matrix7(1)(1 downto 0) <= matrix6(1)(1 downto 0);
	matrix7(1)(2)  <= matrix6(2)(2);
	matrix7(1)(63) <= matrix6(0)(63);
	HA_2_0 : HA Port Map(A => matrix6(0)(2), B => matrix6(1)(2), Cout => matrix7(0)(3), S => matrix7(0)(2));
	HA_3_0 : HA Port Map(A => matrix6(0)(3), B => matrix6(1)(3), Cout => matrix7(0)(4), S => matrix7(1)(3));
	gen4t61_0 : for i in 4 to 61 generate
		FA_1 : FA Port Map(A => matrix6(0)(i), B => matrix6(1)(i), Cin => matrix6(2)(i), Cout => matrix7(0)(i+1), S => matrix7(1)(i));
	end generate;
	HA_62_0 : HA Port Map(A => matrix6(0)(62), B => matrix6(1)(62), Cout => matrix7(0)(63), S => matrix7(1)(62));
-------------------------------------------------------------------------------------------------------------------------------------------------
	PRODUCT1 <= matrix7(0);
	PRODUCT2 <= matrix7(1);
end behavioral;