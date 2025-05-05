library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender_tb is
end entity;

architecture behavior of sign_extender_tb is
    signal input16  : signed(15 downto 0);
    signal output32 : signed(31 downto 0);
begin
    uut: entity work.sign_extender
        port map (
            input16  => input16,
            output32 => output32
        );

    process
    begin
        input16 <= to_signed(10, 16);
        wait for 10 ns;
        assert output32 = to_signed(10, 32)
        report "Test 1 failed: Expected 10" severity error;

        input16 <= to_signed(-1, 16);
        wait for 10 ns;
        assert output32 = to_signed(-1, 32)
        report "Test 2 failed: Expected -1" severity error;

        input16 <= to_signed(-32768, 16);
        wait for 10 ns;
        assert output32 = to_signed(-32768, 32)
        report "Test 3 failed: Expected -32768" severity error;

        report "All sign_extender tests passed.";
        wait;
    end process;
end architecture;
