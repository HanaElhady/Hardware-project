library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl_tb is
end entity;

architecture behavior of ALUControl_tb is

   
    component ALUControl is
	
        port (
            ALUOp     : in  std_logic_vector(1 downto 0);
            funct     : in  std_logic_vector(5 downto 0);
            ALUControl: out std_logic_vector(3 downto 0)
        );
    end component;

    
    signal ALUOp      : std_logic_vector(1 downto 0);
    signal funct      : std_logic_vector(5 downto 0);
    signal ALUControl_sim : std_logic_vector(3 downto 0);

begin

 
    U1: ALUControl
	port map (ALUOp => ALUOp, funct => funct, ALUControl => ALUControl_sim);

   
    process
    begin 
		  -- (add)lw/sw 
        ALUOp <= "00"; funct <= "000000"; wait for 10 ns;

        -- (sub)beq 
        ALUOp <= "01"; funct <= "000000"; wait for 10 ns;
		
		-- R-type 
        -- add
        ALUOp <= "10"; funct <= "100000"; wait for 10 ns;
        
        -- sub
        ALUOp <= "10"; funct <= "100010"; wait for 10 ns;

        -- and
        ALUOp <= "10"; funct <= "100100"; wait for 10 ns;

        -- or
        ALUOp <= "10"; funct <= "100101"; wait for 10 ns;

        -- slt
        ALUOp <= "10"; funct <= "101010"; wait for 10 ns;

        -- undefined 
        ALUOp <= "10"; funct <= "111111"; wait for 10 ns;

        wait;
    end process;

end architecture;
