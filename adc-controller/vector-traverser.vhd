-- Lucas Ritzdorf
-- 01/26/2024
-- EELE 468

use work.common.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- Vector traverser interface
entity Vector_Traverser is
    generic (
        WIDTH : positive
    );
    port (
        clk    : in  std_logic;
        reset  : in  std_logic;
        vector : in  std_logic_vector(WIDTH-1 downto 0);
        run    : in  std_logic;
        index  : out std_logic_vector(clog2(WIDTH)-1 downto 0);
        value  : out std_logic
    );
end entity;


-- Vector traverser implementation
architecture Vector_Traverser_Arch of Vector_Traverser is
    signal count : natural range 0 to WIDTH-1;
begin

    -- Manage counter
    counter : process (clk) is
    begin
        if rising_edge(clk) then
            if reset then
                count <= 0;
            elsif run then
                if count >= WIDTH-1 then
                    count <= 0;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    -- Produce index and bit at that index
    index <= std_logic_vector(to_unsigned(count, index'length));
    value <= vector(count);

end architecture;
