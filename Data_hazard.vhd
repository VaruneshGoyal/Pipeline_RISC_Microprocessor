library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

--!!Need to put one more forwarding at output of alu...in case of SW after LW from same register

entity Data_Hazard is
	port ( 	Rs1_2, Rs2_2, Rs1_3 : in std_logic_vector(2 downto 0);
			Rd_3, Rd_4, Rd_5 : in std_logic_vector(2 downto 0); 
			Load_0_4 : in std_logic;
			RF_en_3, RF_en_4, RF_en_5 : in std_logic;
			mem_write_3: in std_logic;
			DH1, DH2 : out std_logic_vector(1 downto 0);
			DH3: out std_logic
			);
end entity;

architecture Behave of Data_Hazard is

begin
	process
		variable vDH1, vDH2 : std_logic_vector(1 downto 0);
		variable vDH3: std_logic;
	begin
		vDH1 := "00"; vDH2 := "00";
		vDH3 := '0';
		
		if(Rs1_3 = Rd_4 and mem_write_3 ='1' and Load_0_4 = '1') then
			vDH3 := '1';			--addressing lw followed by sw with dependency
		end if;
			--for s1 input
		if(Rd_3 = Rs1_2 and RF_en_3 = '1') then
			vDH1 := "11";
		elsif(Rd_4 = Rs1_2 and RF_en_4 = '1') then
			vDH1 := "10";
		elsif(Rd_5 = Rs1_2 and RF_en_5 = '1') then
			vDH1 := "01";
		end if;

			--for s2 input
		if(Rd_3 = Rs2_2 and RF_en_3 = '1') then
			vDH2 := "11";
		elsif(Rd_4 = Rs2_2 and RF_en_4 = '1') then
			vDH2 := "10";
		elsif(Rd_5 = Rs2_2 and RF_en_5 = '1') then
			vDH2 := "01";
		end if;
	
	DH1 <= vDH1;
	DH2 <= vDH2;
	DH3 <= vDH3;
	end process;


end Behave;
