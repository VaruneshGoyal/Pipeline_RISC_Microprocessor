library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity IITB_RISC_Microprocessor is
port(
clk,reset:in std_logic
--from_memory_data: in std_logic_vector(15 downto 0);
--to_memory_address: out std_logic_vector(15 downto 0);
--mem_read_en_sig, mem_write_en_sig : out std_logic 
);
end entity;

architecture Formula of IITB_RISC_Microprocessor is


signal RF_write_en_sig,RF_pc_en_sig: std_logic;
signal t1_mux_cntrl0_sig ,t1_mux_cntrl1_sig :std_logic;
signal t2_mux_cntrl_sig : std_logic;
signal IR_en_sig :std_logic;
signal pc_mux_cntrl_sig :std_logic;
signal t1_en_sig, t2_en_sig :std_logic;
signal A1_RF_mux_cntrl0_sig, A1_RF_mux_cntrl1_sig:std_logic;
signal  A3_RF_mux_cntrl_sig:std_logic;
signal D3_RF_mux_cntrl0_sig, D3_RF_mux_cntrl1_sig:std_logic;
signal pe_mux_cntrl_sig :std_logic;
signal rpe_en_sig:  std_logic;
signal  alu_mux_upper_cntrl0_sig , alu_mux_upper_cntrl1_sig:std_logic;
signal alu_mux_lower_cntrl0_sig , alu_mux_lower_cntrl1_sig :std_logic;
signal carry_reg_en_sig, zero_reg_en_sig: std_logic;
signal t3_mux_cntrl0_sig, t3_mux_cntrl1_sig:std_logic;
signal t3_en_sig :std_logic;
signal mem_addr_mux_cntrl_sig:std_logic;
signal mem_read_en_sig,mem_write_en_sig :std_logic;
signal z_mux_cntrl_sig:std_logic;
signal Alu_signal_mux_ctrl_sig :std_logic;
signal instr_reg_out_sig :std_logic_vector(15 downto 0);
signal S1_decoder_output_sig :std_logic_vector(3 downto 0);
signal S2_decoder_output_sig :std_logic_vector(3 downto 0);
signal S3_decoder_output_sig :std_logic_vector(3 downto 0);
signal S6_decoder_output_sig :std_logic_vector(3 downto 0);
signal S14_decoder_output_sig :std_logic_vector(3 downto 0);
signal S11_decoder_output_sig :std_logic_vector(3 downto 0);


begin

dut_control_path : IITB_RISC_Controlpath 
	port map (
		
		carry_en => carry_reg_en_sig, zero_en=> zero_reg_en_sig,
		mem_read_en => mem_read_en_sig, mem_write_en =>mem_write_en_sig, mem_address_mux_ctrl => mem_addr_mux_cntrl_sig,	
		IR_en => IR_en_sig,							
		Rpe_mux_ctrl => pe_mux_cntrl_sig,
		D3_mux_ctrl(0) => D3_RF_mux_cntrl0_sig , D3_mux_ctrl(1) => D3_RF_mux_cntrl1_sig,
		A1_mux_ctrl(0) => A1_RF_mux_cntrl0_sig,A1_mux_ctrl(1) => A1_RF_mux_cntrl1_sig, 
		A3_mux_ctrl => A3_RF_mux_cntrl_sig,
		R7_mux_ctrl => pc_mux_cntrl_sig,
		RegFile_write=>RF_write_en_sig, PC_write =>RF_pc_en_sig,
		T1_mux_ctrl(0) => t1_mux_cntrl0_sig ,T1_mux_ctrl(1) => t1_mux_cntrl1_sig,	
		T1_en => t1_en_sig,
		T2_mux_ctrl=> t2_mux_cntrl_sig,
		T2_en => t2_en_sig,
		Rpe_en => rpe_en_sig,
		Z_mux_ctrl => z_mux_cntrl_sig,
		Alu_uppermux_ctrl(0)=> alu_mux_upper_cntrl0_sig, Alu_uppermux_ctrl(1)=> alu_mux_upper_cntrl1_sig,
		Alu_lowermux_ctrl(0) => alu_mux_lower_cntrl0_sig, Alu_lowermux_ctrl(1) => alu_mux_lower_cntrl1_sig,
		Alu_signal_mux_ctrl => Alu_signal_mux_ctrl_sig,
		--Alu_decoder_signal: out std_logic_vector(1 downto 0);
		T3_mux_ctrl(0) => t3_mux_cntrl0_sig , T3_mux_ctrl(1) => t3_mux_cntrl1_sig, 
		T3_en => t3_en_sig,
		clk=>clk, reset=>reset,
		Inst => instr_reg_out_sig,			--check if all necessary
		S1_Decoder=> S1_decoder_output_sig,
		S2_decoder=> S2_decoder_output_sig,
		S3_decoder=> S3_decoder_output_sig,
		S6_decoder=> S6_decoder_output_sig,
		S14_decoder =>S14_decoder_output_sig,
		S11_decoder =>S11_decoder_output_sig
		--ALU_Decoder_in: in std_logic_vector(1 downto 0);
		--Carry_Decoder, zero_Decoder: in std_logic
	     );

