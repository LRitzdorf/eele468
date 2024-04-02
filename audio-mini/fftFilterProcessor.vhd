-- altera vhdl_input_version vhdl_2008

-- Lucas Ritzdorf
-- 04/01/2024
-- EELE 468

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- HPS interface for FFT filter processor
entity fftFilterProcessor is
    port (
        clk                      : in  std_logic;  -- system clock
        reset                    : in  std_logic;  -- system reset, active high

        -- Avalon streaming interface (audio sink)
        avalon_st_sink_valid     : in  std_logic;
        avalon_st_sink_data      : in  std_logic_vector(23 downto 0);
        avalon_st_sink_channel   : in  std_logic_vector(0 downto 0);
        -- Avalon streaming interface (audio source)
        avalon_st_source_valid   : out std_logic;
        avalon_st_source_data    : out std_logic_vector(23 downto 0);
        avalon_st_source_channel : out std_logic_vector(0 downto 0);

        -- Avalon memory-mapped interface (control registers)
        avalon_mm_address        : in  std_logic_vector(0 downto 0);
        avalon_mm_read           : in  std_logic;
        avalon_mm_readdata       : out std_logic_vector(31 downto 0);
        avalon_mm_write          : in  std_logic;
        avalon_mm_writedata      : in  std_logic_vector(31 downto 0)
    );
end entity;


architecture fftFilterProcessor_Arch of fftFilterProcessor is

    -- Actual FFT filter component, generated by MATLAB HDL Coder
    component fftAnalysisSynthesis is
        port (
            clk          : in  std_logic;
            reset        : in  std_logic;
            clk_enable   : in  std_logic;
            audioIn      : in  std_logic_vector(23 downto 0);  -- sfix24_En23
            passthrough  : in  std_logic;  -- ufix1
            filterSelect : in  std_logic_vector(1 downto 0);  -- ufix2
            ce_out       : out std_logic;
            audioOut     : out std_logic_vector(23 downto 0)  -- sfix24_En23
        );
    end component;

    -- Avalon streaming to left/right-clocked interface converter
    component ast2lr is
        port (
            clk                 : in  std_logic;
            avalon_sink_data    : in  std_logic_vector(23 downto 0);
            avalon_sink_channel : in  std_logic;
            avalon_sink_valid   : in  std_logic;
            data_left           : out std_logic_vector(23 downto 0);
            data_right          : out std_logic_vector(23 downto 0)
        );
    end component ast2lr;

    -- Left/right-clocked to Avalon streaming interface converter
    component lr2ast is
        port (
            clk                   : in  std_logic;
            avalon_sink_channel   : in  std_logic;
            avalon_sink_valid     : in  std_logic;
            data_left             : in  std_logic_vector(23 downto 0);
            data_right            : in  std_logic_vector(23 downto 0);
            avalon_source_data    : out std_logic_vector(23 downto 0);
            avalon_source_channel : out std_logic;
            avalon_source_valid   : out std_logic
        );
    end component lr2ast;

    -- Internal audio data signals
    signal
        left_sink_data, right_sink_data,
        left_source_data, right_source_data
        : std_logic_vector(23 downto 0);

    -- Avalon-mapped control registers
    -- NOTE: These apply to both channels (i.e. mono control), though stereo
    --     control is achievable by duplicating the registers and connecting
    --     them to the appropriate component instances.
    signal passthrough  : std_logic;
    signal filterSelect : std_logic_vector(1 downto 0);

begin

    u_ast2lr : component ast2lr
        port map (
            clk                 => clk,
            avalon_sink_data    => avalon_st_sink_data,
            avalon_sink_channel => avalon_st_sink_channel(0),
            avalon_sink_valid   => avalon_st_sink_valid,
            data_left           => left_sink_data,
            data_right          => right_sink_data
        );
    u_lr2ast : component lr2ast
        port map (
            clk                   => clk,
            avalon_sink_channel   => avalon_st_sink_channel(0),
            avalon_sink_valid     => avalon_st_sink_valid,
            data_left             => left_source_data,
            data_right            => right_source_data,
            avalon_source_data    => avalon_st_source_data,
            avalon_source_channel => avalon_st_source_channel(0),
            avalon_source_valid   => avalon_st_source_valid
        );

    -- One filter system for each channel
    left_filter : component fftAnalysisSynthesis
        port map (
            clk          => clk,
            reset        => reset,
            clk_enable   => '1',
            audioIn      => left_sink_data,
            passthrough  => passthrough,
            filterSelect => filterSelect,
            ce_out       => open,
            audioOut     => left_source_data
        );
    right_filter : component fftAnalysisSynthesis
        port map (
            clk          => clk,
            reset        => reset,
            clk_enable   => '1',
            audioIn      => right_sink_data,
            passthrough  => passthrough,
            filterSelect => filterSelect,
            ce_out       => open,
            audioOut     => right_source_data
        );

    -- Manage reading from mapped registers
    avalon_register_read : process (clk) is
    begin
        if rising_edge(clk) and (?? avalon_mm_read) then
            case avalon_mm_address is
                when "0" => avalon_mm_readdata <= std_logic_vector(to_unsigned(0, avalon_mm_readdata'length-1)) & passthrough;
                when "1" => avalon_mm_readdata <= std_logic_vector(resize(unsigned(filterSelect), avalon_mm_readdata'length));
                when others => null;
            end case;
        end if;
    end process;

    -- Manage writing to mapped registers
    avalon_register_write : process (clk, reset) is
    begin
        if reset then
            passthrough  <= '0';   -- No passthrough
            filterSelect <= "01";  -- Bandpass filter
        elsif rising_edge(clk) and (?? avalon_mm_write) then
            case avalon_mm_address is
                when "0" =>
                    -- This should really be an inline when/else statement, but Quartus Standard doesn't support those
                    if avalon_mm_writedata = 32x"0" then
                        passthrough <= '0';
                    else
                        passthrough <= '1';
                    end if;
                when "1" => filterSelect <= std_logic_vector(resize(unsigned(avalon_mm_writedata), filterSelect'length));
                when others => null;
            end case;
        end if;
    end process;

end architecture;
