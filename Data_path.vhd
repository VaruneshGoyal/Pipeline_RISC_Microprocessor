library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;



entity Data_path is 

port (clk:in std_logic;
	reset:in std_logic
);



end Data_path;


architecture Formula_Data_Path of Data_Path is

signal unused_port_16b :std_logic_vector(15 downto 0) := (others =>'Z');
signal constant_sig_1 :std_logic_vector(15 downto 0) := (0=>'1' , others =>'0');
--------------PC signals ------------------------
signal pc_enable:std_logic;
signal pc_reg_in,pc_reg_out :std_logic_vector(15 downto 0);
-------------PC_mux_signal -------------------
signal pc_mux_cntrl :std_logic_vector(1 downto 0);
---------------PC_adder signals ----------------
signal pc_adder_out:std_logic_vector(15 downto 0);
signal pc_adder_carry:std_logic;
-------------PC_adder_mux_signal -------------------
signal pc_adder_mux_cntrl :std_logic_vector(1 downto 0);
signal pc_adder_mux_out :std_logic_vector(15 downto 0);
----------------Instruction Memory signals ----------

signal Instr_mem_out :std_logic_vector(15 downto 0);
-------------------------Priority Encoder signal --------

signal pe_out :std_logic_vector(2 downto 0);
------------------------Priority modify logic modify signals

signal pe_modify_logic_out:std_logic_vector(7 downto 0);

---------------PE_mux signals

signal PE_mux_out:std_logic_vector(8 downto 0);
-------------------------------------------------------------
-----------------------Pipeline 1 signals -------------------
-------------------------------------------------------------
signal Pipe1_Instr_out,Pipe1_PC_out :std_logic_vector(15 downto 0);
signal pipe1_enable,pipe1_imm_data_enable, pipe2_reset:std_logic;

----------------------------Instruction Decoder signals -------

signal Rd_mux_cntrl:std_logic;
signal Rs1_stage2 , Rs2_stage2 ,Rd_stage2 :std_logic_vector(2 downto 0);
signal  RF_enable_stage2 ,mem_read_stage2, mem_write_stage2: std_logic;
signal Dout_mux_cntrl_stage2:std_logic;
signal ALU_cntrl_stage2,ALU_output_mux_cntrl_stage2: std_logic_vector(1 downto 0);
signal C_en_stage2 , Z_en_stage2 , C_dep_stage2, Z_dep_stage2 : std_logic;
signal ALU_a_input_mux_cntrl_stage2,S2_mux_cntrl_stage2:std_logic;
signal Load_0_stage2,JAL_bit_stage2, JLR_bit_stage2,  LM_SM_bit_stage2:std_logic;

-------------------- rpe zero checker signals----------------------

signal rpe_zero_checker_output :std_logic;
----------------------------RD Mux signals -------------------
signal Rd_mux_out :std_logic_vector(2 downto 0);
-----------------------------------------------------------
-------------------------Pipeline 2 signals ---------------
----------------------------------------------------------

signal Rd_stage3,Rs1_stage3,Rs2_stage3 :std_logic_vector(2 downto 0);
signal Pipe2_Imm9_out:std_logic_vector(8 downto 0);
signal Pipe2_PC_out : std_logic_vector(15 downto 0);
signal RF_enable_stage3,mem_write_stage3,mem_read_stage3, Dout_mux_cntrl_stage3 :std_logic;
signal C_en_stage3 , Z_en_stage3 , C_dep_stage3, Z_dep_stage3 : std_logic;
signal ALU_a_input_mux_cntrl_stage3,S2_mux_cntrl_stage3:std_logic;
signal ALU_cntrl_stage3,ALU_output_mux_cntrl_stage3:std_logic_vector(1 downto 0);
signal Load_0_stage3,JAL_bit_stage3, JLR_bit_stage3 :std_logic;
signal pipe2_enable,pipe2_reset :std_logic;


	
	
	
	




















