library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4to1_tb is
end entity;

architecture behavior of mux4to1_tb is
    signal mux_in  : std_logic_vector(3 downto 0);
    signal sel     : std_logic_vector(1 downto 0);
    signal mux_out : std_logic;
begin
    uut: entity work.mux4to1
        port map (
            mux_in  => mux_in,
            sel     => sel,
            mux_out => mux_out
        );

    process
    begin
        mux_in <= "1010"; 
        sel <= "00";
        wait for 10 ns;
        assert mux_out = mux_in(0)
        	report "Test 1 failed: Expected mux_in(0)" severity error;

        sel <= "01";
        wait for 10 ns;
        assert mux_out = mux_in(1)
        	report "Test 2 failed: Expected mux_in(1)" severity error;

        sel <= "10";
        wait for 10 ns;
        assert mux_out = mux_in(2)
        	report "Test 3 failed: Expected mux_in(2)" severity error;

        sel <= "11";
        wait for 10 ns;
        assert mux_out = mux_in(3)
        	report "Test 4 failed: Expected mux_in(3)" severity error;

        report "All mux4to1 tests passed.";
        wait;
    end process;
end architecture;
