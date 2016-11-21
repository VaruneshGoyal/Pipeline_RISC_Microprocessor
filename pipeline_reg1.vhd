library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity pipeline_reg1 is

port(
	Instr_in :in std_logic_vector( 15 downto 0);
	Pc_in : in std_logic_vector( 15 downto 0);

	Instr_out:out std_logic_vector( 15 downto 0);
	Pc_out:out std_logic_vector( 15 downto 0);

	clk,enable,imm_data_enable,reset :in std_logic
);
end entity;

architecture Formula_Pipeline_reg1 of pipeline_reg1 is

begin

	dut_instr_reg: DataRegister_sp
		generic map(data_width=>16)
		port map(Din=> Instr_in,
		      Dout=>Instr_out,
		      clk=>clk, enable=>enable,imm_data_enable=>imm_data_enable,reset=>reset);

	dut_pc_reg: DataRegister
		generic map(data_width=>16)
		port map (Din=> Pc_in,
		      Dout => Pc_out,
		      clk=>clk, enable=>enable,reset=>reset);


end Formula_Pipeline_reg1;

