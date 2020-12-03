--INSERIRE TOP entity
--VERIFICARE IL NUMERO DI BIT PER A E X

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

type signal_matx_15_3 is array (15 downto 0) of std_logic_vector(2 downto 0);
type signal_matx_15_33 is array (15 downto 0) of std_logic_vector(32 downto 0);

entity MBE is
  generic (n : integer := 32);

  Port(
      A   : in unsigned(n-1 downto 0);
      X   : in unsigned(n-1 downto 0);
      P   : out signed(2*n-1 downto 0)
  );
end entity;

architecture STRUCTURAL of MBE is

component Dadda is
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

component FA is
	Port( A    :  IN  std_logic;
  	    B    :  IN  std_logic;
  		Cin  :  IN  std_logic;
  		Cout :  OUT std_logic;
  		S    :  OUT std_logic);
end component;

component HA is
	Port( A    :  IN  std_logic;
  	     B    :  IN  std_logic;
  		Cout :  OUT std_logic;
  		S    :  OUT std_logic);
end component;

component BEU is

  Port(
    X_in       : in signed(2 downto 0);
    outSelect    : out std_logic_vector(2 downto 0)
  );
end component;

component mux51_generic is

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

--mux signals
signal sig_A      : std_logic_vector(32-1 downto 0) <= A;                                --(0)
signal sig_Am     : std_logic_vector(32-1 downto 0) <= not(A)+1;                         --(-A)
signal sig_2A     : std_logic_vector(32-1 downto 0) <= shift_left(A, 1);                 --(A)
signal sig_2Am    : std_logic_vector(32-1 downto 0) <= shift_left(signed(not(A)+1), 1);  --(-2A)

--RCA signals

signal sig_Cout   : std_logic_vector(64-1 downto 0);

--interconnections signals
signal sig_BEUin  : std_logic_vector(n-1 downto 0) <= (others-> '0');
signal sig_BEUout : signal_matx_15_3 <= (others-> '0')(others -> '0');

signal sig_S      : std_logic_vector(16-1 downto 0);
signal sig_E      : std_logic_vector(16-1 downto 0);

signal sig_mux2dadda : signal_matx_15_33 <= (others-> '0')(others -> '0');

signal sig_PRODUCT1toRCA, sig_PRODUCT2toRCA : std_logic_vector(64-1 downto 0);

begin

--generate signals
signal_genS: for i = 0 to 15 generate --generate S array
  sig_S(i) <= sig_BEUout(i)(2); --MSB
end generate;

signal_genE: for i=0 to 15 generate
  sig_E(i) <= sig_S(i) xnor sig_A(32-1); -- S xnor A_msb
end generate;

--generate blocks

Half_Adder : HA port map(A =>sig_PRODUCT1toRCA(0), B =>sig_PRODUCT2toRCA(0), Cout =>sig_Cout(0), S =>P(0));

RCA: for i = 1 to 63 generate
  FA : port map(A => sig_PRODUCT1toRCA(i), B=> sig_PRODUCT2toRCA(i), Cin =>sig_Cout(i-1), Cout =>sig_Cout(i), S=>P(i));
end generate;

BEU_gen: for i = 0 to 15 generate
  BEU : port map(X_in => sig_BEUin(2+(2*i) downto 0+(2*i)), outSelect => sig_BEUout(i));
end generate;

MUX_gen: for i = 0 to 15 generate
MUX51 : mux51_generic port map (mux_in0 => 0, mux_in1 => sig_A, mux_in2 => sig_Am, mux_in3 => sig_2A, mux_in4 => sig_2Am,
                                mux_sel => sig_BEUout(i), mux_out => sig_mux2dadda(i));
end generate;

Dadda_tree: Dadda port map(PP0 => sig_mux2dadda(0), PP1 => sig_mux2dadda(1),PP2 => sig_mux2dadda(2),PP3 => sig_mux2dadda(3),
                          PP4 => sig_mux2dadda(4),PP5 => sig_mux2dadda(5),PP6 => sig_mux2dadda(6),PP7 => sig_mux2dadda(7),
                          PP8 => sig_mux2dadda(8),PP9 => sig_mux2dadda(9),PP10 => sig_mux2dadda(10),PP11 => sig_mux2dadda(11),
                          PP12 => sig_mux2dadda(12), PP13 => sig_mux2dadda(13),PP14 => sig_mux2dadda(14),PP15 => sig_mux2dadda(15),
                          E => sig_E, S => sig_S, PRODUCT1 => sig_PRODUCT1toRCA, PRODUCT2 =>sig_PRODUCT2toRCA);

end architecture;
