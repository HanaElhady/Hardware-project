library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_SW_top is
end entity;

architecture behavior of tb_SW_top is

   

    -- Testbench signals
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '1';
    signal load         : std_logic := '0';
    signal pc_out       : std_logic_vector(31 downto 0);
    signal instruction  : std_logic_vector(31 downto 0);
    signal alu_result ,alu_out    : std_logic_vector(31 downto 0);
    signal mem_data_out : std_logic_vector(31 downto 0);
    signal reg_data1    : std_logic_vector(31 downto 0);
    signal reg_data2    : std_logic_vector(31 downto 0); 
	signal pc_in 		: std_logic_vector(31 downto 0) := x"00400000";



    -- Clock period constant
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.top 
        port map (
            clk          => clk,
            reset        => reset,
            load         => load,
            pc_in        => pc_in,  
            pc_out       => pc_out,
            instruction  => instruction,
            alu_result   => alu_result,	
			alu_out  => alu_out  ,
            mem_data_out => mem_data_out,
            reg_data1    => reg_data1,
            reg_data2    => reg_data2
        );


    -- Clock generation
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial reset
        wait for 20 ns;
        reset <= '0';
        load <= '1';
        wait for 10 ns;
        load <= '0';

        -- Wait for system to settle
        wait for 100 ns;

        -- ASSERT EXAMPLES (modify expected values per your memory contents)
        assert pc_out /= X"00000000"
            report "PC did not change after reset"	severity error;

        assert instruction /= X"00000000"
            report "Instruction not loaded from memory"	severity warning;

        assert reg_data1 /= X"00000000"
            report "Register 1 data is not updated as expected"	severity warning;

        assert alu_result /= X"00000000"
            report "ALU result is zero - may not be executing" severity note;


        -- Finish simulation
        wait for 100 ns;
        assert false report "Testbench completed." severity note;
        wait;
    end process;

end architecture;
