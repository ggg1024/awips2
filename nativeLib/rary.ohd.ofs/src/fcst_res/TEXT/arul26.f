C MEMBER ARUL26
C  (from old member FCARUL26)
C **********************************************************************
      SUBROUTINE ARUL26(SUMMSG,QIMHYD,BDEV,OBSELV,RULEL,DEVIAT)
C **********************************************************************
C SUBROUTINE ARUL26 IS A UTILITY PROGRAM THAT COMPUTES AN ADJUSTMENT
C FOR THE RULE CURVE.  THE ADJUSTMENT IS THE AVERAGE DIFFERENCE BETWEEN
C OBSERVED AND RULE CURVE ELEVATIONS FOR A SPECIFIED NUMBER OF TIME
C PERIODS (NTIMRL).  IF THE DIFFERENCE BETWEEN OBSERVED AND RULE
C CURVE ELEVATION  IS GREATER THAN A SPECIFIED POSITIVE VALUE
C (DIFMAX) OR THE INFLOW IS GREATER THAN A SPECIFIED VALUE (QIMAX), THE
C DIFFERENCE FOR THAT TIME PERIOD IS SET TO 0. AND THE OBSERVED ELEVA-
C TION IS CONSIDERED TO BE MISSING.  IF AN OBSERVED ELEVATION IS MISSING
C THE DEVIATION FOR THAT TIME STEP IS SET TO THE VALUE FOR THE  PREVIOUS
C STEP.  HOWEVER, IF OBSERVED ELEVATIONS ARE MISSING CONSECUTIVELY FOR
C MORE THAN HALF OF NTIMRL TIME PERIODS, THE DEVIATIONS BEYOND HALF OF
C NTIMRL PERIODS ARE SET TO 0. UNTIL AN OBSERVED ELEVATION IS
C ENCOUNTERED.  FOR POWER DAMS THAT DECREASE GENERATION ON WEEKENDS,
C SEVEN DAYS OF DEVIATIONS ARE SUGGESTED.
C **********************************************************************
C THIS SUBROUTINE WAS ORIGINALLY PROGRAMMED BY
C     WILLIAM E. FOX--CONSULTING HYDROLOGIST
C     NOVEMBER, 1981
C **********************************************************************
C SUBROUTIME ARUL26 IS IN
C **********************************************************************
C VARIABLES PASSED TO OR FROM THIS SUBROUTINE ARE DEFINED AS FOLLOWS:
C VARIABLES PASSED TO OR FROM THIS SUBROUTINE ARE DEFINED AS FOLLOWS:
C     NRUN -- POSITION IN ARRAYS AT RUN TIME.
C     NTIMRL -- NO. OF TIME PERIODS TO BE USED IN COMPUTING THE AVERAGE
C       RULE CURVE DEVIATION.
C     NOMSG -- NO. OF CONSECUTIVELY MISSING DEVIATION VALUES AT THE
C       BEGINNING OF THE FIRST TIME STEP.
C     SUMMSG -- ARRAY OF SUM OF CONSECUTIVELY MISSING DEVIATION VALUES
C       CORRESPONDING TO OBSERVED ELEVATION ARRAY.
C     QIMAX -- SPECIFIED VALUE OF INFLOW ABOVE WHICH THE DEVIATION IS
C       SET TO 0.
C     DIFMAX -- MAXIMUM DEVIATION TO BE USED.  ABOVE THIS VALUE THE
C       DEVIATION IS SET TO 0.  DUE TO PAST HIGH INFLOWS OR OTHER CON-
C       DITIONS, THE DEVIATION MIGHT NOT BE APPLICABLE FOR RULE CURVE
C       ADJUSTMENT.
C     QIMHYD -- ARRAY OF MEAN INFLOWS.
C     AGBDEV -- AVERAGE DEVIATION AT BEGINNING OF FIRST TIME PERIOD.
C     BDEV -- ARRAY OF DEVIATIONS FOR NTIMRL PERIODS PRIOR TO BEGINNING
C       OF INFLOW AND ELEVATION ARRAYS.
C     OBSELV-- ARRAY OF OBSERVED ELEVATIONS.
C     RULEL -- ARRAY OF RULE CURVE ELEVATIONS CORRESPONDING TO OBSERVED
C       ELEVATIONS.
C     DEVIAT -- ARRAY OF DEVIATIONS CORRESPONDING TO OBSERVED ELEVATION
C       ARRAY.
C     AVGDEV --  AVERAGE OF RULE CURVE DEVIATIONS.
C     IBUG -- NO TRACE OR DEBUG (IBUG=0), TRACE ONLY (IBUG=1), TRACE AND
C       DEBUG (IBUG=2).
C **********************************************************************
C  ALL VARIABLES EXCEPT DEVIAT,AGBDEV, AND AVGDEV ARE FURNISHED BY THE
C SUPERVISORY EXECUTION ROUTINE.  DEVIAT, AGBDEV, AND AVGDEV ARE COMPUT-
C ED BY ARUL26 AND RETURNED  TO THE SUPERVISORY EXECUTION ROUTINE.
C **********************************************************************
      INCLUDE 'common/fdbug'
      INCLUDE 'common/resv26'
      INCLUDE 'common/exg26'
      INCLUDE 'common/fctime'
      INCLUDE 'common/rulc26'
