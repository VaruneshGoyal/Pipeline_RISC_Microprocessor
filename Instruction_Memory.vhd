
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;

entity Instruction_Memory is
port ( Din: in std_logic_vector(15 downto 0);
	Dout: out std_logic_vector(15 downto 0);
	write_enable,read_enable,clk: in std_logic;
	--write_enable,read_enable: in std_logic;
	Addr: in std_logic_vector(15 downto 0)
);
end Instruction_Memory;

architecture Formula_Memory of Instruction_Memory is
signal Data :Data_in(300 downto 0):= (

0 => "0011000000000001", --LHI R0 000000001 
1 => "1111000000000000", --LHI R1 000000011
2 => "1111000000000000",
3 => "0110000000101010",
4 => "1111000000000000",
5 => "0110000000101010", 
others=>"1111000000000000"
);


begin
 process(clk)		--process(clk)
    begin
        
               --Dout <= Data(to_integer(unsigned(Addr)));
        if (clk'event and (clk  = '0')) then
                if (write_enable = '1') then
                    Data(to_integer(unsigned(Addr))) <= Din  ;
                end if;
		if (read_enable = '1') then
                   Dout<= Data(to_integer(unsigned(Addr)))   ;
                end if;

        end if;
    end process;

end Formula_Memory;