begin
-----------------------PC register ---------------------
	dut_pc: DataRegister
		generic map(data_width=>16);
		port map(Din => pc_reg_in,
		      Dout=>pc_reg_out,
		      clk => clk, enable=>pc_enable,reset => reset);
--#############-----------------PC _MUX -------------------------------------

	dut_pc_mux: Data_MUX 
		generic map (control_bit_width =>2);
		port(Din(0) =>pc_adder_out ,Din(1)=> ,Din(2)=>, Din(3) => ## D1 from reg_file,
			Dout =>pc_reg_in,
			control_bits => pc_mux_cntrl
		);

-- -----------------PC_adder-------------------------
	dut_pc_adder: ALU_adder 
	port map(  
		x =>pc_adder_mux_out ,y => pc_reg_out,
		c_in =>'0',
		s => pc_adder_out,
	       	c_out => pc_adder_carry
	 );

---#####------------------------PC_adder_mux ----------------

	dut_pc_adder_mux: Data_MUX 
			generic map (control_bit_width =>2);
			port map(Din(0) =>constant_sig_1 ,Din(1)=> ,Din(2)=>, Din(3) => ## alu output from pipeline4,
				Dout =>pc_adder_mux_out,
				control_bits => pc_adder_mux_cntrl
			);
-------------------------Instruction mem------------------
	dut_instruction_mem: Memory 
	port map ( Din => unused_port_16b,
		Dout => Instr_mem_out,
		write_enable =>'0',read_enable =>'1',clk =>clk,
		Addr => pc_reg_out
	);
---------------PE_mux------------------------
	
	component Data_MUX_9 is
	generic map (control_bit_width =>1);
	port(Din(0) => Instr_mem_out(8 downto 0),Din(1)(7 downto 0) =>pe_modify_logic_out,Din(1)(8) => pe_modify_logic_out(7),
		Dout=>PE_mux_out,
		control_bits => PE_mux_cntrl
	);
	
 -----------------------PE-----------
	
	dut_pe: priority_encoder 
	port map(  
		x => Pipe1_Instr_out(8 downto 0),
		y =>pe_out
	    	 );
------------PE_modify_logic ------------
	dut_pe_modify_logic:  encode_modifier 
	port map( encode_bits =>pe_out,
	      priority_bits_in  => Pipe1_Instr_out(8 downto 0),
	      priority_bits_out	=> pe_modify_logic_out
		);
---------------------------------------------------------
--------------------PipeLine Register 1 -----------------
---------------------------------------------------------

dut_pipeline_reg1: pipeline_reg1 is

port map(
	Instr_in(15 downto 9) => Instr_mem_out(15 downto 9),
	Instr_in(8 downto 0) => PE_mux_out
	Pc_in =>pc_reg_out,

	Instr_out => Pipe1_Instr_out,
	Pc_out =>Pipe1_PC_out,

	clk =>clk,enable => pipe1_enable,imm_data_enable => pipe1_imm_data_enable,reset=>pipe1_reset);

----------------------- Instruction Decoder ----------------
	dut_Instr_dec: InstructionDecode is
	port map(   IR => Pipe1_Instr_out		--IR = InstructionRegister
			Rpe_zero_checker  => rpe_zero_checker_output,
	     		RdMuxCtrl  => Rd_mux_cntrl,
			Rpe_mux_ctrl=>PE_mux_cntrl,

			Rs1 => Rs1_stage2, Rs2 => Rs2_stage2, Rd=> Rd_stage2 ,
			Rf_en => RF_enable_stage2,
	
			mem_read => mem_read_stage2, mem_write => mem_write_stage2,
			Dout_mux_ctrl=>Dout_mux_cntrl_stage2    --whether data from mem or from alu_output
	
			ALU_ctrl => ALU_cntrl_stage2,
			ALU_output_mux_ctrl =>ALU_output_mux_cntrl_stage2, 
			C_en =>C_en_stage2, C_dep =>C_dep_stage2, Z_en => Z_en_stage2, Z_dep=> Z_dep_stage2 , 
			ALU_a_input_mux_ctrl =>ALU_a_input_mux_cntrl_stage2,

			S2_mux_ctrl => S2_mux_cntrl_stage2,
			--S1_mux_ctrl : std_logic_vector(1 downto 0);

			Load_0 => Load_0_stage2,
			--Z_mux_ctrl : std_logic;

			JAL_bit => JAL_bit_stage2, JLR_bit=> JLR_bit_stage2, LM_SM_bit => LM_SM_bit_stage2  );
