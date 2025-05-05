library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture sim of alu_tb is
    signal rs, rd       : signed(31 downto 0) := (others => '0');
    signal ALUResult    : signed(31 downto 0);
    signal ALUControl   : std_logic_vector(3 downto 0) := "0000";
    signal zero         : std_logic;

begin
    uut: entity work.Alu
        port map (
            rs         => rs,
            rd         => rd,
            ALUResult  => ALUResult,
            ALUControl => ALUControl,
            zero       => zero
        );

    -- Stimulus Process
    stim_proc: process
    begin
        ------------------------------------------------------------------------
        -- Basic Arithmetic and Logic Tests
        ------------------------------------------------------------------------
        
        rs <= to_signed(20, 32);   -- 0x00000014
        rd <= to_signed(5, 32);    -- 0x00000005	
		
        ALUControl <= "0000";	   -- AND
        wait for 10 ns;
        assert ALUResult = (x"00000014" and x"00000005")
            report "AND operation failed" severity error;

        
        ALUControl <= "0001";  	   -- OR 
        wait for 10 ns;
        assert ALUResult = (x"00000014" or x"00000005")
            report "OR operation failed" severity error;

        
        ALUControl <= "0010";	   -- ADD 
        wait for 10 ns;
        assert ALUResult = to_signed(25, 32) and zero = '0'
            report "ADD operation failed" severity error;

        
        ALUControl <= "0110";	   -- SUB
        wait for 10 ns;
        assert ALUResult = to_signed(15, 32) and zero = '0'
            report "SUB operation failed" severity error;

        
        ALUControl <= "0111";	   -- SLT 
        wait for 10 ns;
        assert ALUResult = 0 and zero = '1'
            report "SLT operation failed" severity error;

        ------------------------------------------------------------------------
        -- Edge Case Tests
        ------------------------------------------------------------------------
        -- Test SLT with negative numbers
        rs <= to_signed(-10, 32);
        rd <= to_signed(5, 32);
        wait for 10 ns;
        assert ALUResult = 1 and zero = '0'
            report "SLT with negative numbers failed" severity error;

        -- Test ADD overflow (MAX_INT + 1)
        rs <= to_signed(2147483647, 32);  -- 2^31 - 1
        rd <= to_signed(1, 32);
        ALUControl <= "0010";
        wait for 10 ns;
        assert ALUResult = to_signed(-2147483648, 32)  -- Wraps to MIN_INT
            report "ADD overflow failed" severity error;

        -- Test SUB underflow (MIN_INT - 1)
        rs <= to_signed(-2147483648, 32);  -- -2^31
        rd <= to_signed(1, 32);
        ALUControl <= "0110";
        wait for 10 ns;
        assert ALUResult = to_signed(2147483647, 32)  -- Wraps to MAX_INT
            report "SUB underflow failed" severity error;

        -- Test SLT with equal inputs
        rs <= to_signed(5, 32);
        rd <= to_signed(5, 32);
        ALUControl <= "0111";
        wait for 10 ns;
        assert ALUResult = 0 and zero = '1'
            report "SLT with equal inputs failed" severity error;

        ------------------------------------------------------------------------
        -- Simulation Completion
        ------------------------------------------------------------------------
        report "All ALU tests passed successfully";
        wait;
    end process;
end architecture;
