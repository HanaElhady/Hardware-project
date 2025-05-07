library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionMemory_tb is
end InstructionMemory_tb;

architecture test of InstructionMemory_tb is

  signal ReadAddress : std_logic_vector(31 downto 0):=x"003ffffc";
  signal Instruction : std_logic_vector(31 downto 0);

begin
  -- Instantiate the DUT (Device Under Test)
  DUT: entity work.InstructionMemory
    port map (
      ReadAddress => ReadAddress,
      Instruction => Instruction
    );

  -- Stimulus process to apply test vectors
  stim_proc: process
  begin
	  for i in 0 to 11 loop
		  ReadAddress <= x"00400000" or std_logic_vector(to_unsigned(i*4,32));
		  wait for 25 ns;
	  end loop;
	  
	  assert false 
  report "end"
  severity failure;
	  
  end process;

end architecture;



