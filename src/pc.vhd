library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;  -- Active-high reset
        pc_write  : in  std_logic;  -- Load enable
        pc_in     : in  std_logic_vector(31 downto 0);  -- Input value to load into PC
        pc_out    : out std_logic_vector(31 downto 0)   -- Current PC output
    );
end pc;

architecture Behavioral of pc is
    signal temp1 : std_logic_vector(31 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            temp1 <= (others => '0');
        elsif rising_edge(clk) then
            if pc_write = '1' then
                temp1 <= pc_in;
            end if;
        end if;
    end process;

    pc_out <= temp1;

end architecture;
