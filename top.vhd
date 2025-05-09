library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is  
	
    port (
    clk, reset, load : in 	 std_logic;
	pc_in 			 : inout std_logic_vector(31 downto 0);
    pc_out       	 : out 	 std_logic_vector(31 downto 0);
    instruction  	 : out   std_logic_vector(31 downto 0);
    alu_result , alu_out   	 : out 	 std_logic_vector(31 downto 0);
    mem_data_out 	 : out 	 std_logic_vector(31 downto 0);
    reg_data1    	 : out 	 std_logic_vector(31 downto 0);
    reg_data2    	 : out 	 std_logic_vector(31 downto 0)
    );	 
end entity top;

architecture sims of top is

    signal A_mux_out, memData, C_mux_out,output32 : std_logic_vector(31 downto 0);
    signal input_regA, output_regA, output_regB, input_regB , memory_data_register_output : std_logic_vector(31 downto 0);
    signal rs, rd, ALUOut : std_logic_vector(31 downto 0);
    signal b_shift_out, a_shift_out : std_logic_vector(31 downto 0);  
    signal B_mux_out : std_logic_vector(4 downto 0);
    signal ALUOP : std_logic_vector(1 downto 0);

    signal zero, PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, RegDst, RegWrite, ALUSrcA : std_logic;
    signal ALUSrcB, PCSource : std_logic_vector(1 downto 0);
    signal ALUControl : std_logic_vector(3 downto 0);

 
    signal jump_shift_input : std_logic_vector(31 downto 0);

    -- Internal signals in top port	
	signal instruction_internal , pc_out_internal , alu_result_internal :std_logic_vector(31 downto 0);
    

begin
	
	 -- Assign internals to output port
    instruction <= instruction_internal;
	pc_out   	<= pc_out_internal;
	alu_result  <= alu_result_internal;	
	alu_out <= ALUOut;
	
    pc: entity work.pc
        port map (
            clk      => clk,
            reset    => reset,
            pc_write => PCWrite,
            pc_in    => pc_in,
            pc_out   => pc_out_internal	 
        );

    A_mux2to1: entity work.mux2to1
        port map (
            a         => pc_out_internal, 
            b         => ALUOut,
            sel       => IorD,
            mux_out   => A_mux_out
        );
	
	Memory : entity work.Memory 
		port map(
	    	-- Inputs
		    CLK       => clk,
		    reset 	  => reset,
		    address   => A_mux_out,	
			MemRead   => MemRead,
            MemWrite  => MemWrite,
		    WriteData => output_regB,
	   		MemData   => memData
  );  
  InstructionRegister : entity work.InstructionRegister 
	  port map(
	    CLK       	    => clk,
	    reset 	  	    => reset,   
	    IRWrite   	    => IRWrite,
	    in_instruction  => memData ,
	    out_instruction => instruction_internal
	  );
  MemoryDataRegister : entity work.MemoryDataRegister
    port map ( 
        CLK       => clk,
		reset 	  => reset,
        input     => memData,
        output    => memory_data_register_output
    );
   

    B_mux2to1: entity work.mux2to1
        generic map (N => 5)
        port map (
            a       => instruction_internal(20 downto 16),  -- rt
            b       => instruction_internal(15 downto 11),  -- rd
            sel     => RegDst,
            mux_out => B_mux_out
        );

    C_mux2to1: entity work.mux2to1
        port map (
            a       => ALUOut,
            b       => memory_data_register_output,
            sel     => MemtoReg,
            mux_out => C_mux_out
        );

    registerfile: entity work.registerfile
        port map (
            clk        => clk,
            regWrite   => RegWrite,
            readReg1   => instruction_internal(25 downto 21),
            readReg2   => instruction_internal(20 downto 16),
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
            a       => pc_out_internal,
            b       => output_regA,
            sel     => ALUSrcA,
            mux_out => rs
        );

    left_mux4to1: entity work.mux4to1
        port map (
            a       => output_regB,
            b       => X"00000004",
            c       => output32 ,			
            d       => b_shift_out,
            sel     => ALUSrcB,
            mux_out => rd
        );

    Alu: entity work.Alu
        port map (
            rs          => rs,
            rd          => rd,
            ALUControl  => ALUControl,
            ALUResult   => alu_result_internal,
            zero        => zero
        );

    ALUoutput: entity work.ALUout
        port map (
            clk     => clk,
            reset   => reset,
            load    => load,
            alu_in  => alu_result_internal,
            alu_out => ALUOut
        );

    right_mux4to1: entity work.mux4to1
        port map (
            a       => alu_result_internal,
            b       => ALUOut,
            c       => a_shift_out,
            d       => (others => '0'),
            sel     => PCSource,
            mux_out => pc_in	
        );

    ALUControl_unit: entity work.ALUControl
        port map (
            ALUOP      => ALUOP,
            funct      => instruction_internal(5 downto 0),
            ALUControl => ALUControl
        );

    ControlFSM : entity work.ControlFSM  
        port map(
            clk          => clk,
            reset        => reset,
            zero         => zero,
            opcode       => instruction_internal(31 downto 26),
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
            ALUOp        => ALUOP,
            PCSource     => PCSource
        );

    sign_extender: entity work.sign_extender
        port map (
            input16  => instruction_internal(15 downto 0),
            output32 => output32
        );

    --  Corrected jump input shift
    jump_shift_input <= "000000" & instruction_internal(25 downto 0);

    A_shift_left2: entity work.shift_left2
        port map (
            shift_in  => jump_shift_input,
            shift_out => a_shift_out
        );

    B_shift_left2: entity work.shift_left2
        port map (
            shift_in  => output32,
            shift_out => b_shift_out
        );

    -- Debug outputs
    reg_data1    <= input_regA;
    reg_data2    <= input_regB;
    mem_data_out <= memData;

end architecture sims;
