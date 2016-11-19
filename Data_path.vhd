library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;



entity Data_path is 

port (clk:in std_logic;
	reset:in std_logic;
);



end Data_path;


architecture Formula_Data_Path of Data_Path is

--Register file
dut_rf :Reg_File port map( A1=>A1_RF, A2=>A2_RF, A3=>A3_RF, R7_data_out=>pc_data_out, R7_data_in=>pc_data_in,
      		 D1=>D1_RF, D2=>D2_RF, D3=>D3_RF, write_enable=>RF_write_en, clk=>clk,reset =>reset,
		 pc_enable=>RF_pc_en);


--ALU
dut_alu : ALU port map( X=> alu_mux_upper_out,Y=>alu_mux_lower_out,
      			Z =>alu_output,
     			carry_flag=>alu_carry_flag,zero_flag=>alu_zero_flag,
     		        Control_bits(0)=> alu_cntrl0,Control_bits(1)=> alu_cntrl1);

-- Memory
dut_memory :Memory port map (Din=> t1_output,
			Dout => mem_data_output,
			write_enable=>mem_write_en,
			read_enable=>mem_read_en,clk=>clk,
			Addr=>  mem_addr_mux_output);


--inst_addr <- R7, dedicated +1 unit
--IF/ID reg : contains just the instruction fetched


--ID/RR reg : opcode, Rs1-code, Rs2-code, Rd-code, Mem-write-en, Mem-read-en, Alu-instruction, Rf-write-en, Immediate data


--RR/EX reg : opcode, Rs1, Rs2, Rd-code, Mem-write-en, Mem-read-en, Alu-instruction, Rf-write-en, Immediate-data


--EX/MEM reg : opcode, Alu-output (=mem_addr), Rs1(data for store), Rd-code, Mem-write-en, Mem-read-en, Alu-instruction, Rf-write-en


--MEM/WB reg : opcode, Rd-code, Rf-write-en, Result (can be data from mem or Alu-output)


--Hazard Detectors


--other things required : Carry flag, Zero flag



end Formula_Data_Path;




























