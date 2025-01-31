-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/filterChoice.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: filterChoice
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/frequencyDomainProcessing/applyComplexGains/fftFilterCoefficients/filterChoice
-- Hierarchy Level: 4
-- Model version: 8.3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.fftAnalysisSynthesis_pkg.ALL;

ENTITY filterChoice IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        filterSelect                      :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
        ROMindex                          :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
        conjugate                         :   IN    std_logic;
        filterCoefficients_re             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
        filterCoefficients_im             :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En8
        );
END filterChoice;


ARCHITECTURE rtl OF filterChoice IS

  -- Component Declarations
  COMPONENT filter1Coefficients
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ROMindex                        :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          conjugate                       :   IN    std_logic;
          complexCoefficients_re          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
          complexCoefficients_im          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En8
          );
  END COMPONENT;

  COMPONENT filter2Coefficients
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ROMindex                        :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          conjugate                       :   IN    std_logic;
          complexCoefficients_re          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
          complexCoefficients_im          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En8
          );
  END COMPONENT;

  COMPONENT filter3Coefficients
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ROMindex                        :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          conjugate                       :   IN    std_logic;
          complexCoefficients_re          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
          complexCoefficients_im          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En8
          );
  END COMPONENT;

  COMPONENT filter4Coefficients
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ROMindex                        :   IN    std_logic_vector(8 DOWNTO 0);  -- sfix9
          conjugate                       :   IN    std_logic;
          complexCoefficients_re          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En8
          complexCoefficients_im          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix16_En8
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : filter1Coefficients
    USE ENTITY work.filter1Coefficients(rtl);

  FOR ALL : filter2Coefficients
    USE ENTITY work.filter2Coefficients(rtl);

  FOR ALL : filter3Coefficients
    USE ENTITY work.filter3Coefficients(rtl);

  FOR ALL : filter4Coefficients
    USE ENTITY work.filter4Coefficients(rtl);

  -- Signals
  SIGNAL filterSelect_unsigned            : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL delayMatch1_reg                  : vector_of_unsigned2(0 TO 3);  -- ufix2 [4]
  SIGNAL filterSelect_1                   : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL filter1Coefficients_out1_re      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter1Coefficients_out1_im      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter1Coefficients_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter1Coefficients_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter2Coefficients_out1_re      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter2Coefficients_out1_im      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter2Coefficients_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter2Coefficients_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter3Coefficients_out1_re      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter3Coefficients_out1_im      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter3Coefficients_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter3Coefficients_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter4Coefficients_out1_re      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter4Coefficients_out1_im      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL filter4Coefficients_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL filter4Coefficients_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL Multiport_Switch_out1_re         : signed(15 DOWNTO 0);  -- sfix16_En8
  SIGNAL Multiport_Switch_out1_im         : signed(15 DOWNTO 0);  -- sfix16_En8

BEGIN
  u_filter1Coefficients : filter1Coefficients
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ROMindex => ROMindex,  -- sfix9
              conjugate => conjugate,
              complexCoefficients_re => filter1Coefficients_out1_re,  -- sfix16_En8
              complexCoefficients_im => filter1Coefficients_out1_im  -- sfix16_En8
              );

  u_filter2Coefficients : filter2Coefficients
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ROMindex => ROMindex,  -- sfix9
              conjugate => conjugate,
              complexCoefficients_re => filter2Coefficients_out1_re,  -- sfix16_En8
              complexCoefficients_im => filter2Coefficients_out1_im  -- sfix16_En8
              );

  u_filter3Coefficients : filter3Coefficients
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ROMindex => ROMindex,  -- sfix9
              conjugate => conjugate,
              complexCoefficients_re => filter3Coefficients_out1_re,  -- sfix16_En8
              complexCoefficients_im => filter3Coefficients_out1_im  -- sfix16_En8
              );

  u_filter4Coefficients : filter4Coefficients
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ROMindex => ROMindex,  -- sfix9
              conjugate => conjugate,
              complexCoefficients_re => filter4Coefficients_out1_re,  -- sfix16_En8
              complexCoefficients_im => filter4Coefficients_out1_im  -- sfix16_En8
              );

  filterSelect_unsigned <= unsigned(filterSelect);

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      delayMatch1_reg <= (OTHERS => to_unsigned(16#0#, 2));
    ELSIF rising_edge(clk) THEN
      IF enb = '1' THEN
        delayMatch1_reg(0) <= filterSelect_unsigned;
        delayMatch1_reg(1 TO 3) <= delayMatch1_reg(0 TO 2);
      END IF;
    END IF;
  END PROCESS delayMatch1_process;

  filterSelect_1 <= delayMatch1_reg(3);

  filter1Coefficients_out1_re_signed <= signed(filter1Coefficients_out1_re);

  filter1Coefficients_out1_im_signed <= signed(filter1Coefficients_out1_im);

  filter2Coefficients_out1_re_signed <= signed(filter2Coefficients_out1_re);

  filter2Coefficients_out1_im_signed <= signed(filter2Coefficients_out1_im);

  filter3Coefficients_out1_re_signed <= signed(filter3Coefficients_out1_re);

  filter3Coefficients_out1_im_signed <= signed(filter3Coefficients_out1_im);

  filter4Coefficients_out1_re_signed <= signed(filter4Coefficients_out1_re);

  filter4Coefficients_out1_im_signed <= signed(filter4Coefficients_out1_im);

  
  Multiport_Switch_out1_re <= filter1Coefficients_out1_re_signed WHEN filterSelect_1 = to_unsigned(16#0#, 2) ELSE
      filter2Coefficients_out1_re_signed WHEN filterSelect_1 = to_unsigned(16#1#, 2) ELSE
      filter3Coefficients_out1_re_signed WHEN filterSelect_1 = to_unsigned(16#2#, 2) ELSE
      filter4Coefficients_out1_re_signed;
  
  Multiport_Switch_out1_im <= filter1Coefficients_out1_im_signed WHEN filterSelect_1 = to_unsigned(16#0#, 2) ELSE
      filter2Coefficients_out1_im_signed WHEN filterSelect_1 = to_unsigned(16#1#, 2) ELSE
      filter3Coefficients_out1_im_signed WHEN filterSelect_1 = to_unsigned(16#2#, 2) ELSE
      filter4Coefficients_out1_im_signed;

  filterCoefficients_re <= std_logic_vector(Multiport_Switch_out1_re);

  filterCoefficients_im <= std_logic_vector(Multiport_Switch_out1_im);

END rtl;

