library ieee;
use ieee.std_logic_1164.all;

entity sign_extender_alu is
port( X: in std_logic_vector(15 downto 0);
      Y: out std_logic_vector(16 downto 0)
);

end sign_extender_alu;


architecture Formula_SE of sign_extender_alu is

begin
Y(0) <= X(0);
Y(1) <= X(1);
Y(2) <= X(2);
Y(3) <= X(3);

Y(4) <= X(4);
Y(5) <= X(5);
Y(6) <= X(6);
Y(7) <= X(7);

Y(8) <= X(8);
Y(9) <= X(9);
Y(10) <= X(10);
Y(11) <= X(11);

Y(12) <= X(12);
Y(13) <= X(13);
Y(14) <= X(14);
Y(15) <= X(15);

Y(16) <= X(15);

end Formula_SE;
