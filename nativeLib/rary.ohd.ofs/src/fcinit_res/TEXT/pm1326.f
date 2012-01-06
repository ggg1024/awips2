C MODULE PM1326
C
      SUBROUTINE PM1326(WORK,IUSEW,LEFTW,NP13,
     .                  LENDSU,JDEST,IERR)
C---------------------------------------------------------------------
C  SUBROUTINE TO READ AND INTERPRET PARAMETER INPUT FOR S/U #13
C   POWER GENERATION SCHEME
C---------------------------------------------------------------------
C  K M KROUSE - HRL - DECEMBER 1983
C----------------------------------------------------------------
C
      INCLUDE 'ufreex'
      INCLUDE 'common/comn26'
      INCLUDE 'common/err26'
      INCLUDE 'common/fld26'
      INCLUDE 'common/mult26'
      INCLUDE 'common/rc26'
      INCLUDE 'common/read26'
      INCLUDE 'common/suid26'
      INCLUDE 'common/suin26'
      INCLUDE 'common/suky26'
      INCLUDE 'common/warn26'
C
      DIMENSION INPUT(2,17),LINPUT(17),QVAL(100),IP(17),IPREQ(5),OK(17),
     . HVAL(100),RVAL(100),WORK(1),TVAL(3),HQMIN(100),HUPP(100),
     . HLOW(100),EDIST(24),WDIST(7)
      LOGICAL ENDFND,OK,ALLOK,GETELV,GETHDQ,UDOW,GETTIM
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_res/RCS/pm1326.f,v $
     . $',                                                             '
     .$Id: pm1326.f,v 1.3 1998/07/02 19:37:06 page Exp $
     . $' /
C    ===================================================================
C
C
      DATA PLUS,RMINUS/1H+,1H-/
      DATA INPUT/
     .            4HTOD ,4H    ,4HDAIL,4HY   ,4HDOW ,4H    ,
     .            4HWEEK,4HLY  ,4HMINQ,4HDAY ,4HMINQ,4HWEEK,
     .            4HMINQ,4HINST,4HHUPP,4HER  ,4HHLOW,4HER  ,
     .            4HDSMA,4HXQ  ,4HQGEN,4HMAX ,4HELVS,4HMAXQ,
     .            4HHEAD,4HVSQ ,4HTWCU,4HRVE ,4HCONV,4H    ,
     .            4HCURV,4HE   ,4HRULE,4HTIME/
      DATA LINPUT/1,2,1,11*2,1,2,2/
      DATA NINPUT/17/
      DATA NDINPU/2/
C
      DATA IPREQ/2,8,9,11,16/
C
      DATA RULE/4hRULE/
C
      DATA QMCODE/1130.01/
C
C  INITIALIZE LOCAL VARIABLES AND COUNTERS
C
      NP13 = 0
      OK(1) = .TRUE.
      OK(2) = .FALSE.
      OK(3) = .TRUE.
      OK(4) = .TRUE.
      OK(5) = .TRUE.
      OK(6) = .TRUE.
      OK(7) = .TRUE.
      OK(8) = .FALSE.
      OK(9) = .FALSE.
      OK(10) = .TRUE .
      OK(11) = .FALSE.
      OK(12) = .TRUE.
      OK(13) = .TRUE.
      OK(14) = .TRUE.
      OK(15) = .TRUE.
      OK(16) = .FALSE.
      OK(17) = .TRUE.
C
      GETHDQ = .FALSE.
      GETELV = .FALSE.
      UDOW=.FALSE.
      GETTIM=.FALSE.
      ALLOK = .TRUE.
C
C
      DOW=-999.
      DMINQ=-999.
      WMINQ=-999.
      DSMAX=-999.
      TOD=-999.
      NQVAL = 0
      NHVAL = 0
      NTVAL=0
      CONVG = 0.02
      NHUPP=1
      NHLOW=1
      INOPT=0
      RTIME=-999.0
C
      CODEMQ = QMCODE + SULEVL
C
      DO 3 I = 1,17
           IP(I) = 0
    3 CONTINUE
C
      IERR = 0
C
C  PARMS FOUND, LOOKING FOR ENDP
C
      LPOS = LSPEC + NCARD + 1
      LASTCD = LENDSU
      IBLOCK = 1
C
    5 IF (NCARD .LT. LASTCD) GO TO 8
           CALL STRN26(59,1,SUKYWD(1,7),3)
           IERR = 99
           GO TO 9
    8 NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF .GT. 0 ) GO TO 9000
      NUMWD = (LEN -1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,SUKYWD,LSUKEY,NSUKEY,NDSUKY)
      IF (IDEST.EQ.0) GO TO 5
C
C  IDEST = 7 IS FOR ENDP
C
      IF (IDEST.EQ.7.OR.IDEST.EQ.8) GO TO 9
          CALL STRN26(59,1,SUKYWD(1,7),3)
          JDEST = IDEST
          IERR = 89
    9 LENDP = NCARD
C
C  ENDP CARD OR TS OR CO FOUND AT LENDP,
C  ALSO ERR RECOVERY IF NEITHER ONE OF THEM FOUND.
C
C
      IBLOCK = 2
      CALL POSN26(MUNI26,LPOS)
      NCARD = LPOS - LSPEC -1
C
   10 CONTINUE
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF .GT. 0) GO TO 9000
      NUMWD = (LEN -1)/4 + 1
      IDEST = IKEY26(CHAR,NUMWD,INPUT,LINPUT,NINPUT,NDINPU)
      IF(IDEST .GT. 0) GO TO 50
      IF(NCARD .GE. LENDP) GO TO 5000
C
C  NO VALID KEYWORD FOUND
C
      CALL STER26(1,1)
      ALLOK = .FALSE.
      GO TO 10
C
C  NOW SEND CONTROL TO PROPER LOCATION FOR PROCESSING EXPECTED INPUT
C
   50 CONTINUE
      GO TO  (100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,
     .        1400,1500,1600,1700) , IDEST
C
C-----------------------------------------------------------------------
C  'TOD' KEYWORD EXPECTED. IF FOUND, GET NEXT FIELD ON CARD
C   IF NOT FOUND, STORE VALUES IN WORK USING DEFAULT
C
 100  CONTINUE
C
      IP(1) = IP(1) + 1
      IF (IP(1).GT.1) CALL STER26(39,1)
C
C  AN INTEGER VALUE ( OR A NULL FIELD) MUST FOLLOW
C
      OK(1) = .FALSE.
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 150
C
C  SPECIFICATION MUST BE INTEGER
C
      IF (ITYPE.EQ.0) GO TO 120
      CALL STER26(5,1)
      GO TO 10
C
 120  CONTINUE
C
C  TOD MUST BE .GE. ZERO AND .LE. 24
C
      IF (INTEGR.GE.0 .AND. INTEGR.LE.24) GO TO 130
      CALL STER26(113,1)
      GO TO 10
C
 130  CONTINUE
      TOD = INTEGR + 0.01
C
C  EVERYTHING IS OK
C
 150  CONTINUE
      OK(1) = .TRUE.
      GO TO 10
