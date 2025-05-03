library ieee;
use ieee.std_logic_1164.all;  

entity ALUControl is  
	port(
	ALUOP : in std_logic_vector(1 downto 0);
	funct : in std_logic_vector(5 downto 0); 
	
	ALUControl : out std_logic_vector (3 downto 0) -- 4 bits if i need to do more operations(nand..etc) 
	);
end entity;	

architecture behave of 	ALUControl is 
begin 
	
	process (ALUOP,funct) is 
	begin 
		
	case ALUOP is  
		when "00" =>
		ALUControl <= "0010";  --add(lw/sw)
		
		when "01" =>
		ALUControl <= "0110";  --sub(beq)
		
		--R-type
		when "10"=>
		
		case funct is 
			when "100000" => 
			ALUControl <= "0010";  --add
			when "100010" =>
			ALUControl  <= "0110"; --sub
			when "100100" =>
			ALUControl <= "0000";  --and
			when "100101" =>
			ALUControl <= "0001";  --or
			when "101010" =>
			ALUControl <= "0111";  --slt
			when others =>
			ALUControl <= "1111";
		end case;
		
		when others =>
			ALUControl <= "1111";
	end case;
	
	
	end process;	
end architecture;
	
	