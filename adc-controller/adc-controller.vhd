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
        clk        : in  std_logic;
        reset      : in  std_logic;
        config_reg : in  std_logic_vector(15 downto 0);
        sample     : out std_logic_vector(11 downto 0);
        sample_wr  : out std_logic;
        sample_idx : out std_logic_vector(3 downto 0);
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
    signal traverser_launch, traverser_found : std_logic;

    -- Shift register signals
    signal shift_clk : std_logic;
    signal config_idx  : std_logic_vector(3 downto 0);
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
        vector => config_reg,
        -- Run until a 1 is found, or if explicitly launched
        run    => (not traverser_found) or traverser_launch,
        index  => config_idx,
        value  => traverser_found
    );

    -- ADC config translator component (sequential)
    translator : entity work.Config_Translator
    port map (
        index  => config_idx,
        config => config_data
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
