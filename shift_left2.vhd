library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftLeft is
  port( -- input
        shift_in  : in std_logic_vector(25 downto 0);

        -- output
        shift_out : out std_logic_vector(27 downto 0) );
end ShiftLeft;

architecture Behavioral of ShiftLeft is
begin

  shift_out <= shift_in & "00";

end Behavioral;
