library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryDataRegister_TB is
end entity;

architecture behavior of MemoryDataRegister_TB is

    signal CLK        : std_logic := '0';
    signal reset_neg  : std_logic := '1';
    signal input_data : std_logic_vector(31 downto 0) := (others => '0');
    signal output_data: std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.MemoryDataRegister
        port map (
            CLK     => CLK,
            reset_neg => reset_neg,
            input   => input_data,
            output  => output_data
        );

    -- Clock process
    clk_process : process
    begin
        while now < 200 ns loop
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        reset_neg <= '0';
        input_data <= x"AAAAAAAA";
        wait for clk_period;

        -- Release reset
        reset_neg <= '1';
        wait for clk_period;

        -- Apply new input
        input_data <= x"12345678";
        wait for clk_period;

        -- Apply another input
        input_data <= x"DEADBEEF";
        wait for clk_period;

        -- Assert reset again
        reset_neg <= '0';
        wait for clk_period;

        -- Deassert reset and apply new input
        reset_neg <= '1';
        input_data <= x"CAFEBABE";
        wait for clk_period;

        -- End simulation
        wait;
    end process;

end architecture;
