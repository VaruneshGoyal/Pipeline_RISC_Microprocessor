
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Microprocessor_project.all;


--- standard decoder.
entity decoder_pe is
port(  x: in std_logic_vector(2 downto 0);
	y: out std_logic_vector(7 downto 0)
	
       
 );
end decoder_pe;


architecture Formula_decoder_pe of decoder_pe is
signal x_bar: std_logic_vector(2 downto 0);
begin
x_bar <= not(x);
y(0)<= x_bar(0) and x_bar(1) and x_bar(2);
y(1)<= x(0) and x_bar(1) and x_bar(2);
y(2)<= x_bar(0) and x(1) and x_bar(2);
y(3)<= x(0) and x(1) and x_bar(2);
y(4)<= x_bar(0) and x_bar(1) and x(2);
y(5)<= x(0) and x_bar(1) and x(2);
y(6)<= x_bar(0) and x(1) and x(2);
y(7)<= x(0) and x(1) and x(2);

end Formula_decoder_pe;
