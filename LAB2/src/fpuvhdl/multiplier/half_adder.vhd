library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity HA is
	Port( A    :  IN  std_logic;
	      B    :  IN  std_logic;
			Cout :  OUT std_logic;
			S    :  OUT std_logic);
end HA;

architecture struct of HA is
begin
	S    <= A xor B;
	Cout <= A and B;
end struct;