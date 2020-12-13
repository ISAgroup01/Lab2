library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity MBE is
  generic (n : integer := 32);
  Port(
      A   : in  std_logic_vector(n-1 downto 0);
      X   : in  std_logic_vector(n-1 downto 0);
      P   : out std_logic_vector(2*n-1 downto 0)
  );
end MBE;

architecture STRUCTURAL of MBE is
------------------------------------------------------------------------------------------------
--Component
------------------------------------------------------------------------------------------------
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
    X_in       : in  std_logic_vector(2 downto 0);
    outSelect  : out std_logic_vector(2 downto 0));
end component;

component mux51_generic is
  generic (n : integer := 33); --work with 33 bits
  Port(
    mux_in0    : in std_logic_vector(n-1 downto 0);
    mux_in1    : in std_logic_vector(n-1 downto 0);
    mux_in2    : in std_logic_vector(n-1 downto 0);
    mux_in3    : in std_logic_vector(n-1 downto 0);
    mux_in4    : in std_logic_vector(n-1 downto 0);

    mux_sel   : in std_logic_vector(2 downto 0);
    mux_out   : out std_logic_vector(n-1 downto 0) );
end component;
------------------------------------------------------------------------------------------------
--Signal
------------------------------------------------------------------------------------------------

type signal_matx_15_3  is array (15 downto 0) of std_logic_vector(2 downto 0);
type signal_matx_15_33 is array (15 downto 0) of std_logic_vector(32 downto 0);

--mux signals
signal sig_A      : std_logic_vector(33-1 downto 0);--(A)
signal sig_Am     : std_logic_vector(33-1 downto 0);--(-A)
signal sig_2A     : std_logic_vector(33-1 downto 0);--(2A)
signal sig_2Am    : std_logic_vector(33-1 downto 0);--(-2A)

--RCA signals
signal sig_Cout   : std_logic_vector(64-1 downto 0); --Carry out signal for last RCA

--interconnections signals
signal sig_BEUin  : std_logic_vector(33-1 downto 0); --Input Booth Encoding Unit
signal sig_BEUout : signal_matx_15_3 := (others => (others => '0'));

signal sig_S      : std_logic_vector(16-1 downto 0); --Array sign of partial product
signal sig_E      : std_logic_vector(16-1 downto 0);

signal sig_mux2dadda : signal_matx_15_33 := (others =>(others => '0')); --From mux to DADDA

signal sig_PRODUCT1toRCA, sig_PRODUCT2toRCA : std_logic_vector(64-1 downto 0); --Product of DADDA algorithm
signal A_inv : std_logic_vector(32-1 downto 0); --input A complemented

begin
A_inv <= std_logic_vector(unsigned(not(A))+1);
sig_BEUin <= X & '0';
sig_A   <= A(31) & A;                        --(A)
--sig_Am  <= not(A)+1;                         --(-A)
--sig_2A  <= shift_left(A, 1);                 --(2A)
--sig_2Am <= shift_left(signed(not(A)+1), 1);  --(-2A)
sig_Am  <= A_inv(31) & A_inv;       --(-A)
sig_2A  <= A & '0';                                    --(2A)
sig_2Am <= A_inv & '0'; --(-2A)

--generate signals
signal_genS: for i in 0 to 15 generate --generate S array
  --sig_S(i) <= sig_BEUout(i)(2); --MSB
  sig_S(i) <= sig_BEUin(2+(2*i));
end generate;

signal_genE: for i in 0 to 15 generate
  sig_E(i) <= sig_S(i) xnor sig_A(32); -- S xnor A_msb
end generate;

--generate blocks
BEU_gen: for i in 0 to 15 generate
  BEU_i : BEU port map(X_in => sig_BEUin(2+(2*i) downto 0+(2*i)), outSelect => sig_BEUout(i));
end generate;

MUX_gen: for i in 0 to 15 generate
  MUX51 : mux51_generic port map (mux_in0 => (others => '0'), mux_in1 => sig_A, mux_in2 => sig_Am, mux_in3 => sig_2A, mux_in4 => sig_2Am,
                                  mux_sel => sig_BEUout(i), mux_out => sig_mux2dadda(i));
end generate;

Dadda_tree: Dadda port map(PP0 => sig_mux2dadda(0), PP1 => sig_mux2dadda(1),PP2 => sig_mux2dadda(2),PP3 => sig_mux2dadda(3),
                           PP4 => sig_mux2dadda(4),PP5 => sig_mux2dadda(5),PP6 => sig_mux2dadda(6),PP7 => sig_mux2dadda(7),
                           PP8 => sig_mux2dadda(8),PP9 => sig_mux2dadda(9),PP10 => sig_mux2dadda(10),PP11 => sig_mux2dadda(11),
                           PP12 => sig_mux2dadda(12), PP13 => sig_mux2dadda(13),PP14 => sig_mux2dadda(14),PP15 => sig_mux2dadda(15),
                           E => sig_E, S => sig_S, PRODUCT1 => sig_PRODUCT1toRCA, PRODUCT2 =>sig_PRODUCT2toRCA);

Half_Adder : HA port map(A =>sig_PRODUCT1toRCA(0), B =>sig_PRODUCT2toRCA(0), Cout =>sig_Cout(0), S =>P(0));

RCA: for i in 1 to 63 generate
  FA_i : FA port map(A => sig_PRODUCT1toRCA(i), B=> sig_PRODUCT2toRCA(i), Cin =>sig_Cout(i-1), Cout =>sig_Cout(i), S=>P(i));
end generate;

end STRUCTURAL;
