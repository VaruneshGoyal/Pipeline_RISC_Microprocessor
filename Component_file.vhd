library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package Microprocessor_project is
type Data_in is array (natural range <>) of std_logic_vector(15 downto 0);
type Data_in_2 is array (natural range <>) of std_logic_vector(1 downto 0);
type Data_in_3 is array (natural range <>) of std_logic_vector(2 downto 0);
type Data_in_8 is array (natural range <>) of std_logic_vector(7 downto 0);
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
      write_enable,clk, reset: in std_logic;
      pc_enable:in std_logic;
      D3: in std_logic_vector( 15 downto 0);
      R7_data_in : in std_logic_vector(15 downto 0);
      R7_data_out : out std_logic_vector(15 downto 0)
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

component S1_decoder is
port( i0, i1, i2, i3: in std_logic;
      S1_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S2_decoder is
port( i0, i2, i3, p0, p1, z, c: in std_logic;
      S2_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S3_decoder is
port( i0, i2, i3, z: in std_logic;
      S3_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S6_decoder is
port( i1, z_Rpe: in std_logic;
      S6_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S11_decoder is
port( z_Rpe: in std_logic;
      S11_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S12_decoder is
port( z_Rpe: in std_logic;
      S12_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component S14_decoder is
port( z_Rpe: in std_logic;
      S14_decoder_out : out std_logic_vector(3 downto 0)
 );
end component;

component ALUnFLAG_decoder is
port( IR15, IR14, IR13, IR12: in std_logic;
      ALU_decoder_out : out std_logic_vector(1 downto 0);
      carry_decoder_out, zero_decoder_out : out std_logic
 );
end component;

component Data_path is 

port (clk:in std_logic;
	reset:in std_logic;
	RF_write_en,RF_pc_en:in std_logic;
	t1_mux_cntrl0, t1_mux_cntrl1:in std_logic;
	t2_mux_cntrl:in std_logic;
	IR_en: in std_logic;
	pc_mux_cntrl:in std_logic;
	t1_en:in std_logic;
	t2_en:in std_logic;
	A1_RF_mux_cntrl0, A1_RF_mux_cntrl1:in std_logic;
	A3_RF_mux_cntrl: in std_logic;
	D3_RF_mux_cntrl0, D3_RF_mux_cntrl1:in  std_logic;
	pe_mux_cntrl : in std_logic;
	rpe_en :in std_logic;
	alu_mux_upper_cntrl0,alu_mux_upper_cntrl1:in std_logic;
	alu_mux_lower_cntrl0,alu_mux_lower_cntrl1:in std_logic;
	carry_reg_en:in std_logic;
	zero_reg_en:in std_logic;
	t3_mux_cntrl0,t3_mux_cntrl1 :in std_logic;
	t3_en:in std_logic;
	mem_addr_mux_cntrl:in std_logic;
	mem_read_en,mem_write_en:in std_logic;
	z_mux_cntrl: in std_logic;
	Alu_signal_mux_ctrl :in std_logic;
	--carry_reg_out: out std_logic;
	--zero_reg_out: out std_logic;
	instr_reg_out :out std_logic_vector(15 downto 0);
	--pe_zero_flag :out std_logic;
	S1_decoder_output :out std_logic_vector(3 downto 0);
	S2_decoder_output :out std_logic_vector(3 downto 0);
	S3_decoder_output :out std_logic_vector(3 downto 0);
	S6_decoder_output :out std_logic_vector(3 downto 0);
	S14_decoder_output :out std_logic_vector(3 downto 0);

	S11_decoder_output :out std_logic_vector(3 downto 0)

	--mem_data_output:in std_logic_vector(15 downto 0);
	--mem_addr_mux_output: out std_logic_vector(15 downto 0)
);

end component;

--- Control Path


component IITB_RISC_Controlpath is
	port (
		-- carry_flag, zero_flag: in std_logic; not needed anymore as being handled by decoders after states
		carry_en, zero_en: out std_logic;
	
		
		mem_read_en, mem_write_en, mem_address_mux_ctrl: out std_logic;		
		IR_en: out std_logic;							
		Rpe_mux_ctrl: out std_logic; -- rpe_mux_cntrl
		D3_mux_ctrl: out std_logic_vector(1 downto 0);
		A1_mux_ctrl: out std_logic_vector(1 downto 0);
		A3_mux_ctrl: out std_logic;
		R7_mux_ctrl: out std_logic; -- pc_muc cntrl
		RegFile_write, PC_write: out std_logic;
		T1_mux_ctrl: out std_logic_vector(1 downto 0);	
		T1_en: out std_logic;
		T2_mux_ctrl: out std_logic;
		T2_en: out std_logic;
		Rpe_en: out std_logic;
		Z_mux_ctrl: out std_logic;
		Alu_uppermux_ctrl: out std_logic_vector(1 downto 0);
		Alu_lowermux_ctrl: out std_logic_vector(1 downto 0);
		Alu_signal_mux_ctrl: out std_logic;
		--Alu_decoder_signal: out std_logic_vector(1 downto 0);
		T3_mux_ctrl: out std_logic_vector(1 downto 0);
		T3_en: out std_logic;
		clk, reset: in std_logic;
		Inst: in std_logic_vector(15 downto 0);			--check if all necessary
		S1_Decoder, S2_decoder, S3_decoder, S6_decoder, S11_decoder, S14_decoder : in std_logic_vector(3 downto 0)
		--ALU_Decoder_in: in std_logic_vector(1 downto 0);
		--Carry_Decoder, zero_Decoder: in std_logic
	     );
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

