-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/Decrement_Stored_Integer.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: Decrement_Stored_Integer
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/frequencyDomainProcessing/applyComplexGains/fftFilterCoefficients/fftROMindexing/Decrement 
-- Stored Intege
-- Hierarchy Level: 5
-- Model version: 8.3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Decrement_Stored_Integer IS
  PORT( u                                 :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
        y                                 :   OUT   std_logic_vector(8 DOWNTO 0)  -- sfix9
        );
END Decrement_Stored_Integer;


ARCHITECTURE rtl OF Decrement_Stored_Integer IS

  -- Signals
  SIGNAL u_signed                         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL FixPt_Constant_out1              : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL FixPt_Sum1_out1                  : signed(8 DOWNTO 0);  -- sfix9

BEGIN
  u_signed <= signed(u);

  FixPt_Constant_out1 <= to_signed(16#001#, 9);

  FixPt_Sum1_out1 <= u_signed - FixPt_Constant_out1;

  y <= std_logic_vector(FixPt_Sum1_out1);


END rtl;