C
C---------------------------------------------------------------------
C  'DAILY' KEYWORD EXPECTED. IF FOUND, GET NEXT FIELD ON CARD.
C   IT'S AN ERROR IF NOT FOUND.
C
  200 CONTINUE
C
      IP(2) = IP(2) + 1
      IF (IP(2).GT.1) CALL STER26(39,1)
C
C  ONE VALUE PER TIME PERIOD MUST FOLLOW
C
C
C  GET LIST OF VALUES
C
      NEDIST=24
      CALL GLST26(1,1,IX,EDIST,IX,NEDIST,OK(2))
C
C  MUST HAVE 24/MINODT VALUES
C
      IF (NEDIST.EQ.24/MINODT) GO TO 220
C
      CALL STER26(62,1)
      GO TO 10
C
C  ALL VALUES MUST BE POSITIVE
C
  220 CONTINUE
C
      TOTAL = 0.000
      DO 230 I=1,NEDIST
C
      IF (EDIST(I) .GE. 0.00) GO TO 225
C
      CALL STER26(61,1)
      GO TO 10
C
  225 CONTINUE
      TOTAL = TOTAL + EDIST(I)
  230 CONTINUE
C
C  TOTAL MUST SUM TO 1.000 +- .001
C
      DIFF = ABS(TOTAL-1.000)
      IF (DIFF .LE. 0.001) GO TO 240
C
      CALL STER26(71,1)
      GO TO 10
C
C  EVERYTHING IS OK
C
  240 CONTINUE
      OK(2) = .TRUE.
      GO TO 10
C
C----------------------------------------------------------------------
C  'DOW' EXPECTED HERE. IF FOUND, IT MUST BE FOLLOWED BY A 1 THRU 7.
C   IF NOT ENTERED, STORE AS A -999.
C
  300 CONTINUE
      IP(3) = IP(3) + 1
      IF (IP(3).GT.1) CALL STER26(39,1)
C
C  LOOK FOR 1 THRU 7 VALUE OR A NULL FIELD.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF.EQ.1)GO TO 335
      IF (IERF.GT.1) GO TO 9000
C
C  FIELD MUST BE INTEGER
C
      IF (ITYPE.EQ.0) GO TO 320
C
      CALL STER26(5,1)
      GO TO 10
C
C
  320 CONTINUE
      IF (INTEGR.GE.1.AND.INTEGR.LE.7) GO TO 330
C
      CALL STER26(107,1)
      GO TO 10
C
C  EVERYTHING IS OK
C
  330 CONTINUE
      DOW = INTEGR + 0.01
      UDOW=.TRUE.
 335  OK(3)=.TRUE.
      GO TO 10
C
C---------------------------------------------------------------------
C  'WEEKLY' KEYWORD EXPECTED. IF FOUND, GET NEXT FIELD ON CARD.
C   ONLY NEEDED IF 'DOW' NOT EQUAL TO -999.
C
  400 CONTINUE
C
      IP(4) = IP(4) + 1
      IF (IP(4).GT.1) CALL STER26(39,1)
      IF (UDOW) GO TO 410
      CALL STRN26(60,1,INPUT(1,IDEST),LINPUT(IDEST))
           GO TO 10
C
C  SEVEN VALUES MUST FOLLOW
C
  410 CONTINUE
C
C  GET LIST OF VALUES
C
      NWDIST=7
      CALL GLST26(1,1,IX,WDIST,IX,NWDIST,OK(4))
C
C  MUST HAVE 7 VALUES
C
      IF (NWDIST.EQ.7) GO TO 420
C
      CALL STER26(62,1)
      GO TO 10
C
C  ALL VALUES MUST BE POSITIVE
C
  420 CONTINUE
C
      TOTAL = 0.000
      DO 430 I=1,NWDIST
C
      IF (WDIST(I) .GE. 0.00) GO TO 425
C
      CALL STER26(61,1)
      GO TO 10
C
  425 CONTINUE
      TOTAL = TOTAL + WDIST(I)
  430 CONTINUE
C
C  TOTAL MUST SUM TO 1.000 +- .001
C
      DIFF = ABS(TOTAL-1.000)
      IF (DIFF .LE. 0.001) GO TO 440
C
      CALL STER26(71,1)
      GO TO 10
C
C  EVERYTHING IS OK
C
  440 CONTINUE
      OK(4) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'MINQ-DAY' IS NEXT. IF IT IS NOT FOUND IN THE INPUT STREAM,
C  SET TO -999.
C
  500 CONTINUE
      IP(5) = IP(5) + 1
      IF (IP(5).GT.1) CALL STER26(39,1)
C
C  GET NEXT FIELD. ALLOWED FIELDS ARE THE NULL FIELD, OR A REAL POSITIVE
C  VALUE
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 590
C
C  LOOKING FOR REAL, POSITIVE VALUE
C
      IF (ITYPE.EQ.1) GO TO 520
      CALL STER26(4,1)
      GO TO 10
C
  520 CONTINUE
      IF(REAL.GE. 0.00)GO TO 530
      CALL STER26(61,1)
      GO TO 10
C
C  SAVE THE VALUE AS ALL IS OK WITH 'MINQ-DAY'
C
  530 CONTINUE
      DMINQ = REAL/CONVLT
C
  590 CONTINUE
      OK(5) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'MINQWEEK' IS NEXT. IF IT IS NOT FOUND IN THE INPUT STREAM,
C  SET TO -999.
C
  600 CONTINUE
      IP(6) = IP(6) + 1
      IF (IP(6).GT.1) CALL STER26(39,1)
C
C  GET NEXT FIELD. ALLOWED FIELDS ARE THE NULL FIELD, OR A REAL POSITIVE
C  VALUE
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 690
C
C  LOOKING FOR REAL, POSITIVE VALUE
C
      IF (ITYPE.EQ.1) GO TO 620
      CALL STER26(4,1)
      GO TO 10
C
  620 CONTINUE
      IF(REAL.GE.0.0)GO TO 630
      CALL STER26(61,1)
      GO TO 10
C
C  SAVE THE VALUE AS ALL IS OK WITH 'MINQWEEK'
C
  630 CONTINUE
      WMINQ = REAL/CONVLT
C
  690 CONTINUE
      OK(6) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'MINQINST' IS NEXT. VALUE SPECIFIED MUST BE A REAL POSITIVE SINGLE
C   VALUE OR A SET OF DATES VS. MINIMUM FLOW VALUES. IF NOT USED, SET
C   THE NUMBER OF VALUES TO ZERO.
C
 700  CONTINUE
      IP(7) = IP(7) + 1
      IF (IP(7).GT.1) CALL STER26(39,1)
C
C  NEXT FIELD MUST BE REAL POSITIVE VALUE, A NULL FIELD, OR A SET OF
C  VALUES.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1)GO TO 790
C
C  FIELD IS NUMERIC. REPOSITION TO READ FIRST FIELD AFTER 'MINQINST'.
C
      LPOSST=LSPEC+NCARD
      CALL POSN26(MUNI26,LPOSST)
      NCARD=LPOSST-LSPEC-1
      NUMFLD=0
      CALL UFLD26(NUMFLD,IERF)
