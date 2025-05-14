library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TBench is
end TBench;

architecture sim of TBench is
  signal clk   : std_logic := '0';
  signal reset : std_logic := '1';
  
  constant sim_time : time := 2 us;

begin

  -- Clock generation (20ns period)
  clk_process : process
  begin
    while now < sim_time loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
    wait; 
  end process;

  -- Reset logic
  reset_process : process
  begin
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait;
  end process;

  -- DUT instantiation
  uut: entity work.top
    port map (
      clk   => clk,
      reset => reset
    );

end sim;