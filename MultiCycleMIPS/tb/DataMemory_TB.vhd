library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory_TB is
end entity;

architecture behavior of DataMemory_TB is
    signal Address    : std_logic_vector(31 downto 0) := (others => '0');
    signal WriteData  : std_logic_vector(31 downto 0) := (others => '0');
    signal MemRead    : std_logic := '0';
    signal MemWrite   : std_logic := '0';
    signal ReadData   : std_logic_vector(31 downto 0);
begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.DataMemory
        port map (
            Address    => Address,
            WriteData  => WriteData,
            MemRead    => MemRead,
            MemWrite   => MemWrite,
            ReadData   => ReadData
        );

    -- Stimulus process
    process
    begin
        -- Write 0x11112222 to address 0x10010000
        Address    <= x"10010000";
        WriteData  <= x"11112222";
        MemWrite   <= '1';
        wait for 10 ns;
        MemWrite   <= '0';
        wait for 10 ns;

        -- Write 0x33334444 to address 0x10010004
        Address    <= x"10010004";
        WriteData  <= x"33334444";
        MemWrite   <= '1';
        wait for 10 ns;
        MemWrite   <= '0';
        wait for 10 ns;

        -- Read from address 0x10010000
        Address    <= x"10010000";
        MemRead    <= '1';
        wait for 10 ns;
        MemRead    <= '0';
        wait for 10 ns;

        -- Read from address 0x10010004
        Address    <= x"10010004";
        MemRead    <= '1';
        wait for 10 ns;
        MemRead    <= '0';
        wait for 10 ns;

        assert false report "End of testbench" severity failure;
    end process;
end architecture;