C
C  DETERMINE IF JUST ONE VALUE OR SET OF VALUES.
C
      NHQMIN=100
      CALL GLST26(1,1,X,HQMIN,X,NHQMIN,OK(7))
      INOPT=NHQMIN/2 + 0.01
      IF(.NOT.OK(7))GO TO 10
      IF(NHQMIN.EQ.1)GO TO 758
C
C  'MINQINST' IS A SET OF DATE VS. FLOW VALUES.
C   FOUR CHECKS MUST BE MADE ON THE CURVE:
C    1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF HQMIN ARE
C       NEEDED)
C    2) THE FLOWS MUST BE REAL AND POSITIVE
C    3) THE DATES MUST BE BETWEEN 1 AND 366, AND
C    4) THE DATES MUST BE IN ASCENDING ORDER
C
      IF(MOD(NHQMIN,2).EQ.0)GO TO 730
C
      CALL STER26(40,1)
      GO TO 10
C
 730  CONTINUE
      NHALF=NHQMIN/2
      NSEC=NHALF+1
C
C  SEE IF DATES ARE IN ASCENDING ORDER
C
      CALL ASCN26(HQMIN,NHALF,0,IERA)
      IF(IERA.GT.0)GO TO 10
C
C  SEE IF DATES ARE BETWEEN 1 AND 366
C
      DO 740 I=1,NHALF
      IF(1.0.LE.HQMIN(I). AND. HQMIN(I).LE.366.02)GO TO 740
C
      CALL STER26(64,1)
      GO TO 10
C
 740  CONTINUE
C
C  SEE IF FLOWS ARE  REAL AND POSITIVE.
C
      DO 755 I=NSEC,NHQMIN
      HQMIN(I)=HQMIN(I)/CONVLT
      IF(HQMIN(I).GT.0.0)GO TO 755
      CALL STER26(61,1)
      GO TO 10
 755  CONTINUE
      GO TO 795
C
C  'MINQINST' IS A CONSTANT VALUE.
C  VALUE MUST BE REAL AND POSITIVE.
C
 758  HQM = HQMIN(1)/CONVLT
      INOPT=1
      IF(HQM.GT.0.0)GO TO 795
      CALL STER26(61,1)
      GO TO 10
C
C  EVERYTHING IS OK
C
 790  CONTINUE
      INOPT=0
 795  OK(7)=.TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'HUPPER' IS NEXT. VALUE SPECIFIED MUST BE WITHIN THE ELEV. VS.
C   STORAGE CURVE, OR IT MUST BE 'RULE' FOR THE RULE CURVE VALUE.
C   OR IT CAN ALSO BE A SET OF DATE VS. ELEVATION VALUES.
C
 800  CONTINUE
      IP(8) = IP(8) + 1
      IF (IP(8).GT.1) CALL STER26(39,1)
C
C  NEXT FIELD MUST BE REAL POSITIVE VALUE, ALSO WITHIN ELVSSTOR CURVE.
C  OR 'RULE' ,OR A SET OF VALUES.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
C  IF FIELD IS CHARACTER, LOOK FOR THE WORD 'RULE'.
C
      IF (ITYPE.GT.1) GO TO 860
C
C  FIELD IS NUMERIC. REPOSITION TO READ FIRST FIELD AFTER 'HUPPER'.
C
      LPOSST=LSPEC+NCARD
      CALL POSN26(MUNI26,LPOSST)
      NCARD=LPOSST-LSPEC-1
      NUMFLD=0
      CALL UFLD26(NUMFLD,IERF)
C
C  DETERMINE IF JUST ONE VALUE OR SET OF VALUES.
C
      NHUPP=100
      CALL GLST26(1,1,X,HUPP,X,NHUPP,OK(8))
      IF(.NOT.OK(8))GO TO 10
      IF(NHUPP.EQ.1)GO TO 858
C
C  'HUPPER' IS A SET OF DATE VS. ELEVATION VALUES.
C   FOUR CHECKS MUST BE MADE ON THE CURVE:
C    1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF HUPP ARE
C       NEEDED)
C    2) THE ELEVATIONS MUST BE BETWEEN THE DEFINED BOUNDARIES OF THE
C       ELVSSTOR CURVE
C    3) THE DATES MUST BE BETWEEN 1 AND 366, AND
C    4) THE DATES MUST BE IN ASCENDING ORDER
C
      IF(MOD(NHUPP,2).EQ.0)GO TO 830
C
      CALL STER26(40,1)
      GO TO 10
C
 830  CONTINUE
      NHALF=NHUPP/2
      NSEC=NHALF+1
C
C  SEE IF DATES ARE IN ASCENDING ORDER
C
      CALL ASCN26(HUPP,NHALF,0,IERA)
      IF(IERA.GT.0)GO TO 10
C
C  SEE IF DATES ARE BETWEEN 1 AND 366
C
      DO 840 I=1,NHALF
      IF(1.0.LE.HUPP(I). AND. HUPP(I).LE.366.02)GO TO 840
C
      CALL STER26(64,1)
      GO TO 10
C
 840  CONTINUE
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELVSSTOR CURVE.
C
      DO 855 I=NSEC,NHUPP
      HUPP(I)=HUPP(I)/CONVL
 855  CONTINUE
C
      CALL ELST26(HUPP(NSEC),NHALF,IERST)
      IF(IERST.GT.0)GO TO 10
      GO TO 890
C
C  'HUPPER' IS A CONSTANT VALUE.
C  VALUE MUST BE WITHIN THE ELVSSTOR CURVE.
C
 858  HUPPER = HUPP(1)/CONVL
      CALL ELST26(HUPPER,1,IERS)
      IF (IERS.EQ.0) GO TO 890
      GO TO 10
C
C  CHARACTER FIELD FOUND. IT MUST BE 'RULE'
C  OR IT CAN BE 'RULE + FACTOR'
C
 860  CONTINUE
C
       IF (IUSAME(CHAR,RULE,1).EQ.1) GO TO 865
C
       CALL STRN26(59,1,RULE,1)
       GO TO 10
C
C  DETERMINE IF 'RULE' IS FOLLOWED BY A '+ FACTOR'.
C
 865  IEND=ISTRT+LEN-1
      CALL USCHBF (PLUS,ISTRT,IEND,IX)
C
C  IF IX = 0 , NO '+' WAS FOUND.
C
      IF(IX.EQ.0)GO TO 880
C
C  '+' FOUND. GO GET CHARACTER STRING FOLLOWING IT. LOOKING FOR A
C  NUMBER, EITHER INTEGER OR REAL.
C
      IXS = IX -ISTRT + 1
      CALL UAFT26(3,TVAL,ISTRT,IXS,LEN,IERA)
C
      IF(IERA.EQ.0)GO TO 870
      IF(IERA.EQ.-1)IERN=4
      IF(IERA.EQ.2)IERN=20
      CALL STER26(IERN,6)
      GO TO 10
