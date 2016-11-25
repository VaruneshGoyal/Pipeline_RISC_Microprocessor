
library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
library work;
use work.Microprocessor_project.all;

entity Data_Memory is
port ( Din: in std_logic_vector(15 downto 0);
	Dout: out std_logic_vector(15 downto 0);
	write_enable,read_enable,clk: in std_logic;
	--write_enable,read_enable: in std_logic;
	Addr: in std_logic_vector(15 downto 0)
);
end Data_Memory;

architecture Formula_Memory of Data_Memory is
signal Data :Data_in(300 downto 0):= (

0 => "0000000000000000", --LHI R0 000000001 
1 => "0000000000000001", --LM R0 011111111 
2 => "1000000000000010", --RANDOM
3 => "0000000100000011",  --RANDOM
4 => "0000000000000101", --RANDOM	
5 => "0110001000001000",  --LM R1 000000000
6 => "0000100001110000", --ADD R4 R1 R6
7 => "0000000000000000",
8 => "1000100010001000",
9 => "0000000000001111",
15=> "0000000000001001",
--0 => "0011000000000001", --LHI R0 000000001 
--1 => "0110000011111111", --LM R0 011111111 
--2 => "0000000000000000", --RANDOM
--3 => "0000000000000000",  --RANDOM
--4 => "0000000000000000", --RANDOM	
--5 => "0110001000000000",  --LM R1 000000000
--6 => "0000100001110000", --ADD R4 R1 R6
--7 => "0000011001000010", --ADC R3 R1 R0
--8 => "0000111011100001", --ADZ R7 R3 R4
--9 => "0010010010010000",-- NDU R2 R2 R2
--10 =>"0000101101101000",-- ADD R5 R5 R5
--11 =>"0000111100001001",--ADZ R7 R4 R1
--12 =>"0000000000000000", --RANDOM
--13 =>"0000000000000000", --RANDOM
--14 =>"0101010000000010", --SW R2 R0 2
--15=>"0011010000000001", --LHI R2 1
--16=>"1100111000111111", --BEQ R7 R0 XX
--17=>"0000110001101000", --ADD R6 R1 R5
--18=>"1100110001000011", --BEQ R6 R1 3 //
--19=>"0000000000000000", --RANDOM
--20=>"0000000000000000", --RANDOM
--21=>"1000010000000100", --JAL R2 4
--22=>"0000000000000000", --RANDOM
--23=>"1001110010000000", -- JLR R6 R2
--24=>"0000000000000000", --RANDOM
--25=>"1000010111111110", --JAL R2 -2
--26=>"0011001100000001", --LHI R1 100000001
--27=>"0011010100000001",--LHI R2 100000001
--28=>"0010001010011010",--NDC R1 R2 R3
--29=>"0000011001010000",--ADD R3 R2 R1
--30=>"0010001010011001",--NDZ R1 R2 R3
--31=>"0010101110001010",--NDC R5 R6 R1
--32=>"0000100001010010",--ADC R4 R1 R2
--33=>"0001011110111101",--ADI R3 R6 -3
--34=>"0011000000000010",--LHI R0 256
--35=>"0111000010101011",--SM R0 010101011
--36=>"0111000000000000",--SM R0 000000000
--37=>"0100001011000101",--LW R1 R3 5
--38=>"1000000111011010",--JAL R0, -38
--128=>"0000000000000001",--DATA 
--129=>"0000000000000010",--DATA 
--130=>"0000000000000011",--DATA
--131=>"0000000000000000",--DATA
--132=>"0000000000000000",--DATA
--133=>"0000000000000000",--DATA
--134=>"0000000000001010",--DATA
--135=>"0000000000000101",--DATA
--136=>"0000000000001111",--DATA   
others=>"0000000011101111"
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
