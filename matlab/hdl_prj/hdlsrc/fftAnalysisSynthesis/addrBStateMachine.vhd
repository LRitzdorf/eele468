-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/addrBStateMachine.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: addrBStateMachine
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/analysis/fftFrameBuffering/addrBgen/addrBStateMachine
-- Hierarchy Level: 4
-- Model version: 8.3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY addrBStateMachine IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        start                             :   IN    std_logic;
        fftCountHit                       :   IN    std_logic;
        powerup                           :   OUT   std_logic;
        frameShiftCounterEnable           :   OUT   std_logic;
        fftIndexCounterReset              :   OUT   std_logic;
        fftIndexCounterEnable             :   OUT   std_logic;
        fftValid                          :   OUT   std_logic
        );
END addrBStateMachine;


ARCHITECTURE rtl OF addrBStateMachine IS

  ATTRIBUTE multstyle : string;

  -- Signals
  SIGNAL current_state                    : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL current_state_next               : unsigned(2 DOWNTO 0);  -- ufix3

BEGIN
  addrBStateMachine_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      current_state <= to_unsigned(16#0#, 3);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        current_state <= current_state_next;
      END IF;
    END IF;
  END PROCESS addrBStateMachine_1_process;

  addrBStateMachine_1_output : PROCESS (current_state, fftCountHit, start)
  BEGIN
    --MATLAB Function 'fftAnalysisSynthesis/analysis/fftFrameBuffering/addrBgen/addrBStateMachine'
    -------------------------------------------------------------
    -- States
    -------------------------------------------------------------
    -- initialization state
    -- wait for start pulse
    -- counting state
    -- update the frame shift counter
    -------------------------------------------------------------
    -- default control values
    -------------------------------------------------------------
    powerup <= '0';
    frameShiftCounterEnable <= '0';
    fftIndexCounterReset <= '1';
    fftIndexCounterEnable <= '0';
    fftValid <= '0';
    -------------------------------------------------------------
    -- State machine for counter control signals
    -------------------------------------------------------------
    CASE current_state IS
      WHEN "000" =>
        ---------------------------------------------------------
        -- wait for start pulse
        powerup <= '1';
        current_state_next <= to_unsigned(16#1#, 3);
        ---------------------------------------------------------
      WHEN "001" =>
        -- wait for start pulse
        IF start = '1' THEN 
          current_state_next <= to_unsigned(16#2#, 3);
        ELSE 
          current_state_next <= to_unsigned(16#1#, 3);
        END IF;
        ---------------------------------------------------------
      WHEN "010" =>
        -- count from 0 to FFT length
        fftIndexCounterReset <= '0';
        fftIndexCounterEnable <= '1';
        fftValid <= '1';
        IF fftCountHit = '1' THEN 
          current_state_next <= to_unsigned(16#4#, 3);
        ELSE 
          current_state_next <= to_unsigned(16#2#, 3);
        END IF;
        ---------------------------------------------------------
      WHEN "011" =>
        -- count from 0 to FFT length
        fftIndexCounterReset <= '0';
        fftIndexCounterEnable <= '1';
        fftValid <= '1';
        current_state_next <= to_unsigned(16#4#, 3);
        ---------------------------------------------------------
      WHEN "100" =>
        fftIndexCounterReset <= '0';
        frameShiftCounterEnable <= '1';
        current_state_next <= to_unsigned(16#1#, 3);
      WHEN OTHERS => 
        current_state_next <= to_unsigned(16#0#, 3);
    END CASE;
  END PROCESS addrBStateMachine_1_output;


END rtl;

