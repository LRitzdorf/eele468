-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/frequencyDomainProcessing.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: frequencyDomainProcessing
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/frequencyDomainProcessing
-- Hierarchy Level: 1
-- Model version: 8.3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.fftAnalysisSynthesis_pkg.ALL;

ENTITY frequencyDomainProcessing IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        fftData_re                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        fftData_im                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        fftValid                          :   IN    std_logic;
        fftFramePulse                     :   IN    std_logic;
        passthrough                       :   IN    std_logic;  -- ufix1
        filterSelect                      :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        fftModifiedData_re                :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        fftModifiedData_im                :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        fftValidOut                       :   OUT   std_logic;
        fftFramePulseOut                  :   OUT   std_logic
        );
END frequencyDomainProcessing;


ARCHITECTURE rtl OF frequencyDomainProcessing IS

  -- Component Declarations
  COMPONENT applyComplexGains
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          fftData_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          fftData_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          fftValid                        :   IN    std_logic;
          fftFramePulse                   :   IN    std_logic;
          filterSelect                    :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          fftModifiedData_re              :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          fftModifiedData_im              :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          fftValidOut                     :   OUT   std_logic;
          fftFramePulseOut                :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : applyComplexGains
    USE ENTITY work.applyComplexGains(rtl);

  -- Signals
  SIGNAL rd_0_reg                         : std_logic_vector(3 DOWNTO 0);  -- ufix1 [4]
  SIGNAL passthrough_1                    : std_logic;  -- ufix1
  SIGNAL rd_2_reg                         : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL passthrough_2                    : std_logic;  -- ufix1
  SIGNAL switch_compare_1                 : std_logic;
  SIGNAL applyComplexGains_out1_re        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL applyComplexGains_out1_im        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL applyComplexGains_out2           : std_logic;
  SIGNAL applyComplexGains_out3           : std_logic;
  SIGNAL applyComplexGains_out1_re_signed : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL applyComplexGains_out1_im_signed : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL fftData_re_signed                : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL fftData_im_signed                : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL rd_1_reg_re                      : vector_of_signed31(0 TO 2);  -- sfix31_En23 [3]
  SIGNAL rd_1_reg_im                      : vector_of_signed31(0 TO 2);  -- sfix31_En23 [3]
  SIGNAL fftData_re_1                     : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL fftData_im_1                     : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Switch_out1_re                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL Switch_out1_im                   : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL switch_compare_1_1               : std_logic;
  SIGNAL rd_4_reg                         : std_logic_vector(1 DOWNTO 0);  -- ufix1 [2]
  SIGNAL applyComplexGains_out2_1         : std_logic;
  SIGNAL fftValid_1                       : std_logic;
  SIGNAL Switch1_out1                     : std_logic;
  SIGNAL switch_compare_1_2               : std_logic;
  SIGNAL Switch2_out1                     : std_logic;

BEGIN
  -- Switch between passthrough mode 
  -- (no processing of FFT data)
  -- and frequency domain processing mode.  
  -- Passthrough mode when passthrough = 1.

  u_applyComplexGains : applyComplexGains
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              fftData_re => fftData_re,  -- sfix31_En23
              fftData_im => fftData_im,  -- sfix31_En23
              fftValid => fftValid,
              fftFramePulse => fftFramePulse,
              filterSelect => filterSelect,  -- ufix2
              fftModifiedData_re => applyComplexGains_out1_re,  -- sfix31_En23
              fftModifiedData_im => applyComplexGains_out1_im,  -- sfix31_En23
              fftValidOut => applyComplexGains_out2,
              fftFramePulseOut => applyComplexGains_out3
              );

  rd_0_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_0_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_0_reg(0) <= passthrough;
        rd_0_reg(3 DOWNTO 1) <= rd_0_reg(2 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS rd_0_process;

  passthrough_1 <= rd_0_reg(3);

  rd_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_2_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_2_reg(0) <= passthrough_1;
        rd_2_reg(1) <= rd_2_reg(0);
      END IF;
    END IF;
  END PROCESS rd_2_process;

  passthrough_2 <= rd_2_reg(1);

  
  switch_compare_1 <= '1' WHEN passthrough_2 > '0' ELSE
      '0';

  applyComplexGains_out1_re_signed <= signed(applyComplexGains_out1_re);

  applyComplexGains_out1_im_signed <= signed(applyComplexGains_out1_im);

  fftData_re_signed <= signed(fftData_re);

  fftData_im_signed <= signed(fftData_im);

  rd_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_1_reg_re <= (OTHERS => to_signed(16#00000000#, 31));
      rd_1_reg_im <= (OTHERS => to_signed(16#00000000#, 31));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_1_reg_im(0) <= fftData_im_signed;
        rd_1_reg_im(1 TO 2) <= rd_1_reg_im(0 TO 1);
        rd_1_reg_re(0) <= fftData_re_signed;
        rd_1_reg_re(1 TO 2) <= rd_1_reg_re(0 TO 1);
      END IF;
    END IF;
  END PROCESS rd_1_process;

  fftData_re_1 <= rd_1_reg_re(2);
  fftData_im_1 <= rd_1_reg_im(2);

  
  Switch_out1_re <= applyComplexGains_out1_re_signed WHEN switch_compare_1 = '0' ELSE
      fftData_re_1;
  
  Switch_out1_im <= applyComplexGains_out1_im_signed WHEN switch_compare_1 = '0' ELSE
      fftData_im_1;

  fftModifiedData_re <= std_logic_vector(Switch_out1_re);

  fftModifiedData_im <= std_logic_vector(Switch_out1_im);

  
  switch_compare_1_1 <= '1' WHEN passthrough_1 > '0' ELSE
      '0';

  rd_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      rd_4_reg <= (OTHERS => '0');
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        rd_4_reg(0) <= applyComplexGains_out2;
        rd_4_reg(1) <= rd_4_reg(0);
      END IF;
    END IF;
  END PROCESS rd_4_process;

  applyComplexGains_out2_1 <= rd_4_reg(1);

  rd_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fftValid_1 <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        fftValid_1 <= fftValid;
      END IF;
    END IF;
  END PROCESS rd_3_process;


  
  Switch1_out1 <= applyComplexGains_out2_1 WHEN switch_compare_1_1 = '0' ELSE
      fftValid_1;

  
  switch_compare_1_2 <= '1' WHEN passthrough > '0' ELSE
      '0';

  
  Switch2_out1 <= applyComplexGains_out3 WHEN switch_compare_1_2 = '0' ELSE
      fftFramePulse;

  fftValidOut <= Switch1_out1;

  fftFramePulseOut <= Switch2_out1;

END rtl;