C
C  CONVERT CHARACTER STRING INTO NUMERIC REPRESENTATION
C
 870  CONTINUE
      IXSS=IXS+1
      CALL UFRLFX(FACT,ISTRT,IXSS,LEN,0,IERR)
      IF(IERR.EQ.0)GO TO 875
C
      CALL STER26(4,6)
      GO TO 10
C
C  ADD FACTOR TO -999. FOR STORING IN WORK ARRAY.
C
 875  CONTINUE
      HUPPER=-999.+FACT/CONVL
      GO TO 890
C
C  STORE ELEVATION AS -999.0 TO INDICATE RULE CURVE USAGE
C
 880  HUPPER=-999.0
C
C EVERYTHING IS OK
C
 890  CONTINUE
      OK(8) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'HLOWER' IS NEXT. VALUE SPECIFIED MUST BE WITHIN THE ELEV. VS.
C   STORAGE CURVE, OR IT MUST BE 'RULE' FOR THE RULE CURVE VALUE.
C   OR IT CAN ALSO BE A SET OF DATE VS. ELEVATION VALUES.
C
 900  CONTINUE
      IP(9) = IP(9) + 1
      IF (IP(9).GT.1) CALL STER26(39,1)
C
C  NEXT FIELD MUST BE REAL POSITIVE VALUE, ALSO WITHIN ELVSSTOR CURVE.
C  OR 'RULE' ,OR A SET OF VALUES.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
C  IF FIELD IS CHARACTER, LOOK FOR THE WORD 'RULE'.
C
      IF (ITYPE.GT.1) GO TO 960
C
C  FIELD IS NUMERIC. REPOSITION TO READ FIRST FIELD AFTER 'HLOWER'.
C
      LPOSST=LSPEC+NCARD
      CALL POSN26(MUNI26,LPOSST)
      NCARD=LPOSST-LSPEC-1
      NUMFLD=0
      CALL UFLD26(NUMFLD,IERF)
C
C  DETERMINE IF JUST ONE VALUE OR SET OF VALUES.
C
      NHLOW=100
      CALL GLST26(1,1,X,HLOW,X,NHLOW,OK(9))
      IF(.NOT.OK(9))GO TO 10
      IF(NHLOW.EQ.1)GO TO 958
C
C  'HLOWER' IS A SET OF DATE VS. ELEVATION VALUES.
C   FOUR CHECKS MUST BE MADE ON THE CURVE:
C    1) THE TOTAL NO. OF VALUES INPUT MIST BE EVEN (PAIRS OF HLOW ARE
C       NEDDED)
C    2) THE ELEVATIONS MUST BE BETWEEN THE DEFINED BOUNDARIES OF THE
C       ELVSSTOR CURVE
C    3) THE DATES MUST BE BETWEEN 1 AND 366, AND
C    4) THE DATES MUST BE IN ASCENDING ORDER
C
      IF(MOD(NHLOW,2).EQ.0)GO TO 930
C
      CALL STER26(40,1)
      GO TO 10
C
 930  CONTINUE
      NHALF=NHLOW/2
      NSEC=NHALF+1
C
C  SEE IF DATES ARE IN ASCENDING ORDER
C
      CALL ASCN26(HLOW,NHALF,0,IERA)
      IF(IERA.GT.0)GO TO 10
C
C  SEE IF DATES ARE BETWEEN 1 AND 366
C
      DO 940 I=1,NHALF
      IF(1.0.LE.HLOW(I). AND. HLOW(I).LE.366.02)GO TO 940
C
      CALL STER26(64,1)
      GO TO 10
C
 940  CONTINUE
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELVSSTOR CURVE.
C
      DO 955 I=NSEC,NHLOW
      HLOW(I)=HLOW(I)/CONVL
 955  CONTINUE
C
      CALL ELST26(HLOW(NSEC),NHALF,IERST)
      IF(IERST.GT.0)GO TO 10
      GO TO 990
C
C  'HLOWER' IS A CONSTANT VALUE.
C  VALUE MUST BE WITHIN THE ELVSSTOR CURVE.
C
 958  HLOWER = HLOW(1)/CONVL
      CALL ELST26(HLOWER,1,IERS)
      IF (IERS.EQ.0) GO TO 990
      GO TO 10
C
C  CHARACTER FIELD FOUND. IT MUST BE 'RULE'
C  OR IT CAN BE 'RULE - FACTOR'
C
 960  CONTINUE
C
       IF (IUSAME(CHAR,RULE,1).EQ.1) GO TO 965
C
       CALL STRN26(59,1,RULE,1)
       GO TO 10
C
C  DETERMINE IF 'RULE' IS FOLLOWED BY A '- FACTOR'.
C
 965  IEND=ISTRT+LEN-1
      CALL USCHBF (RMINUS,ISTRT,IEND,IX)
C
C  IF IX = 0 , NO '-' WAS FOUND.
C
      IF(IX.EQ.0)GO TO 980
C
C  '-' FOUND. GO GET CHARACTER STRING FOLLOWING IT. LOOKING FOR A
C  NUMBER, EITHER INTEGER OR REAL.
C
      IXS = IX -ISTRT + 1
      CALL UAFT26(3,TVAL,ISTRT,IXS,LEN,IERA)
C
      IF(IERA.EQ.0)GO TO 970
      IF(IERA.EQ.-1)IERN=4
      IF(IERA.EQ.2)IERN=20
      CALL STER26(IERN,6)
      GO TO 10
C
C  CONVERT CHARACTER STRING INTO NUMERIC REPRESENTATION
C
 970  CONTINUE
      IXSS=IXS+1
      CALL UFRLFX(FACT,ISTRT,IXSS,LEN,0,IERR)
      IF(IERR.EQ.0)GO TO 975
C
      CALL STER26(4,6)
      GO TO 10
C
C  SUBTRACT FACTOR FROM -999.0 FOR STORING IN WORK ARRAY.
C
 975  CONTINUE
      HLOWER=-999.-FACT/CONVL
      GO TO 990
C
C  STORE ELEVATION AS -999.0 TO INDICATE RULE CURVE USAGE
C
 980  HLOWER=-999.0
C
C EVERYTHING IS OK
C
 990  CONTINUE
      OK(9) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'DSMAXQ' IS NEXT. IF IT IS NOT FOUND IN THE INPUT STREAM,
C  SET TO -999.
C
 1000 CONTINUE
      IP(10) = IP(10) + 1
      IF (IP(10).GT.1) CALL STER26(39,1)
C
C  GET NEXT FIELD. ALLOWED FIELDS ARE THE NULL FIELD, OR A REAL POSITIVE
C  VALUE
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 1090
C
C  LOOKING FOR REAL, POSITIVE VALUE
C
      IF (ITYPE.EQ.1) GO TO 1020
      CALL STER26(4,1)
      GO TO 10
C
 1020 CONTINUE
      IF(REAL.GE.0.0)GO TO 1030
      CALL STER26(61,1)
      GO TO 10
