library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is

    -- Component Declaration UUT
    component RegisterFile
        Port (
            clk         : in  std_logic;
            regWrite    : in  std_logic;
            readReg1    : in  std_logic_vector(4 downto 0);
            readReg2    : in  std_logic_vector(4 downto 0);
            writeReg    : in  std_logic_vector(4 downto 0);
            writeData   : in  std_logic_vector(31 downto 0);
            readData1   : out std_logic_vector(31 downto 0);
            readData2   : out std_logic_vector(31 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal tb_clk         : std_logic := '0';
    signal tb_regWrite    : std_logic := '0'; 
	
    signal tb_readReg1    : std_logic_vector(4 downto 0);
    signal tb_readReg2    : std_logic_vector(4 downto 0);
    signal tb_writeReg    : std_logic_vector(4 downto 0); 
	
    signal tb_writeData   : std_logic_vector(31 downto 0);	
	
    signal tb_readData1   : std_logic_vector(31 downto 0);
    signal tb_readData2   : std_logic_vector(31 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: registerfile Port Map (
        clk => tb_clk,
        regWrite => tb_regWrite,
        readReg1 => tb_readReg1,
        readReg2 => tb_readReg2,
        writeReg => tb_writeReg,
        writeData => tb_writeData,
        readData1 => tb_readData1,
        readData2 => tb_readData2
    );

    -- Clock generation
    clk_process : process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
    end process;

    -- testing process
	
--	test1: process
--    begin	
--		--[1] reading all 32 registers
--		for i in 0 to 30 loop
--			tb_readReg1<= std_logic_vector(to_unsigned(i,5)); -- iteger-->unsigned(5bits)==> vector
--			tb_readReg2<= std_logic_vector(to_unsigned(i+1,5));
--			wait for clk_period;  
--		end loop; 
--	report "END tb of test 1 register file" severity note;  
--	wait;
--    end process;

--	test2: process
--    begin	 
--		 --[2] Write value 0xAAAA5555 to register 5
--        tb_writeReg <= "00101";  -- register 5
--        tb_writeData <= x"AAAA5555";	
--        tb_regWrite <= '1';
--        wait for clk_period;
--		tb_regWrite <= '0';  -- Stop writing
--	report "END tb of test 2 register file" severity note;
--    end process;                                             
	
	test3: process
    begin	
		--[3]Read from register 5 into both read ports
        tb_readReg1 <= "00101";
        tb_readReg2 <= "00101";
        wait for clk_period;
	report "END tb of test 3 register file" severity note;
   end process;

end behavior;
