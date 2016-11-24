library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity InstructionDecode is
port(   IR: in std_logic_vector(15 downto 0);		--IR = InstructionRegister
		Rpe_zero_checker : in std_logic;
     	RdMuxCtrl : out std_logic;
		Rpe_mux_ctrl : out std_logic;

		Rs1, Rs2, Rd : out std_logic_vector(2 downto 0);
		Rf_en : out std_logic;
		Rs1_dep, Rs2_dep : out std_logic;
	
		mem_read, mem_write : out std_logic;
		Dout_mux_ctrl : out std_logic;    --whether data from mem or from alu_output
	
		ALU_ctrl : out std_logic_vector(1 downto 0);
		ALU_output_mux_ctrl : out std_logic_vector(1 downto 0);
		C_en, C_dep, Z_en, Z_dep : out std_logic; 
		ALU_a_input_mux_ctrl : out std_logic;

		S2_mux_ctrl : out std_logic;
		--S1_mux_ctrl : std_logic_vector(1 downto 0);

		Load_0 : out std_logic;
		--Z_mux_ctrl : std_logic;

		JAL_bit, JLR_bit, LM_SM_bit : out std_logic
 );
end InstructionDecode;


architecture Behave of InstructionDecode is

begin

	process(IR)
		variable vRdMuxCtrl : std_logic;
		variable vRpe_mux_ctrl : std_logic;

		variable vRs1, vRs2, vRd : std_logic_vector(2 downto 0);
		variable vRf_en, vRs1_dep, vRs2_dep : std_logic;
	
		variable vmem_read, vmem_write : std_logic;
		variable vDout_mux_ctrl : std_logic;    --whether data from mem or from alu_output
	
		variable vALU_ctrl : std_logic_vector(1 downto 0);
		variable vALU_output_mux_ctrl : std_logic_vector(1 downto 0);
		variable vC_en, vC_dep, vZ_en, vZ_dep : std_logic; 
		variable vALU_a_input_mux_ctrl : std_logic;

		variable vS2_mux_ctrl : std_logic;
		--variable vS1_mux_ctrl : std_logic_vector(1 downto 0);

		variable vLoad_0 : std_logic;
		--variable vZ_mux_ctrl : std_logic;

		variable vJAL_bit, vJLR_bit, vLM_SM_bit : std_logic;
	
		--variable vincrementor_mux_ctrl : std_logic_vector(1 downto 0);


		

	begin
	--defaults
		vRdMuxCtrl := '0';		--1 if from PE
		vRpe_mux_ctrl := '0';	--1 if LM/SM instruction

		vRs1 := "000"; 
		vRs2 :="000"; 
		vRd :="000";
		vRf_en := '0';
		vRs1_dep := '0';
		vRs2_dep := '0';
	
		vmem_read := '0'; 
		vmem_write := '0';
		vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
	
		vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
		vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
		vC_en:= '0'; 
		vC_dep:= '0'; 
		vZ_en:= '0'; 
		vZ_dep:= '0'; 
		vALU_a_input_mux_ctrl:= '0'; --1 for SE6

		vS2_mux_ctrl:= '0';
		--vS1_mux_ctrl:= "00";

		vLoad_0 := '0';				--1 for LW
		--vZ_mux_ctrl := '0';			--probably not needed

		vJAL_bit := '0'; 
		vJLR_bit := '0';
		vLM_SM_bit := '0';
	
	case IR(15 downto 12) is

		when "0000" =>					--ADD done
			vRdMuxCtrl := '0';
			vRpe_mux_ctrl := '0';
	
			vRs1 := IR(5 downto 3);
			vRs2 := IR(8 downto 6);
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '1';
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '1'; 
			if(IR(0) = '1') then
				vZ_dep := '1';
			elsif (IR(1) = '1') then
				vC_dep := '1';
			end if;
			vZ_en:= '1'; 
			vALU_a_input_mux_ctrl:= '0';	--1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
	
		when "0001" =>						 --ADI
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			--vRs1 := "000"; 
			vRs2 := IR(8 downto 6);
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '0';
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem or from alu_output
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '1'; 
			vC_dep:= '0'; 
			vZ_en:= '1'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '1'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
		
			vJAL_bit := '0'; 
			vJLR_bit := '0';
		
		when "0010" =>						--NDU
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := IR(5 downto 3);
			vRs2 := IR(8 downto 6);
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '1';
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "01";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			if(IR(0) = '1') then
				vZ_dep := '1';
			elsif (IR(1) = '1') then
				vC_dep := '1';
			end if;
			vZ_en:= '1'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';		
	
		when "0011" =>	 					--LHI
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := "000"; 
			vRs2 :="000"; 
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '0';
			vRs2_dep := '0';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "10"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
	
		when "0100" =>						 --LW
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := "000"; 
			vRs2 := IR(8 downto 6);
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '0';
			vRs2_dep := '1';
		
			vmem_read := '1'; 
			vmem_write := '0';
			vDout_mux_ctrl := '1';    --whether data from mem(1) or from alu_output(0)
	
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '1'; --!!!!!!!Actually dont care case here
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '1'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '1';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
	
		when "0101" =>	 						--SW 
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := IR(11 downto 9);
			vRs2 := IR(8 downto 6);
			vRd := "000";
			vRf_en := '0';
			vRs1_dep := '0';		--actually dependent but no need to put stall because of this dependency
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '1';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '1'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
	
