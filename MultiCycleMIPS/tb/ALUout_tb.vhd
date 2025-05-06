library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ALUout_tb is
end ALUout_tb;


architecture sim of ALUout_tb is
    -- Component Declaration
    component ALUout
        Port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            load     : in  std_logic;
			alu_in   : in  std_logic_vector(31 downto 0);  
			
            alu_out  : out std_logic_vector(31 downto 0)
        );
    end component;
    
	-- Signals to connect with the ALUout (UUT)
    signal tb_clk     : std_logic := '0';
    signal tb_reset   : std_logic := '0';
    signal tb_load    : std_logic := '0';
    signal tb_alu_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal tb_alu_out : std_logic_vector(31 downto 0);
	
	
    constant clk_period : time := 10 ns;
	
begin

    -- Clock generation
    clk_process : process
    begin
        while true loop
            tb_clk <= '0';
            wait for clk_period / 2;
            tb_clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- UUT instantiation
    uut: ALUout
        port map (
            clk     => tb_clk,
            reset   => tb_reset,
            load    => tb_load,
            alu_in  => tb_alu_in,
            alu_out => tb_alu_out
        );

    -- Test Process
    test : process
    begin
        -- Reset
        tb_reset <= '1';
        wait for clk_period;
        tb_reset <= '0';

        -- Load value 
        tb_alu_in <= x"AAAA5555";
        tb_load <= '1';
        wait for clk_period; 
		
	    assert tb_alu_out = x"AAAA5555"
        report "at ALUout tb : alu_in != alu_out" severity error; 

        tb_load <= '0';
        tb_alu_in <= x"FFFFFFFF";
        wait for clk_period;   
		
		assert tb_alu_out = x"AAAA5555"
        report "at ALUout tb : alu_in != alu_out" severity error; 
		
		tb_load <= '1';	  
		wait for clk_period; 	 
		tb_load <= '0';	 	  
		
		assert tb_alu_out = x"FFFFFFFF"
        report "at ALUout tb : alu_in != alu_out" severity error; 
		
		
        report "ALUout testbench completed successfully." severity note;
        wait;

    end process;

end sim;