C
C  SAVE THE VALUE AS ALL IS OK WITH 'DSMAXQ'
C
 1030 CONTINUE
      DSMAX = REAL/CONVLT
C
 1090 CONTINUE
      OK(10) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'QGENMAX' IS NEXT.
C
 1100 CONTINUE
      IP(11) = IP(11) + 1
      IF (IP(11).GT.1) CALL STER26(39,1)
C
C  GET NEXT FIELD. MUST BE REAL AND POSITIVE. IF NOT FOUND,
C  CALL IT AN ERROR.
C
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
C  LOOKING FOR REAL, POSITIVE VALUE
C
      IF (ITYPE.EQ.1) GO TO 1120
      CALL STER26(4,1)
      GO TO 10
C
 1120 CONTINUE
      IF(REAL.GE.0.0)GO TO 1130
      CALL STER26(61,1)
      GO TO 10
C
C  SAVE THE VALUE AS ALL IS OK WITH 'QGENMAX'
C
 1130 CONTINUE
      QGEN = REAL/CONVLT
      OK(11) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'ELVSMAXQ' IS NEXT. IT'S NEEDED TO DEFINE THE ELEVATION VS. MAXIMUM
C   DISCHARGE CURVE. ALLOWED ONLY IF 'HEADVSQ' IS NOT DEFINED.
C
 1200 CONTINUE
      IP(12) = IP(12) + 1
      IF (IP(12).GT.1) CALL STER26(39,1)
      IF(IP(13).GT.0) CALL STER26(114,1)
C
C GET LIST OF VALUES FOR DEFINING THE MAX GENERATION CURVE
C
      NQVAL=100
      CALL GLST26(1,1,X,QVAL,X,NQVAL,OK(12))
      IF (.NOT.OK(12)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE CURVE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE ELEVATIONS MUST BE BETWEEN THE DEFINED BOUNDARIES OF THE ELEV
C      VS STORAGE CURVE,
C   3) THE ELEVATIONS MUST BE IN ASCENDING ORDER,
C   4) THE DISCHARGES MUST BE IN ASCENDING ORDER,
C   12) THE DISCHARGES MUST BE POSITIVE.
C
      IF (MOD(NQVAL,2).EQ.0) GO TO 1220
C
      CALL STER26(40,1)
      GO TO 10
C
 1220 CONTINUE
      NHALF = NQVAL/2
      NSEC = NHALF + 1
C
C  SEE IF ELEVATIONS ARE IN ASCENDING ORDER
C
      CALL ASCN26(QVAL,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF DISCHARGES ARE IN ASCENDING ORDER
C
      CALL ASCN26(QVAL(NSEC),NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF DISCHARGES ARE ALL POSITIVE
C
      DO 1240 I=NSEC,NQVAL
      QVAL(I) = QVAL(I)/CONVLT
      IF (QVAL(I).GE.0.00) GO TO 1240
C
      CALL STER26(95,1)
      GO TO 10
C
 1240 CONTINUE
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELEV VS. STORAGE CURVE
C  IF STORAGE CURVE WAS NOT DEFINED, CALL IT AN ERROR
C
      DO 1255 I=1,NHALF
      QVAL(I) = QVAL(I)/CONVL
 1255 CONTINUE
C
      CALL ELST26(QVAL,NHALF,IERST)
      IF (IERST.GT.0) GO TO 10
C
C  CURVE IS DEFINED OK
C
 1295 CONTINUE
      OK(12) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'HEADVSQ' IS NEXT IN LINE.
C
 1300 CONTINUE
      IP(13) = IP(13) + 1
      IF (IP(13).GT.1) CALL STER26(39,1)
      IF(IP(12).EQ.0)GO TO 1310
      CALL STER26(114,1)
      GO TO 10
C
C  READ FIRST FIELD AFTER 'HEADVSQ'. IF IT'S NUMERIC, GET LIST OF NUMBER
C   FOR DEFINING CURVE
C  IF IT'S CHARACTER, ASSUME A MULTIPLE USE REFERENCE HAS BEEN ENTERED,
C   SEE IF SPEC IS VALID.
C
C  IN THE 1ST CASE, WE MUST REPOSITION READ POINTER BACK TO READ THE FIR
C  FIELD AFTER 'HEADVSQ'.
C
 1310 CONTINUE
      GETHDQ=.TRUE.
      LPOSST = LSPEC + NCARD
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
      IHTYPE = ITYPE
      IF (IHTYPE.GT.1) GO TO 1370
C
C  REPOSITION TO READ FIRST FIELD AFTER 'HEADVSQ'
C
      CALL POSN26(MUNI26,LPOSST)
      NCARD = LPOSST - LSPEC - 1
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
C
C
C GET LIST OF VALUES FOR DEFINING THE HEAD VS. Q CURVE
C
      NHVAL=100
      CALL GLST26(1,1,X,HVAL,X,NHVAL,OK(13))
      IF (.NOT.OK(13)) GO TO 10
C
C  FIVE CHECKS MUST BE MADE ON THE CURVE:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF VALUES ARE
C      NEEDED,
C   2) THE HEAD VALUES MUST BE IN ASCENDING ORDER,
C   3) THE DISCHARGES MUST BE IN ASCENDING ORDER,
C   4) THE DISCHARGES AND HEAD VALUES MUST BE POSITIVE.
C
      IF (MOD(NHVAL,2).EQ.0) GO TO 1330
C
      CALL STER26(40,1)
      GO TO 10
C
 1330 CONTINUE
      NHALF = NHVAL/2
      NSEC = NHALF + 1
