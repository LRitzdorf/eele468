-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/fftAnalysisSynthesis_tc.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fftAnalysisSynthesis_tc
-- Source Path: fftAnalysisSynthesis_tc
-- Hierarchy Level: 1
-- 
-- Master clock enable input: clk_enable
-- 
-- enb         : identical to clk_enable
-- enb_1_2048_0: 2048x slower than clk with last phase
-- enb_1_2048_1: 2048x slower than clk with phase 1
-- enb_1_4194304_0: 4194304x slower than clk with last phase
-- enb_1_4194304_1: 4194304x slower than clk with phase 1
-- enb_1_4194304_4097: 4194304x slower than clk with phase 4097
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fftAnalysisSynthesis_tc IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        enb                               :   OUT   std_logic;
        enb_1_2048_0                      :   OUT   std_logic;
        enb_1_2048_1                      :   OUT   std_logic;
        enb_1_4194304_0                   :   OUT   std_logic;
        enb_1_4194304_1                   :   OUT   std_logic;
        enb_1_4194304_4097                :   OUT   std_logic
        );
END fftAnalysisSynthesis_tc;


ARCHITECTURE rtl OF fftAnalysisSynthesis_tc IS

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
  SIGNAL count4194304                     : unsigned(21 DOWNTO 0);  -- ufix22
  SIGNAL comp_0_tmp_1                     : std_logic;
  SIGNAL phase_0_tmp_1                    : std_logic;
  SIGNAL phase_0_1                        : std_logic;
  SIGNAL enb_1_4194304_0_1                : std_logic;
  SIGNAL comp_1_tmp_1                     : std_logic;
  SIGNAL phase_1_tmp_1                    : std_logic;
  SIGNAL phase_1_1                        : std_logic;
  SIGNAL enb_1_4194304_1_1                : std_logic;
  SIGNAL comp_4097_tmp                    : std_logic;
  SIGNAL phase_4097_tmp                   : std_logic;
  SIGNAL phase_4097                       : std_logic;
  SIGNAL enb_1_4194304_4097_1             : std_logic;

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
    ELSIF rising_edge(clk) THEN
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
    ELSIF rising_edge(clk) THEN
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
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_1 <= phase_1_tmp;
      END IF;
    END IF;
  END PROCESS phase_delay_1_process;


  enb_1_2048_1_1 <= phase_1 AND clk_enable;

  enb_1_2048_1 <= enb_1_2048_1_1;

  -- Count limited, Unsigned Counter
  --  initial value   = 1
  --  step value      = 1
  --  count to value  = 4194303
  counter_4194304_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      count4194304 <= to_unsigned(16#000001#, 22);
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        count4194304 <= count4194304 + to_unsigned(16#000001#, 22);
      END IF;
    END IF;
  END PROCESS counter_4194304_process;


  
  comp_0_tmp_1 <= '1' WHEN count4194304 = to_unsigned(16#3FFFFF#, 22) ELSE
      '0';

  phase_0_tmp_1 <= comp_0_tmp_1 AND clk_enable;

  phase_delay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_0_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_0_1 <= phase_0_tmp_1;
      END IF;
    END IF;
  END PROCESS phase_delay_2_process;


  enb_1_4194304_0_1 <= phase_0_1 AND clk_enable;

  enb_1_4194304_0 <= enb_1_4194304_0_1;

  
  comp_1_tmp_1 <= '1' WHEN count4194304 = to_unsigned(16#000000#, 22) ELSE
      '0';

  phase_1_tmp_1 <= comp_1_tmp_1 AND clk_enable;

  phase_delay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_1_1 <= '1';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_1_1 <= phase_1_tmp_1;
      END IF;
    END IF;
  END PROCESS phase_delay_3_process;


  enb_1_4194304_1_1 <= phase_1_1 AND clk_enable;

  enb_1_4194304_1 <= enb_1_4194304_1_1;

  
  comp_4097_tmp <= '1' WHEN count4194304 = to_unsigned(16#001000#, 22) ELSE
      '0';

  phase_4097_tmp <= comp_4097_tmp AND clk_enable;

  phase_delay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      phase_4097 <= '0';
    ELSIF rising_edge(clk) THEN
      IF clk_enable = '1' THEN
        phase_4097 <= phase_4097_tmp;
      END IF;
    END IF;
  END PROCESS phase_delay_4_process;


  enb_1_4194304_4097_1 <= phase_4097 AND clk_enable;

  enb_1_4194304_4097 <= enb_1_4194304_4097_1;

END rtl;

