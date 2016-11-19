library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Microprocessor_project.all;

entity Reg_File is

port( A1,A2,A3: in std_logic_vector(2 downto 0);
      D1, D2: out std_logic_vector(15 downto 0);
      write_enable,clk,reset: in std_logic;
      pc_enable:in std_logic;
      D3: in std_logic_vector( 15 downto 0);
      R7_data_in : in std_logic_vector(15 downto 0);
      R7_data_out : out std_logic_vector(15 downto 0)
);
end Reg_File;

architecture Formula_RF of Reg_File is
signal decoded_addr,enable_bit: std_logic_vector(7 downto 0);
signal R0_D,R1_D,R2_D,R3_D,R4_D,R5_D,R6_D,R7_D,R7_Din_sig,R7_Dout_sig:std_logic_vector(15 downto 0);

begin
	dut_decoder1 :decoder_pe port map(x=>A3, y=> decoded_addr);
	
	enable_bit(0)<=decoded_addr(0) and write_enable; 
	enable_bit(1)<=decoded_addr(1) and write_enable; 
	enable_bit(2)<=decoded_addr(2) and write_enable; 
	enable_bit(3)<=decoded_addr(3) and write_enable; 

	enable_bit(4)<=decoded_addr(4) and write_enable; 
	enable_bit(5)<=decoded_addr(5) and write_enable; 
	enable_bit(6)<=decoded_addr(6) and write_enable; 
	enable_bit(7)<=(decoded_addr(7) and write_enable) or pc_enable ; 
	-- the write to pc is enable if pc_enable is set or write enable is set with address of r7.
	
	dut_0 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R0_D, Enable => enable_bit(0), clk => clk,reset=>reset);
	dut_1 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R1_D, Enable => enable_bit(1), clk => clk,reset=>reset);
	dut_2 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R2_D, Enable => enable_bit(2), clk => clk,reset=>reset);
	dut_3 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R3_D, Enable => enable_bit(3), clk => clk,reset=>reset) ;             

	dut_4 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R4_D, Enable => enable_bit(4), clk => clk,reset=>reset);
	dut_5 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R5_D, Enable => enable_bit(5), clk => clk,reset=>reset);
	dut_6 : DataRegister generic map (data_width => 16) port map (Din => D3, Dout => R6_D, Enable => enable_bit(6), clk => clk,reset=>reset);
	dut_7 : DataRegister generic map (data_width => 16) port map (Din => R7_Din_sig, Dout => R7_Dout_sig, Enable => enable_bit(7) , clk => clk,reset=>reset);

	R7_data_out<=R7_Dout_sig;
	R7_D<= R7_Dout_sig;

	dut_MUX_R7 :  Data_MUX generic map (control_bit_width => 1) port map(Din(0)=> D3,Din(1) =>R7_data_in,control_bits(0)=>pc_enable,Dout=>R7_Din_sig);

	dut_MUX1: Data_MUX generic map (control_bit_width => 3) port map(Din(0)=>R0_D,Din(1)=>R1_D,Din(2)=>R2_D,Din(3)=>R3_D,Din(4)=>R4_D,Din(5)=>R5_D,Din(6)=>R6_D,Din(7)=>R7_D, Dout=>D1,control_bits=>A1);

	dut_MUX2: Data_MUX generic map (control_bit_width => 3) port map(Din(0)=>R0_D,Din(1)=>R1_D,Din(2)=>R2_D,Din(3)=>R3_D,Din(4)=>R4_D,Din(5)=>R5_D,Din(6)=>R6_D,Din(7)=>R7_D, Dout=>D2,control_bits=>A2);

end Formula_RF;

