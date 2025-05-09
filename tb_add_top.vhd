library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_add_tb is
end;

architecture tb of top_add_tb is

    signal clk, reset, load : std_logic := '0';
    signal pc_in   : std_logic_vector(31 downto 0);
    signal pc_out  : std_logic_vector(31 downto 0);
    signal instruction, alu_result, alu_out, mem_data_out : std_logic_vector(31 downto 0);
    signal reg_data1, reg_data2 : std_logic_vector(31 downto 0);

begin

    -- Instantiate Unit Under Test (UUT)
    uut: entity work.top
        port map (
            clk           => clk,
            reset         => reset,
            load          => load,
            pc_in         => pc_in,
            pc_out        => pc_out,
            instruction   => instruction,
            alu_result    => alu_result,
            alu_out       => alu_out,
            mem_data_out  => mem_data_out,
            reg_data1     => reg_data1,
            reg_data2     => reg_data2
        );

    -- Clock generation
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus
    stim_proc : process
    begin
        -- Initial reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Load PC to 0
        load <= '1';
        pc_in <= X"00000000";
        wait for 10 ns;
        load <= '0';

        -- Wait long enough for instruction at address 8 to be executed
        wait for 200 ns;

        -- Expected: R1 = 4, R2 = 5 ? R3 = 9
        assert alu_result = X"00000009"
            report "FAILED: Expected ALU result 9, got " & integer'image(to_integer(unsigned(alu_result)))
            severity error;

        report "PASSED: ADD instruction executed correctly." severity note;
        wait;

    end process;

end architecture;
