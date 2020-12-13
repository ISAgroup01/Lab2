LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
library std;
use std.textio.all;

ENTITY TB_Dadda IS
END TB_Dadda;

ARCHITECTURE TB OF TB_Dadda IS

component Dadda
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
end component;

signal pr1, pr2    : std_logic_vector(63 downto 0);
signal E_sig : std_logic_vector(15 downto 0);
signal S_sig : std_logic_vector(15 downto 0);
BEGIN
DUT : Dadda port map(
		  PP0 		=> ,
		  PP1 		=> ,
		  PP2 		=> ,
		  PP3 		=> ,
		  PP4 		=> ,
		  PP5 		=> ,
		  PP6 		=> ,
		  PP7 		=> ,
		  PP8       => ,
		  PP9       => ,
		  PP10      => ,
		  PP11      => ,
		  PP12      => ,
		  PP13      => ,
		  PP14      => ,
		  PP15      => ,
		  E         => E_sig,
		  S         => S_sig,
		  PRODUCT1  => pr1,
		  PRODUCT2  => pr2);


end TB;

