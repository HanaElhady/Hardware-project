library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pc is
end entity;

architecture Behavioral of tb_pc is	 

    component pc is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;  --clear
        pc_write    : in  std_logic;  --load enable
        pc_in       : in  std_logic_vector(31 downto 0);   -- value that will load to pc
		
        pc_out      : out std_logic_vector(31 downto 0)	   -- address that the pc will go to in memory  
    );
    end component;
	
    -- Signals to connect with the PC (UUT)
    signal tb_clk       : std_logic := '0';
    signal tb_reset     : std_logic := '0';
    signal tb_pc_write  : std_logic := '0';
    signal tb_pc_in     : std_logic_vector(31 downto 0) := (others => '0');
    signal tb_pc_out    : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- UUT (Unit Under Test)
    uut: PC
        port map (
            clk      => tb_clk,
            reset    => tb_reset,
            pc_write => tb_pc_write,
            pc_in    => tb_pc_in,
            pc_out   => tb_pc_out
        );

    -- Clock generation process
    clk_process : process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
    end process;

    test: process
    begin
        -- Test 1: Reset 
		
        tb_reset <= '1';
        wait for clk_period;
        tb_reset <= '0';
        wait for clk_period;
		
        assert tb_pc_out = x"00000000"
        report "Reset failed: PC is not zero" severity error;

        -- Test 2: Load address 0x00000010
		
        tb_pc_in <= x"00000010";
        tb_pc_write <= '1';
        wait for clk_period;
        tb_pc_write <= '0';
        wait for clk_period; 
		
        assert tb_pc_out = x"00000010"
        report "Write failed: PC not loaded with 0x00000010" severity error;

        -- Test 3: Try to write with/without enable (should hold)
	
        tb_pc_in <= x"DEADBEEF";  -- change input
        tb_pc_write <= '0';       -- don't allow write
        wait for clk_period;	 
		
        assert tb_pc_out = x"00000010"
        report "Write occurred without enable" severity error;
		
		tb_pc_write <= '1';       -- allow write
        wait for clk_period;
		tb_pc_write <= '0';
		wait for clk_period;
		
		assert tb_pc_out = x"DEADBEEF"
        report "Write occurred without enable" severity error; 
		
        report "PC testbench completed successfully." severity note;
        wait;
    end process;

end architecture;
