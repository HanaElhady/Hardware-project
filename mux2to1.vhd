library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is  
	 generic (
        N : integer := 32
    );
	
    port (
	a, b   : in std_logic_vector(N-1 downto 0);
	sel: in std_logic;
    mux_out : out  std_logic_vector(N-1 downto 0)
    );		
end entity;

architecture sims of mux2to1 is
begin
    with sel select
	
	mux_out <= a when '0',
			   b when others;
	
end architecture;
