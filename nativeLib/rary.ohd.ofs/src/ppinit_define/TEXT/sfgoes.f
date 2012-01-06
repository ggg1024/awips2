C MEMBER SFGOES
C-----------------------------------------------------------------------
C
C                             LAST UPDATE: 03/04/94.08:59:32 BY $WC20SV
C
C @PROCESS LVL(77)
C
C DESC PROCESS GOES SOURCE INFORMATION USED TO CREATE STATION IN
C DESC CONTROL FILE.
C
      SUBROUTINE SFGOES (STAID,NGPS,GPS,NSRCEN,SRCEN,
     *   ITPPVR,ITTAVR,IPPROC,ITYOBS,
     *   MDLYTP,DLYTYP,NDLYTP,NUMRRS,RRSTPS,
     *   NUMERR,NUMWRN,ISTAT)
C
C
      REAL PCPN/4HPCPN/,TEMP/4HTEMP/,PE/4HPE  /,RRS/4HRRS /
      REAL PP24/4HPP24/,PP06/4HPP06/,PP03/4HPP03/,PP01/4HPP01/
      REAL TM24/4HTM24/,TA06/4HTA06/,TA03/4HTA03/,TA01/4HTA01/
      REAL EA24/4HEA24/
C
      DIMENSION STAID(2),GPS(1),SRCEN(1),DLYTYP(1),RRSTPS(1)
C
      INCLUDE 'uio'
      INCLUDE 'scommon/sudbgx'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/ppinit_define/RCS/sfgoes.f,v $
     . $',                                                             '
     .$Id: sfgoes.f,v 1.1 1995/09/17 19:11:03 dws Exp $
     . $' /
C    ===================================================================
C
C
C
      IF (ISTRCE.GT.0) WRITE (IOSDBG,210)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
C  SET DEBUG LEVEL
      LDEBUG=ISBUG('DEFN')
C
      ISTAT=0
C
      IF (LDEBUG.EQ.0) GO TO 10
         WRITE (IOSDBG,220) STAID
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,230) NGPS,(GPS(I),I=1,NGPS)
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,240) ITPPVR,ITTAVR,IPPROC,ITYOBS,NUMRRS
         CALL SULINE (IOSDBG,1)
         WRITE (IOSDBG,250) NSRCEN,(SRCEN(I),I=1,NSRCEN)
         CALL SULINE (IOSDBG,1)
C
C  CHECK IF ANY DATA TYPES NOT TO BE TRANSFERRED
10    NPCPN=0
      NTEMP=0
      NPE=0
      IF (NSRCEN.EQ.0) GO TO 70
         DO 20 I=1,NSRCEN
            IF (SRCEN(I).EQ.PCPN) NPCPN=1
            IF (SRCEN(I).EQ.TEMP) NTEMP=1
            IF (SRCEN(I).EQ.PE) NPE=1
20          CONTINUE
C
C  CHECK IF DATA TYPE NOT TO BE TRANSFERRED BUT NOT DEFINED
      DO 60 I=1,NSRCEN
         DO 30 N=1,NGPS
            IF (SRCEN(I).EQ.GPS(N)) GO TO 60
30          CONTINUE
         IF (NUMRRS.EQ.0) GO TO 50
            DO 40 N=1,NUMRRS
               IF (SRCEN(I).EQ.RRSTPS(N)) GO TO 60
40             CONTINUE
50       WRITE (LP,290) SRCEN(I),STAID
         CALL SUWRNS (LP,2,NUMWRN)
60       CONTINUE
C
C  CHECK WHICH TYPES OF DATA TO BE TRANSFERRED
70    DO 100 I=1,NGPS
         IF (GPS(I).NE.PCPN) GO TO 80
            IF (NPCPN.EQ.1) GO TO 100
               IF (IPPROC.EQ.2) GO TO 100
               NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               DLYTYP(NDLYTP)=PP24
               IF (ITPPVR.EQ.6) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITPPVR.EQ.6) DLYTYP(NDLYTP)=PP06
               IF (ITPPVR.EQ.3) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITPPVR.EQ.3) DLYTYP(NDLYTP)=PP03
               IF (ITPPVR.EQ.1) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITPPVR.EQ.1) DLYTYP(NDLYTP)=PP01
               GO TO 100
80       IF (GPS(I).NE.TEMP) GO TO 90
            IF (NTEMP.EQ.1) GO TO 100
               IF (ITYOBS.EQ.4) GO TO 100
               IF (ITYOBS.NE.2) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITYOBS.NE.2) DLYTYP(NDLYTP)=TM24
               IF (ITTAVR.EQ.6) NDLYTP=NDLYTP+1
               IF (ITTAVR.EQ.6) DLYTYP(NDLYTP)=TA06
               IF (ITTAVR.EQ.3) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITTAVR.EQ.3) DLYTYP(NDLYTP)=TA03
               IF (ITTAVR.EQ.1) NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               IF (ITTAVR.EQ.1) DLYTYP(NDLYTP)=TA01
               GO TO 100
