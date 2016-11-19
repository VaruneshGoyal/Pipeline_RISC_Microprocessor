library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Microprocessor_project.all;

entity encode_modifier is
port( encode_bits : in std_logic_vector(2 downto 0);
      priority_bits_in : in std_logic_vector(7 downto 0);
      priority_bits_out	: out std_logic_vector( 7 downto 0)
	);

end encode_modifier;

architecture Formula_EM of encode_modifier is
 signal decoded_signal :std_logic_vector(7 downto 0);
begin

dut_decoder :  decoder_pe port map (x => encode_bits,y=> decoded_signal);

priority_bits_out <= priority_bits_in xor decoded_signal;
	
       
 

end Formula_EM;

