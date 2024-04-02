-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj/hdlsrc/fftAnalysisSynthesis/FFT.vhd
-- 
-- Generated by MATLAB 23.2, HDL Coder 23.2, and Simulink 23.2
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: FFT
-- Source Path: fftAnalysisSynthesis/fftAnalysisSynthesis/analysis/FFT
-- Hierarchy Level: 2
-- Model version: 8.2
-- 
-- FFT
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY FFT IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_2048_0                      :   IN    std_logic;
        dataIn                            :   IN    std_logic_vector(23 DOWNTO 0);  -- sfix24_En23
        validIn                           :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        dataOut_im                        :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
        validOut                          :   OUT   std_logic
        );
END FFT;


ARCHITECTURE rtl OF FFT IS

  -- Component Declarations
  COMPONENT TWDLROM
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dMemOutDly_vld                  :   IN    std_logic;
          stage                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          initIC                          :   IN    std_logic;
          twdl_re                         :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
          twdl_im                         :   OUT   std_logic_vector(30 DOWNTO 0)  -- sfix31_En29
          );
  END COMPONENT;

  COMPONENT MINRESRX2FFT_MEMORY
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          dMemIn1_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn1_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn2_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn2_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          wrEnb1                          :   IN    std_logic;
          wrEnb2                          :   IN    std_logic;
          wrEnb3                          :   IN    std_logic;
          rdEnb1                          :   IN    std_logic;
          rdEnb2                          :   IN    std_logic;
          rdEnb3                          :   IN    std_logic;
          stage                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          initIC                          :   IN    std_logic;
          unLoadPhase                     :   IN    std_logic;
          dMemOut1_re                     :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut1_im                     :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_re                     :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_im                     :   OUT   std_logic_vector(30 DOWNTO 0)  -- sfix31_En23
          );
  END COMPONENT;

  COMPONENT MINRESRX2FFT_BTFSEL
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          din_1_re                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          din_1_im                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          validIn                         :   IN    std_logic;
          rdy                             :   IN    std_logic;
          dMemOut1_re                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut1_im                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_re                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_im                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut_vld                     :   IN    std_logic;
          stage                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          initIC                          :   IN    std_logic;
          btfIn1_re                       :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn1_im                       :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn2_re                       :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn2_im                       :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn_vld                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT MINRESRX2_BUTTERFLY
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          btfIn1_re                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn1_im                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn2_re                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn2_im                       :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfIn_vld                       :   IN    std_logic;
          twdl_re                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
          twdl_im                         :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En29
          btfOut1_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut1_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut2_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut2_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut_vld                      :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT MINRESRX2FFT_MEMSEL
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          btfOut1_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut1_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut2_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut2_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          btfOut_vld                      :   IN    std_logic;
          stage                           :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          initIC                          :   IN    std_logic;
          stgOut1_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut1_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut2_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut2_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut_vld                      :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT MINRESRX2FFT_CTRL
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          din_1_re                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          din_1_im                        :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          validIn                         :   IN    std_logic;
          stgOut1_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut1_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut2_re                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut2_im                      :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          stgOut_vld                      :   IN    std_logic;
          dMemIn1_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn1_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn2_re                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemIn2_im                      :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          wrEnb1                          :   OUT   std_logic;
          wrEnb2                          :   OUT   std_logic;
          wrEnb3                          :   OUT   std_logic;
          rdEnb1                          :   OUT   std_logic;
          rdEnb2                          :   OUT   std_logic;
          rdEnb3                          :   OUT   std_logic;
          dMemOut_vld                     :   OUT   std_logic;
          vldOut                          :   OUT   std_logic;
          stage                           :   OUT   std_logic_vector(2 DOWNTO 0);  -- ufix3
          rdy                             :   OUT   std_logic;
          initIC                          :   OUT   std_logic;
          unLoadPhase                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT MINRESRX2FFT_OUTMux
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_2048_0                    :   IN    std_logic;
          rdEnb1                          :   IN    std_logic;
          rdEnb2                          :   IN    std_logic;
          rdEnb3                          :   IN    std_logic;
          dMemOut1_re                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut1_im                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_re                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dMemOut2_im                     :   IN    std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          vldOut                          :   IN    std_logic;
          dOut_re                         :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dOut_im                         :   OUT   std_logic_vector(30 DOWNTO 0);  -- sfix31_En23
          dout_vld                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : TWDLROM
    USE ENTITY work.TWDLROM(rtl);

  FOR ALL : MINRESRX2FFT_MEMORY
    USE ENTITY work.MINRESRX2FFT_MEMORY(rtl);

  FOR ALL : MINRESRX2FFT_BTFSEL
    USE ENTITY work.MINRESRX2FFT_BTFSEL(rtl);

  FOR ALL : MINRESRX2_BUTTERFLY
    USE ENTITY work.MINRESRX2_BUTTERFLY(rtl);

  FOR ALL : MINRESRX2FFT_MEMSEL
    USE ENTITY work.MINRESRX2FFT_MEMSEL(rtl);

  FOR ALL : MINRESRX2FFT_CTRL
    USE ENTITY work.MINRESRX2FFT_CTRL(rtl);

  FOR ALL : MINRESRX2FFT_OUTMux
    USE ENTITY work.MINRESRX2FFT_OUTMux(rtl);

  -- Signals
  SIGNAL dataIn_signed                    : signed(23 DOWNTO 0);  -- sfix24_En23
  SIGNAL dtc_re                           : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL dtc_im                           : signed(30 DOWNTO 0);  -- sfix31_En23
  SIGNAL syncReset                        : std_logic;
  SIGNAL dMemOut_vld                      : std_logic;
  SIGNAL dMemOutDly_vld                   : std_logic;
  SIGNAL stage                            : std_logic_vector(2 DOWNTO 0);  -- ufix3
  SIGNAL initIC                           : std_logic;
  SIGNAL twdl_re                          : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL twdl_im                          : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemIn1_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemIn1_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemIn2_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemIn2_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL wrEnb1                           : std_logic;
  SIGNAL wrEnb2                           : std_logic;
  SIGNAL wrEnb3                           : std_logic;
  SIGNAL rdEnb1                           : std_logic;
  SIGNAL rdEnb2                           : std_logic;
  SIGNAL rdEnb3                           : std_logic;
  SIGNAL unLoadPhase                      : std_logic;
  SIGNAL dMemOut1_re                      : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemOut1_im                      : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemOut2_re                      : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dMemOut2_im                      : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL rdy                              : std_logic;
  SIGNAL btfIn1_re                        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfIn1_im                        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfIn2_re                        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfIn2_im                        : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfIn_vld                        : std_logic;
  SIGNAL btfOut1_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfOut1_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfOut2_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfOut2_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL btfOut_vld                       : std_logic;
  SIGNAL stgOut1_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL stgOut1_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL stgOut2_re                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL stgOut2_im                       : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL stgOut_vld                       : std_logic;
  SIGNAL vldOut                           : std_logic;
  SIGNAL dOut_re                          : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dOut_im                          : std_logic_vector(30 DOWNTO 0);  -- ufix31
  SIGNAL dout_vld                         : std_logic;