C
C  SEE IF HEAD VALUES ARE IN ASCENDING ORDER
C
      CALL ASCN26(HVAL,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF DISCHARGES ARE IN ASCENDING ORDER
C
      CALL ASCN26(HVAL(NSEC),NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF ALL VALUES ARE ALL POSITIVE
C
      DO 1350 I=1,NHVAL
      CONV = CONVL
      IF (I.GT.NHALF) CONV = CONVLT
      HVAL(I) = HVAL(I)/CONV
      IF (HVAL(I).GT.0.00) GO TO 1350
C
      CALL STER26(61,1)
      GO TO 10
C
 1350 CONTINUE
C
C  STORE CODE FOR HEAD VS DISCHARGE CURVE IN /MULT26/
C
      NMDEF(3) = NMDEF(3) + 1
      DMCODE(NMDEF(3),3) = CODEMQ
C
      GO TO 1395
C
C--------------------------------
C  FIRST FIELD AFTER 'HEADVSQ' IS CHARACTER. SEE IF IT'S A VALID S/U ID
C  WITH OR WITHOUT PARENTHESES
C
 1370 CONTINUE
      CALL MREF26(3,REFCDH,LOCWK,LOCCDH,IERM)
      IF (IERM.GT.0) GO TO 10
C
C  CURVE IS DEFINED OK
C
 1395 CONTINUE
      OK(13) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'TWCURVE' IS NEXT IN LINE. ALLOWED ONLY IF HEADVSQ WAS NOT ENTERED.
C
 1400 CONTINUE
      IP(14) = IP(14) + 1
      IF (IP(14).GT.1) CALL STER26(39,1)
      IF(IP(13).EQ.1)GO TO 1410
      CALL STRN26(60,1,INPUT(1,14),LINPUT(14))
      GO TO 10
C
C  LOOK FOR RATING CURVE NAME
C
 1410 CONTINUE
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
C  SEE IF RATING CURVE HAS BEEN DEFINED WITHIN THE FORECAST SEGMENT
C
      CALL CHEKRC(CHAR,IERR)
      IF (IERR.GT.0) GO TO 10
C
C  SEE IF WE'VE ALREADY DEFINED A TAIL WATER RATING CURVE
C
      CALL CKRC26(1,CHAR,IERR)
      IF (IERR.GT.0) GO TO 10
C
C  CURVE IS REFERRED TO PROPERLY.
C
 1495 CONTINUE
      OK(7) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'CONV' IS NEXT. IF IT IS NOT FOUND IN THE INPUT STREAM,
C  USE THE DEFAULT (2%). ALLOWED ONLY IF HEADVSQ WAS ENTERED.
C
 1500 CONTINUE
      IP(15) = IP(15) + 1
      OK(15) = .FALSE.
      IF (IP(15).GT.1) CALL STER26(39,1)
      IF(IP(13).EQ.1)GO TO 1510
      CALL STRN26(60,1,INPUT(1,15),LINPUT(15))
      GO TO 10
C
C  GET NEXT FIELD. ALLOWED FIELDS ARE THE NULL FIELD, OR A REAL POSITIVE
C  VALUE BETWEEN 0.01 AND 1.00
C
 1510 NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 1590
C
C  LOOKING FOR REAL, POSITIVE VALUE BETWEEN 0.01 AND 1.00
C
      IF (ITYPE.EQ.1) GO TO 1520
      CALL STER26(4,1)
      GO TO 10
C
 1520 CONTINUE
      IF (REAL.GE.0.01.AND.REAL.LE.1.00) GO TO 1530
      CALL STER26(61,1)
      GO TO 10
C
C  SAVE THE VALUE AS ALL IS OK WITH 'CONV'
C
 1530 CONTINUE
      CONVG = REAL
C
 1590 CONTINUE
      OK(15) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'RULECURV' EXPECTED HERE.
C
 1600 CONTINUE
      IP(16) = IP(16) + 1
      IF (IP(16).GT.1) CALL STER26(39,1)
C
C  READ FIRST FIELD AFTER 'RULECURV'. IF IT'S NUMERIC, GET LIST OF NUMBE
C   FOR DEFINING RULECURV
C  IF IT'S CHARACTER, ASSUME A MULTIPLE USE REFERENCE HAS BEEN ENTERED,
C   SEE IF SPEC IS VALID.
C
C  IN THE 1ST CASE, WE MUST REPOSITION READ POINTER BACK TO READ THE FIR
C  FIELD AFTER 'RULECURV'.
C
C  IF THE CURVE IS NEEDED AND NOT FOUND, CALL IT AN ERROR.
C
 1620 CONTINUE
      LPOSST = LSPEC + NCARD
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.0) GO TO 9000
C
      ICTYPE = ITYPE
      IF (ICTYPE.GT.1) GO TO 1660
C
C  REPOSITION TO READ FIRST FIELD AFTER 'RULECURV'
C
      GETTIM=.TRUE.
      CALL POSN26(MUNI26,LPOSST)
      NCARD = LPOSST - LSPEC - 1
      NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
C
C
C GET LIST OF VALUES FOR DEFINING THE RULE RULECURV
C
      NRVAL=100
      CALL GLST26(1,1,X,RVAL,X,NRVAL,OK(16))
      IF (.NOT.OK(16)) GO TO 10
C
C  FOUR CHECKS MUST BE MADE ON THE RULECURV:
C   1) THE TOTAL NO. OF VALUES INPUT MUST BE EVEN (PAIRS OF RVALS ARE
C      NEEDED,
C   2) THE ELEVATIONS MUST BE BETWEEN THE DEFINED BOUNDARIES OF THE ELEV
C      VS STORAGE RULECURV,
C   3) THE DATES MUST BE BETWEEN 1 AND 366, AND
C   4) THE DATES MUST BE IN ASCENDIONG ORDER.
C
      IF (MOD(NRVAL,2).EQ.0) GO TO 1630
C
      CALL STER26(40,1)
      GO TO 10
C
 1630 CONTINUE
      NHALF = NRVAL/2
      NSEC = NHALF + 1
C
C  SEE IF DATES ARE IN ASCENDING ORDER
C
      CALL ASCN26(RVAL,NHALF,0,IERA)
      IF (IERA.GT.0) GO TO 10
C
C  SEE IF DATES ARE BETWEEN 1 AND 366
C
      DO 1640 I=1,NHALF
      IF (1.0.LE.RVAL(I).AND.RVAL(I).LE.366.02) GO TO 1640
C
      CALL STER26(64,1)
      GO TO 10
C
 1640 CONTINUE
C
C  SEE IF ELEVATIONS ARE WITHIN BOUNDS OF ELEV VS. STORAGE CURVE
C  IF RULECURV WAS NOT DEFINED, CALL IT AN ERROR
C
      DO 1655 I=NSEC,NRVAL
      RVAL(I) = RVAL(I)/CONVL
 1655 CONTINUE
C
      CALL ELST26(RVAL(NSEC),NHALF,IERST)
      IF (IERST.GT.0) GO TO 10
C
C  STORE CODE FOR RULERULECURV IN /MULT26/
C
      NMDEF(1) = NMDEF(1) + 1
      DMCODE(NMDEF(1),1) = CODEMQ
C
      GO TO 1695
C
C--------------------------------
C  FIRST FIELD AFTER 'RULECURV' IS CHARACTER. SEE IF IT'S A VALID S/U ID
C  WITH OR WITHOUT PARENTHESES
C
 1660 CONTINUE
      CALL MREF26(1,REFCDE,LOCWK,LOCCDE,IERM)
      IF (IERM.GT.0) GO TO 10
C
C  CURVE IS DEFINED OK
C
 1695 CONTINUE
      OK(16) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  'RULETIME' KEYWORD EXPECTED. IF FOUND, GET NEXT FIELD ON CARD
C   IF NOT FOUND, STORE VALUES IN WORK USING DEFAULT
C
 1700 CONTINUE
C
      IP(17) = IP(17) + 1
      IF (IP(17).GT.1) CALL STER26(39,1)
      IF (GETTIM) GO TO 1710
C
C  'RULETIME' FOUND BUT NOT NEEDED. (I.E. - A REFERENCE TO 'CURVE' WAS
C   FOUND.)
C
      CALL STRN26(60,1,INPUT(1,17),2)
      GO TO 10
C
C  AN INTEGER VALUE ( OR A NULL FIELD) MUST FOLLOW
C
 1710 CONTINUE
