library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package Microprocessor_project is
type Data_in is array (natural range <>) of std_logic_vector(15 downto 0);
type Data_in_2 is array (natural range <>) of std_logic_vector(1 downto 0);
type Data_in_3 is array (natural range <>) of std_logic_vector(2 downto 0);
type Data_in_8 is array (natural range <>) of std_logic_vector(7 downto 0);
type Data_in_9 is array (natural range <>) of std_logic_vector(8 downto 0);
type Data_in_1 is array (natural range <>) of std_logic_vector(0 downto 0);
--type FsmState is ( instruction_fetch, S2, S3, S4, S40, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);

component priority_encoder is
port(  
	x: in std_logic_vector(7 downto 0);
	y: out std_logic_vector(2 downto 0)
       
 );
end component;

component encode_modifier is
port( encode_bits : in std_logic_vector(2 downto 0);
      priority_bits_in : in std_logic_vector(7 downto 0);
      priority_bits_out	: out std_logic_vector( 7 downto 0)
	);

end component;


component decoder_pe is
port(  x: in std_logic_vector(2 downto 0);
	y: out std_logic_vector(7 downto 0)
	
       
 );
end component;

component DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable,reset: in std_logic);
end component;

component DataRegister_sp is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0) ;
	      clk, enable,imm_data_enable,reset: in std_logic);
end component;

--

