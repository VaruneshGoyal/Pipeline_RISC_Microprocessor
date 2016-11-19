library ieee;
use ieee.std_logic_1164.all;


-- just adds 7 0's behind the diven 9 bits to give 16 bit output'
entity data_extender_9to16 is
port(
	x: in std_logic_vector(8 downto 0);
	y : out std_logic_vector( 15 downto 0)
);
end data_extender_9to16;

architecture Formula_DE_9to16 of data_extender_9to16 is 



begin

	y(0) <= '0';
	y(1) <= '0';
	y(2) <= '0';
	y(3) <= '0';
	y(4) <= '0';
	y(5) <= '0';
	y(6) <= '0';
	y(7) <= x(0);
	y(8) <= x(1);
	y(9) <= x(2);
	y(10) <= x(3);
	y(11) <= x(4);
	y(12) <= x(5);
	y(13) <= x(6);
	y(14) <= x(7);
	y(15) <= x(8);


end Formula_DE_9to16;


