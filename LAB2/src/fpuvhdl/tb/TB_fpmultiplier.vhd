LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY TB_FPmul IS
END TB_FPmul;

ARCHITECTURE TB OF TB_FPmul IS

COMPONENT FPmul is
  PORT(
     FP_A : IN     std_logic_vector (31 DOWNTO 0);
     FP_B : IN     std_logic_vector (31 DOWNTO 0);
     clk  : IN     std_logic;
     FP_Z : OUT    std_logic_vector (31 DOWNTO 0));
END component;

COMPONENT data_maker is
  port (
    CLK  : in  std_logic;
    DATA1 : out std_logic_vector(31 downto 0);
    DATA2 : out std_logic_vector(31 downto 0));
END component;

COMPONENT clk_gen is
  port (
    CLK     : out std_logic;
    RST_n   : out std_logic);
END component;

COMPONENT data_sink is
  port (
    CLK   : in std_logic;
    RST_n : in std_logic;
    DIN   : in std_logic_vector(31 downto 0));
END component;

signal sig_inA    : std_logic_vector(31 downto 0);
signal sig_inB    : std_logic_vector(31 downto 0);
signal sig_out    : std_logic_vector(31 downto 0);
signal sig_rst    : std_logic := '0';
signal sig_clk    : std_logic := '0';


BEGIN

clock : clk_gen
  PORT MAP (
  CLK     => sig_clk,
  RST_n   => sig_rst
 );

DM: data_maker
   port map (
     CLK    => sig_clk,
     DATA1  => sig_inA,
     DATA2  => sig_inB
  );

 MUL : FPmul
   PORT MAP(
      FP_A => sig_inA,
      FP_B => sig_inB,
      clk  => sig_clk,
      FP_Z => sig_out
   );

DS: data_sink
    port map(
      CLK    => sig_clk,
      RST_n  => sig_rst,
      DIN    => sig_out
    );

end TB;
