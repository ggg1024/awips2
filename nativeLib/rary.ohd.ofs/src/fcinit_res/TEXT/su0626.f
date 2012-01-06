C MEMBER SU0626
C  (from old member FCSU0626)
C
      SUBROUTINE SU0626(WORK,IUSEW,LEFTW,IERR)
C
C---------------------------------------------------------------------
C  SUBROUTINE TO GET PARAMETERS, TIME-SERIES, AND CARRYOVER VALUES
C  FOR SCHEME/UTILITY #06 - SPILLWAY ROUTING SCHEME
C---------------------------------------------------------------------
C  ARGS:
C     WORK - ARRAY TO HOLD INFORMATION
C    IUSEW - NUMBER OF WORDS ALREADY USED IN WORK ARRAY
C    LEFTW - NUMBER OF WORDS LEFT IN WORK ARRAY
C-------------------------------------------------------------------
C  JTOSTROWSKI - HRL - MARCH 1983
C----------------------------------------------------------------
C
      INCLUDE 'common/err26'
C
C
      INCLUDE 'common/fld26'
C
C
      INCLUDE 'common/read26'
C
C
      INCLUDE 'common/suid26'
C
C
      INCLUDE 'common/suin26'
C
C
      INCLUDE 'common/suky26'
C
C
      INCLUDE 'common/warn26'
C
C
C
      DIMENSION ENDSU(3),ISU(3)
      DIMENSION WORK(1)
C
      LOGICAL ENDFND,INPTOK
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_res/RCS/su0626.f,v $
     . $',                                                             '
     .$Id: su0626.f,v 1.1 1995/09/17 18:52:53 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA ENDSU/4HENDS,4HPWY ,4H    /
      DATA BLANK/4H    /
      DATA CODESP/1060.01/
C
C
C  INITIALIZE NO. OF WORDS FOR HOLDING PARMS, TIME-SERIES, AND CARRYOVER
C  FOR THIS SCHEME/UTILITY.
C
      NPARXX = 0
      NTSXX = 0
      NTSPXX = 2
      NCOXX = 0
C
      USEDUP = .FALSE.
      ENDFND = .FALSE.
      NPACK = 3
C
      DO 3 I = 1,3
           ISU(I) = 0
    3 CONTINUE
C
C--------------------------------------------------------------------
C  NOW PROCESS INPUT UP TO 'ENDSPWY', LOOKING FOR, IN ORDER, KEYWORDS
C  FOR PARMS, TIME-SERIES, AND CARRYOVER.
C
      IERR = 0
C
C  SU FOUND , LOOKING FOR ENDSU
C
      LPOS = LSPEC + NCARD + 1
      LASTCD = NSPEC -2
      IBLOCK = 1
C
    5 IF (NCARD .LT. LASTCD) GO TO 6
           CALL STRN26(59,1,ENDSU,3)
           IERR = 1
           GO TO 9
    6 NUMFLD = 0
      CALL UFLD26(NUMFLD,IERF)
      IF(IERF .GT. 0 ) GO TO 9000
      ISAME = IUSAME(CHAR,ENDSU,2)
      IF(ISAME .EQ. 1) GO TO  9
C
C  INSTEAD OF ENDSU, WE FIND OTHER SU W/O ().
C
      IF (LLPAR .GT. 0 .AND. LRPAR .GT. 0) GO TO 7
           NUMWD = (LEN -1)/4 + 1
           IDEST = IKEY26(CHAR,NUMWD,SUID,LSUID,NSUID,NDSUID)
           IF (IDEST .EQ. 0) GO TO 5
                CALL STRN26(59,1,ENDSU,3)
                IERR = 99
                GO TO 9
C
C  INSTEAD OF ENDSU, WE FIND OTHER SU WITH ().
C
    7 CALL IDWP26(TNAME,NPACK,JNAME,INTVAL,IERID)
      IF (JNAME .EQ. 0) GO TO 5
           CALL STRN26(59,1,ENDSU,3)
           IERR = 99
C
    9 LENDSU = NCARD
C
C  ENDSU CARD OR OTHER SU FOUND AT LENDSU,
C  ALSO ERR RECOVRY IF THERE'S NO ENDSU FOUND.
C
C  NOW WE'RE LOOKING FOR PARMS, TIME-SERIES AND CARRYOVER.
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
      IDEST = IKEY26(CHAR,NUMWD,SUKYWD,LSUKEY,NSUKEY,NDSUKY)
      IF(IDEST .GT. 0) GO TO 50
      IF(NCARD .GE. LENDSU) GO TO 900
