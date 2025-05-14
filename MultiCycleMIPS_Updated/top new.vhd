library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is  
    port (
        clk   : in std_logic;
        reset : in std_logic
    );	 
end entity top;

architecture sims of top is

  constant PC_increment : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";
-- signals
  signal PC_out, MuxToAddress, MemDataOut, MemoryDataRegOut, InstructionRegOut, MuxToWriteData,
  ReadData1ToA, ReadData2ToB, RegAToMux, RegBOut, SignExtendOut, ShiftLeft1ToMux4, MuxToAlu,
  Mux4ToAlu, AluResultOut, AluOutToMux, JumpAddress, MuxToPC : std_logic_vector(31 downto 0);
  
  signal ZeroCarry_TL, ALUSrcA_TL, RegWrite_TL, RegDst_TL, PCWriteCond_TL, PCWrite_TL, IorD_TL,
  MemRead_TL, MemWrite_TL, MemToReg_TL, IRWrite_TL, ANDtoOR, ORtoPC : std_logic;
  signal MuxToWriteRegister : std_logic_vector(4 downto 0);
  signal ALUControltoALU : std_logic_vector(3 downto 0);
  signal PCsource_TL, ALUSrcB_TL, ALUOp_TL : std_logic_vector(1 downto 0);

begin

  ANDtoOR <= ZeroCarry_TL and PCWriteCond_TL;
  ORtoPC <= ANDtoOR or PCWrite_TL;
  JumpAddress(31 downto 28) <= PC_out(31 downto 28); 
  
    pc: entity work.pc
        port map (
            clk      => clk,
            reset    => reset,
            pc_write => ORtoPC,
            pc_in    => MuxToPC,
            pc_out   => PC_out
        );

    A_mux2to1: entity work.mux2to1	 
        port map (
            a         => PC_out, 
            b         => AluOutToMux,
            sel       => IorD_TL,
            mux_out   => MuxToAddress
        );
	
	Memory : entity work.Memory 
		port map(
	    	-- Inputs
		    CLK       => clk,
		    reset 	  => reset,
		    address   => MuxToAddress,	
			MemRead   => MemRead_TL,
            MemWrite  => MemWrite_TL,
		    WriteData => RegBOut,
	   		MemData   => MemDataOut
  );  
  InstructionRegister : entity work.InstructionRegister 
	  port map(
	    CLK       	    => clk,
	    reset 	  	    => reset,   
	    IRWrite   	    => IRWrite_TL,
	    in_instruction  => MemDataOut ,
	    out_instruction => InstructionRegOut
	  );
  MemoryDataRegister : entity work.MemoryDataRegister
    port map ( 
        CLK       => clk,
		reset 	  => reset,
        input     => MemDataOut,
        output    => MemoryDataRegOut
    );
   

    B_mux2to1: entity work.mux2to1
      generic map (N => 5)
        port map (
            a       => InstructionRegOut(20 downto 16),  -- rt
            b       => InstructionRegOut(15 downto 11),  -- rd
            sel     => RegDst_TL,
            mux_out => MuxToWriteRegister
        );

    C_mux2to1: entity work.mux2to1
        port map (
            a       => AluOutToMux,
            b       => MemoryDataRegOut,
            sel     => MemToReg_TL,
            mux_out => MuxToWriteData
        );

    registerfile: entity work.registerfile
        port map (
            clk        => clk,
            regWrite   => RegWrite_TL,
            readReg1   => InstructionRegOut(25 downto 21),
            readReg2   => InstructionRegOut(20 downto 16),
            writeReg   => MuxToWriteRegister,
            writeData  => MuxToWriteData,
            readData1  => ReadData1ToA,
            readData2  => ReadData2ToB
        );

    A_Register: entity work.A_Register
        port map (
            clk   => clk,
            A_in  => ReadData1ToA,
            A_out => RegAToMux
        );

    B_Register: entity work.B_Register
        port map (
            clk   => clk,
            B_in  => ReadData2ToB,
            B_out => RegBOut
        );

    D_mux2to1: entity work.mux2to1
        port map (
            a       => PC_out,
            b       => RegAToMux,
            sel     => ALUSrcA_TL,
            mux_out => MuxToAlu
        );

    left_mux4to1: entity work.mux4to1
        port map (
            a       => RegBOut,
            b       => PC_increment,
            c       => SignExtendOut ,			
            d       => ShiftLeft1ToMux4,
            sel     => ALUSrcB_TL,
            mux_out => Mux4ToAlu
        );

    Alu: entity work.Alu
        port map (
            rs          => MuxToAlu,
            rd          => Mux4ToALU,
            ALUControl  => ALUControltoALU,
            ALUResult   => AluResultOut,
            zero        => ZeroCarry_TL
        );

    ALUoutput: entity work.ALUout
        port map (
            clk     => clk,
            reset   => reset,
            alu_in  => AluResultOut,
            alu_out => AluOutToMux
        );

    right_mux4to1: entity work.mux4to1
        port map (
            a       => AluResultOut,
            b       => AluOutToMux,
            c       => JumpAddress,
            d       => (others => '0'),
            sel     => PCsource_TL,
            mux_out => MuxToPC	
        );

    ALUControl_unit: entity work.ALUControl
        port map (
            ALUOP      => ALUOp_TL,
            funct      => InstructionRegOut(5 downto 0),
            ALUControl => ALUControltoALU
        );

    ControlFSM : entity work.ControlFSM  
        port map(
            clk          => clk,
            reset        => reset,
			
            zero         => ZeroCarry_TL, 
			
            opcode       => InstructionRegOut(31 downto 26),
            
			PCWrite      => PCWrite_TL,
            PCWriteCond  => PCWriteCond_TL,
            IorD         => IorD_TL,
            MemRead      => MemRead_TL,
            MemWrite     => MemWrite_TL,
            IRWrite      => IRWrite_TL,
            MemtoReg     => MemToReg_TL,
            RegDst       => RegDst_TL,
            RegWrite     => RegWrite_TL,
            ALUSrcA      => ALUSrcA_TL,
            ALUSrcB      => ALUSrcB_TL, 
            ALUOp        => ALUOp_TL,
            PCSource     => PCsource_TL
        );

    sign_extender: entity work.sign_extender
        port map (
            input16  => InstructionRegOut(15 downto 0),
            output32 => SignExtendOut
        );

    A_shift_left2: entity work.shift_left2
        port map (
            shift_in  => SignExtendOut,
            shift_out => ShiftLeft1ToMux4
        );

    B_shift_left2: entity work.ShiftLeft
        port map (
            shift_in  => InstructionRegOut(25 downto 0),
            shift_out => JumpAddress(27 downto 0)
        );

end architecture sims;