library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4to1 is 
	GENERIC (
	N : INTEGER := 32
	);
    port (
        a,b,c,d : in  std_logic_vector(N-1 downto 0);
        sel     : in  std_logic_vector(1 downto 0);
        mux_out : out std_logic_vector(N-1 downto 0)
    );		
end entity;

architecture sims of mux4to1 is
begin
    with sel select
        mux_out <= a when "00",
                   b when "01",
                   c when "10",
                   d when others;
end architecture;