--put zero checker on output of IR
--use hazard detection to take input in S1 from ALU_output (incremented value)
		when "0110" =>	 				--LM	
			vRdMuxCtrl := '1';		--1 if from PE
			vRpe_mux_ctrl := '1';	--1 if LM/SM instruction
	
			vRs1 := IR(11 downto 9); 
			vRs2 :="000"; 
			vRd := "000";		--dont care case
			vRf_en := '1' and (not Rpe_zero_checker);
			vRs1_dep := '1';
			vRs2_dep := '0';
		
			vmem_read := '1'; 
			vmem_write := '0';
			vDout_mux_ctrl := '1';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '1';			-- +1 to be done
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
			vLM_SM_bit := '1' and (not Rpe_zero_checker);

--use hazard detection to take input in S1 from ALU_output (incremented value)
		when "0111" =>					 --SM		
			vRdMuxCtrl := '1';		--1 if from PE
			vRpe_mux_ctrl := '1';	--1 if LM/SM instruction
	
			vRs1 := IR(11 downto 9);
			vRs2 :="000"; 
			vRd := "000";
			vRf_en := '0';
			vRs1_dep := '1';
			vRs2_dep := '0';
		
			vmem_read := '0'; 
			vmem_write := '1' and (not Rpe_zero_checker);
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '1';				-- +1 to be done
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
			vLM_SM_bit := '1' and (not Rpe_zero_checker);
	
		when "1000" =>						--JAL 											//old PC value to be used!!!! not considered yet
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := "111"; 
			vRs2 :="000"; 
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '1';
			vRs2_dep := '0';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '1';				-- +1 to be done
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '1'; 
			vJLR_bit := '0';
	
		when "1001" =>						  --JLR
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := IR(8 downto 6);
			vRs2 := "111"; 
			vRd := IR(11 downto 9);
			vRf_en := '1';
			vRs1_dep := '1';
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "00";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "00"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '1';				-- +1 to be done
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '1';
	
		when "1100" =>						--BEQ
			vRdMuxCtrl := '0';		--1 if from PE
			vRpe_mux_ctrl := '0';	--1 if LM/SM instruction
	
			vRs1 := IR(8 downto 6); 
			vRs2 := IR(11 downto 9);
			vRd := "000";
			vRf_en := '0';
			vRs1_dep := '1';
			vRs2_dep := '1';
		
			vmem_read := '0'; 
			vmem_write := '0';
			vDout_mux_ctrl := '0';    --whether data from mem(1) or from alu_output(0)
		
			vALU_ctrl := "10";			--00 for add, 01 for NAND, 10 for XOR
			vALU_output_mux_ctrl:= "01"; --00 for Alu output, 01 for SE6, 10 for DE
			vC_en:= '0'; 
			vC_dep:= '0'; 
			vZ_en:= '0'; 
			vZ_dep:= '0'; 
			vALU_a_input_mux_ctrl:= '0'; --1 for SE6
	
			vS2_mux_ctrl:= '0';
			--vS1_mux_ctrl:= "00";
	
			vLoad_0 := '0';				--1 for LW
			--vZ_mux_ctrl := '0';			--probably not needed
	
			vJAL_bit := '0'; 
			vJLR_bit := '0';
	
		when others => 
			vRF_en := '0';		
									--do nothing --all control signals stay zero
	end case;

	--now assign the variables to the signals
		RdMuxCtrl <= vRdMuxCtrl;
		Rpe_mux_ctrl <= vRpe_mux_ctrl;	
		Rs1 <= vRs1; 
		Rs2 <= vRs2; 
		Rd <= vRd;
		Rf_en <= vRf_en;
		Rs1_dep <= vRs1_dep;
		Rs2_dep <= vRs2_dep;
	
		mem_read <= vmem_read; 
		mem_write <= vmem_write;
		Dout_mux_ctrl <= vDout_mux_ctrl;

		ALU_ctrl <= vALU_ctrl;			
		ALU_output_mux_ctrl <= vALU_output_mux_ctrl; 
		C_en <= vC_en; 
		C_dep <= vC_dep; 
		Z_en <= vZ_en; 
		Z_dep <= vZ_dep; 
		ALU_a_input_mux_ctrl <= vALU_a_input_mux_ctrl; 

		S2_mux_ctrl <= vS2_mux_ctrl;
		--S1_mux_ctrl <= vS1_mux_ctrl;

		Load_0 <= vLoad_0;				--1 for LW
		--Z_mux_ctrl <= vZ_mux_ctrl;			--probably not needed

		JAL_bit <= vJAL_bit; 
		JLR_bit <= vJLR_bit;
		LM_SM_bit <= vLM_SM_bit;
	
	end process;


end Behave;
      














