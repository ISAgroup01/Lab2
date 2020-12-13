LIBRARY ieee.std_logic_1164.all;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity tb_MBE is
end tb_MBE;

ARCHITECTURE TB of tb_MBE is

 COMPONENT MBE_mod is
  generic (n : integer := 32);
  Port(
      A   : in  std_logic_vector(n-1 downto 0);
      X   : in  std_logic_vector(n-1 downto 0);
      S   : out std_logic_vector(16-1 downto 0);
      E   : out std_logic_vector(16-1 downto 0);
      P   : out std_logic_vector(n-1 downto 0);
      
  );
end COMPONENT;

  signal tb_X std_logic_vector(n-1 downto 0) <= (others->0);
  signal tb_A std_logic_vector(n-1 downto 0) <= (others->0);

  file file_results : text;

  begin

    --00000000   --3e9e377a
    --25a00002   --3f4f1bbd
    --25400003   --3f800000
    --a5e00002   --3f4f1bbd
    --a6900000   --3e9e377a

    --------------------------------------------------------------------------------------------------------
    --give UUT some inputs
    --------------------------------------------------------------------------------------------------------

    tb_X <= x"00000000", --samples
            x"25a00002" after 10 ns,
            x"25400003" after 10 ns,
            x"a5e00002" after 10 ns,
            x"a6900000" after 10 ns;
            
    tb_A <= x"3e9e377a" after 10 ns, --samples
            x"3f4f1bbd" after 10 ns,
            x"3f800000" after 10 ns,
            x"3f4f1bbd" after 10 ns,
            x"3f800000" after 10 ns;
            
         

--------------------------------------------------------------------------------------------------------
    --writing output on a file
--------------------------------------------------------------------------------------------------------

--process(tb_X)
  --file res_fp : text open WRITE_MODE is "../src/tb_MBE_outputs.txt";
  --variable line_out : line;
--begin  -- process

  --write(line_out, conv_integer(signed(tb_P)));
  --write(line_out, conv_integer(tb_P));
  --writeline(res_fp, line_out);

--end process;

    UUT : MBE_mod port map(X => tb_X, A => tb_A);
  end TB;
