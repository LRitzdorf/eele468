-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/combFilterFeedforward/combFilterSystem_tc.vhd
-- Created: 2024-03-20 10:34:09
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: combFilterSystem_tc
-- Source Path: combFilterSystem_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb         : identical to clk_enable
-- enb_1_2048_0: 2048x slower than clk with last phase
-- enb_1_2048_1: 2048x slower than clk with phase 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY combFilterSystem_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb                               :   OUT   std_logic;
        enb_1_2048_0                      :   OUT   std_logic;
        enb_1_2048_1                      :   OUT   std_logic
        );
END combFilterSystem_tc;


ARCHITECTURE rtl OF combFilterSystem_tc IS

  ATTRIBUTE multstyle : string;

  -- Signals
  SIGNAL count2048                        : unsigned(10 DOWNTO 0);  -- ufix11
  SIGNAL comp_0_tmp                       : std_logic;
  SIGNAL phase_0_tmp                      : std_logic;
  SIGNAL phase_0                          : std_logic;
  SIGNAL enb_1_2048_0_1                   : std_logic;
  SIGNAL comp_1_tmp                       : std_logic;
  SIGNAL phase_1_tmp                      : std_logic;
  SIGNAL phase_1                          : std_logic;
  SIGNAL enb_1_2048_1_1                   : std_logic;

BEGIN
  enb <= clk_enable;

  -- Count limited, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  --  count to value  = 2047
  counter_2048_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count2048 <= to_unsigned(16#001#, 11);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF clk_enable = '1' THEN
        count2048 <= count2048 + to_unsigned(16#001#, 11);
      END IF;
    END IF;
  END PROCESS counter_2048_process;


  
  comp_0_tmp <= '1' WHEN count2048 = to_unsigned(16#7FF#, 11) ELSE
      '0';

  phase_0_tmp <= comp_0_tmp AND clk_enable;

  phase_delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_0 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF clk_enable = '1' THEN
        phase_0 <= phase_0_tmp;
      END IF;
    END IF;
  END PROCESS phase_delay_process;


  enb_1_2048_0_1 <= phase_0 AND clk_enable;

  enb_1_2048_0 <= enb_1_2048_0_1;

  
  comp_1_tmp <= '1' WHEN count2048 = to_unsigned(16#000#, 11) ELSE
      '0';

  phase_1_tmp <= comp_1_tmp AND clk_enable;

  phase_delay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF clk_enable = '1' THEN
        phase_1 <= phase_1_tmp;
      END IF;
    END IF;
  END PROCESS phase_delay_1_process;


  enb_1_2048_1_1 <= phase_1 AND clk_enable;

  enb_1_2048_1 <= enb_1_2048_1_1;

END rtl;

