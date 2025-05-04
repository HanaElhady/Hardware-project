library ieee;
use ieee.std_logic_1164.all;  

entity ControlFSM is  
	port(
    clk     : in  std_logic;
    reset   : in  std_logic;
	opcode  : in  std_logic_vector(5 downto 0);
	zero    :  in  std_logic; 	
	
    PCWrite     : out std_logic;
    PCWriteCond : out std_logic;
    IorD        : out std_logic;
    MemRead     : out std_logic;
    MemWrite    : out std_logic;
    IRWrite     : out std_logic;
    MemtoReg    : out std_logic;
    RegDst      : out std_logic;
    RegWrite    : out std_logic;
    ALUSrcA     : out std_logic;
    ALUSrcB     : out std_logic_vector(1 downto 0);
    ALUOp       : out std_logic_vector(1 downto 0);
    PCSource    : out std_logic_vector(1 downto 0)
	
	);
end entity;

architecture behave of 	ControlFSM is 
type state_type is (fetch,decode, memaddr, memread_s, memwriteback, memwrite_s, execute, aluwriteback, branch, jump);
signal state, next_state : state_type;
begin 
	
	
	process(clk, reset)
	begin 
		if reset = '1' then 
			state <= fetch;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
	
	NextState: process(state, opcode)
	begin 
		case state is 
			
		when fetch => 
		next_state <= decode;
		
		when decode =>
                case opcode is
                    when "000000" => next_state <= execute;    -- R-type
                    when "100011" => next_state <= memaddr;    -- lw
                    when "101011" => next_state <= memaddr;    -- sw
                    when "000100" => next_state <= branch;     -- beq
                    when "000010" => next_state <= jump;       -- j
                    when others   => next_state <= fetch;
                end case;
				
		when memaddr =>	
		
		if opcode = "100011" then
		  next_state <= memread_s;
		  
		else 
		  next_state <= memwrite_s;
		end if;
		
		when memread_s =>
		next_state <= memwriteback;
		
		when memwriteback =>
		next_state <= fetch;
		
		when memwrite_s =>
		next_state <= fetch;
		
        when execute =>
		next_state <= aluwriteback;
		 

		when aluwriteback =>
	    next_state <= fetch;
		 
	    when branch => 
		next_state <= fetch; 
		 

	    when jump =>
		next_state <= fetch; 
		 
        end case;
	end process;

	
	
	defineStates: process(state)
	begin
		 PCWrite     <= '0';
         PCWriteCond <= '0';
         IorD        <= '0';
         MemRead     <= '0';
         MemWrite    <= '0';
         IRWrite     <= '0';
         MemtoReg    <= '0';
         RegDst      <= '0';
         RegWrite    <= '0';
         ALUSrcA     <= '0';
         ALUSrcB     <= "00";
         ALUOp       <= "00";
         PCSource    <= "00";
	
		case state is 
			
			when fetch =>
			IorD     <= '0';
			MemRead  <= '1';
			IRWrite  <= '1';
			ALUSrcA  <= '0';
			ALUSrcB  <= "01";
			PCSource <= "00";
			PCWrite   <= '1';
		    ALUOp    <= "00";
			
			when decode =>
            ALUSrcA   <= '0';
			ALUSrcB   <= "11";
			ALUOp     <= "00";
			
		
			
			
			when memaddr =>
			ALUSrcB <= "10";
		    ALUSrcA <= '1';
			ALUOp   <= "00"; -- for addition
			
			
			when memread_s =>
			IorD <= '1';
			memRead  <= '1'; 
		
			--for lw
			when memwriteback =>
			MemtoReg <='1';
			RegWrite <= '1';
			RegDst <= '0'; --rt 20:16
			--for sw
			when memwrite_s =>
			memwrite <= '1';
			IorD <= '1';
			
			when execute =>
			alusrca <= '1';
			alusrcb <= "00";
			ALUOp <= "10";
			
			when aluwriteback =>
			MemtoReg <= '0';
			RegWrite <= '1';
			RegDst <= '1'; 
			
			when branch =>
			ALUSrcA  <= '1';			
			ALUSrcB  <= "00";			
			ALUOp    <= "01"; --for subtraction 
         	PCSource <= "01";
				
		    if zero = '1' then
            PCWriteCond <= '1';  -- Branch taken
            else
            PCWriteCond <= '0';  -- No branch
            end if;
				
           
				

            when jump => 
			
            PCWrite <= '1';
            PCSource <= "10";
			
			when others =>
            null;
			
		end case;	
	end process;		
	
end architecture;
