
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

31=> "0011000000000000",
32=> "0110000001111111", --r0 = 0, r1 = 1, r2 = 0x8002, r3 = 0x0103, r4 = 5, r5 = 0x6208, r6 = 0x0870
33=> "0000000000000000", --add r0 r0 r0 : r0 = 0, set z
34=> "0000001001001001", --adz r1 r1 r1 :r1 = 2, will execute z=0
35=> "1111001001001010", --adc r1 r1 r1 :r1 = 2, will not execute
36=> "0000001001001001", --will not execute
37=> "1111001001001010", --will not execute
38=> "0100001001000101", --lw r1 r1 5: r1 = 0, zero flag will set
39=> "0010100100100001", --(ndz r4 r4 r4)will execute, finally z = 0, r4 = 0xFFFA 
40=> "0100001001001000", --lw r1 r1 8: r1 = 0x8888, z = 0
41=> "0010100100100001", --(ndz r4 r4 r4) will not execute; r4 = 0xFFFA
42=> "0010100100100000", --ndu r4 r4 r4 :r4=5
43=> "0100001100000100", --lw r1 r4 4 :r1 = 0x000F
44=> "0100010001000000", --lw r2 r1 0 :r2 = 9
45=> "0000011010010000", --add r3 r2 r2: r3 = 0x0012 

46=> "1100000000001000", --add r7 r2 r0
--9 => "0011 111 000101111", --lhi r7 47
47=> "0000111111111001", --adz r7 r7 r7; will not execute
48=> "0000000000000000", --add r0 r0 r0; set z flag
49=> "0000111111100001", --adz r7 r7 r4; r4=5, therefore r7 = 49+5 = 54

--50=> "", 
--51=> "",
--52=> "",
--53=> "",
--54=> "0011111000000001", --lhi r7 1 
--55=> "0000000000000000",
--56=> "0010111111111001",
--128=>"1000101110110111", --jal r5 -73 

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
