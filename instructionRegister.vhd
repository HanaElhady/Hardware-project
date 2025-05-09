library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionRegister is
  generic (
    WIDTH : integer := 32
  );
  port (
    CLK            : in  std_logic;
    reset     	   : in  std_logic;
    IRWrite        : in  std_logic;
    in_instruction : in  std_logic_vector(WIDTH - 1 downto 0);
    out_instruction: out std_logic_vector(WIDTH - 1 downto 0)
  );
end InstructionRegister;

architecture rtl of InstructionRegister is
  signal instruction_reg : std_logic_vector(WIDTH - 1 downto 0) := (others => '0');
begin

  process(CLK)
  begin
    if reset = '1' then
      instruction_reg <= (others => '0');
    elsif rising_edge(CLK) then
      if IRWrite = '1' then
        instruction_reg <= in_instruction;
      end if;
    end if;
  end process;

  out_instruction <= instruction_reg;

end rtl;