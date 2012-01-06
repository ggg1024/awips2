C   MEMBER MPFORM
C ----------------------------------------------------------------------
C
C                             LAST UPDATE: 01/19/95.09:14:54 BY $WC20SV
C
C @PROCESS LVL(77)
C
      SUBROUTINE MPFORM
C
C
C  THIS ROUTINE PRINTS DATA
C
C  THE DATA ARRAY IS DIMENSIONED AT 744 AND CAN CONTAIN ONE MONTH OF
C  HOURLY DATA.
C
C  LEGITIMATE TIME INTERVALS OF THE DATA IN HOURS ARE -
C             1,2,3,4,6,8,12,24
C
C  DATA IS PRINTED IN A FIELD OF  8  USING A FORMAT OF  F8.X  WHERE X
C  IS THE SPECIFIED NUMBER OF DECIMAL PLACES
C  DATA CAN BE PRINTED USING  4  DECIMAL FORMATS -
C             0,1,2,3
C
C  A MAXIMUM OF 3 DECIMAL PLACES CAN BE PRINTED
C
      DIMENSION    NDAYS(12)
      INTEGER      DEBUG,DEBUGA
      INTEGER      DAY,EVENTS
C
      INCLUDE 'common/ionum'
      COMMON /MAP/ DEBUG,DEBUGA
      COMMON  /LSDTA/ IDEC,IMO,IYR,LMO,LYR,UNITW,FNAME(3),DTYPE,IT,
     *                STAID(3),DESCRP(5),DESCR(5),JMO,JYR,DATA(744)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/calb/src/map/RCS/mpform.f,v $
     . $',                                                             '
     .$Id: mpform.f,v 1.1 1997/01/27 15:33:24 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA  NDAYS /31,28,31,30,31,30,31,31,30,31,30,31/
C
C
      IF (DEBUG.EQ.1) WRITE (IPR,120)
C
      IUSTOP=0
C
C
C  CHECK FOR LEGITIMATE DECIMAL FORMAT
      IF (IDEC.LE.3.AND.IDEC.GE.0) GO TO 10
      WRITE (IPR,130) IDEC
      CALL USTOP (IPR,IUSTOP)
C
10    DAY=1
C
C  CALCULATE NUMBER OF DATA VALUES FOR MONTH
C  CHECK AND ACCOUNT FOR LEAP YEAR
      IF (JMO.NE.2) GO TO 20
      KYR=JYR/4*4
      IF (JYR.EQ.KYR) NDAYS(2)=29
20    EVENTS=NDAYS(JMO)*24/IT
      NDAYS(2)=28
      IF (DEBUG.EQ.1) WRITE (IPR,270)  JMO,IT,EVENTS
C
C  CHECK FOR LEGITIMATE DATA TIME INTERVAL
      IF (IT.GT.24) GO TO 30
      IF ((24/IT*IT).EQ.24) GO TO 40
30    WRITE (IPR,140) IT
      CALL USTOP (IPR,IUSTOP)
C
C  CHOOSE DESIRED TIME INTERVAL FORMAT
40    IF (IT.EQ.1) GO TO 50
      IF (IT.EQ.3) GO TO 70
      IF (IT.EQ.6) GO TO 90
C
C  1-HOUR INTERVAL - 744 VALUES MAXIMUM PER MONTH
50    CONTINUE
      DO  60 I=1,EVENTS,24
      NUM=24
      IF ((I+NUM).GT.EVENTS) NUM=EVENTS-I+1
      IF (IDEC.EQ.0)   WRITE (IPR,150) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.1)   WRITE (IPR,160) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.2)   WRITE (IPR,170) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.3)   WRITE (IPR,180) DAY,(DATA(I+J-1),J=1,NUM)
60    DAY=DAY+1
      GO TO 110
C
C  3-HOUR INTERVAL - 248 VALUES MAXIMUM PER MONTH
70    CONTINUE
      DO 80  I=1,EVENTS,24
      NUM=24
      IF ((I+NUM).GT.EVENTS) NUM=EVENTS-I+1
      IF (IDEC.EQ.0)   WRITE (IPR,190) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.1)   WRITE (IPR,200) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.2)   WRITE (IPR,210) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.3)   WRITE (IPR,220) DAY,(DATA(I+J-1),J=1,NUM)
80    DAY=DAY+3
      GO TO 110
C
C  6-HOUR INTERVAL - 124 VALUES MAXIMUM PER MONTH
90    CONTINUE
      DO 100  I=1,EVENTS,12
      NUM=12
      IF ((I+NUM).GT.EVENTS) NUM=EVENTS-I+1
      IF (IDEC.EQ.0)   WRITE (IPR,230) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.1)   WRITE (IPR,240) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.2)   WRITE (IPR,250) DAY,(DATA(I+J-1),J=1,NUM)
      IF (IDEC.EQ.3)   WRITE (IPR,260) DAY,(DATA(I+J-1),J=1,NUM)
100   DAY=DAY+3
      GO TO 110
C
C
110   RETURN
C
120   FORMAT (' *** ENTER MPFORM')
130   FORMAT ('0*** ERROR - INVALID NUMBER OF DECIMAL PLACES ',
     *   'REQUESTED : ',I2,'.')
140   FORMAT ('0*** ERROR - INVALID TIME INTERVAL : ',I2,'.')
150   FORMAT (10X,I2,2X,12(F8.0,1X)/  14X,12(F8.0,1X),1H/)
160   FORMAT (10X,I2,2X,12(F8.1,1X)/  14X,12(F8.1,1X),1H/)
170   FORMAT (10X,I2,2X,12(F8.2,1X)/  14X,12(F8.2,1X),1H/)
180   FORMAT (10X,I2,2X,12(F8.3,1X)/  14X,12(F8.3,1X),1H/)
190   FORMAT (10X,I2,2X,4(F8.0,1X),1H ,4(F8.0,1X),1H/,4(F8.0,1X)/
     *       14X,4(F8.0,1X),1H/,4(F8.0,1X),1H ,4(F8.0,1X),1H/)
200   FORMAT (10X,I2,2X,4(F8.1,1X),1H ,4(F8.1,1X),1H/,4(F8.1,1X)/
     *       14X,4(F8.1,1X),1H/,4(F8.1,1X),1H ,4(F8.1,1X),1H/)
210   FORMAT (10X,I2,2X,4(F8.2,1X),1H ,4(F8.2,1X),1H/,4(F8.2,1X)/
     *       14X,4(F8.2,1X),1H/,4(F8.2,1X),1H ,4(F8.2,1X),1H/)
220   FORMAT (10X,I2,2X,4(F8.3,1X),1H ,4(F8.3,1X),1H/,4(F8.3,1X)/
     *       14X,4(F8.3,1X),1H/,4(F8.3,1X),1H ,4(F8.3,1X),1H/)
230   FORMAT (10X,I2,2X,3(4(F8.0,1X),1H/))
240   FORMAT (10X,I2,2X,3(4(F8.1,1X),1H/))
250   FORMAT (10X,I2,2X,3(4(F8.2,1X),1H/))
260   FORMAT (10X,I2,2X,3(4(F8.3,1X),1H/))
270   FORMAT (1H ,3I6)
C
      END
