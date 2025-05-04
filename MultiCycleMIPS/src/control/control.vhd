library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    port (
	   -- ALU control
        opcode  : in  std_logic_vector(5 downto 0);
        funct   : in  std_logic_vector(5 downto 0);
		
        ALUControl : out std_logic_vector(3 downto 0);

        -- Control FSM
	    clk     : in  std_logic;
        reset   : in  std_logic;
		zero    : in  std_logic;
		--+opcode 
		
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
        PCSource    : out std_logic_vector(1 downto 0)
    );
end entity;

architecture structural of control is

    -- Internal signal to connect both FSM and alucontrol
    signal ALUOp_signal : std_logic_vector(1 downto 0);

begin

   
    U1: entity work.ControlFSM
        port map (
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
            ALUOp       => ALUOp_signal,
            PCSource    => PCSource
        );

   
    U2: entity work.ALUControl
        port map (
            ALUOp      => ALUOp_signal,
            funct      => funct,
            ALUControl => ALUControl
        );

end architecture;
