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

---------------Instruction_mem_mux signals

signal Instr_mem_mux_out:std_logic_vector(8 downto 0);

-----------------------Pipeline 1 signals -------------------
signal Pipe1_Instr_out,Pipe1_PC_out :std_logic_vector(15 downto 0);
signal pipe1_enable,pipe1_imm_data_enable:std_logic;

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
		port(Din(0) =>pc_adder_out ,Din(1)=> ,Din(2)=>, Din(3) => unused_port_16b,
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
			port map(Din(0) =>constant_sig_1 ,Din(1)=> ,Din(2)=>, Din(3) => ,
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
---------------Instruction_mem_mux------------------------
	
	component Data_MUX_9 is
	generic map (control_bit_width =>1);
	port(Din(0) => Instr_mem_out(8 downto 0),Din(1)(7 downto 0) =>pe_modify_logic_out,Din(1)(8) => pe_modify_logic_out(7),
		Dout=>Instr_mem_mux_out,
		control_bits => Instr_mem_mux_cntrl
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
	Instr_in(8 downto 0) => Instr_mem_mux_out
	Pc_in =>pc_reg_out,

	Instr_out => Pipe1_Instr_out,
	Pc_out =>Pipe1_PC_out,

	clk =>clk,enable => pipe1_enable,imm_data_enable => pipe1_imm_data_enable,reset=>reset);




end Formula_Data_Path;




























