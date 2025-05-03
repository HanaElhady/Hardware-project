library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4to1 is 
    port (
        mux_in  : in  std_logic_vector(3 downto 0);	  
        sel     : in  std_logic_vector(1 downto 0);
        mux_out : out std_logic
    );		
end entity;

architecture sims of mux4to1 is
begin
    with sel select
        mux_out <= mux_in(0) when "00",
                   mux_in(1) when "01",
                   mux_in(2) when "10",
                   mux_in(3) when others;
end architecture;

