library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;
entity Load_hazard is
	port(
		Rd_4 : in std_logic_vector(2 downto 0);		
		Rs1_3, Rs2_3 : in std_logic_vector(2 downto 0);
		Rs1_dep_3, Rs2_dep_3 : in std_logic;
		Z_dep_3, Z_en_3: in std_logic;
		Load_0_4: in std_logic;
		mem_write_3: in std_logic;		--for removing the case of lw followewd by sw with dependency		
		Z_mux_ctrl: out std_logic;
		--Z_en : out std_logic;
		pipereg_1_en, pipereg_2_en, pipereg_3_en: out std_logic;
		pc_en: out std_logic;
		C_en: out std_logic;
		reset_4: out std_logic
		);
end entity;

Architecture Behave of Load_hazard is
begin 

	process(Rd_4, Rs1_3, Rs2_3, Rs1_dep_3, Rs2_dep_3, Z_Dep_3, Z_en_3, Load_0_4, mem_write_3)
		variable vZ_mux_ctrl : std_logic;
		variable vC_en, vpipereg_1_en, vpipereg_2_en, vpipereg_3_en, vpc_en : std_logic;
		variable vreset_4: std_logic;
	Begin
		vZ_mux_ctrl := '0';
		--vZ_en := '1';
		vC_en := '1';
		vpc_en := '1';
		vpipereg_1_en := '1';
		vpipereg_2_en := '1';
		vpipereg_3_en := '1';
		vreset_4:= '0';
		if(Rd_4 = "111" and Load_0_4 = '1') then
			vZ_mux_ctrl := '1';
			--vZ_en = '1';
		elsif(Load_0_4 = '1' and ((Rd_4 = Rs1_3 and Rs1_dep_3 = '1') or (Rd_4 = Rs2_3 and Rs2_dep_3 = '1') or Z_dep_3 = '1')) then 
			--dependent instruction			
			--stall case
			vpipereg_1_en := '0';
			vpipereg_2_en := '0';
			vpipereg_3_en := '0';
			vpc_en := '0';
			vreset_4 := '1';
			vC_en := '0';
			--vZ_en = '1';
			vZ_mux_ctrl := '1';
		elsif(Z_en_3 = '0' and Load_0_4 = '1') then
			--vZ_en = '1';
			vZ_mux_ctrl := '1'; --non dependent instruction case
		end if;--last remaining case non dependent instruction which affects zero flag
		Z_mux_ctrl <= vZ_mux_ctrl;
		pipereg_1_en <= vpipereg_1_en;
		pipereg_2_en <= vpipereg_2_en;
		pipereg_3_en <= vpipereg_3_en;	
		C_en <= vC_en;
		pc_en <= vpc_en;
		reset_4 <= vreset_4;
	end process;
end Behave;

