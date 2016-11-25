
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
signal Data :Data_in(65535 downto 0):= (


0 => "0011000000000001", --LHI R0 000000001 
1 => "0110000011111111", --LM R0 011111111 
2 => "0000000000000000", --RANDOM
3 => "0000000000000000",  --RANDOM
4 => "0000000000000000", --RANDOM	
5 => "0110001000000000",  --LM R1 000000000
6 => "0000100001110000", --ADD R4 R1 R6
7 => "0000011001000010", --ADC R3 R1 R0
8 => "0000111011100001", --ADZ R7 R3 R4
9 => "0010010010010000",-- NDU R2 R2 R2
10 =>"0000101101101000",-- ADD R5 R5 R5
11 =>"0000111100001001",--ADZ R7 R4 R1
12 =>"0000000000000000", --RANDOM
13 =>"0000000000000000", --RANDOM
14 =>"0101010000000010", --SW R2 R0 2
15=>"0011010000000001", --LHI R2 1
16=>"1100111000111111", --BEQ R7 R0 XX
17=>"0000110001101000", --ADD R6 R1 R5
18=>"1100110001000011", --BEQ R6 R1 3 //
19=>"0000000000000000", --RANDOM
20=>"0000000000000000", --RANDOM
21=>"1000010000000100", --JAL R2 4
22=>"0000000000000000", --RANDOM
23=>"1001110010000000", -- JLR R6 R2
24=>"0000000000000000", --RANDOM
25=>"1000010111111110", --JAL R2 -2
26=>"0011001100000001", --LHI R1 100000001
27=>"0011010100000001",--LHI R2 100000001
28=>"0010001010011010",--NDC R1 R2 R3
29=>"0000011001010000",--ADD R3 R2 R1
30=>"0010001010011001",--NDZ R1 R2 R3
31=>"0010101110001010",--NDC R5 R6 R1
32=>"0000100001010010",--ADC R4 R1 R2
33=>"0001011110111101",--ADI R3 R6 -3
34=>"0011000000000010",--LHI R0 256
35=>"0111000010101011",--SM R0 010101011
36=>"0111000000000000",--SM R0 000000000
37=>"0100001011000101",--LW R1 R3 5
38=>"1000000111011010",--JAL R0, -38

--31=> "0011000000000000",
--32=> "0110000001111111", --r0 = 0, r1 = 1, r2 = 0x8002, r3 = 0x0103, r4 = 5, r5 = 0x6208, r6 = 0x0870
--33=> "0000000000000000", --add r0 r0 r0 : r0 = 0, set z
--34=> "0000001001001001", --adz r1 r1 r1 :r1 = 2, will execute z=0
--35=> "1111001001001010", --adc r1 r1 r1 :r1 = 2, will not execute
--36=> "0000001001001001", --will not execute
--37=> "1111001001001010", --will not execute
--38=> "0100001001000101", --lw r1 r1 5: r1 = 0, zero flag will set
--39=> "0010100100100001", --(ndz r4 r4 r4)will execute, finally z = 0, r4 = 0xFFFA 
--40=> "0100001001001000", --lw r1 r1 8: r1 = 0x8888, z = 0
41=> "0010100100100001", --(ndz r4 r4 r4) will not execute; r4 = 0xFFFA
42=> "0010100100100000", --ndu r4 r4 r4 :r4=5
43=> "0100001100000100", --lw r1 r4 4 :r1 = 0x000F
44=> "0100010001000000", --lw r2 r1 0 :r2 = 9
45=> "0000011010001000", --add r3 r2 r1: r3 = 0x0018 

--46=> "1100000000001000", --add r7 r2 r0
--9 => "0011 111 000101111", --lhi r7 47
47=> "0000111111111001", --adz r7 r7 r7; will not execute
48=> "0000000000000000", --add r0 r0 r0; set z flag
49=> "0000111111100001", --adz r7 r7 r4; r4=5, therefore r7 = 49+5 = 54

--50=> "", 
--51=> "",
--52=> "",
--53=> "",
54=> "0011111000000001", --lhi r7 1 
55=> "0000000000000000",
56=> "0010111111111001",
128=>"1000101110110111", --jal r5 -73 
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
