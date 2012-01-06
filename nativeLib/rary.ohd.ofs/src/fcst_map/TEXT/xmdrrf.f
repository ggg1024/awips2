C MEMBER XMDRRF
C  (from old member PPXMDRCV)
C***********************************************************************
C
      SUBROUTINE XMDRRF(IPER,PPVR,PTVR,MDR6,PT24,PGENL,LPG,NTABLE)
C
C   XMDRRF : CONVERT ALL MDR VALUES TO PRECIP ESTIMATES
C
C SUBROUTINE ORIGINALLY BY ED VANBLARGAN - HRL - 4/83
C BASED ON ALGORITHM (CONVRT) BY RANDY TETZLOFF IN TULSA RFC MDR
C   PLOT PROGRAM.
C.......................................................................
C
C THE METHOD OF MADNESS FOR THIS COVERSION ROUTINE IS:
C 1. GO THRU 6-HR STATIONS (FOR EACH PERIOD) AND PICK OUT ONLY THOSE
C    HAVING A NON-ZERO, NON-MISSING OBSERVED PRECIP
C 2. FOR EACH STATION WITH PRECIP, FIND ITS MDR VALUE AND CONVERT
C    THE MDR TO PRECIP AT THE 30, 50, AND 70 % LEVELS (TABLES FOR
C    CONVERSION ARE STRAIT OUT OF RANDY'S PROGRAM).
C    THUS , NOW HAVE 3 PRECIP ESTIMATES.
C 3. COMPUTE THE GAGE:RADAR (OBSERVE:MDR) RATIO FOR EACH PROBABILITY
C    LEVEL FOR EACH STATION (USE ONLY MDR ESTIMATES BETWEEN 0-2)
C 4. THEN, FOR ALL STATIONS DETERMINE THE AVERAGE G:R RATIO FOR THE
C    3 LEVELS
C 5. FINALLY DETERMINE WHICH AVERAGE G:R IS CLOSEST TO 1.0 AND
C    USE THAT PROBABILITY TABLE TO CONVERT ALL THE MDR VALUES
C    TO PRECIP.
C    NOTE: IF NO G:R OBSERVATIONS EXIST THE USE 70% TABLE.
C 6. ALSO, IF OPTION IS ON, PRINT OUT THE COMPARISON G:R RESULTS.
C
C NOTE: MORE INFO ON THESE PROBABILITY TABLES AND CONVERSION OF MDR
C       TO PRECIP CAN BE FOUND IN 2 PAPERS BY DAN SMITH, CHIEF SSD,
C       SOUTHERN REGION HEADQUARTERS.
C
C ARGUMENT LIST
C
C NAME  I/O TYPE DIM DESC
C ----  --- ---- --- ------------------------------------------
C IPER   I    I   1  NUMBER OF THE CURRENT 6-HR PERIOD
C PPVR   I   I*2 VAR 6-HR PRECIP ARRAY (SEE MAIN MDR SUBROUTINE)
C PTVR   I   I*2 VAR 6-HR POINTER ARRAY (SEE MAIN MDR SUBROUTINE)
C MDR6   I   I*2 VAR 6-HR MDR PRECIP ARRAY (SEE MAIN MDR SUBROUTINE)
C PT24   I   I*2 VAR 24 HR POINTER ARRAY (SEE MAIN MDR SUBROUTINE)
C PGENL  I   R*4 LPG WORK SPACE ARRAY FOR STATION GENL PARAMETERS
C LPG    I    I    1 LENGTH OF PGENL
C NTABLE O    I    1 PROBABILITY TABLE USED I.E, 30,50, OR 70
C
C INTERNAL VARIABLES
C ------------------
C LXXXX  - POINTERS FOR ARRAYS PTVR,PT24,MDR6,PPVR (WHERE XXXX CAN BE
C          PTVR,PT24,OCMDR,PP RESPECTIVELY)
C THIRTY - ARRAY WITH 30 % TABLE OF PRECIP FOR ALL POSSIBLE MDR VALUES
C FIFTY  -  "     "   50 %   "    "  "      "   "      "     "   "
C SEVNTY -  "     "   70 %   "    "  "      "   "      "     "   "
C R30    - MDR PRECIP VALUE FOR STATION AT 30% LEVEL
C R50    -  "    "     "     "    "     "  50%  "
C R70    -  "    "     "     "    "     "  70%  "
C GR30   - GAGE TO RADAR(MDR) RATIO FOR STATION AT 30% LEVEL
C GR50   -  "    "     "       "     "     "    "  50%  "
C GR70   -  "    "     "       "     "     "    "  70%  "
C AVGR30 - SUM OF ALL GR30 AND FINALLY AVERAGE G:R RATIO AT 30% LEVEL
C AVGR50 _  "   "  "  GR50  "    "       "      "    "   "  50%  "
C AVGR70 _  "   "  "  GR70  "    "       "      "    "   "  70%  "
C NGR30  - NUMBER OF OBSERVATIONS OF GR30
C NGR50  -   "    "       "       "  GR50
C NGR70  -   "    "       "       "  GR70
C NOBS   - TOTAL NUMBER OF GR OBSERVATIONS (30+50+70)
C NTABLE - NUMBER OF PROBABILITY TABLE (30,50,70) FINALLY USED TO
C          CONVERT MDR TO PRECIP
C ADJTBL - ARRAY TO HOLD THE TABLE VALUES USED IN FINAL CONVERSIO OD MDR
C
C.......................................................................
C
C
C
      INTEGER*2 PPVR,PTVR,PT24,MDR6
      DIMENSION PPVR(1),PTVR(1),MDR6(1),PGENL(1),PT24(1),STNID(2),
     $ THIRTY(36),FIFTY(36),SEVNTY(36),ADJTBL(36)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/pudbug'
      INCLUDE 'common/xmdr'
      INCLUDE 'common/xsize'
      INCLUDE 'common/xopt'
      INCLUDE 'common/xdispl'
      INCLUDE 'common/xtime'
      INCLUDE 'common/xmday'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_map/RCS/xmdrrf.f,v $
     . $',                                                             '
     .$Id: xmdrrf.f,v 1.1 1995/09/17 18:59:54 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA BLANK,AGEN/4H    ,4HGENL/,SNAME/4HXMDR/
      DATA THIRTY/0.03, 0.05, 0.07, 0.10, 0.12, 0.15, 0.20, 0.35, 0.50,
     1   0.75, 1.00, 1.20, 1.40, 1.65, 2.00, 2.30, 2.75, 3.25, 3.80,
     2   4.15, 4.50, 4.65, 4.75, 5.00, 5.15, 5.25, 5.50, 5.65, 5.75,
     3   5.90, 6.00, 6.15, 6.25, 6.40, 6.50, 6.75/
      DATA FIFTY/0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.15, 0.20, 0.25,
     1   0.30, 0.35, 0.45, 0.55, 0.75, 0.95, 1.15, 1.35, 1.50, 1.70,
     2   1.90, 2.25, 2.75, 3.00, 3.50, 3.75, 3.95, 4.15, 4.30, 4.40,
     3   4.50, 4.65, 4.75, 4.80, 4.90, 5.00, 5.25/
      DATA SEVNTY/0.01, 0.02, 0.03, 0.05, 0.08, 0.10, 0.12, 0.15, 0.20,
     1   0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.70, 0.80, 1.00,
     2   1.10, 1.30, 1.50, 1.60, 1.70, 1.80, 2.00, 2.25, 2.40, 2.65,
     3   3.00, 3.30, 3.65, 3.80, 3.95, 4.00, 4.15/
C
C INITIALIZE VARIABLES
C
      IBUG=IPBUG(SNAME)
      IF (IPTRCE.GE.1) WRITE(IOPDBG,805)
      IFOUND=0
      NGR30=0
      NGR50=0
      NGR70=0
      AVGR30=0.00
      AVGR50=0.00
      AVGR70=0.00
      NTABLE=70
      LPTVR=-3
C
C ** LOOP THRU THE STATIONS
C
      DO 290 N=1,NSLOT6
C CHECK IF STATION DEFINED AND SET UP POINTERS
      LPTVR=LPTVR+4
      IPTR=PTVR(LPTVR)
      IF (IPTR.EQ.0) GO TO 290
      LPT24=PTVR(LPTVR+1)
C CHECK TIME INTERVAL (IDT), IF .GT. 6 DO NOT USE
C ALSO, SET NUMBER OF OBS VALUES PER 6 HR PERIOD (NUMVAL)
      IDT=PTVR(LPTVR+2)
      IF (IDT.GT.6) GO TO 290
      NUMVAL=6/IDT
C LOOP THRU OBS FOR THIS PERIOD AND SUM INTO 6 HR VALUES (GAGE).
C IF ANY OBS MISSING THEN SET ENTIRE PERIOD TO MISSING
      GAGE=0.0
      LPP  =PTVR(LPTVR+3)+(IPER-1)*NUMVAL-1
      DO 150 NV=1,NUMVAL
      IF (PPVR(LPP+NV).EQ.MSNG6) GO TO 290
      GAGE=GAGE+PPVR(LPP+NV)/100.
150   CONTINUE
C IF PRECIP IS 0
      IF (GAGE.LE.0.00001) GO TO 290
C GET MDRBOX AND CHECK IF VALID
      MDRBOX=PT24(LPT24+4)
      IF (MDRBOX.EQ.0) GO TO 290
      CALL XMDRAL(MDRBOX,LOCMDR,ISTAT)
      IF (ISTAT.NE.0) GO TO 290
C CONVERT MDR VALUE (IF MISSING SKIP IT) TO RAINFALL VALUES
C USING 30,50,70 PERCENT TABLES. IF=0, PRINT BUT DONT AVERAGE IN.
      IF (MDR6(LOCMDR).EQ.MSGMDR) GO TO 290
      MDRVAL=MDR6(LOCMDR)
      MDRVAL=IABS(MDRVAL)
      IF (MDRVAL.NE.0) GO TO 200
      R30=0.0
      R50=0.0
      R70=0.0
      GR30=0.0
      GR50=0.0
      GR70=0.0
      GO TO 260
C MDR VALUE NE 0
 200  R30=THIRTY(MDRVAL)
      R50=FIFTY (MDRVAL)
      R70=SEVNTY(MDRVAL)
      GR30=GAGE/R30
      GR50=GAGE/R50
      GR70=GAGE/R70
C
C ADD GR VALUE TO RUNNING SUM TOTAL GR.
C DO NOT ADD IF GR IS 0 OR GT 2.
C
      IF(GR30.LT.0.01 .OR. GR30.GT.2.00) GO TO 220
      NGR30=NGR30+1
      AVGR30=AVGR30+GR30
C
 220  IF(GR50.LT.0.01 .OR. GR50.GT.2.00) GO TO 240
      NGR50=NGR50+1
      AVGR50=AVGR50+GR50
C
 240  IF(GR70.LT.0.01 .OR. GR70.GT.2.00) GO TO 260
      NGR70=NGR70+1
      AVGR70=AVGR70+GR70
C
C SEE IF PRINT OPTION IS ON. IF SO, GET STATION INFO FROM
C PPDB AND PRINT GR ANALYSIS.
C
260   IF (IPRDAY.EQ.0 .OR. MDRPRT.NE.2) GO TO 290
      IROW=((MDRBOX-1)/113)+1
      ICOL=MDRBOX-(IROW-1)*113
      STNID(1)=BLANK
      STNID(2)=BLANK
      IPTR=-IPTR
      CALL RPPREC(STNID,AGEN,IPTR,LPG,PGENL,NPUSE,IDUM,ISTAT)
      IF (ISTAT.NE.0) CALL PSTRDC(ISTAT,AGEN,STNID,IPTR,
     $ LPG,NPUSE)
      IF (IFOUND.EQ.0)
     $ WRITE(IPR,865) MMO,MDAY,MYEAR,MHR,TZCODE,IPER
      WRITE(IPR,815) (PGENL(I),I=5,9),PGENL(2),PGENL(3),IROW,ICOL,
     1   GAGE,R30,GR30,GAGE,R50,GR50,GAGE,R70,GR70
      IFOUND=1
290   CONTINUE
C ** END LOOP THRU STATIONS
C
C DETERMINE GR AVERAGES FOR EACH PROBABILITY LEVEL
C
      NOBS=NGR30+NGR50+NGR70
      IF (NGR30.NE.0) AVGR30=AVGR30/NGR30
      IF (NGR50.NE.0) AVGR50=AVGR50/NGR50
      IF (NGR70.NE.0) AVGR70=AVGR70/NGR70
C
C PRINT OUT AVERAGES IF DESIRED
C
      IF (IPRDAY.EQ.0 .OR. MDRPRT.NE.2) GO TO 320
      IF (NOBS.EQ.0) GO TO 310
      WRITE(IPR,825) AVGR30,AVGR50,AVGR70
      GO TO 320
310   WRITE(IPR,835)
C
C CHECK IF ANY OBSERVATIONS WERE FOUND
320   IF (NOBS.NE.0) GO TO 400
C
C  NO SA-SM OBSERVED RAINFALL OR COMPARISONS AVAILABLE ...
C     CONVERT TO RAINFALL USING UNADJUSTED 70% TABLE
C
      DO 350 N=1,36
350   ADJTBL(N)=SEVNTY(N)
      GO TO 550
C
C  SA-SM OBSERVED RAINFALL AND COMPARISONS ARE AVAILABLE ...
C     CONVERT TO RAINFALL USING TABLE WITH AVERAGE G/R CLOSEST TO 1.00
C     ... MODIFYING TABLE BY THE AVERAGE G/R (OPTIONAL)
C
 400  DIF30=ABS(AVGR30-1.00)
      IF(AVGR30.EQ.0.00) DIF30=99.99
      DIF50=ABS(AVGR50-1.00)
      IF(AVGR50.EQ.0.00) DIF50=99.99
      DIF70=ABS(AVGR70-1.00)
      IF(AVGR70.EQ.0.00) DIF70=99.99
C
      DIFMIN=DIF70
      IF(DIF50.LT.DIFMIN) NTABLE=50
      IF(DIF50.LT.DIFMIN) DIFMIN=DIF50
      IF(DIF30.LT.DIFMIN) NTABLE=30
C
C  ADJUST RAINFALL CONVERSION TABLE BY THE AVERAGE G/R CLOSEST TO 1.00
C NOTE CAN ADDITIONALLY ADJUST BY ADJTBL=ADJTBL*AVGR?
C
      DO 500 N=1,36
      IF(NTABLE.EQ.30) ADJTBL(N)=THIRTY(N)
      IF(NTABLE.EQ.50) ADJTBL(N)= FIFTY(N)
      IF(NTABLE.EQ.70) ADJTBL(N)=SEVNTY(N)
500   CONTINUE
C
C NOW TABLE(ADJTBL) IS SET UP, SO
C SET UP MDR PRECIP IN INTEGER FORM TO 100'S OF AN INCH.
C    INTEGER OUTPUT IS OF FORM XXXX=XX.XX
C FOR MISSING MDR SET IT = TO MISSING PRECIP CODE
C
550   DO 600 N=1,NMDR
      IF (MDR6(N).NE.MSGMDR) GO TO 590
      MDR6(N)=MSNG6
      GO TO 600
C DATA NOT MISSING
590   MDRVAL=MDR6(N)
      MDRVAL=IABS(MDRVAL)
      IF (MDRVAL.EQ.0) GO TO 600
      MDR6(N)=ADJTBL(MDRVAL)*100. +0.01
600   CONTINUE
C
C............DEBUG TIME.................................................
C
      IF (IBUG.EQ.0) GO TO 999
      WRITE(IOPDBG,891) NTABLE,ADJTBL
C.......................................................................
C
999   RETURN
C
C..........FORMATS......................................................
C
805   FORMAT(1H0,21H *** ENTER XMDRRF ***)
C
815   FORMAT(1X,5A4,1X,2A4,4X,I2,1X,I3,4X,
     1   3(F5.2,2X),2X,3(F5.2,2X),2X,3(F5.2,2X))
C
825   FORMAT(// 45X,13HAVERAGE G/R = ,F5.2,5X,13HAVERAGE G/R = ,F5.2,
     1   5X,13HAVERAGE G/R = ,F5.2)
C
835   FORMAT(///// 1X,39HNO 6-HR OBSERVED RAINFALL OR COMPARISON,
     $ 57H AVAILABLE. MDR TO PRECIP CONVERSION DONE WITH UNADJUSTED,
     $ 18H 70 PERCENT TABLE.)
C
865   FORMAT(1H1,25X,35HCOMPARISON OF OBSERVED 6 HR PRECIP ,
     1   27HWITH 6 HR SUMMED MDR PRECIP /
     A   26X,25H(G/R'S=0 OR G/R'S GREATER,
     B   33H THAN 2.00 NOT USED IN AVERAGING) //
     2   37X,I2,1H/,I2,1H/,I4,3H HR,I3,1X,A4,11H  ...PERIOD,I2 //
     3   35X,3HMDR,10X,12H30% PROBABLE,11X,12H50% PROBABLE,11X,
     4   12H70% PROBABLE / 1X,12HSTATION NAME,9X,
     5   4H  ID,7X,7HROW COL,5X,18HGAGE   RADAR   G/R,5X,
     6   18HGAGE   RADAR   G/R,5X,18HGAGE   RADAR   G/R /
     7   1X,20(1H*),1X,8(1H*),3X,7H*** ***,4X,6(1H*),1X,
     8   6(1H*),1X,6(1H*),3X,6(1H*),1X,6(1H*),1X,6(1H*),3X,
     9   6(1H*),1X,6(1H*),1X,6(1H*) /)
C
891   FORMAT(1H0,7HNTABLE=,I8,2X,7HADJTBL:,(/ 1X,10F10.2))
C
C.......................................................................
C
      END
