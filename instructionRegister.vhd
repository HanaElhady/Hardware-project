library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionRegister is
  GENERIC(n : integer := 32);
  port(
    -- Inputs
    CLK             : in std_logic;
    reset           : in std_logic;
    IRWrite         : in std_logic;
    in_instruction  : in std_logic_vector(31 downto 0);

    -- Output
    out_instruction : out std_logic_vector(31 downto 0)
  );
end InstructionRegister;

architecture Behavioral of InstructionRegister is
  type instr_reg_type is array (0 to 0) of std_logic_vector(31 downto 0);
  signal instr_reg : instr_reg_type := ((others => (others => '0')));
begin

  process(CLK, reset)
  begin
    if reset = '1' then
      instr_reg(0) <= (others => '0');
    elsif rising_edge(CLK) then
      if IRWrite = '1' then
        instr_reg(0) <= in_instruction;
      end if;
    end if;
  end process;

  out_instruction <= instr_reg(0);

end Behavioral;
