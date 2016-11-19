
library ieee;
use ieee.std_logic_1164.all;
entity DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0) ;
	      clk, enable,reset: in std_logic);
end entity;
architecture Behave of DataRegister is
 signal data_sig:std_logic_vector(data_width-1 downto 0);
constant const0:std_logic_vector(data_width-1 downto 0) := (others => '0');
begin
    process(clk)
    begin
	--Dout<=data_sig;
       if(clk'event and (clk  = '1')) then
	   if( reset ='1') then
		Dout <= const0;
	   else
		   if(enable = '1' ) then
		       Dout <= Din;
		   end if;
	   end if;
       end if;
    end process;
end Behave;

