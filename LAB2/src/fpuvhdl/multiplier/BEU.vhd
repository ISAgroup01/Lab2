library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BEU is
  Port(
    X_in       : in  std_logic_vector(2 downto 0);
    outSelect  : out std_logic_vector(2 downto 0));
end BEU;

architecture BEHAVIOR of BEU is
begin
  process(X_in)
    begin
    case X_in is
      when "000"  => outSelect <= "000"; --0
      when "001"  => outSelect <= "001"; --(A)
      when "010"  => outSelect <= "001"; --(A)
      when "011"  => outSelect <= "011"; --(2A)
      when "100"  => outSelect <= "100"; --(-2A)
      when "101"  => outSelect <= "010"; --(-A)
      when "110"  => outSelect <= "010"; --(-A)
      when "111"  => outSelect <= "000"; --(0)
	  when others => outSelect <= "000"; --other cases
    end case;
end process;

end BEHAVIOR;
