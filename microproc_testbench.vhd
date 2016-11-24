library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library work;
use work.Microprocessor_project.all;

entity Microproc_Testbench is
end entity;
architecture Behave of Microproc_Testbench is

component Data_path is
   port(clk :in std_logic; reset: in std_logic);
end component;

  signal clk: std_logic := '0';
  signal reset: std_logic := '1';

 begin

  clk <= not clk after 5 ns; -- assume 10ns clock.

  -- reset process
  process
  begin
	report "line1";
     reset <= '0' after 17 ns;
     wait;
  end process;

  dut: Data_path  
     port map(clk => clk,reset => reset);
end Behave;