dut_data_path: Data_path  

	port map (clk =>clk,
		reset =>reset,
		RF_write_en=>RF_write_en_sig,RF_pc_en => RF_pc_en_sig,
		t1_mux_cntrl0 =>t1_mux_cntrl0_sig, t1_mux_cntrl1=>t1_mux_cntrl1_sig,
		t2_mux_cntrl => t2_mux_cntrl_sig,
		IR_en => IR_en_sig,
		pc_mux_cntrl => pc_mux_cntrl_sig,
		t1_en => t1_en_sig,
		t2_en => t2_en_sig,
		A1_RF_mux_cntrl0 => A1_RF_mux_cntrl0_sig, A1_RF_mux_cntrl1=>A1_RF_mux_cntrl1_sig,
		A3_RF_mux_cntrl => A3_RF_mux_cntrl_sig,
		D3_RF_mux_cntrl0 => D3_RF_mux_cntrl0_sig, D3_RF_mux_cntrl1 => D3_RF_mux_cntrl1_sig,
		pe_mux_cntrl  => pe_mux_cntrl_sig,
		rpe_en => rpe_en_sig,
		alu_mux_upper_cntrl0 => alu_mux_upper_cntrl0_sig,alu_mux_upper_cntrl1 => alu_mux_upper_cntrl1_sig,
		alu_mux_lower_cntrl0 => alu_mux_lower_cntrl0_sig,alu_mux_lower_cntrl1 => alu_mux_lower_cntrl1_sig,
		carry_reg_en=> carry_reg_en_sig,
		zero_reg_en => zero_reg_en_sig,
		t3_mux_cntrl0 => t3_mux_cntrl0_sig,t3_mux_cntrl1 => t3_mux_cntrl1_sig,
		t3_en => t3_en_sig,
		mem_addr_mux_cntrl => mem_addr_mux_cntrl_sig,
		mem_read_en => mem_read_en_sig, mem_write_en => mem_write_en_sig,
		z_mux_cntrl => z_mux_cntrl_sig,
		Alu_signal_mux_ctrl => Alu_signal_mux_ctrl_sig,
		--carry_reg_out: out std_logic;
		--zero_reg_out: out std_logic;
		instr_reg_out => instr_reg_out_sig,
		--pe_zero_flag :out std_logic;
		S1_decoder_output => S1_decoder_output_sig,
		S2_decoder_output => S2_decoder_output_sig,
		S3_decoder_output => S3_decoder_output_sig,
		S6_decoder_output  => S6_decoder_output_sig,
		S14_decoder_output => S14_decoder_output_sig,
		S11_decoder_output =>S11_decoder_output_sig

		--mem_data_output => from_memory_data,
		--mem_addr_mux_output => to_memory_address
	);



end Formula;

