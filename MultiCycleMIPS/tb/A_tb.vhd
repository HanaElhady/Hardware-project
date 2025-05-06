library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity A_tb is
end A_tb;

architecture test of A_tb is

    -- Component declaration of UUT (unit under test)
    component A_Register
        Port (
            clk   : in  std_logic;
            A_in  : in  std_logic_vector(31 downto 0);
            A_out : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to the DUT (device under test)
    signal tb_clk    : std_logic := '0';
    signal tb_A_in   : std_logic_vector(31 downto 0) := (others => '0');
    signal tb_A_out  : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: A_Register port map (
        clk => tb_clk,
        A_in => tb_A_in,
        A_out => tb_A_out
    );

    -- Clock generation
    clk_process : process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
    end process;

    test: process
    begin
        wait for 5 ns;  -- before first rising edge
        tb_A_in <= x"AAAA5555";		
        wait for clk_period;

        assert tb_A_out = x"AAAA5555"
        report "Test 1 Passed: A_out = A_in after clock" severity failure;	   
		
	    wait for 5 ns; 
        tb_A_in <= x"BBBBBBBB";
        wait for clk_period;

        assert tb_A_out = x"BBBBBBBB"
        report "Test 2 Passed: A_out == A_in after clock" severity failure;
		
		report "tb of A reg passed successfully" severity note;
        wait;
    end process;

end test;