C
      DIMENSION QIMHYD(1),BDEV(1),OBSELV(1),RULEL(1),DEVIAT(1),SUMMSG(1)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_res/RCS/arul26.f,v $
     . $',                                                             '
     .$Id: arul26.f,v 1.1 1995/09/17 19:05:23 dws Exp $
     . $' /
C    ===================================================================
C
C
C **********************************************************************
C WRITE TRACE AND DEBUG IF REQUIRED.
C **********************************************************************
      IF(IBUG-1)80,10,20
   10 WRITE(IODBUG,30)
      GO TO 80
   20 WRITE(IODBUG,30)
   30 FORMAT(1H0,10X,17H** ARUL26 ENTERED)
      WRITE(IODBUG,40) NRUN,NTIMRL,NOMSG,QIMAX,DIFMAX,IBUG
   40 FORMAT(1H0,39H    NRUN,NTIMRL,NOMSG,QIMAX,DIFMAX,IBUG/1X,3I6,2F12.
     $3,I6)
      WRITE(IODBUG,50)(QIMHYD(I),I=1,NRUN)
   50 FORMAT(1H0,12H INFLOWS ARE/(1X,10F12.3))
      WRITE(IODBUG,60) (BDEV(I),I=1,NTIMRL)
      WRITE(IODBUG,70) (OBSELV(I),I=1,NRUN)
   60 FORMAT(1H0,20H BACK DEVIATIONS ARE/(1X,10F12.3))
   70 FORMAT(1H0,41H OBSERVED ELEVATIONS THROUGH RUN TIME ARE/(1X,10F12.
     $3))
C **********************************************************************
C COMPUTE THE SUM OF DEVIATIONS IN THE BDEV ARRAY.
C **********************************************************************
   80 SUM=BDEV(1)
      NMSG=0
      DO 90 I=2,NTIMRL
   90 SUM=SUM+BDEV(I)
      TMPD=NTIMRL
      AGBDEV=SUM/TMPD
C
C **********************************************************************
C  SET AVERAGE DEVIATION AT END OF OBSERVED PERIOD TO AVERAGE AT START
C  OF RUN IN CASE THERE ARE NO OBSERVATIONS.
C **********************************************************************
C
      AVGDEV = AGBDEV
