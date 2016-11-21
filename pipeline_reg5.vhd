

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;


entity pipeline_reg5 is
port(

	RF_enable_in:in std_logic;
	Rd_in : in std_logic_vector(2 downto 0);
	result_in:in std_logic_vector(15 downto 0);

	RF_enable_out:out std_logic;
	Rd_out: out std_logic_vector(2 downto 0);
	result_out:out std_logic_vector(15 downto 0);
	clk,enable,reset :in std_logic
);

end entity;


architecture Formula_Pipeline_reg5 of pipeline_reg5 is

begin
	
	dut_RF_enable_reg: DataRegister	generic map(data_width=>1)port map (Din(0)=> RF_enable_in,Dout(0) =>RF_enable_out,clk=>clk, enable=>enable,reset=>reset);

	dut_rd_reg: DataRegister
				generic map(data_width=>3)
				port map (Din=> Rd_in,
				      Dout => Rd_out,
				      clk=>clk, enable=>enable,reset=>reset);

	dut_result_reg: DataRegister
			generic map(data_width=>16)
			port map (Din=> result_in,
			      Dout => result_out,
			      clk=>clk, enable=>enable,reset=>reset);





end Formula_Pipeline_reg5;

