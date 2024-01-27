-- Lucas Ritzdorf
-- 01/23/2024
-- EELE 468

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- ADC controller interface
entity ADC_Controller is
    port (
        -- External interface
        clk      : in  std_logic;
        reset    : in  std_logic;
        config   : in  std_logic_vector(15 downto 0);
        sample   : out std_logic_vector(11 downto 0);
        samp_ok  : out std_logic;
        samp_idx : out std_logic_vector(3 downto 0);
        -- ADC control interface
        convst : out std_logic;
        sck    : out std_logic;
        sdi    : out std_logic;
        sdo    : in  std_logic
    );
end entity;


-- ADC controller implementation
architecture ADC_Controller_Arch of ADC_Controller is

    -- Traverser status/control signals
    signal traverser_run, traverser_found : std_logic;

    signal shift_clk : std_logic;
    -- Config shift register (output) signals
    signal config_data : std_logic_vector(5 downto 0);
    signal config_load : std_logic;

    -- IP components
    component shiftreg_s2p is
        port (
            clock   : in std_logic;
            shiftin : in std_logic;
            q       : out std_logic_vector(11 downto 0)
        );
    end component;
    component shiftreg_p2s is
        port (
            clock    : in std_logic;
            data     : in std_logic_vector(5 downto 0);
            load     : in std_logic;
            shiftout : out std_logic
        );
    end component;

begin

    -- Traverser component, wired to pause itself upon success
    traverser : entity work.Vector_Traverser
    generic map (
        WIDTH => 16
    )
    port map (
        clk    => clk,
        reset  => reset,
        vector => config,
        -- Run until a 1 is found, or if traverser_run is asserted
        run    => (not traverser_found) or traverser_run,
        index  => samp_idx,
        value  => traverser_found
    );

    -- Shift registers
    -- Capture serial input data into parallel vector
    shiftreg_s2p_inst : shiftreg_s2p port map (
        clock   => shift_clk,
        shiftin => sdo,
        q       => sample
    );
    -- Transmit configuration vector in serial form
    shiftreg_p2s_inst : shiftreg_p2s port map (
        clock    => shift_clk,
        data     => config_data,
        load     => config_load,
        shiftout => sdi
    );
    sck <= shift_clk;   -- Pass shift clock to ADC

end architecture;
