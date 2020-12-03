library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

type P is array (N downto 0) of signed(nb_opt-1 downto 0);

entity BEU is

  Port(
    X_in       : in std_logic_vector(2 downto 0);
    outSelect    : out std_logic_vector(2 downto 0)
  );
end entity;

architecture BEHAVIOR of BEU is

  process(X_in)

    begin

    case X_in is

      when "000" => outSelect <= "000"; --0
      when "001" => outSelect <= "001"; --(A)
      when "010" => outSelect <= "001"; --(A)
      when "011" => outSelect <= "011"; --(2A)
      when "100" => outSelect <= "100"; --(-2A)
      when "101" => outSelect <= "010"; --(-A)
      when "110" => outSelect <= "010"; --(-A)
      when "111" => outSelect <= "000"; --(0)


    end case;

end process;

end architecture;
