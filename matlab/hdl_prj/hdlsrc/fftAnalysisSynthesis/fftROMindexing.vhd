-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/fftROMindexing.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: fftROMindexing
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/frequencyDomainProcessing/applyComplexGains/fftFilterCoefficients/fftROMindexing
-- Hierarchy Level: 4
-- Model version: 8.3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fftROMindexing IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        fftValid                          :   IN    std_logic;
        ROMindex                          :   OUT   std_logic_vector(8 DOWNTO 0);  -- sfix9
        conjugate                         :   OUT   std_logic
        );
END fftROMindexing;


ARCHITECTURE rtl OF fftROMindexing IS

  ATTRIBUTE multstyle : string;

  -- Component Declarations
  COMPONENT Decrement_Stored_Integer
    PORT( u                               :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          y                               :   OUT   std_logic_vector(8 DOWNTO 0)  -- sfix9
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : Decrement_Stored_Integer
    USE ENTITY work.Decrement_Stored_Integer(rtl);

  -- Signals
  SIGNAL stateControl_1                   : std_logic;
  SIGNAL delayMatch_reg                   : std_logic_vector(2 DOWNTO 0);  -- ufix1 [3]
  SIGNAL stateControl_2                   : std_logic;
  SIGNAL Bitwise_Operator_out1            : std_logic;
  SIGNAL count_step                       : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL count_reset                      : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL fftIndexCount_out1               : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL count                            : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL count_1                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL count_2                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL count_3                          : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Constant5_out1                   : unsigned(6 DOWNTO 0);  -- ufix7
  SIGNAL Relational_Operator_relop1       : std_logic;
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL Constant1_out1                   : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Add_sub_cast                     : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add_sub_cast_1                   : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Add_out1                         : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL fftIndexCount_out1_dtc           : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Switch_out1                      : signed(8 DOWNTO 0);  -- sfix9
  SIGNAL Decrement_Stored_Integer_out1    : std_logic_vector(8 DOWNTO 0);  -- ufix9
  SIGNAL Bitwise_Operator1_out1           : std_logic;

BEGIN
  -- ROM is indexed by k=i-1 (zero offset)
  -- so decrement by one.
  -- Determine when we transition to the
  -- negative frequencies in the FFT frame
  -- Matlab FFT index i = 1:NFFT
  -- Matlab conjugate index = NFFT - i + 2
  -- Assert conjugation when counting through 
  -- the conjugate negative frequencies.
  -- If we are dealing with negative frequencies 
  -- we need to know when to apply a 
  -- conjugation operation.
  -- Count from 1 to NFFT 
  -- while fftValid is asserted

  u_Decrement_Stored_Integer : Decrement_Stored_Integer
    PORT MAP( u => std_logic_vector(Switch_out1),  -- sfix9
              y => Decrement_Stored_Integer_out1  -- sfix9
              );

  stateControl_1 <= '1';

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch_reg(0) <= stateControl_1;
        delayMatch_reg(2 DOWNTO 1) <= delayMatch_reg(1 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS delayMatch_process;

  stateControl_2 <= delayMatch_reg(2);

  Bitwise_Operator_out1 <=  NOT fftValid;

  -- Free running, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  count_step <= to_unsigned(16#01#, 8);

  count_reset <= to_unsigned(16#00#, 8);

  count <= fftIndexCount_out1 + count_step;

  
  count_1 <= fftIndexCount_out1 WHEN fftValid = '0' ELSE
      count;

  
  count_2 <= count_1 WHEN Bitwise_Operator_out1 = '0' ELSE
      count_reset;

  
  count_3 <= fftIndexCount_out1 WHEN stateControl_2 = '0' ELSE
      count_2;

  fftIndexCount_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fftIndexCount_out1 <= to_unsigned(16#00#, 8);
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        fftIndexCount_out1 <= count_3;
      END IF;
    END IF;
  END PROCESS fftIndexCount_process;


  Constant5_out1 <= to_unsigned(16#41#, 7);

  
  Relational_Operator_relop1 <= '1' WHEN fftIndexCount_out1 <= resize(Constant5_out1, 8) ELSE
      '0';

  
  switch_compare_1 <= '1' WHEN Relational_Operator_relop1 > '0' ELSE
      '0';

  Constant1_out1 <= to_unsigned(16#82#, 8);

  Add_sub_cast <= signed(resize(Constant1_out1, 9));
  Add_sub_cast_1 <= signed(resize(fftIndexCount_out1, 9));
  Add_out1 <= Add_sub_cast - Add_sub_cast_1;

  fftIndexCount_out1_dtc <= signed(resize(fftIndexCount_out1, 9));

  
  Switch_out1 <= Add_out1 WHEN switch_compare_1 = '0' ELSE
      fftIndexCount_out1_dtc;

  Bitwise_Operator1_out1 <=  NOT Relational_Operator_relop1;

  ROMindex <= Decrement_Stored_Integer_out1;

  conjugate <= Bitwise_Operator1_out1;

END rtl;

