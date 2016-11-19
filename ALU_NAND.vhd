library ieee;
use ieee.std_logic_1164.all;

entity ALU_NAND is
port( X,Y: in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0)
 );
end ALU_NAND;


architecture Formula_NAND of ALU_NAND is

begin
Z <= not (X and Y);

end Formula_NAND;
      
