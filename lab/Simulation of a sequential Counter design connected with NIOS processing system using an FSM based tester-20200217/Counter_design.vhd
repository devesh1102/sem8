-- This Counter design takes in two 32 bit count values and counts for ('count1' + 'count2') cycles.
-- The design is FSM based consisting of 3 states : 'stIdle', 'stCounting', 'stFinished'.
-- It begins with the 'stIdle' state. Proceeds to 'stCounting' state once the 'start' signal is received.
-- In the 'stCounting' state, it maintains a count variable 'curr_count' and increments it every cycle of 'counter_clock'.
-- Once 'counter_clock' equals the 'total_count' (sum of both the input counts), it proceeds to the 'stFinished' state, setting the 'finished' output signal.
-- Once 'finished' signal is received, we can read the 32 bit 'count_out' output port to read the corect sum of both the input counts.


library std;
use std.standard.all;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity Counter_design is
    port( 
         counter_clk, reset_n, start : in std_logic;
         count1, count2 : in std_logic_vector(31 downto 0);
         count_out : out std_logic_vector(31 downto 0);
         finished : out std_logic := '0'
         );
end entity;

architecture behave of Counter_design is
  signal total_count : integer;
  type t_state is (stIdle, stCounting, stFinished);
  signal state : t_state := stIdle;
  signal one_value : std_logic_vector(31 downto 0);

begin
    total_count <= to_integer(unsigned(count1)) + to_integer(unsigned(count2));

    finished <= '1' when (state = stFinished) else
                '0';

           
   one_value <= (0 => '1', others => '0');

    process(counter_clk, reset_n)
        variable curr_count_int : integer := 0;
       variable curr_count : unsigned(31 downto 0) := (others => '0');
    begin
        if (reset_n = '0') then
          state <= stIdle;
          curr_count_int := 0;
          curr_count := (others => '0');
        elsif (counter_clk'event and counter_clk = '1') then
            case (state) is
                when stIdle =>
                    if (start = '1') then
                        state <= stCounting ;
                        curr_count_int := 0;
                        curr_count := (others => '0');
                    end if;
                when stCounting =>
                    curr_count_int := curr_count_int + 1;
                    curr_count := curr_count + unsigned(one_value);
                    if(curr_count = total_count) then
                        state <= stFinished;
                    end if;
                when stFinished =>
                    state <= stIdle;
            end case;
        end if;

        count_out <= std_logic_vector(curr_count);
    
    end process;

end behave;