C **********************************************************************
C AGBDEV IS THE AVERAGE DEVIATION FOR NTIMRL PERIODS PRIOR TO THE BEGIN-
C NING TIME PERIOD AND WILL BE USED FOR ADJUSTING THE RULE CURVE FOR THE
C SIMULATED RUN.  COMPUTE DEVIATION AND SUM OF DEVIATIONS FOR PAST
C NTIMRL TIME PERIODS FOR EACH POSITION IN THE DEVIAT ARRAY.  SET THE
C FIRST DEVIATION (ADD) TO THE LAST POSITION IN THE BDEV ARRAY IN CASE
C THE FIRST POSITION OR POSITIONS IN OBSELV ARRAY ARE MISSING.  CO4PUTE
C POSITION (LOBSTO) OF LAST OBSERVED ELEVATION.
C **********************************************************************
      ADD=BDEV(NTIMRL)
      NMSG=NOMSG
C
      LOBSTO = 0
C
C  SET UP VALUES FOR 'IGNORETS' MOD USE
C
      IPTYPE = 4
      ISUTYP = 1
      DO 100 I=1,NRUN
      JULI = I*MINODT + (IDA-1)*24
      IF(IFMSNG(OBSELV(I)).NE.1 .AND. IFGNOR(IPTYPE,JULI,ISUTYP).NE.1)
     .  LOBSTO = I
  100 CONTINUE
C
      DO 170 I=1,NUM
      IF(QIMHYD(I).GT.QIMAX .OR. I.GT.LOBSTO) GO TO 110
      JULI = I*MINODT + (IDA-1)*24
      IF(IFMSNG(OBSELV(I)).NE.1 .AND. IFGNOR(IPTYPE,JULI,ISUTYP).NE.1)
     .  GO TO 130
      NMSG=NMSG+1
      IF(NMSG.GT.(NTIMRL/2))GO TO 120
      GO TO 140
  110 NMSG=NMSG+1
  120 ADD=0.
      GO TO 140
  130 ADD=OBSELV(I)-RULEL(I)
      IF(ADD.GT.DIFMAX)GO TO 110
      NMSG=0
  140 IF(I.GT.NTIMRL)GO TO 150
      SUB=BDEV(I)
      GO TO 160
  150 NOBS=I-NTIMRL
      SUB=DEVIAT(NOBS)
C **********************************************************************
C COMPUTE THE SUM OF DEVIATIONS FOR THE PAST NTIMRL PERIODS BY ADDING TO
C THE PREVIOUS SUM THE LATEST DEVIATION (ADD) AND SUBTRACTING THE DEVIA-
C TION (SUB) NTIMRL TIME PERIODS PRIOR TO THE LATEST DEVIATION.
C **********************************************************************
  160 SUM=SUM+ADD-SUB
      SUMMSG(I)=NMSG
      DEVIAT(I)=ADD
C **********************************************************************
C COMPUTE AVERAGE DEVIATION FOR ADJUSTING RULE CURVE FOR ADJUSTED RUN.
C IF AT END OF OBSERVED PERIOD.
C **********************************************************************
      IF (I.EQ.LOBSTO) AVGDEV = SUM/TMPD
  170 CONTINUE
C **********************************************************************
C WRITE TRACE AND DEBUG IF REQUIRED.
C **********************************************************************
      IF(IBUG-1)230,210,180
  180 WRITE(IODBUG,190)NTIMRL,AGBDEV,AVGDEV,LOBSTO,(DEVIAT(I),I=1,LOBSTO
     $)
  190 FORMAT(1H0,60H NO. OF TIME PERIODS USED FOR COMPUTING AVERAGE DEVI
     $ATION IS,I4,53H.  AVERAGE DEVIATION AT START OF FIRST TIME PERIOD
     $IS,F8.3/65H AVERAGE DEVIATION THROUGH THE LAST OF THE OBSERVED ELE
     $VATIONS IS,F8.3,20H DEVIATIONS FOR LAST,I6,12H PERIODS ARE/(1X,15F
     $8.3))
      WRITE(IODBUG,200) (SUMMSG(I),I=1,LOBSTO)
  200 FORMAT(1H0,49H VALUES IN ARRAY OF SUM OF MISSING DEVIATIONS ARE/(1
     $X,10F12.3))
  210 WRITE(IODBUG,220)
  220 FORMAT(1H0,10X,17H** LEAVING ARUL26)
  230 RETURN
      END