C
      OK(17) = .FALSE.
      NUMFLD = -2
      CALL UFLD26(NUMFLD,IERF)
      IF (IERF.GT.1) GO TO 9000
      IF (IERF.EQ.1) GO TO 1750
C
C  SPECIFICATION MUST BE INTEGER
C
      IF (ITYPE.EQ.0) GO TO 1720
      CALL STER26(5,1)
      GO TO 10
C
 1720 CONTINUE
C
C  RULETIME MUST BE .GE. ZERO
C
      IF (INTEGR.GE.0) GO TO 1730
C
      CALL STER26(95,1)
      GO TO 10
C
C  TIME MUST BE MULTIPLE OF OPERATION TIME INTERVAL.
C
 1730 CONTINUE
C$     IF (MOD(INTEGR,MINODT).EQ.0) GO TO 1740
C
C$     CALL STER26(47,1)
C$     GO TO 10
C
C$ 1740 CONTINUE
      RTIME = INTEGR + 0.01
C
C  EVERYTHING IS OK
C
 1750 CONTINUE
      OK(17) = .TRUE.
      GO TO 10
C
C-----------------------------------------------------------------------
C  END OF INPUT. STORE VALUES IN WORK ARRAY IF EVERYTHING WAS ENTERED
C  WITHOUT ERROR.
C
 5000 CONTINUE
C
      DO 5005 I = 1,5
            NIP = IPREQ(I)
            IF (IP(NIP).EQ.0)
     .      CALL STRN26(59,1,INPUT(1,NIP),LINPUT(NIP))
 5005 CONTINUE
C
      IF (UDOW.AND.IP(4).EQ.0) CALL STRN26(59,1,INPUT(1,4),LINPUT(4))
      IF (GETHDQ.AND.IP(14).EQ.0)
     .    CALL STRN26(59,1,INPUT(1,14),LINPUT(14))
      IF(GETTIM .AND. IP(17).EQ.0)
     .    CALL STRN26(59,1,INPUT(1,17),LINPUT(17))
C
      DO 5007 I=1,17
      IF (.NOT.OK(I)) GO TO 9999
 5007 CONTINUE
      IF (ALLOK) GO TO 5010
      GO TO 9999
C--------------------------------------------------------
C  STORE TIME OF DAY TO BRING TO RULE CURVE
C
 5010 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,TOD,501)
      NP13 = NP13 + 1
C
C----------------------------
C  STORE DAILY DISTRIBUTION
C
      DO 5015 I=1,NEDIST
      CALL FLWK26(WORK,IUSEW,LEFTW,EDIST(I),501)
 5015 CONTINUE
      NP13 = NP13 + NEDIST
C
C------------------------------
C  STORE DAY OF WEEK TO RETURN TO RULE CURVE
C
      CALL FLWK26(WORK,IUSEW,LEFTW,DOW,501)
      NP13 = NP13 + 1
C
C------------------------------
C  STORE WEEKLY DISTRIBUTION FUNCTION
C
C  STORE ONLY IF 'DOW' (DAY OF WEEK) WAS USED.
C
      IF(.NOT.UDOW)GO TO 5025
      DO 5020 I=1,7
      CALL FLWK26(WORK,IUSEW,LEFTW,WDIST(I),501)
 5020 CONTINUE
      NP13 = NP13 + 7
C
C--------------------------------------------------
C  STORE DAILY MINIMUM FLOW
C
 5025 CALL FLWK26(WORK,IUSEW,LEFTW,DMINQ,501)
      NP13 = NP13 + 1
C----------------------------------------------------
C  STORE WEEKLY MINIMUM FLOW
C
      CALL FLWK26(WORK,IUSEW,LEFTW,WMINQ,501)
      NP13 = NP13 + 1
C--------------------------------------------
C  STORE INSTANTANEOUS MINIMUM FLOW
C
      OPT=INOPT + .01
      IF(INOPT.EQ.0)GO TO 5030
      IF(INOPT.EQ.1)GO TO 5035
      GO TO 5040
C
C  OPTION IS '0'. 'MINQINST' IS NOT USED. STORE OPTION IN WORK ARRAY.
C
 5030 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,OPT,501)
      NP13 = NP13 + 1
      GO TO 5050
C
C  OPTION IS '1'. STORE OPTION AND A CONSTANT SINGLE VALUE
C  FOR 'MINQINST'.
C
 5035 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,OPT,501)
      NP13 = NP13 + 1
      CALL FLWK26(WORK,IUSEW,LEFTW,HQM,501)
      NP13 = NP13 + 1
      GO TO 5050
C
C  OPTION IS FOR A SET OF DATES VS. MIN FLOW VALUES.
C  STORE NUMBER OF PAIRS OF VALUES , FOLLOWED BY THE VALUES.
C
 5040 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,OPT,501)
      NP13 = NP13 + 1
      NVAL=2 * INOPT
      DO 5045 I=1,NVAL
      CALL FLWK26(WORK,IUSEW,LEFTW,HQMIN(I),501)
 5045 CONTINUE
      NP13 = NP13 + NVAL
C
 5050 CONTINUE
C-------------------------------------------------------------
C  STORE LIMITING UPPER ELEVATION
C
      IF(NHUPP.GT.1)GO TO 5060
C
C  'HUPPER' IS EITHER A CONSTANT REAL NUMBER OR -999.0 TO
C   SIGNAL RULECURVE USAGE. STORE A '1' AND THEN THE VALUE.
C
      HNUM=NHUPP +.01
      CALL FLWK26(WORK,IUSEW,LEFTW,HNUM,501)
      NP13 = NP13 + 1
      CALL FLWK26(WORK,IUSEW,LEFTW,HUPPER,501)
      NP13 = NP13 + 1
      GO TO 5070
C
C  'HUPPER' IS A CURVE OF DATE VS. ELEVATION VALUES. STORE FIRST
C   THE NUMBER OF PAIRS OF VALUES IN THE CURVE AND THEN THE DATES
C   FOLLOWED BY THE ELEVATIONS.
C
 5060 CONTINUE
C
      PAIR=NHUPP/2 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
      NP13 = NP13 + 1
      DO 5065 I=1,NHUPP
      CALL FLWK26(WORK,IUSEW,LEFTW,HUPP(I),501)
 5065 CONTINUE
      NP13 = NP13 + NHUPP
C
 5070 CONTINUE
C-------------------------------------------------------
C  STORE LIMITING LOWER ELEVATION
C
      IF(NHLOW.GT.1) GO TO 5080
C
C  'HLOWER' IS EITHER A CONSTANT REAL VALUE OR -999.0 TO
C   SIGNAL RULECURVE USAGE. STORE A '1' AND THEN THE VALUE.
C
      HNUM= NHLOW + .01
      CALL FLWK26(WORK,IUSEW,LEFTW,HNUM,501)
      NP13 = NP13 + 1
      CALL FLWK26(WORK,IUSEW,LEFTW,HLOWER,501)
      NP13 = NP13 + 1
      GO TO 5090