BEGIN
  u_MinResRX2FFT_TWDLROM : TWDLROM
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dMemOutDly_vld => dMemOutDly_vld,
              stage => stage,  -- ufix3
              initIC => initIC,
              twdl_re => twdl_re,  -- sfix31_En29
              twdl_im => twdl_im  -- sfix31_En29
              );

  u_MinResRX2FFT_MEMORY : MINRESRX2FFT_MEMORY
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              dMemIn1_re => dMemIn1_re,  -- sfix31_En23
              dMemIn1_im => dMemIn1_im,  -- sfix31_En23
              dMemIn2_re => dMemIn2_re,  -- sfix31_En23
              dMemIn2_im => dMemIn2_im,  -- sfix31_En23
              wrEnb1 => wrEnb1,
              wrEnb2 => wrEnb2,
              wrEnb3 => wrEnb3,
              rdEnb1 => rdEnb1,
              rdEnb2 => rdEnb2,
              rdEnb3 => rdEnb3,
              stage => stage,  -- ufix3
              initIC => initIC,
              unLoadPhase => unLoadPhase,
              dMemOut1_re => dMemOut1_re,  -- sfix31_En23
              dMemOut1_im => dMemOut1_im,  -- sfix31_En23
              dMemOut2_re => dMemOut2_re,  -- sfix31_En23
              dMemOut2_im => dMemOut2_im  -- sfix31_En23
              );

  u_MinResRX2FFT_BTFSEL : MINRESRX2FFT_BTFSEL
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              din_1_re => std_logic_vector(dtc_re),  -- sfix31_En23
              din_1_im => std_logic_vector(dtc_im),  -- sfix31_En23
              validIn => validIn,
              rdy => rdy,
              dMemOut1_re => dMemOut1_re,  -- sfix31_En23
              dMemOut1_im => dMemOut1_im,  -- sfix31_En23
              dMemOut2_re => dMemOut2_re,  -- sfix31_En23
              dMemOut2_im => dMemOut2_im,  -- sfix31_En23
              dMemOut_vld => dMemOut_vld,
              stage => stage,  -- ufix3
              initIC => initIC,
              btfIn1_re => btfIn1_re,  -- sfix31_En23
              btfIn1_im => btfIn1_im,  -- sfix31_En23
              btfIn2_re => btfIn2_re,  -- sfix31_En23
              btfIn2_im => btfIn2_im,  -- sfix31_En23
              btfIn_vld => btfIn_vld
              );

  u_MinResRX2FFT_BUTTERFLY : MINRESRX2_BUTTERFLY
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              btfIn1_re => btfIn1_re,  -- sfix31_En23
              btfIn1_im => btfIn1_im,  -- sfix31_En23
              btfIn2_re => btfIn2_re,  -- sfix31_En23
              btfIn2_im => btfIn2_im,  -- sfix31_En23
              btfIn_vld => btfIn_vld,
              twdl_re => twdl_re,  -- sfix31_En29
              twdl_im => twdl_im,  -- sfix31_En29
              btfOut1_re => btfOut1_re,  -- sfix31_En23
              btfOut1_im => btfOut1_im,  -- sfix31_En23
              btfOut2_re => btfOut2_re,  -- sfix31_En23
              btfOut2_im => btfOut2_im,  -- sfix31_En23
              btfOut_vld => btfOut_vld
              );

  u_MinResRX2FFT_MEMSEL : MINRESRX2FFT_MEMSEL
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              btfOut1_re => btfOut1_re,  -- sfix31_En23
              btfOut1_im => btfOut1_im,  -- sfix31_En23
              btfOut2_re => btfOut2_re,  -- sfix31_En23
              btfOut2_im => btfOut2_im,  -- sfix31_En23
              btfOut_vld => btfOut_vld,
              stage => stage,  -- ufix3
              initIC => initIC,
              stgOut1_re => stgOut1_re,  -- sfix31_En23
              stgOut1_im => stgOut1_im,  -- sfix31_En23
              stgOut2_re => stgOut2_re,  -- sfix31_En23
              stgOut2_im => stgOut2_im,  -- sfix31_En23
              stgOut_vld => stgOut_vld
              );

  u_MinResRX2FFT_CTRL : MINRESRX2FFT_CTRL
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              din_1_re => std_logic_vector(dtc_re),  -- sfix31_En23
              din_1_im => std_logic_vector(dtc_im),  -- sfix31_En23
              validIn => validIn,
              stgOut1_re => stgOut1_re,  -- sfix31_En23
              stgOut1_im => stgOut1_im,  -- sfix31_En23
              stgOut2_re => stgOut2_re,  -- sfix31_En23
              stgOut2_im => stgOut2_im,  -- sfix31_En23
              stgOut_vld => stgOut_vld,
              dMemIn1_re => dMemIn1_re,  -- sfix31_En23
              dMemIn1_im => dMemIn1_im,  -- sfix31_En23
              dMemIn2_re => dMemIn2_re,  -- sfix31_En23
              dMemIn2_im => dMemIn2_im,  -- sfix31_En23
              wrEnb1 => wrEnb1,
              wrEnb2 => wrEnb2,
              wrEnb3 => wrEnb3,
              rdEnb1 => rdEnb1,
              rdEnb2 => rdEnb2,
              rdEnb3 => rdEnb3,
              dMemOut_vld => dMemOut_vld,
              vldOut => vldOut,
              stage => stage,  -- ufix3
              rdy => rdy,
              initIC => initIC,
              unLoadPhase => unLoadPhase
              );

  u_MinResRX2FFT_OUTMUX : MINRESRX2FFT_OUTMux
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_2048_0 => enb_1_2048_0,
              rdEnb1 => rdEnb1,
              rdEnb2 => rdEnb2,
              rdEnb3 => rdEnb3,
              dMemOut1_re => dMemOut1_re,  -- sfix31_En23
              dMemOut1_im => dMemOut1_im,  -- sfix31_En23
              dMemOut2_re => dMemOut2_re,  -- sfix31_En23
              dMemOut2_im => dMemOut2_im,  -- sfix31_En23
              vldOut => vldOut,
              dOut_re => dOut_re,  -- sfix31_En23
              dOut_im => dOut_im,  -- sfix31_En23
              dout_vld => dout_vld
              );

  dataIn_signed <= signed(dataIn);

  dtc_re <= resize(dataIn_signed, 31);

  dtc_im <= to_signed(16#00000000#, 31);

  syncReset <= '0';

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dMemOutDly_vld <= '0';
    ELSIF rising_edge(clk) THEN
      IF enb_1_2048_0 = '1' THEN
        IF syncReset = '1' THEN
          dMemOutDly_vld <= '0';
        ELSE 
          dMemOutDly_vld <= dMemOut_vld;
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  dataOut_re <= dOut_re;

  dataOut_im <= dOut_im;

  validOut <= dout_vld;

END rtl;

