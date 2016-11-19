library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Microprocessor_project.all;

entity ALUnFLAG_decoder is
port( IR15, IR14, IR13, IR12: in std_logic;
      ALU_decoder_out : out std_logic_vector(1 downto 0);
      carry_decoder_out, zero_decoder_out : out std_logic
 );
end ALUnFLAG_decoder;


architecture combinational of ALUnFLAG_decoder is
	--signal state : std_logic_vector(3 downto 0);
begin
       
	ALU_decoder_out(0) <= IR15 and IR14;
	ALU_decoder_out(1) <= IR13;
	carry_decoder_out <= not( IR15 or IR14 or IR13);
	zero_decoder_out <= (not IR14) or ((not IR15)and(not IR12)); 
end combinational;
      