C
C  'HLOWER' IS A CURVE OF DATE VS. ELEVATION VALUES. STORE FIRST
C   THE NUMBER OF PAIRS OF VALUES AND THEN THE DATES FOLLOWED BY
C   THE ELEVATIONS.
C
 5080 PAIR=NHLOW/2 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
      NP13 = NP13 + 1
      DO 5085 I=1,NHLOW
      CALL FLWK26(WORK,IUSEW,LEFTW,HLOW(I),501)
 5085 CONTINUE
      NP13 = NP13 + NHLOW
C
 5090 CONTINUE
C-----------------------------------------------------------------
C  STORE DOWNSTREAM DAM LIMITING DISCHARGE.
C  IF NOT USED , STORE AS -999.0.
C
      CALL FLWK26(WORK,IUSEW,LEFTW,DSMAX,501)
      NP13 = NP13 + 1
C
C------------------------------------------------------------------
C  STORE MAXIMUM CONSTANT DISCHARGE
C
      CALL FLWK26(WORK,IUSEW,LEFTW,QGEN,501)
      NP13 = NP13 + 1
C
C------------------------------------------------------------------
C  STORE THE INFORMATION PERTAINING TO THE ELVSMAXQ, HEADVSQ, TWCURVE,
C  AND CONV PARAMETERS AS REQUIRED.
C
      IF(IP(12).EQ.0 .AND. IP(13).EQ.0)GO TO 5350
      IF(IP(12).EQ.0)GO TO 5200
C
C  ELEVATION VS. MAXIMUM DISCHARGE CURVE IS USED. STORE A '-1'
C  FOR THE OPTION. FOLLOW WITH THE NUMBER OF PAIRS OF VALUES IN
C  THE CURVE AND THEN THE ELEVATION AND DISCHARGE VALUES.
C
      OPT= -1.01
      CALL FLWK26(WORK,IUSEW,LEFTW,OPT,501)
      NP13 = NP13 + 1
C
      PAIR=NQVAL/2 + .01
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
      NP13 = NP13 + 1
      DO 5100 I=1,NQVAL
      CALL FLWK26(WORK,IUSEW,LEFTW,QVAL(I),501)
 5100 CONTINUE
      NP13 = NP13 + NQVAL
      GO TO 5400
C
C  HEAD VS. DISCHARGE CURVE IS USED. STORE A '1' FOR THIS
C  OPTION. FOLLOW WITH INFORMATION FOR 'HEADVSQ'.
C
 5200 CONTINUE
      OPT=1 + .01
      CALL FLWK26(WORK,IUSEW,LEFTW,OPT,501)
      NP13 = NP13 + 1
C
C  IF THE CURVE WAS REFERENCED TO ANOTHER S/U, JUST STORE THAT REFERENCE
C  LOCATION.
C
      IF (IHTYPE.GT.1) GO TO 5230
C
C  STORE DEFINITION OF THE HEAD VS. Q CURVE
C
      PAIR = NHVAL/2 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
C
C  STORE LOCATION FOR THIS CURVE DEFINITION
C
      IPOWD(NMDEF(3),3) = NPMENT + NP13 + 1
      IWKWD(NMDEF(3),3) = IUSEW
C
C  STORE CURVE
C
      DO 5220 I=1,NHVAL
      CALL FLWK26(WORK,IUSEW,LEFTW,HVAL(I),501)
 5220 CONTINUE
      NP13 = NP13 + NHVAL + 1
      GO TO 5300
C
C  STORE REFERENCE TO CURVE IN WORK ARRAY
C
 5230 CONTINUE
      CDHLOC = - (LOCCDH+0.01)
      CALL FLWK26(WORK,IUSEW,LEFTW,CDHLOC,501)
      NP13 = NP13 + 1
      GO TO 5300
C
C------------------------------------------------------------
C  STORE TAILWATER RATING CURVE NAME.
C
 5300 CONTINUE
C
      CALL FLWK26(WORK,IUSEW,LEFTW,RCID26(1,1),501)
      CALL FLWK26(WORK,IUSEW,LEFTW,RCID26(2,1),501)
      NP13 = NP13 + 2
C---------------------------------------
C  STORE CONVERGENCE CRITERION
C
      CALL FLWK26(WORK,IUSEW,LEFTW,CONVG,501)
      NP13 = NP13 + 1
      GO TO 5400
C---------------------------------------------------
C  STORE INDICATION THAT NO CURVES FOR ELEVATION VS. MAXIMUM Q WERE
C  ENTERED
C
 5350 CONTINUE
      CALL FLWK26(WORK,IUSEW,LEFTW,0.01,501)
      NP13 = NP13 + 1
C--------------------------------
C  IF RULE CURVE WAS DEFINED IN THIS ROUTINE, STORE THE ENTIRE CURVE,
C  OTHERWISE JUST STORE THE NEGATIVE LOCATION IN THE WORK ARRAY
C
 5400 CONTINUE
      IF (IP(16).GE.1) GO TO 5445
C
C  STORE ZERO TO INDICATE NO RULE CURVE USED.
C
      CALL FLWK26(WORK,IUSEW,LEFTW,0.01,501)
      NP13 = NP13 + 1
      GO TO 9999
C
 5445 CONTINUE
      IF (ICTYPE.GT.1) GO TO 5460
C
C  CURVE WAS DEFINED IN THIS SCHEME
C
      PAIR = NRVAL/2 + 0.01
      CALL FLWK26(WORK,IUSEW,LEFTW,PAIR,501)
C
C  STORE LOCATION FOR THIS RULE CURVE DEFINITION
C
      IPOWD(NMDEF(1),1) = NPMENT + NP13 + 1
      IWKWD(NMDEF(1),1) = IUSEW
C
C  STORE CURVE DEFINITION
C
      DO 5450 I=1,NRVAL
      CALL FLWK26(WORK,IUSEW,LEFTW,RVAL(I),501)
 5450 CONTINUE
C
C  STORE RULETIME HERE
C
      CALL FLWK26(WORK,IUSEW,LEFTW,RTIME,501)
      NP13 = NP13 + 1
      GO TO 5470
C
C  STORE REFERENCE TO PREVIOUS DEFINITION IN WORK
C
 5460 CONTINUE
      CDELOC = - (LOCCDE+0.01)
      NRVAL = 0
      CALL FLWK26(WORK,IUSEW,LEFTW,CDELOC,501)
C
 5470 CONTINUE
      NP13 = NP13 + NRVAL + 1
      GO TO 9999
C------------------------------------
C  ERROR IN UFLD26
C
 9000 CONTINUE
      IF (IERF.EQ.1) CALL STER26(19,1)
      IF (IERF.EQ.2) CALL STER26(20,1)
      IF (IERF.EQ.3) CALL STER26(21,1)
      IF (IERF.EQ.4) CALL STER26( 1,1)
C
      IF (NCARD.GE.LASTCD) GO TO 9100
      IF (IBLOCK.EQ.1)  GO TO 5
      IF (IBLOCK.EQ.2)  GO TO 10
C
 9100 USEDUP = .TRUE.
C
 9999 CONTINUE
      RETURN
      END
