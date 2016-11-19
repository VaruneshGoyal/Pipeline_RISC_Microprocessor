library ieee;
use ieee.std_logic_1164.all;

entity inverter is
port( X : in std_logic_vector(16 downto 0);
      Y : out std_logic_vector(16 downto 0)
 );
end inverter;

architecture Formula_inv of inverter is

begin

Y<= not(X);

end Formula_inv;

