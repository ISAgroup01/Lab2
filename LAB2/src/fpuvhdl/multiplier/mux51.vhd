library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux51_generic is

  generic (n : integer := 32);
  Port(
    mux_in0    : in std_logic_vector(n-1 downto 0);
    mux_in1    : in std_logic_vector(n-1 downto 0);
    mux_in2    : in std_logic_vector(n-1 downto 0);
    mux_in3    : in std_logic_vector(n-1 downto 0);
    mux_in4    : in std_logic_vector(n-1 downto 0);

    mux_sel   : in std_logic_vector(2 downto 0);
    mux_out   : out std_logic_vector(n-1 downto 0)
  );
end entity;

  architecture BEHAVIOR of BEU is

    process(mux_sel)

      begin

      case mux_in is

        when "000" => mux_out <= mux_in0;
        when "001" => mux_out <= mux_in1;
        when "010" => mux_out <= mux_in2;
        when "011" => mux_out <= mux_in3;
        when "100" => mux_out <= mux_in4;

        when others => mux_out <= mux_in0;

      end case;

  end process;
