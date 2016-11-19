library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;

-- helps choose from 2^n inputs ( 16 bit vector) using n control bits

entity Data_MUX is
generic (control_bit_width:integer);
port(Din:in Data_in( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(15 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end Data_MUX;


architecture  Formula_mux of Data_MUX is
signal indice:integer:=0;
begin


indice <= to_integer(unsigned(control_bits));
 Dout <= Din(indice);
end Formula_mux;
-----------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;


entity Data_MUX_8 is
generic (control_bit_width:integer);
port(Din:in Data_in_8( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(7 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end Data_MUX_8;


architecture  Formula_mux_8 of Data_MUX_8 is
signal indice:integer:=0;
begin


indice <= to_integer(unsigned(control_bits));
 Dout <= Din(indice);
end Formula_mux_8;

----------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;


entity Data_MUX_3 is
generic (control_bit_width:integer);
port(Din:in Data_in_3( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(2 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end Data_MUX_3;


architecture  Formula_mux_3 of Data_MUX_3 is
signal indice:integer:=0;
begin


indice <= to_integer(unsigned(control_bits));
 Dout <= Din(indice);
end Formula_mux_3;

--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;


entity Data_MUX_1 is
generic (control_bit_width:integer);
port(Din:in Data_in_1( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(0 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end Data_MUX_1;


architecture  Formula_mux_1 of Data_MUX_1 is
signal indice:integer:=0;
begin


indice <= to_integer(unsigned(control_bits));
 Dout <= Din(indice);
end Formula_mux_1;

------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;


entity Data_MUX_2 is
generic (control_bit_width:integer);
port(Din:in Data_in_2( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(1 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end Data_MUX_2;


architecture  Formula_mux_2 of Data_MUX_2 is
signal indice:integer:=0;
begin


indice <= to_integer(unsigned(control_bits));
 Dout <= Din(indice);
end Formula_mux_2;

