library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity InstructionDecode is
port( IR: in std_logic_vector(15 downto 0);		--IR = InstructionRegister
      Rs1, Rs2, Rd : out std_logic_vector(2 downto 0);
	  EX  --
	  RR  --
	  MA  --
	  RF_en : out
	  Immediate : out std_logic_vector(8 downto 0);
	  Rpe_zero : in std_logic;
	  --PC_in : in std_logic_vector(15 downto 0);
	  --PC_out : out std_logic_vector(15 downto 0)
 );
end InstructionDecode;


architecture Behave of InstructionDecode is

begin
	process(IR, Rpe_zero)
      variable vRs1, vRs2, vRd : std_logic_vector(2 downto 0);
	  variable vImmediate : std_logic_vector(8 downto 0);

	  variable vincrementor_mux_ctrl : std_logic_vector(1 downto 0);
	  variable vRpe_mux_ctrl : std_logic;

	  variable vRdMuxCtrl : std_logic;

	  variable vS2_mux_ctrl : std_logic;
	  variable vS1_mux_ctrl : std_logic_vector(1 downto 0);

	  variable vALU_signal : std_logic_vector(1 downto 0);
	  variable vALU_output_mux, vC_en, vC_dep, vZ_en, vZ_dep : std_logic; 

	  variable vmem_read, vmem_write : std_logic;
	  variable vDout_mux_ctrl : std_logic;    --whether data from mem or from alu_output

	  variable vRf_en : std_logic;
	

	begin
	--defaults
	vRs1 := "000"; vRs2 := "000"; vRd := "000";
	vImmediate := "000000000";

	vincrementor_mux_ctrl := "00";
	vRpe_mux_ctrl := '0';

	vRdMuxCtrl := '0';

	vS2_mux_ctrl := '0';
	vS1_mux_ctrl := "00";

	vALU_signal := "00";
	vALU_output_mux:='0'; vC_en:='0'; vC_dep :='0'; vZ_en := '0'; vZ_dep := '0';

	vmem_read := '0'; vmem_write := '0';
	vDout_mux_ctrl :='0';

	vRf_en := '0'; 

	if(IR(15 downto 12) = "0000") then	--ADD done
		vRs1 := IR(5 downto 3);
		vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		--vImmediate := "000000000";
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		--vS2_mux_ctrl := '0';
		--vS1_mux_ctrl := "00";

		--vALU_signal := "00";
		--vALU_output_mux := '0';
		vC_en := '1'; vZ_en := '1';
		
		if(IR(0) = '1')
			vZ_dep := '1';
		elsif (IR(1) = '1')
			vC_dep := '1';
		end if;

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 

	elsif(IntructionReg(15 downto 12) = "0001") then --ADI
		--vRs1 := IR(5 downto 3);
		vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		--vS2_mux_ctrl := '0';
		vS1_mux_ctrl := "10";

		--vALU_signal := "00";
		--vALU_output_mux := '0';
		vC_en := '1'; vZ_en := '1';
		--vZ_dep := '0'; vC_dep := '0';

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 

	elsif(IntructionReg(15 downto 12) = "0010") then --NDU
		vRs1 := IR(5 downto 3);
		vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		--vImmediate := "000000000";
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		--vS2_mux_ctrl := '0';
		--vS1_mux_ctrl := "00";

		vALU_signal := "01";
		--vALU_output_mux := '0';
		vC_en := '1'; vZ_en := '1';
		
		if(IR(0) = '1')
			vZ_dep := '1';
		elsif (IR(1) = '1')
			vC_dep := '1';
		end if;

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 

	elsif(IntructionReg(15 downto 12) = "0011") then --LHI
		--vRs1 := IR(5 downto 3);
		--vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		--vS2_mux_ctrl := '0';
		--vS1_mux_ctrl := "00";

		--vALU_signal := "00";
		vALU_output_mux := '1';
		vC_en := '0'; vZ_en := '0';
		--vZ_dep := '0'; vC_dep := '0';

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 


	elsif(IntructionReg(15 downto 12) = "0100") then --LW
		--vRs1 := IR(5 downto 3);
		vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		vS2_mux_ctrl := '0';
		vS1_mux_ctrl := "10";

		vALU_signal := "00";
		vALU_output_mux := '0';
		--vC_en := '1'; 
		vZ_en := '1';
		--vZ_dep := '0'; vC_dep := '0';

		vmem_read := '1'; vmem_write := '0';
		vDout_mux_ctrl :='1';

		vRf_en := '1'; 

	--!!!!!!!!!!!!!!!!INCORRECT!!!!!!!!!!!!!!!!!!!!!!!!!!!	NEED TO ADD MUX JUST BEFORE ALU. ADD CONTROL SIGNALS FOR IT.
	elsif(IntructionReg(15 downto 12) = "0101") then --SW 
		vRs1 := IR(11 downto 9);
		vRs2 := IR(6 downto 8);
		--vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		vS2_mux_ctrl := '0';
		vS1_mux_ctrl := "10";

		vALU_signal := "00";
		vALU_output_mux := '0';
		--vC_en := '1'; vZ_en := '1';
		--vZ_dep := '0'; vC_dep := '0';

		vmem_read := '0'; vmem_write := '1';
		--vDout_mux_ctrl :='0';

		--vRf_en := '0'; 

	elsif(IntructionReg(15 downto 12) = "0110") then --LM		//use hazard detection to take input in S1 from ALU_output (incremented value)
		vRs1 := IR(11 downto 9);
		--vRs2 := IR(6 downto 8);
		--vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		vRpe_mux_ctrl := '1';

		vRdMuxCtrl := '1';			--destination decided by PE

		vS2_mux_ctrl := '1';		--+1 to be done
		vS1_mux_ctrl := "00";

		vALU_signal := "00";
		vALU_output_mux := '0';
		--vC_en := '0'; 
		--vZ_en := '0';
		--vZ_dep := '0'; vC_dep := '0';

		vmem_read := '1'; vmem_write := '0';
		vDout_mux_ctrl :='1';

		vRf_en := '1'; 

	--!!!!!!!!!!!!!!!!INCORRECT!!!!!!!!!!!!!!!!!!!!!!!!!!!	
	elsif(IntructionReg(15 downto 12) = "0111") then --SM		//use hazard detection to take input in S1 from ALU_output (incremented value)
		vRs1 := IR(11 downto 9);
		--vRs2 := IR(6 downto 8);
		--vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		vRpe_mux_ctrl := '1';

		vRdMuxCtrl := '1';			--destination decided by PE

		vS2_mux_ctrl := '1';		--+1 to be done
		vS1_mux_ctrl := "00";

		vALU_signal := "00";
		vALU_output_mux := '0';
		--vC_en := '0'; vZ_en := '0';
		--vZ_dep := '0'; vC_dep := '0';

		vmem_read := '0'; vmem_write := '1';
		--vDout_mux_ctrl :='0';

		vRf_en := '0'; 

	elsif(IntructionReg(15 downto 12) = "1000") then --JAL 
		vRs1 := "111";		--PC
		--vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		vincrementor_mux_ctrl := "10";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		vS2_mux_ctrl := '1';		--+1 to be done to PC
		--vS1_mux_ctrl := "00";

		vALU_signal := "00";
		vALU_output_mux := '0';
		--vC_en := '0'; vZ_en := '0';
		--vZ_dep := '0'; vC_dep := '0';

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 

	elsif(IntructionReg(15 downto 12) = "1001") then  --JLR
		vRs1 := IR(8 downto 6);
		vRs2 := "111";
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		vS2_mux_ctrl := '0';
		vS1_mux_ctrl := "00";

		vALU_signal := "00";
		vALU_output_mux := '0';
		vC_en := '1'; vZ_en := '1';
		--vZ_dep := '0'; vC_dep := '0';

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 

	elsif(IntructionReg(15 downto 12) = "1100") then
		--vRs1 := IR(5 downto 3);
		vRs2 := IR(6 downto 8);
		vRd := IR(11 downto 9);
		vImmediate := IR(8 downto 0);
	
		--vincrementor_mux_ctrl := "00";
		--vRpe_mux_ctrl := '0';

		--vRdMuxCtrl := '0';

		vS2_mux_ctrl := '0';
		vS1_mux_ctrl := "00";

		vALU_signal := "00";
		vALU_output_mux := '0';
		vC_en := '1'; vZ_en := '1';
		--vZ_dep := '0'; vC_dep := '0';

		--vmem_read := '0'; vmem_write := '0';
		--vDout_mux_ctrl :='0';

		vRf_en := '1'; 


end Behave;
      
