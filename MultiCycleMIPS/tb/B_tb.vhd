library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity B_tb is
end B_tb;

architecture test of B_tb is
    -- Component declaration of UUT (unit under test)
    component B_Register
        Port (
            clk   : in  std_logic;
            B_in  : in  std_logic_vector(31 downto 0);
            B_out : out std_logic_vector(31 downto 0)
        );
    end component;
	
	-- Signals to connect to the DUT (device under test)
    signal tb_clk    : std_logic := '0';
    signal tb_B_in   : std_logic_vector(31 downto 0) := (others => '0');
    signal tb_B_out  : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin
	-- Instantiate the Unit Under Test (UUT)
    uut: B_Register port map (
        clk => tb_clk,
        B_in => tb_B_in,
        B_out => tb_B_out
    );

    clk_process : process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
    end process;

    testB: process
    begin
        wait for 5 ns;
        tb_B_in <= x"CCCCCCCC";
        wait for clk_period/2;

        assert tb_B_out = x"CCCCCCCC"
        report "Test 1 Passed: B_out matches B_in after clock" severity failure;
		
        tb_B_in <= x"FFFFFFFF";
        wait for clk_period;

        assert tb_B_out = x"FFFFFFFF"
        report "Test 2 Passed: B_out matches B_in after clock" severity failure;
		
		tb_B_in <= x"DDDDD111";
        wait for clk_period;

        assert tb_B_out = x"DDDDD111"
        report "Test 3 Passed: B_out matches B_in after clock" severity failure;
		
		report "tb of B reg passed successfully" severity note;
        wait;
    end process;

end test;

