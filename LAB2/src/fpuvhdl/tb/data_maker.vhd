library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

entity data_maker is
  port (
    CLK  : in  std_logic;
    DATA1 : out std_logic_vector(31 downto 0);
    DATA2 : out std_logic_vector(31 downto 0) );
end data_maker;

architecture beh of data_maker is

begin  -- beh

  process (CLK)
    file fp : text open read_mode is "../src/fp_samples.hex";
    variable ptr1, ptr2 : line;
    variable val1, val2 : std_logic_vector(31 downto 0);
  begin  -- process
    if CLK'event and CLK = '1' then  -- rising clock edge
      if (not(endfile(fp))) then
        readline(fp, ptr1);
        --readline(fp, ptr2);
        hread(ptr1, val1);
        --hread(ptr2, val2);
      end if;
      DATA1 <= val1;
      DATA2 <= val1;

    end if;
  end process;

end beh;
