library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alu is 
    port (
        rs, rd       : in  std_logic_vector(31 downto 0);
        ALUControl   : in  std_logic_vector(3 downto 0);
        ALUResult    : out std_logic_vector(31 downto 0);
        zero         : out std_logic
    );		
end entity;

architecture sims of Alu is
begin 		
    process(rs, rd, ALUControl)
        variable result : signed(31 downto 0);
    begin
        case ALUControl is
            when "0000" =>  -- AND
                result := signed(rs) and signed(rd);

            when "0001" =>  -- OR
                result := signed(rs) or signed(rd);

            when "0010" =>  -- ADD
                result := signed(rs) + signed(rd);

            when "0110" =>  -- SUB
                result := signed(rs) - signed(rd);

            when "0111" =>  -- SLT
                if signed(rs) < signed(rd) then
                    result := (others => '0');
                    result(0) := '1';  -- Set LSB
                else
                    result := (others => '0');
                end if;

            when others =>
                result := (others => '0');
        end case;

        -- Set zero flag
        if result = 0 then
            zero <= '1';
        else
            zero <= '0';
        end if;

        ALUResult <= std_logic_vector(result);
    end process;
end architecture;

	