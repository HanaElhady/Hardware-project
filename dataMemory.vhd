library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DataMemory is
    port(
        Address   : in  std_logic_vector(31 downto 0);
        WriteData : in  std_logic_vector(31 downto 0);
        MemRead   : in  std_logic;
        MemWrite  : in  std_logic;
        ReadData  : out std_logic_vector(31 downto 0)
    );
end entity;

architecture behavior of DataMemory is
    type RAM32 is array (0 to 15) of std_logic_vector(31 downto 0);
    signal DM : RAM32 := (
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000",
        x"00000000", x"00000000", x"00000000", x"00000000"
    );

    constant BASE_ADDR : integer := 16#10010000#;
    constant END_ADDR  : integer := BASE_ADDR + 4 * 15; -- last address = 0x1001003C

begin
    process (MemWrite, MemRead)
        variable addr_int : integer;
        variable index    : integer;
    begin
        addr_int := to_integer(unsigned(Address));
        index := (addr_int - BASE_ADDR) / 4;

        if (addr_int >= BASE_ADDR and addr_int <= END_ADDR) then
            if MemWrite = '1' then
                DM(index) <= WriteData;
            end if;

            if MemRead = '1' then
                ReadData <= DM(index);
            else
                ReadData <= (others => '0');
            end if;
        else
            ReadData <= (others => '0'); -- Prevent invalid memory read
        end if;
    end process;
end architecture;
