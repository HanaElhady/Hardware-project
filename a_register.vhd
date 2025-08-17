library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A_Register is
    Port (
        clk   : in  std_logic;
        A_in  : in  std_logic_vector(31 downto 0);
        A_out : out std_logic_vector(31 downto 0)
    );
end A_Register;

architecture Behavioral of A_Register is
    signal temp : std_logic_vector(31 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            temp <= A_in;
        end if;
    end process;

    A_out <= temp;
end Behavioral;

