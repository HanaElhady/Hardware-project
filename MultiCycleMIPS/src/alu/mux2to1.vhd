library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is 
    port (
	mux_in  : in  std_logic_vector(1 downto 0);	  
	sel: in std_logic;
       mux_out : out std_logic
    );		
end entity;

architecture sims of mux2to1 is
begin
    with sel select
	
	mux_out <= mux_in(0) when '0',
			   mux_in(1) when others;
	
end architecture;
