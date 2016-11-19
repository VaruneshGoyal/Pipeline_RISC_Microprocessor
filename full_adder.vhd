library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
port(  
	x,y,c_in: in std_logic;
	s, c_out: out std_logic
       
 );
end full_adder;


architecture Formula_FA of full_adder is
	signal P,G :std_logic;
begin

	P<=  ((not x) and y) or ((not y) and x);
	G<= x and y;
	c_out<= (P and c_in ) or G;
	s<= ((not P) and c_in) or ((not c_in) and P);
end Formula_FA;