component Data_MUX is
generic (control_bit_width:integer);
port(Din:in Data_in( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(15 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;

component Memory is
port ( Din: in std_logic_vector(15 downto 0);
	Dout: out std_logic_vector(15 downto 0);
	write_enable,read_enable,clk: in std_logic;
	Addr: in std_logic_vector(15 downto 0)
);
end component;

component Reg_File is

port( A1,A2,A3: in std_logic_vector(2 downto 0);
      D1, D2: out std_logic_vector(15 downto 0);
      write_enable,clk,reset: in std_logic;
      D3: in std_logic_vector( 15 downto 0);
      PC_data_in : in std_logic_vector(15 downto 0)
      
);
end component;

component ALU is
port( X,Y: in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0);
      carry_flag,zero_flag :out std_logic;
      Control_bits: in std_logic_vector(1 downto 0)
      
 );
end component;


component ALU_adder is
port(  
	x,y: in std_logic_vector(15 downto 0);
	c_in : in std_logic;
	s: out std_logic_vector(15 downto 0);
       	c_out: out std_logic
 );
end component;

component ALU_XOR is
port( X,Y: in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0)
 );
end component;

component ALU_NAND is
port( X,Y: in std_logic_vector(15 downto 0);
      Z : out std_logic_vector(15 downto 0)
 );
end component;

component full_adder is
port(  
	x,y,c_in: in std_logic;
	s, c_out: out std_logic
       
 );
end component;



component zero_checker is
port( X :in std_logic_vector(15 downto 0);
      Z:out std_logic
      
 );
end component;


component inverter is
port( X : in std_logic_vector(16 downto 0);
      Y : out std_logic_vector(16 downto 0)
 );
end component;

-- used to multiplex 8 bit data fed to priority encoder
component Data_MUX_8 is
generic (control_bit_width:integer);
port(Din:in Data_in_8( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(7 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;
--- used to multiplex 3 bit data fed to A1 RF
component Data_MUX_3 is
generic (control_bit_width:integer);
port(Din:in Data_in_3( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(2 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;

--- used to multiplex 2 bit data
component Data_MUX_2 is
generic (control_bit_width:integer);
port(Din:in Data_in_2( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(1 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;

component Data_MUX_9 is
generic (control_bit_width:integer);
port(Din:in Data_in_9( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(9 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;

--data extender
component data_extender_9to16 is
port(
	x: in std_logic_vector(8 downto 0);
	y: out std_logic_vector( 15 downto 0)
);
end component;

--sign extender 6 to 16
component sign_extender_6to16 is
port(
	x: in std_logic_vector(5 downto 0);
	y: out std_logic_vector( 15 downto 0)
);
end component;
--sign extender 6 to 16
component sign_extender_9to16 is
port(
	x: in std_logic_vector(8 downto 0);
	y: out std_logic_vector( 15 downto 0)
);
end component;

--data mux for zero flag
component Data_MUX_1 is
generic (control_bit_width:integer);
port(Din:in Data_in_1( (2**control_bit_width)-1 downto 0);
	Dout:out std_logic_vector(0 downto 0);
	control_bits:in std_logic_vector(control_bit_width-1 downto 0)
);
end component;

component pipeline_reg1 is

port(
	Instr_in :in std_logic_vector( 15 downto 0);
	Pc_in : in std_logic_vector( 15 downto 0);

	Instr_out:out std_logic_vector( 15 downto 0);
	Pc_out:out std_logic_vector( 15 downto 0);

	clk,enable,imm_data_enable,reset :in std_logic
);
end component;

component pipeline_reg2 is

port(	Rd_in : in std_logic_vector(2 downto 0);
	Rs1_in : in std_logic_vector(2 downto 0);
	Rs2_in : in std_logic_vector(2 downto 0);
	Imm9_in :in std_logic_vector( 8 downto 0);
	Pc_in : in std_logic_vector( 15 downto 0);

	RF_enable_in,Mem_write_in,Mem_read_in,Dout_mux_cntrl_in:in std_logic;
	carry_enable_in,zero_enable_in,carry_dep_in,zero_dep_in,alu_output_mux_cntrl_in: in std_logic;
	alu_cntrl_in : in std_logic_vector(1 downto 0);
	S2_mux_cntrl_in :in std_logic;
	alu_a_input_mux_cntrl_in,Load_0_in:in std_logic;
	Rs1_dep_in,Rs2_dep_in:in std_logic;
	JAL_bit_in,JLR_bit_in:in std_logic;

	Rd_out : out std_logic_vector(2 downto 0);
	Rs1_out : out std_logic_vector(2 downto 0);
	Rs2_out : out std_logic_vector(2 downto 0);
	Imm9_out :out std_logic_vector( 8 downto 0);
	Pc_out : out std_logic_vector( 15 downto 0);

	RF_enable_out,Mem_write_out,Mem_read_out,Dout_mux_cntrl_out: out std_logic;
	carry_enable_out,zero_enable_out,carry_dep_out,zero_dep_out,alu_output_mux_cntrl_out: out std_logic;
	alu_cntrl_out : out std_logic_vector(1 downto 0);
	S2_mux_cntrl_out :out std_logic;
	alu_a_input_mux_cntrl_out,Load_0_out:out std_logic;
	Rs1_dep_out,Rs2_dep_out:out std_logic;
	JAL_bit_out,JLR_bit_out:out std_logic;

	clk,enable,reset :in std_logic
);
end component;


component pipeline_reg3 is

port(
	Rd_in : in std_logic_vector(2 downto 0);
	Rs1_in : in std_logic_vector(2 downto 0);
	Rs2_in : in std_logic_vector(2 downto 0);
	S1_in, S2_in: in std_logic_vector( 15 downto 0);
	Imm9_in :in std_logic_vector( 8 downto 0);
	RF_enable_in,Mem_write_in,Mem_read_in,Dout_mux_cntrl_in:in std_logic;
	carry_enable_in,zero_enable_in,carry_dep_in,zero_dep_in,alu_output_mux_cntrl_in: in std_logic;
	alu_cntrl_in: in std_logic_vector(1 downto 0);
	alu_a_input_mux_cntrl_in,Load_0_in:in std_logic;
	Rs1_dep_in,Rs2_dep_in:in std_logic;


	Rd_out : out std_logic_vector(2 downto 0);
	Rs1_out:out std_logic_vector(2 downto 0);
	Rs2_out:out std_logic_vector(2 downto 0);
	Imm9_out:out std_logic_vector( 8 downto 0);
	S1_out, S2_out: out std_logic_vector( 15 downto 0);
	RF_enable_out,Mem_write_out,Mem_read_out,Dout_mux_cntrl_out: out std_logic;
	carry_enable_out,zero_enable_out,carry_dep_out,zero_dep_out,alu_output_mux_cntrl_out: out std_logic;
	alu_cntrl_out: out std_logic_vector(1 downto 0);
	
	alu_a_input_mux_cntrl_out,Load_0_out:out std_logic;
	Rs1_dep_out,Rs2_dep_out:out std_logic;

	clk,enable,reset :in std_logic
);

end component;

component pipeline_reg4 is
port(
	alu_cntrl_1_in :in std_logic;
	Rd_in : in std_logic_vector(2 downto 0);
	Rs1_in : in std_logic_vector(2 downto 0);
	Rs2_in : in std_logic_vector(2 downto 0);
	S1_in, S2_in: in std_logic_vector( 15 downto 0);
	RF_enable_in,Mem_write_in,Mem_read_in,Dout_mux_cntrl_in:in std_logic;
	Load_0_in:in std_logic;
	alu_result_in:in std_logic_vector(15 downto 0);
	alu_z_output_in :in std_logic;

	alu_cntrl_1_out:out std_logic;
	Rd_out: out std_logic_vector(2 downto 0);
	Rs1_out:out std_logic_vector(2 downto 0);
	Rs2_out:out std_logic_vector(2 downto 0);
	S1_out, S2_out:out std_logic_vector( 15 downto 0);
	RF_enable_out,Mem_write_out,Mem_read_out,Dout_mux_cntrl_out: out std_logic;
	Load_0_out:out std_logic;
	alu_result_out:out std_logic_vector(15 downto 0);
	alu_z_output_out:out std_logic;

	clk,enable,reset :in std_logic
	);

end component;

component pipeline_reg5 is
port(

	RF_enable_in:in std_logic;
	Rd_in : in std_logic_vector(2 downto 0);
	result_in:in std_logic_vector(15 downto 0);

	RF_enable_out:out std_logic;
	Rd_out: out std_logic_vector(2 downto 0);
	result_out:out std_logic_vector(15 downto 0);
	clk,enable,reset :in std_logic
);

end component;

component InstructionDecode is
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
end component;

component Control_Hazard is
	port ( BEQ_bit_4 : in std_logic; --the alu_signal(1) bit
			JAL_bit_2, JLR_bit_2 : in std_logic;
			Rd_3, Rd_4 : in std_logic_vector(2 downto 0);
			mem_read_4 : in std_logic;
			reset_1, reset_2, reset_3, reset_4 : out std_logic;
			incrementor_mux_ctrl : out std_logic_vector(1 downto 0);
			PC_mux_ctrl : out std_logic_vector(1 downto 0);
			C_en, Z_en : out std_logic );
end component;

component Data_Hazard is
	port ( 	Rs1_2, Rs2_2, Rs1_3 : in std_logic_vector(1 downto 0);
			Rd_3, Rd_4, Rd_5 : in std_logic_vector(1 downto 0); 
			Load_0_4 : in std_logic;
			RF_en_3, RF_en_4, RF_en_5 : in std_logic;
			mem_write_3: in std_logic;
			DH1, DH2 : out std_logic_vector(1 downto 0);
			DH3: out std_logic
			);
end component;

component Load_hazard is
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
		reset_4: out std_logic	);
end component;


component IITB_RISC_Microprocessor is
port(
clk,reset:in std_logic
--from_memory_data: in std_logic_vector(15 downto 0);
--to_memory_address: out std_logic_vector(15 downto 0);
--mem_read_en_sig, mem_write_en_sig : out std_logic 
);
end component;



end package;

