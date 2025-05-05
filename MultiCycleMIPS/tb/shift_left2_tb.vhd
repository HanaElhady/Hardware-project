library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_left2_tb is
end entity;

architecture behavior of shift_left2_tb is
    signal shift_in  : unsigned(31 downto 0) := (others => '0');
    signal shift_out : unsigned(31 downto 0);
begin
    uut: entity work.shift_left2
        port map (
            shift_in  => shift_in,
            shift_out => shift_out
        );

    process
    begin
        shift_in <= to_unsigned(1, 32);
        wait for 10 ns;
        assert shift_out = to_unsigned(4, 32)
        report "Test 1 failed: Expected 4" severity error;

        shift_in <= to_unsigned(3, 32);
        wait for 10 ns;
        assert shift_out = to_unsigned(12, 32)
        report "Test 2 failed: Expected 12" severity error;

        report "All shift_left2 tests passed.";
        wait;
    end process;
end architecture;
