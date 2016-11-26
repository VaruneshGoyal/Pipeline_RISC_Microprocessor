library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

--!!Need to put one more forwarding at output of alu...in case of SW after LW from same register

entity Data_Hazard is
	port ( 	Rs1_2, Rs2_2, Rs1_3, Rs2_3: in std_logic_vector(2 downto 0);
			Rd_3, Rd_4, Rd_5 : in std_logic_vector(2 downto 0); 
			Rs1_dep_3, Rs2_dep_3 : in std_logic;
			Load_0_4 : in std_logic;
			Load_0_3 : in std_logic;
			RF_en_3, RF_en_4, RF_en_5 : in std_logic;
			LM_SM_bit_stage4, LM_SM_bit_stage5 : in std_logic;
			mem_write_3: in std_logic;
			Z_flag, Z_dep_stage4, C_flag, C_dep_stage4 : in std_logic;
			DH1, DH2 : out std_logic_vector(1 downto 0);
			DH3: out std_logic;
			S2_enable, S1_enable : out std_logic
			);
end entity;

architecture Behave of Data_Hazard is

begin
	process(Rs1_2, Rs2_2, Rs1_3, Rd_3, Rd_4, Rd_5, Load_0_3, Load_0_4, RF_en_3, RF_en_4, RF_en_5, mem_write_3, LM_SM_bit_stage4, LM_SM_bit_stage5,
			Rs2_3, Rs1_dep_3, Rs2_dep_3 )
		variable vDH1, vDH2 : std_logic_vector(1 downto 0);
		variable vDH3: std_logic;
		variable vS2_enable,vS1_enable : std_logic;
	begin
		vDH1 := "00"; vDH2 := "00";
		vDH3 := '0';
		vS2_enable := '0';
		vS1_enable := '0';
		
		if(Rs1_3 = Rd_4 and mem_write_3 ='1' and Load_0_4 = '1') then
			vDH3 := '1';			--addressing lw followed by sw with dependency
		end if;
		
			--for s1 input
		if(Rs1_3 = Rd_4 and Rs1_dep_3 = '1' and Load_0_4 = '1') then
			vDH1 := "10";
			vS1_enable := '1';
		elsif((Rd_3 = Rs1_2 and RF_en_3 = '1' and (not ((Z_flag = '0' and z_dep_stage4 = '1') or (C_flag = '0' and C_dep_stage4 = '1')))) 
					or (LM_SM_bit_stage4 = '1')) then
			vDH1 := "11";
		elsif(Rd_4 = Rs1_2 and RF_en_4 = '1') then
			vDH1 := "10";
		elsif(Rd_5 = Rs1_2 and RF_en_5 = '1') then
			vDH1 := "01";
		end if;


		if(Rs2_3 = Rd_4 and Rs2_dep_3 = '1' and Load_0_4 = '1') then
			vDH2 := "10";
			vS2_enable := '1';
		elsif(Rd_3 = Rs2_2 and RF_en_3 = '1' and (not ((Z_flag = '0' and z_dep_stage4 = '1') or (C_flag = '0' and C_dep_stage4 = '1')))) then	
				vDH2 := "11";
		elsif(Rd_4 = Rs2_2 and RF_en_4 = '1') then
			vDH2 := "10";
		elsif(Rd_5 = Rs2_2 and RF_en_5 = '1') then
			vDH2 := "01";
		end if;
	
	DH1 <= vDH1;
	DH2 <= vDH2;
	DH3 <= vDH3;
	S2_enable <= vS2_enable;
	S1_enable <= vS1_enable;
	end process;


end Behave;
