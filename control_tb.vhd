library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_tb is
end entity;

architecture sim of control_tb is

    
    signal opcode      : std_logic_vector(5 downto 0) := (others => '0');
    signal funct       : std_logic_vector(5 downto 0) := (others => '0');
    signal ALUControl  : std_logic_vector(3 downto 0);
    
    signal clk         : std_logic := '0';
    signal reset       : std_logic := '1';
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
    signal PCSource    : std_logic_vector(1 downto 0);

    
    constant clk_period : time := 10 ns;

begin

    
    DUT: entity work.control
        port map (
            opcode      => opcode,
            funct       => funct,
            ALUControl  => ALUControl,
            clk         => clk,
            reset       => reset,
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
            PCSource    => PCSource
        );

    -- Clock process
    clk_process : process
    begin
        while now < 300 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;
					 
    process
    begin
        -- Areset
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- R-type instruction (add)
        opcode <= "000000";
        funct  <= "100000";  -- ADD
        wait for 60 ns;

        -- LW
        opcode <= "100011";
        wait for 60 ns;

        -- SW
        opcode <= "101011";
        wait for 60 ns;

        -- beq with zero = 1
        opcode <= "000100";
        zero   <= '1';
        wait for 60 ns;

        -- jump
        opcode <= "000010";
        wait for 60 ns;

        wait;
    end process;

end architecture;
