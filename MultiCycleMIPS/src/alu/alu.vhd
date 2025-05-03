library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alu is 
    port (
        rs, rd       : in std_logic_vector(31 downto 0);	
        ALUControl   : in std_logic_vector(3 downto 0);
        ALUResult    : out std_logic_vector(31 downto 0);
        zero         : out std_logic
    );		
end entity;

architecture sims of Alu is
    signal result : std_logic_vector(31 downto 0);
begin 		
    process(rs, rd, ALUControl)
    begin
        case ALUControl is
            when "0000" =>  -- AND
                result <= rs and rd;

            when "0001" =>  -- OR
                result <= rs or rd;

            when "0010" =>  -- ADD
                result <= std_logic_vector(signed(rs) + signed(rd));

            when "0110" =>  -- SUB
                result <= std_logic_vector(signed(rs) - signed(rd));

            when "0111" =>  -- SLT
                if signed(rs) < signed(rd) then
                    result <= (31 downto 1 => '0') & '1';
                else
                    result <= (others => '0');
                end if;

            when others =>
                result <= (others => '0');
        end case;

        -- Set zero flag
        if result = (others => '0') then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;

    ALUResult <= result;

end architecture;

	
