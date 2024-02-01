-- Lucas Ritzdorf
-- 01/30/2024
-- EELE 468

use std.env.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.uniform;  -- For random number generation


-- ADC controller testbench
entity ADC_Controller_TB is
end entity;

architecture ADC_Controller_TB_Arch of ADC_Controller_TB is
    constant CLK_PER  : time := 20 ns;
    constant DATA_PER : time := 42 ns;  -- Not just alternating 0s and 1s

    signal clk, reset  : std_logic;
    signal config      : std_logic_vector(15 downto 0);
    signal convst, sdo : std_logic;
begin

    -- ADC controller DUT instance
    dut : entity work.ADC_Controller
    port map (
        -- External interface
        clk        => clk,
        reset      => reset,
        config_reg => config,
        sample     => open,
        sample_wr  => open,
        sample_idx => open,
        -- ADC control interface
        convst => convst,
        sck    => open,
        sdi    => open,
        sdo    => sdo
    );

    -- Clock driver
    clock : process is
    begin
        clk <= '1';
        while true loop
            wait for CLK_PER / 2;
            clk <= not clk;
        end loop;
    end process;

    -- Data driver
    fake_data : process is
    begin
        sdo <= '0';
        while true loop
            wait for DATA_PER / 2;
            sdo <= not sdo;
        end loop;
    end process;

    -- Test driver
    -- NOTE: This testbench is NOT automated! This would be rather intensive to
    -- build, and would likely be rather fragile anyway. Instead, it simply
    -- produces a representative set of inputs, and requires that the DUT's
    -- outputs be manually verified.
    tester : process is
    begin
        wait until falling_edge(clk);

        -- Initialization: reset system
        reset <= '1';
        for i in 1 to 5 loop
            wait until falling_edge(clk);
        end loop;
        reset <= '0';
        wait until rising_edge(convst);

        -- Test case: Normal use case
        config <= b"0010_0000_0010_0101";
        -- Let the system run for a few cycles
        for i in 1 to 6 loop
            wait until rising_edge(convst);
        end loop;

        finish;
    end process;

end architecture;