90       IF (GPS(I).NE.PE) GO TO 100
            IF (NPE.EQ.1) GO TO 100
               NDLYTP=NDLYTP+1
               IF (NDLYTP.GT.MDLYTP) GO TO 110
               DLYTYP(NDLYTP)=EA24
100      CONTINUE
      GO TO 120
C
C  MAXIMUM DAILY DATA TYPES EXCEEDED
110   WRITE (LP,300) MDLYTP
      CALL SUERRS (LP,2,NUMERR)
      ISTAT=1
C
120   IF (NUMRRS.EQ.0) GO TO 180
C
C  CHECK IF ANY RRS DATA TYPES NOT TO BE TRANSFERRED
      IF (NSRCEN.EQ.0) GO TO 180
C
C  CHECK WHICH RRS DATA TYPES NOT TO BE TRANSFERRED
      DO 170 I=1,NSRCEN
         IF (SRCEN(I).EQ.PCPN) GO TO 170
         IF (SRCEN(I).EQ.TEMP) GO TO 170
         IF (SRCEN(I).EQ.PE) GO TO 170
         IF (SRCEN(I).NE.RRS) GO TO 130
            NUMRRS=0
            GO TO 170
130         DO 150 N=1,NUMRRS
               IF (SRCEN(I).NE.RRSTPS(N)) GO TO 150
                  IF (NUMRRS.EQ.0) GO TO 170
                  IF (N.EQ.NUMRRS) GO TO 160
                     NUM=NUMRRS-1
                     DO 140 J=N,NUM
                        RRSTPS(J)=RRSTPS(J+1)
140                     CONTINUE
                     GO TO 160
150            CONTINUE
               WRITE (LP,260) SRCEN(I)
               CALL SUWRNS (LP,2,NUMWRN)
               GO TO 170
160         NUMRRS=NUMRRS-1
170      CONTINUE
C
180   IF (LDEBUG.EQ.0) GO TO 190
         WRITE (IOSDBG,270) NDLYTP,(DLYTYP(I),I=1,NDLYTP)
         CALL SULINE (LP,1)
         WRITE (IOSDBG,280) NUMRRS,(RRSTPS(I),I=1,NUMRRS)
         CALL SULINE (LP,1)
C
C  CHECK IF ANY DAILY OR RRS TYPES TO BE DEFINED
190   IF (NDLYTP.GT.0.OR.NUMRRS.GT.0) GO TO 200
         WRITE (LP,310)
         CALL SUERRS (LP,2,NUMERR)
         ISTAT=1
         NSRCEN=0
C
200   IF (ISTRCE.GT.0) WRITE (IOSDBG,320)
      IF (ISTRCE.GT.0) CALL SULINE (IOSDBG,1)
C
      RETURN
C
C- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
C
210   FORMAT (' *** ENTER SFGOES')
220   FORMAT (' STAID=',2A4)
230   FORMAT (' NGPS=',I2,3X,'GPS(I)=',10(A4,1X))
240   FORMAT (' ITPPVR=',I2,3X,'ITTAVR=',I2,3X,'IPPROC=',I2,3X,
     *   'ITYOBS=',I2,3X,'NUMRRS=',I2)
250   FORMAT (' NSRCEN=',I2,3X,'SRCEN(I)=',10(A4,1X))
260   FORMAT ('0*** WARNING - GOES DATA TYPE SPECIFIED NOT TO BE ',
     *   'TRANSFERRED (',A4,') IS NOT DEFINED AS AN RRS TYPE.')
270   FORMAT (' NDLYTP=',I2,3X,'DLYTYP=',10(A4,1X))
280   FORMAT (' NUMRRS=',I2,3X,'RRSTPS=',10(A4,1X))
290   FORMAT ('0*** WARNING - DATA GROUP OR RRS TYPE ',A4,
     *   ' SPECIFIED NOT TO BE TRANSFERRED FROM GOES IS NOT ',
     *   'DEFINED FOR STATION ',2A4,'.')
300   FORMAT ('0*** ERROR - IN SFGOES - MAXIMUM NUMBER OF DAILY DATA ',
     *   'TYPES (',I2,') EXCEEDED.')
310   FORMAT ('0*** ERROR - IN SFGOES - NO DAILY OR RRS DATA TYPES ',
     *   'TO BE CREATED IN GOES CONTROL FILE.')
320   FORMAT (' *** EXIT SFGOES')
C
      END
