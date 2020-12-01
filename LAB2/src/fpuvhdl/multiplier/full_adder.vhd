library IEEE;
use IEEE.std_logic_1164.all; 
use ieee.numeric_std.all;

entity FA is
	Port( A    :  IN  std_logic;
	      B    :  IN  std_logic;
			Cin  :  IN  std_logic;
			Cout :  OUT std_logic;
			S    :  OUT std_logic);
end FA;

architecture struct of FA is
begin
	S    <=  A xor B xor Cin;
	Cout <=  (A and B) or (A and Cin) or (B and Cin);
end struct;