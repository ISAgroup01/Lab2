library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity gen_6th is
	Port( ivect0  : IN  std_logic_vector(64-1 downto 0);
	      ivect1  : IN  std_logic_vector(64-1 downto 0);
	      ivect2  : IN  std_logic_vector(64-1 downto 0);
			ivect3  : IN  std_logic_vector(64-1 downto 0);
			-- Output vector
			ovect0  : OUT std_logic_vector(64-1 downto 0);
			ovect1  : OUT std_logic_vector(64-1 downto 0);
			ovect2  : OUT std_logic_vector(64-1 downto 0)
			);
end gen_6th;

architecture struc of gen_6th is
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
type type_level5 is array (3  downto 0) of std_logic_vector(64-1 downto 0); -- array 4*64
type type_level6 is array (2  downto 0) of std_logic_vector(64-1 downto 0); -- array 3*64
signal matrix5 : type_level5 := (others => (others => '0')); --matrix level 5
signal matrix6 : type_level6 := (others => (others => '0')); --matrix level 6
begin
	matrix5(0)  <= ivect0;
	matrix5(1)  <= ivect1;
	matrix5(2)  <= ivect2;
	matrix5(3)  <= ivect3;
-----------------------------------------------------------------------------------------------------------------------------	
	--matrix6(0 to 2)(3 downto 0) <= matrix5(0 to 2)(3 downto 0);
	matrix6(0)(3 downto 0) <= matrix5(0)(3 downto 0);
	matrix6(1)(3 downto 0) <= matrix5(1)(3 downto 0);
	matrix6(2)(3 downto 0) <= matrix5(2)(3 downto 0);
	--matrix6(0 to 2)(63 downto 62) <= matrix5(0 to 2)(63 downto 62);
	matrix6(0)(63 downto 62) <= matrix5(0)(63 downto 62);
	matrix6(1)(63 downto 62) <= matrix5(1)(63 downto 62);
	matrix6(2)(63 downto 62) <= matrix5(2)(63 downto 62);
	--matrix6(1 to 2)(4) <= matrix5(2 to 3)(4);
	matrix6(1)(4) <= matrix5(2)(4);
	matrix6(2)(4) <= matrix5(3)(4);
	matrix6(2)(5) <= matrix5(2)(5);
	matrix6(2)(59 downto 6) <= matrix5(3)(59 downto 6);
	matrix6(2)(60) <= matrix5(2)(60);
	matrix6(1)(61) <= matrix5(0)(61);
	matrix6(2)(61) <= matrix5(1)(61);
	HA_4_0 : HA Port Map(A => matrix5(0)(4), B => matrix5(1)(4), Cout => matrix6(0)(5), S => matrix6(0)(4));
	HA_5_0 : HA Port Map(A => matrix5(0)(5), B => matrix5(1)(5), Cout => matrix6(0)(6), S => matrix6(1)(5));
	gen6t59_0 : for i in 6 to 59 generate
		FA_1 : FA Port Map(A => matrix5(0)(i), B => matrix5(1)(i), Cin => matrix5(2)(i), Cout => matrix6(0)(i+1), S => matrix6(1)(i));
	end generate;
	HA_60_0 : HA Port Map(A => matrix5(0)(60), B => matrix5(1)(60), Cout => matrix6(0)(61), S => matrix6(1)(60));
-----------------------------------------------------------------------------------------------------------------------------------
	ovect0  <= matrix6(0);
	ovect1  <= matrix6(1);
	ovect2  <= matrix6(2);
end architecture;
