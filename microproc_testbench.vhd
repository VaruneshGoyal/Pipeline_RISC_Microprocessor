library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library work;
use work.Microprocessor_project.all;

entity Microproc_Testbench is
end entity;
architecture Behave of Microproc_Testbench is

component IITB_RISC_Microprocessor is
   port(clk,reset: in std_logic);
end component;

  signal clk: std_logic := '0';
  signal reset: std_logic := '1';

 begin
  clk <= not clk after 5 ns; -- assume 10ns clock.

  -- reset process
  process
  begin

     reset <= '0' after 17 ns;
     wait;
  end process;

  dut: IITB_RISC_Microprocessor  
     port map(clk => clk,reset => reset);
end Behave;

