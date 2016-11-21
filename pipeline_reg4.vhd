
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;


entity pipeline_reg4 is
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

end entity;


architecture Formula_Pipeline_reg4 of pipeline_reg4 is

begin

	dut_alu_cntrl_1_reg: DataRegister
				generic map(data_width=>1)
				port map (Din(0)=> alu_cntrl_1_in,
				      Dout(0) => alu_cntrl_1_out,
				      clk=>clk, enable=>enable,reset=>reset);

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


	dut_S1_reg: DataRegister
				generic map(data_width=>16)
				port map (Din=> S1_in,
				      Dout => S1_out,
				      clk=>clk, enable=>enable,reset=>reset);

	dut_S2_reg: DataRegister
			generic map(data_width=>16)
			port map (Din=> S2_in,
			      Dout => S2_out,
			      clk=>clk, enable=>enable,reset=>reset);

	dut_alu_result_reg: DataRegister
			generic map(data_width=>16)
			port map (Din=> alu_result_in,
			      Dout => alu_result_out,
			      clk=>clk, enable=>enable,reset=>reset);

	dut_alu_z_output_reg: DataRegister
			generic map(data_width=>16)
			port map (Din(0)=> alu_z_output_in,
			      Dout(0) => alu_z_output_out,
			      clk=>clk, enable=>enable,reset=>reset);
--------------------------------------------------------------------------------------------

dut_RF_enable_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> RF_enable_in,Dout(0) =>RF_enable_out,clk=>clk, enable=>enable,reset=>reset);

	dut_Mem_write_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> Mem_write_in,Dout(0) =>Mem_write_out,clk=>clk, enable=>enable,reset=>reset);
	
	dut_Mem_read_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> Mem_read_in,Dout(0) =>Mem_read_out,clk=>clk, enable=>enable,reset=>reset);

	dut_Dout_mux_cntrl_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> Dout_mux_cntrl_in,Dout(0) =>Dout_mux_cntrl_out,clk=>clk, enable=>enable,reset=>reset);

-----------------------------------------------------------------------------------------------

dut_Load_0_out_reg: DataRegister generic map(data_width=>1)port map (Din(0)=> Load_0_in,Dout(0) =>Load_0_out,clk=>clk, enable=>enable,reset=>reset);



end Formula_Pipeline_reg4;