------------------------zero checker -----------------------
	dut_zero_checker: zero_checker is
	port( X (8 downto 0) => Pipe1_Instr_out(8 downto 0),
	      X(15 downto 9) => "0000000",
	      Z => rpe_zero_checker_output
	      
	 );
--------------------------Rd_mux ------------------
	dut_Rd_mux: Data_MUX_3 is
	generic map(control_bit_width => 1)
	port map(Din(0) => Rd_stage2, Din(1) => pe_out, 
		Dout=> Rd_mux_out,
		control_bits=>Rd_mux_cntrl
	); 

-------------------------------------------------------------
-----------------------Pipe line 2---------------------------
-------------------------------------------------------------

dut_pipe2: pipeline_reg2 

port map(	Rd_in => Rd_mux_out,
	Rs1_in=> Rs1_stage2,
	Rs2_in => Rs2_stage2,
	Imm9_in :Pipe1_Instr_out( 8 downto 0),
	Pc_in : Pipe1_PC_out( 15 downto 0),

	RF_enable_in => RF_enable_stage2,
	Mem_write_in => mem_write_stage2mem_read_stage2,
	Mem_read_in => mem_read_stage2,
	Dout_mux_cntrl_in=>Dout_mux_cntrl_stage2,
	carry_enable_in => C_en_stage2,
	zero_enable_in =>Z_en_stage2,
	carry_dep_in => C_dep_stage2,
	zero_dep_in => Z_dep_stage2,
	alu_output_mux_cntrl_in => ALU_output_mux_cntrl_stage2,
	alu_cntrl_in => ALU_cntrl_stage2,
	S2_mux_cntrl_in =>  S2_mux_cntrl_stage2
	alu_a_input_mux_cntrl_in =>  ALU_a_input_mux_cntrl_stage2,
	Load_0_in => Load_0_stage2,
	
	
	JAL_bit_in => JAL_bit_stage2,
	JLR_bit_in => JAL_bit_stage2,

	Rd_out => Rd_stage3,
	Rs1_out => Rs1_stage3,
	Rs2_out => Rs2_stage3,
	Imm9_out => Pipe2_Imm9_out,
	Pc_out => Pipe2_PC_out,

	RF_enable_out => RF_enable_stage3,
	Mem_write_out=> mem_write_stage3,
	Mem_read_out =>mem_read_stage3,
	Dout_mux_cntrl_out => Dout_mux_cntrl_stage3,
	carry_enable_out => C_en_stage3,
	zero_enable_out=> Z_en_stage3,
	carry_dep_out => C_dep_stage3,
	zero_dep_out => Z_dep_stage3,
	alu_output_mux_cntrl_out => ALU_output_mux_cntrl_stage3,

	alu_cntrl_out=> ALU_cntrl_stage3,
	S2_mux_cntrl_out => S2_mux_cntrl_stage3,

	alu_a_input_mux_cntrl_out=> ALU_a_input_mux_cntrl_stage3,
	Load_0_out => Load_0_stage3,

	JAL_bit_out => JAL_bit_stage3,
	JLR_bit_out => JAL_bit_stage3,

	clk =>clk,enable=> pipe2_enable,reset => pipe2_reset
);



end Formula_Data_Path;




























