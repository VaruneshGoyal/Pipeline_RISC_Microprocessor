library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;



entity pipeline_reg2 is

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
end entity;

architecture Formula_Pipeline_reg2 of pipeline_reg2 is

begin

	
	dut_rd_reg: DataRegister
		generic map(data_width=>3)
		port map (Din=> Rd_in,
		      Dout => Rd_out,
		      clk=>clk, enable=>enable,reset=>reset);

	dut_rs1_reg: DataRegister
		generic map(data_width=>3)
		port map (Din=> Rs1_in,
		      Dout => Rs1_out,
		      clk=>clk, enable=>enable,reset=>reset);
	dut_rs2_reg: DataRegister
		generic map(data_width=>3)
		port map (Din=> Rs2_in,
		      Dout => Rs2_out,
		      clk=>clk, enable=>enable,reset=>reset);

	dut_pc_reg: DataRegister
		generic map(data_width=>16)
		port map (Din=> Pc_in,
		      Dout => Pc_out,
		      clk=>clk, enable=>enable,reset=>reset);
	dut_imm9_reg: DataRegister
			generic map(data_width=>9)
			port map (Din=> Imm9_in,
			      Dout => Imm9_out,
			      clk=>clk, enable=>enable,reset=>reset);

------------------------------------------------------------
	dut_RF_enable_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> RF_enable_in,Dout(0) =>RF_enable_out,clk=>clk, enable=>enable,reset=>reset);

	dut_Mem_write_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> Mem_write_in,Dout(0) =>Mem_write_out,clk=>clk, enable=>enable,reset=>reset);
	
	dut_Mem_read_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> Mem_read_in,Dout(0) =>Mem_read_out,clk=>clk, enable=>enable,reset=>reset);

	dut_Dout_mux_cntrl_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> Dout_mux_cntrl_in,Dout(0) =>Dout_mux_cntrl_out,clk=>clk, enable=>enable,reset=>reset);


-------------------------------------------------------------------------------
	dut_carry_enable_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> carry_enable_in,Dout(0) =>carry_enable_out,clk=>clk, enable=>enable,reset=>reset);

	dut_zero_enable_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> zero_enable_in,Dout(0) =>zero_enable_out,clk=>clk, enable=>enable,reset=>reset);

	dut_carry_dep_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> carry_dep_in,Dout(0) =>carry_dep_out,clk=>clk, enable=>enable,reset=>reset);

	dut_zero_dep_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> zero_dep_in,Dout(0) =>zero_dep_out,clk=>clk, enable=>enable,reset=>reset);

	dut_alu_output_mux_cntrl_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> alu_output_mux_cntrl_in,Dout(0) =>alu_output_mux_cntrl_out,clk=>clk, enable=>enable,reset=>reset);
--------------------------------------------------------------------
	dut_alu_cntrl_reg: DataRegister generic map(data_width=>2)port map (Din=>alu_cntrl_in,Dout=> alu_cntrl_out ,clk=>clk, enable=>enable,reset=>reset);

	dut_S2_mux_cntrl_reg: DataRegister generic map(data_width=>1)port map (Din(0)=>S2_mux_cntrl_in,Dout(0)=> S2_mux_cntrl_out ,clk=>clk, enable=>enable,reset=>reset);

-------------------------------------------------------------------------

	dut_alu_a_input_mux_cntrl_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> alu_a_input_mux_cntrl_in,Dout(0) =>alu_a_input_mux_cntrl_out,clk=>clk, enable=>enable,reset=>reset);

	
	dut_Load_0_out_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> Load_0_in,Dout(0) =>Load_0_out,clk=>clk, enable=>enable,reset=>reset);

	


--------------------------------------------------------------

dut_Rs1_dep_bit_reg: DataRegister generic map(data_width=>1)port map (Din(0)=>Rs1_dep_in,Dout(0) =>Rs1_dep_out,clk=>clk, enable=>enable,reset=>reset);

dut_Rs2_dep_bit_reg: DataRegister generic map(data_width=>1)port map (Din(0)=>Rs2_dep_in,Dout(0) =>Rs2_dep_out,clk=>clk, enable=>enable,reset=>reset);

----------------------------------------------------------------------------------

	dut_JAL_bit_reg: DataRegister generic map(data_width=>1)port map (Din(0)=>JAL_bit_in,Dout(0) =>JAL_bit_out,clk=>clk, enable=>enable,reset=>reset);

	dut_JLR_bit_reg: DataRegister generic map(data_width=>1)port map (Din(0)=>JLR_bit_in,Dout(0) =>JLR_bit_out,clk=>clk, enable=>enable,reset=>reset);


end Formula_Pipeline_reg2;

