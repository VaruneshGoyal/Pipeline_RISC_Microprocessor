library ieee;
use ieee.std_logic_1164.all;

entity ALU_XOR is
port( X,Y: in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0)
 );
end ALU_XOR;


architecture Formula_XOR of ALU_XOR is

begin
Z <= ((not X) and  Y) or((not Y) and X) ;

end Formula_XOR;
