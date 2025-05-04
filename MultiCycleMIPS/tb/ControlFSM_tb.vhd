library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlFSM_tb is
end entity;

architecture test of ControlFSM_tb is

    
    component ControlFSM is
        port(
            clk         : in  std_logic;
            reset       : in  std_logic;
            opcode      : in  std_logic_vector(5 downto 0);
            zero        : in  std_logic; 

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
    end component;

   
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '0';
    signal opcode      : std_logic_vector(5 downto 0) := (others => '0');
    signal zero        : std_logic := '0';

    
    signal PCWrite     : std_logic;
    signal PCWriteCond : std_logic;
    signal IorD        : std_logic;
    signal MemRead     : std_logic;
    signal MemWrite    : std_logic;
    signal IRWrite     : std_logic;
    signal MemtoReg    : std_logic;
    signal RegDst      : std_logic;
    signal RegWrite    : std_logic;
    signal ALUSrcA     : std_logic;
    signal ALUSrcB     : std_logic_vector(1 downto 0);
    signal ALUOp       : std_logic_vector(1 downto 0);
    signal PCSource    : std_logic_vector(1 downto 0);

    
    constant clk_period : time := 10 ns;

begin

    
    U: ControlFSM
        port map(
            clk         => clk,
            reset       => reset,
            opcode      => opcode,
            zero        => zero,

            PCWrite     => PCWrite,
            PCWriteCond => PCWriteCond,
            IorD        => IorD,
            MemRead     => MemRead,
            MemWrite    => MemWrite,
            IRWrite     => IRWrite,
            MemtoReg    => MemtoReg,
            RegDst      => RegDst,
            RegWrite    => RegWrite,
            ALUSrcA     => ALUSrcA,
            ALUSrcB     => ALUSrcB,
            ALUOp       => ALUOp,
            PCSource    => PCSource
        );

    
    clk_process : process
    begin
        clk <= not clk;
        wait for clk_period;
    end process;


    process
    begin
      -- Test Reset 
        reset <= '1';
        wait for clk_period;
        reset <= '0';
        wait for clk_period;

        -- Test R-type 
        opcode <= "000000";  
        wait for clk_period;
        
        
        -- Test lw 
        opcode <= "100011";  
        wait for clk_period;
      
        
        -- Test sw 
        opcode <= "101011";  
        wait for clk_period;
       
        
        -- Test Branch 
        opcode <= "000100";  
        zero <= '1';         --branch is taken
        wait for clk_period;
        
        
        zero <= '0';         -- branch not taken
        wait for clk_period;
     
        
        -- Test Jump  
        opcode <= "000010";  
        wait for clk_period;
       

        wait;
    end process;

end architecture;
