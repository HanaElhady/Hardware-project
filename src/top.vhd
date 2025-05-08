library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk, reset, load : in std_logic;
        pc_out       : out std_logic_vector(31 downto 0);
        instruction  : out std_logic_vector(31 downto 0);
        alu_result   : out std_logic_vector(31 downto 0);
        mem_data_out : out std_logic_vector(31 downto 0);
        reg_data1    : out std_logic_vector(31 downto 0);
        reg_data2    : out std_logic_vector(31 downto 0)
    );
end entity top;

architecture sims of top is

    signal pc_in, A_mux_out, memData, B_mux_out, C_mux_out : std_logic_vector(31 downto 0);
    signal input_regA, output_regA, output_regB, input_regB :std_logic_vector(31 downto 0);
    signal rs, rd, ALUOut : std_logic_vector(31 downto 0);
	signal b_shift_out, a_shift_out : std_logic_vector(31 downto 0);
	

    signal zero, PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, RegDst, RegWrite, ALUSrcA : std_logic;
    signal ALUSrcB, PCSource : std_logic_vector(1 downto 0);
    signal ALUControl : std_logic_vector(3 downto 0);

    -- Modified signals
    signal output32 : std_logic_vector(31 downto 0);                   -- Output of sign extender
    signal unsigned_output32 : std_logic_vector(31 downto 0);          -- Converted unsigned for shifting

begin

  

    pc: entity work.pc
        port map (
            clk      => clk,
            reset    => reset,
            pc_write => PCWrite,
            pc_in    => pc_in,
            pc_out   => pc_out	 
        );

    A_mux2to1: entity work.mux2to1
        port map (
            a => pc_out, 
            b => ALUOut,
            sel       => IorD,
            mux_out   => A_mux_out
        );

    DataMemory: entity work.DataMemory
        port map (
            Address    => A_mux_out,
            WriteData  => output_regB,
            MemRead    => MemRead,
            MemWrite   => MemWrite,
            ReadData   => memData
        );

    MemoryDataRegister: entity work.MemoryDataRegister
        port map (
		CLK     => clk,	
		reset_neg => reset,
            input   => memData,
            output  => instruction
        );

    B_mux2to1: entity work.mux2to1
        port map (
            a => instruction(20 downto 16),  -- rt
            b => instruction(15 downto 11),  -- rd
            sel       => RegDst,
            mux_out   => B_mux_out
        );

    C_mux2to1: entity work.mux2to1
        port map (
            a => ALUOut,
            b => memData,
            sel       => MemtoReg,
            mux_out   => C_mux_out
        );

    registerfile: entity work.registerfile
        port map (
            clk        => clk,
            regWrite   => RegWrite,
            readReg1   => instruction(25 downto 21),
            readReg2   => instruction(20 downto 16),
            writeReg   => B_mux_out,
            writeData  => C_mux_out,
            readData1  => input_regA,
            readData2  => input_regB
        );

    A_Register: entity work.A_Register
        port map (
            clk   => clk,
            A_in  => input_regA,
            A_out => output_regA
        );

    B_Register: entity work.B_Register
        port map (
            clk   => clk,
            B_in  => input_regB,
            B_out => output_regB
        );

    D_mux2to1: entity work.mux2to1
        port map (
            a => pc_out,
            b => output_regA,
            sel       => ALUSrcA,
            mux_out   => rs
        );

    left_mux4to1: entity work.mux4to1
        port map (
            a => output_regB,
            b => X"00000004",
            c => b_shift_out,
            d => (others => '0'),
            sel       => ALUSrcB,
            mux_out   => rd
        );

    Alu: entity work.Alu
        port map (
            rs          => rs,
            rd          => rd,
            ALUControl  => ALUControl,
            ALUResult   => alu_result,
            zero        => zero
        );

    ALUout: entity work.ALUout
        port map (
            clk     => clk,
            reset   => reset,
            load    => load,
            alu_in  => alu_result,
            alu_out => ALUOut
        );

    right_mux4to1: entity work.mux4to1
        port map (
            a => alu_result,
            b => ALUOut,
            c => a_shift_out,
            d => (others => '0'),
            sel       => PCSource,
            mux_out   => pc_in
        );

    ALUControl_unit: entity work.ALUControl
        port map (
            ALUOP      => instruction(31 downto 26),
            funct      => instruction(5 downto 0),
            ALUControl => ALUControl
        );

    control: entity work.control
        port map (
            clk          => clk,
            reset        => reset,
            zero         => zero,
            opcode       => instruction(31 downto 26),
            funct        => instruction(5 downto 0),
            PCWrite      => PCWrite,
            PCWriteCond  => PCWriteCond,
            IorD         => IorD,
            MemRead      => MemRead,
            MemWrite     => MemWrite,
            IRWrite      => IRWrite,
            MemtoReg     => MemtoReg,
            RegDst       => RegDst,
            RegWrite     => RegWrite,
            ALUSrcA      => ALUSrcA,
            ALUSrcB      => ALUSrcB,
            PCSource     => PCSource,
            ALUControl   => ALUControl
        );

    sign_extender: entity work.sign_extender
        port map (
            input16  => instruction(15 downto 0),
            output32 => output32
        );

    A_shift_left2: entity work.shift_left2
        port map (
            shift_in  => instruction(25 downto 0),
            shift_out => a_shift_out
        );

    B_shift_left2: entity work.shift_left2
        port map (
            shift_in  => unsigned_output32,
            shift_out => b_shift_out
        );

    -- Debug outputs
    reg_data1    <= input_regA;
    reg_data2    <= input_regB;
    mem_data_out <= memData;

end architecture sims;

