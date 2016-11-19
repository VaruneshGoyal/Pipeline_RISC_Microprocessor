library std;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;
architecture Behave of Testbench is
  	signal op : std_logic_vector(1 downto 0); 
	signal a, b, output : std_logic_vector (15 downto 0);
	signal flags : std_logic_vector(1 downto 0);
	signal error_flag : bit := '0';

	component ALU is
	port( X,Y: in std_logic_vector(15 downto 0);
	      Z : out std_logic_vector(15 downto 0);
	      carry_flag,zero_flag :out std_logic;
	      Control_bits: in std_logic_vector(1 downto 0) );	
	end component;
	
	function bitvec_to_str ( x : bit_vector ) return String is
		variable L : line ;
		variable W : String (1 to x ' length ) :=( others => ' ') ;
		begin
			write (L , x ) ;
			W ( L . all ' range ) := L . all ;
			Deallocate ( L ) ;
		return W ;
	end bitvec_to_str ;

   function chr(sl: std_logic) return character is
    variable c: character;
    begin
      case sl is
         when 'U' => c:= 'U';
         when 'X' => c:= 'X';
         when '0' => c:= '0';
         when '1' => c:= '1';
         when 'Z' => c:= 'Z';
         when 'W' => c:= 'W';
         when 'L' => c:= 'L';
         when 'H' => c:= 'H';
         when '-' => c:= '-';
      end case;
    return c;
   end chr;

   function std_logic_vec_to_str(slv: std_logic_vector) return string is
     variable result : string (1 to slv'length);
     variable r : integer;
   begin
     r := 1;
     for i in slv'range loop
        result(r) := chr(slv(i));
        r := r + 1;
     end loop;
     return result;
   end std_logic_vec_to_str;
	
  	function to_std_logic_vector (x: bit_vector) return std_logic_vector is
		variable y : std_logic_vector((x'length-1) downto 0);
		begin
			for k in 0 to (x'length-1) loop
				if(x(k)='1') then y(k) := '1';
				else y(k) := '0';
				end if;
			end loop;
		return y;
  	end to_std_logic_vector;

	function to_string(x: string) return string is
      		variable ret_val: string(1 to x'length);
      		alias lx : string (1 to x'length) is x;
	 	begin  
		  ret_val := lx;
		return(ret_val);
	end to_string;

begin
	process
	file f : text open read_mode is "TRACEFILE_ALU.txt" ;
	file g : text open write_mode is "error_log.txt" ;
	variable av : bit_vector (15 downto 0) ;
	variable bv : bit_vector (15 downto 0) ;
	variable op_code : bit_vector (1 downto 0) ;
	variable L : line ;
	variable OUTPUT_LINE : line;
	variable line_count : integer := 0;
	--variable to_check : string;
	variable expected_output : bit_vector (15 downto 0);
	variable expected_flags : bit_vector(1 downto 0);

	begin
		while not endfile(f) loop
			line_count := LINE_COUNT + 1;
			readline(f,L);
			read(L,op_code);
			read(L,av);
			read(L,bv);
			read(L,expected_output);
			read(L,expected_flags);
			op <= to_std_logic_vector(op_code);
			a <= to_std_logic_vector(av);
			b <= to_std_logic_vector(bv);

			wait for 10 ns ;
			--this is for the computation of the output by the circuit
			
			--to_check = bitvec_to_str(y);

			if(not (output = to_std_logic_vector(expected_output)) or not (flags = to_std_logic_vector(expected_flags))) then
            			write(OUTPUT_LINE, LINE_COUNT);
            			write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, op_code);
            			write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, av);
            			write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, bv);
            			write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, std_logic_vec_to_str(output));            			
				write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, expected_output);
            			write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, std_logic_vec_to_str(flags));            			
				write(OUTPUT_LINE, to_string(" "));
            			write(OUTPUT_LINE, expected_flags);
            			writeline(g, OUTPUT_LINE);
				--write(g,bitvec_to_str(av));
				--write(g,bitvec_to_str(bv));
				--write(g,bitvec_to_str(op_code));
				--write(g,std_logic_vec_to_str(output));
				--write(g,bitvec_to_str(expected_output));
				--write(g," ");
				error_flag <= '1';
			end if;

			assert (output = to_std_logic_vector(expected_output))
				report "ALU Error"
				severity error;

			if(not (flags = to_std_logic_vector(expected_flags))) then
            			--write(OUTPUT_LINE, LINE_COUNT);
            			--write(OUTPUT_LINE, to_string(" "));
            			--write(OUTPUT_LINE, op_code);
            			--write(OUTPUT_LINE, to_string(" "));
            			--write(OUTPUT_LINE, av);
            			--write(OUTPUT_LINE, to_string(" "));
            			--write(OUTPUT_LINE, bv);
            			--write(OUTPUT_LINE, to_string(" "));
            			--write(OUTPUT_LINE, std_logic_vec_to_str(flags));            			
				--write(OUTPUT_LINE, to_string(" "));
            			--write(OUTPUT_LINE, expected_flags);
            			--writeline(g, OUTPUT_LINE);
				--write(g,bitvec_to_str(av));
				--write(g,bitvec_to_str(bv));
				--write(g,bitvec_to_str(op_code));
				--write(g,std_logic_vec_to_str(flags));
				--write(g,bitvec_to_str(expected_flags));
				--write(g," ");
				error_flag <= '1';
			end if;		

			assert (flags = to_std_logic_vector(expected_flags))
				report "FLAG error"
				severity error;		
			
		end loop ;

		assert (error_flag = '0') report "Test completed. Errors present. See error_log.txt"
			severity error;
		assert (error_flag = '1') report "Test completed. Successful!!!"
			severity note;
		wait ;
	end process ;
	dut : ALU port map (X => a, Y => b, Z => output, carry_flag => flags(1), zero_flag => flags(0), Control_bits => op);
			
end Behave ;
