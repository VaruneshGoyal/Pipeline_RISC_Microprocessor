
library ieee;
use ieee.std_logic_1164.all;

--- Priority encoder.gives highest priority to LSB.
entity priority_encoder is
port(  
	x: in std_logic_vector(7 downto 0);
	y: out std_logic_vector(2 downto 0)
       
 );
end priority_encoder;

architecture Formula_pe of priority_encoder is
signal x_bar:std_logic_vector(7 downto 0);
begin
x_bar<= not(x);

y(0) <=x_bar(0) and (x(1) or(x_bar(2) and x(3))or (x_bar(2) and x_bar(4) and x(5)) or (x_bar(2) and x_bar(4) and x_bar(6) and x(7)));
y(1) <= x_bar(0) and x_bar(1) and (x(2) or x(3) or (x_bar(4) and x_bar(5) and (x(6) or x(7)))); 
y(2) <= x_bar(0) and x_bar(1) and x_bar(2) and x_bar(3) and ( x(4) or x(5) or x(6) or x(7));


end Formula_pe;

