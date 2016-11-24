library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

--!!Need to put one more forwarding at output of alu...in case of SW after LW from same register

entity Control_Hazard is
	port ( BEQ_bit_4 : in std_logic; --the alu_signal(1) bit
			JAL_bit_2, JLR_bit_2 : in std_logic;
			Rd_3, Rd_4 : in std_logic_vector(2 downto 0);
			mem_read_4 : in std_logic;
			reset_1, reset_2, reset_3, reset_4 : out std_logic;
			incrementor_mux_ctrl : out std_logic_vector(1 downto 0);
			incrementor_mux_2_ctrl: out std_logic_vector(1 downto 0);
			PC_mux_ctrl : out std_logic_vector(1 downto 0);
			C_en, Z_en : out std_logic );
end entity;

architecture Behave of Control_Hazard is

begin
	process(BEQ_bit_4, JAL_bit_2, JLR_bit_2, Rd_3, Rd_4, mem_read_4)
		variable vPC_mux_ctrl : std_logic_vector (1 downto 0);
		variable vincrementor_mux_ctrl : std_logic_vector (1 downto 0);
		variable vreset_1 : std_logic;
		variable vreset_2 : std_logic;
		variable vreset_3 : std_logic;
		variable vreset_4 : std_logic;
		variable vC_en : std_logic; variable vZ_en : std_logic;
	begin	
		vPC_mux_ctrl := "00";
		vincrementor_mux_ctrl := "00";
		vreset_1 := '0'; vreset_2 := '0'; vreset_3 := '0'; vreset_4 := '0';
		vC_en := '1'; vZ_en := '1';

		if(BEQ_bit_4 = '1') then
			vincrementor_mux_ctrl := "11";			--11 indicates ALU_output (SE6 in case of BEQ) ... could have been SE6 (10) ?
			vreset_1 := '1';
			vreset_2 := '1';
			vreset_3 := '1';
			vreset_4 := '1';
			vC_en := '0'; vZ_en := '0';
		elsif(Rd_4 = "111" and mem_read_4 = '1') then
			vPC_mux_ctrl := "10";					--10 indicates from memory
			vreset_1 := '1'; vreset_2 := '1'; vreset_3 := '1'; vreset_4 := '1';
			vC_en := '0';
			--control of Z flag from here or separate? decide later...build a LW detector unit.
			--Z_en <= '1';
			--Z_mux_ctrl <= '1';						--i.e. from memory
		elsif(Rd_3 = "111") then
			vPC_mux_ctrl := "01";						-- is this is to be done by data hazard? No. For any instruction in R7 is a control hazard
			vreset_1 := '1'; vreset_2 := '1'; vreset_3 := '1';
		elsif (JLR_bit_2 = '1') then
			vPC_mux_ctrl := "11";					--11 indicates from D1 ...which is content of registerA as required in JLR
			vreset_1 := '1'; vreset_2 := '1';
		elsif (JAL_bit_2 = '1') then
			vincrementor_mux_ctrl := "01";			--01 indicates SE9
			vreset_1 := '1'; vreset_2 := '1';
		end if;
		
		PC_mux_ctrl <= vPC_mux_ctrl;
		incrementor_mux_ctrl <= vincrementor_mux_ctrl;
		incrementor_mux_2_ctrl <= vincrementor_mux_ctrl;
		reset_1 <= vreset_1; reset_1 <= vreset_2; reset_1 <= vreset_3; reset_1 <= vreset_4;
		C_en <= vC_en;
		Z_en <= vZ_en;
	end process;
end Behave;