C
C  BAD BLOCK STRUCTURE, DESIRED BLOCK WILL BE DETERMINED SOON.
C
          CALL STER26(82,1)
          GO TO 10
C
C  NOW SEND TO CONTROL TO LOCATION TO PROCESS PROPER KEYWORD
C
   50 CONTINUE
      IF (IDEST .LT. 7) GO TO 60
C
C  BAD BLOCK STRUCTURE FOR PM,TS OR CO.
C
           IDST = (IDEST-7)/2
           ISUKY = 2 * IDST + 1
           CALL STRN26(94,1,SUKYWD(1,ISUKY),3)
           GO TO 10
   60 GO TO (100,100,200,200,300,300) , IDEST
C
C--------------------------------------------------------------------
C  PARMS EXPECTED, IF NOT FOUND SIGNAL ERROR. IF FOUND, GO GET PARMS
C   NEEDED FOR OPERATION.
C
  100 CONTINUE
      ISU(1) = ISU(1) + 1
      IF (ISU(1).GT.1) CALL STER26(39,1)
C
      PMLOC = IUSEW + 1
      CALL RFIL26(WORK,LOCPXX,PMLOC)
C
C
      CALL PM0626(WORK,IUSEW,LEFTW,NPARXX,CODESP,INPTOK,
     .            LENDSU,JDEST,IERPM)
C
C
C  WE'RE AT LENDSU WHEN IERPM IS 99
C
      IF (IERPM.EQ.99) GO TO 900
C
      IF (IERPM.NE.89) GO TO 10
C
C  BAD BLOCK STRUCTURE OF PM WHEN IERPM IS 89 WHERE TS OR CO FOUND.
C
      IDEST = JDEST
      GO TO 50
C
C-----------------------------------------------------------------------
C  TIME-SERIES INFORMATION EXPECTED NEXT. IF NOT FOUND, STORE ALL BLANK
C  ID'S FOR BOTH OPTIONAL TIME SERIES.
C  IF FOUND, CALL ROUTINE TO INPUT ALL REQUIRED AND OPTIONAL TIME-SERIES
C
  200 CONTINUE
      ISU(2) = ISU(2) + 1
      IF (ISU(2).GT.1) CALL STER26(39,1)
C
      TSLOC = IUSEW + 1
      CALL RFIL26(WORK,LOCTXX,TSLOC)
C
C
      CALL TS0626(WORK,IUSEW,LEFTW,NTSXX,
     .            LENDSU,JDEST,IERTS)
C
C  WE'RE AT LENDSU WHEN IERTS IS 99
C
      IF (IERTS.EQ.99) GO TO 900
C
      IF (IERTS.NE.89) GO TO 10
C
C  BAD BLOCK STRUCTURE OF TS WHEN IERTS IS 89 WHERE PM OR CO FOUND.
C
      IDEST = JDEST
      GO TO 50
C
C--------------------------------------------------------------
C  CO EXPECTED, IF NOT FOUND THEN SIGNAL ERROR.
C
  300 CONTINUE
      ISU(3) = ISU(3) + 1
      IF (ISU(3).GT.1) CALL STER26(39,1)
C
      COLOC = IUSEW + 1
      CALL RFIL26(WORK,LOCCXX,COLOC)
C
C
      CALL CO0626(WORK,IUSEW,LEFTW,NCOXX)
      GO TO 10
C
C-------------------------------------------------------------------
C  SUMMARY
C  IF TS IS NOT FOUND , STORE ALL BLANK ID'S FOR BOTH OPTIONAL TS.
C
  900 CONTINUE
      IF (ISU(1).EQ.0) CALL STER26(35,1)
      IF (ISU(2).GT.0) GO TO 930
C
C
      TSLOC = IUSEW + 1
      CALL RFIL26(WORK,LOCTXX,TSLOC)
C
      DO 920 I = 1,4
          CALL FLWK26(WORK,IUSEW,LEFTW,BLANK,501)
  920 CONTINUE
      NTSXX = 4
C
  930 IF (ISU(3).EQ.0) CALL STER26(37,1)
      GO TO 9999
C
C--------------------------------------------------------------
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
