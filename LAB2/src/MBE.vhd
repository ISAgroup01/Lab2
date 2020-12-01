library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

type P is array (N downto 0) of signed(nb_opt-1 downto 0);

entity MBE is
  generic n := 32;

  Port(
      A   : in unsigned(n-1 downto 0);
      X   : in unsigned(2 downto 0);

  );
end entity;

architecture STRUCTURAL of MBE is

component BEU is

  Port(
    X_in        : in signed(2 downto 0);
    out2mux    : out std_logic_vector(2 downto 0)
  );
end component;

component mux51_generic is

  generic n := 32;
  Port(
    mux_in0    : in std_logic_vector(n-1 downto 0);
    mux_in1    : in std_logic_vector(n-1 downto 0);
    mux_in2    : in std_logic_vector(n-1 downto 0);
    mux_in3    : in std_logic_vector(n-1 downto 0);
    mux_in4    : in std_logic_vector(n-1 downto 0);

    mux_sel   : in std_logic_vector(2 downto 0);
    mux_out   : out std_logic_vector(n-1 downto 0)
  );

end component;

signal sig_BEU2mux : std_logic_vector(2 downto 0);
signal sig_shiftREG2BEU : std_logic_vector(2 downto 0);

signal sig_A    : std_logic_vector(n-1 downto 0) <= A;                                --(0)
signal sig_Am   : std_logic_vector(n-1 downto 0) <= not(A)+1;                         --(-A)
signal sig_2A   : std_logic_vector(n-1 downto 0) <= shift_left(A, 1);       --(A)
signal sig_2Am  : std_logic_vector(n-1 downto 0) <= shift_left(signed(not(A)+1), 1);  --(-2A)

begin

BEU1 : BEU port map();


end architecture;
