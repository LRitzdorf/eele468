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

begin

end architecture;
