-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/combFilterFeedforward/Delay.vhd
-- Created: 2024-03-12 15:48:15
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Delay
-- Source Path: combFilterFeedforward/combFilterSystem/combFilterFeedforward/Delay
-- Hierarchy Level: 2
-- Model version: 6.1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Delay IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        audioIn                           :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        delayM                            :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
        delayedAudioOut                   :   OUT   std_logic_vector(23 DOWNTO 0)  -- sfix24_En23
        );
END Delay;


ARCHITECTURE rtl OF Delay IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          dout                            :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : SimpleDualPortRAM_generic
    USE ENTITY work.SimpleDualPortRAM_generic(rtl);

  -- Signals
  SIGNAL count_step                       : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL write_addr_counter_out1          : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL count                            : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL always_write_out1                : std_logic;
  SIGNAL delayM_unsigned                  : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Sub_out1                         : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Simple_DPRAM_out1                : std_logic_vector(23 DOWNTO 0);  -- ufix24

BEGIN
  -- Note: The value of delayM must be greater than zero
  -- since addr_A can't be the same as addr_B, which will cause
  -- Simulink to throw an error.
  -- Circular Buffer 
  -- Write Address Generator

  u_Simple_DPRAM : SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 16,
                 DataWidth => 24
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => audioIn,
              wr_addr => std_logic_vector(write_addr_counter_out1),
              wr_en => always_write_out1,
              rd_addr => std_logic_vector(Sub_out1),
              dout => Simple_DPRAM_out1
              );

  count_step <= to_unsigned(16#0001#, 16);

  count <= write_addr_counter_out1 + count_step;

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  write_addr_counter_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      write_addr_counter_out1 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        write_addr_counter_out1 <= count;
      END IF;
    END IF;
  END PROCESS write_addr_counter_process;


  always_write_out1 <= '1';

  delayM_unsigned <= unsigned(delayM);

  Sub_out1 <= write_addr_counter_out1 - delayM_unsigned;

  delayedAudioOut <= Simple_DPRAM_out1;

END rtl;

