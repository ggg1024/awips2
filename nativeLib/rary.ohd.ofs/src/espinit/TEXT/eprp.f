C MEMBER EPRP
C  (from old member EEPRP)
C-----------------------------------------------------------------------
C
C                             LAST UPDATE: 06/08/94.08:27:10 BY $WC20SV
C
C @PROCESS LVL(77)
C
      SUBROUTINE EPRP (PESP,LPESP)
C
C ......................................................................
C
C THIS ROUTINE IS PART OF THE ESP INITILIZATION PROGRAM AND
C   PRINT SEGMENT ROUTINE (EPRPSEG)
C THIS ROUTINE WILL PRINT THE INFORMATION STORED IN THE
C   P ARRAY FOR ESP (PESP).
C
C MODIFIED 5/29/84 : TO ALLOW FOR MULTIVALUED TS
C THE MULTIVALUED TS HAVE A DATA TYPE AND NAME AS SHOWN BELOW
C    DATA TYPE  NAME       NUMBER
C    ---------  --------   -------
C    SMZC       UZTDEF       1
C               UZFWC        2
C               LZTDEF       3
C               LZFSC        4
C               LZFPC        5
C    ROCL       TCHANINF     1
C               IMP-RO       2
C               DIR-RO       3
C               SUR-RO       4
C               INTERFLO     5
C               SUPBASE      6
C               PRIMBASE     7
C THE NUMBER IS CONTAINED AS THE DECIMAL PORTION IN THE PESP
C LOCATION CONTAINING POINTER TO TIME SERIES IN D ARRAY,
C E.G., PESP(18)=100.03  THEN NUMBER=3
C
C ......................................................................
C
C ORIGINALLY WRITTEN BY
C    ED VANBLARGAN - HRL - JUNE, 1981
C
C ......................................................................
C
      DIMENSION PESP(1),KFLAG(4),OBSIM(6),SBNAME(2),OLDOPN(2),
     $ XNAM1(10),XNAM2(14),TSMV(2),TSNAM(2)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/where'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/espinit/RCS/eprp.f,v $
     . $',                                                             '
     .$Id: eprp.f,v 1.1 1995/09/17 18:46:31 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA BLANK,KFLAG/4H    ,4H ABO,4HVE  ,4H BEL,4HOW  /
      DATA NAME,SIM,SBNAME/4HEPRT,4HSIM ,4HEPRP,4H    /
      DATA OBSIM/4HOBSE,4HRVED,4H    ,4HSIMU,4HLATE,4HD   /
      DATA XNAM1/4HUZTD,4HEF  ,4HUZFW,4HC   ,4HLZTD,4HEF  ,4HLZFS,
     $ 4HC   ,4HLZFP,4HC   /,XNAM2/4HTCHA,4HNINF,4HIMP-,4HRO  ,
     $ 4HDIR-,4HRO  ,4HSUR-,4HRO  ,4HINTE,4HRFLO,4HSUPB,4HASE ,
     $ 4HPRIM,4HBASE/, TSMV/4HSMZC,4HROCL/,I1,I2/1,2/
C
C SET ERROR TRACES
C
      IOLDOP=IOPNUM
      IOPNUM=0
      DO 10 I=1,2
      OLDOPN(I)=OPNAME(I)
10    OPNAME(I)=SBNAME(I)
C
C GET TRACE LEVEL AND DEBUG
C
      IF (ITRACE.GE.1) WRITE(IODBUG,50)
50    FORMAT(1H0,12HEPRP ENTERED)
      IBUG=IFBUG(NAME)
C
      WRITE (IPR,60)
60    FORMAT(// 1H0,45HANALYSIS INFORMATION STORED IN THE PESP ARRAY,
     * 38H FOR THIS SEGMENT FOLLOWS AND SHOWS
     * / 1X,45HWHICH OUTPUT VARIABLES ARE ANALYZED FOR WHICH,
     * 36H TIME SERIES USING DESIRED DISPLAYS:)
C
C SET LOCATIONS IN P ARRAY.
C ALSO, CHECK FOR END OF FILE (ITYP=0)
C
      NEX=1
C
100   I=NEX
      ITYP=PESP(I)
      IF (ITYP.LE.0) GO TO 999
C
C
      NEX=PESP(I+1)
      KODE=PESP(I+4)
      VALUE=PESP(I+5)
      KPTR=2*IABS(KODE)-1
C
C PRINT THE OUTPUT VARIABLE.
C
      GO TO (110,120,130,140,150,160,170,180),ITYP
C
      WRITE (IPR,105) ITYP
105   FORMAT(1H0,10X,40H**WARNING** NUMBER FOR OUTPUT VARIABLE =,I4
     * / 2X,38HTHIS NUMBER SHOULD BE BETWEEN 1 AND 8.,
     * ' IMPOSSIBLE GOTO.')
C
110   WRITE (IPR,115)
115   FORMAT(1H0,42HOUTPUT VARIABLE : MAXIMUM MEAN DAILY VALUE,
     * 32H AND NUMBER OF DAYS TO THAT MAX. / 1X,15(1H-))
      GO TO 300
C
120   WRITE (IPR,125)
125   FORMAT(1H0,42HOUTPUT VARIABLE : MINIMUM MEAN DAILY VALUE,
     * 32H AND NUMBER OF DAYS TO THAT MIN. / 1X,15(1H-))
      GO TO 300
C
130   WRITE (IPR,135)
135   FORMAT(1H0,35HOUTPUT VARIABLE : MEAN DAILY VALUE. / 1X,15(1H-))
      GO TO 300
C
C
140   WRITE (IPR,145)
145   FORMAT(1H0,48HOUTPUT VARIABLE : CUMULATIVE VALUE (FLOW VOLUME)
     */ 1X,15(1H-))
      GO TO 300
C
150   WRITE (IPR,155)
155   FORMAT(1H0,45HOUTPUT VARIABLE : MAXIMUM INSTANTANEOUS VALUE,
     * 32H AND NUMBER OF DAYS TO THAT MAX. / 1X,15(1H-))
      GO TO 300
C
160   WRITE (IPR,165)
165   FORMAT(1H0,45HOUTPUT VARIABLE : MINIMUM INSTANTANEOUS VALUE,
     * 32H AND NUMBER OF DAYS TO THAT MIN. / 1X,15(1H-))
      GO TO 300
C
170   WRITE (IPR,175) KFLAG(KPTR),KFLAG(KPTR+1),VALUE
175   FORMAT(1H0,38HOUTPUT VARIABLE : NUMBER OF DAYS UNTIL,
     *17H TIME SERIES GETS,2A4,F10.1 / 1X,15(1H-))
      GO TO 300
C
180   WRITE (IPR,185) KFLAG(KPTR),KFLAG(KPTR+1),VALUE
185   FORMAT(1H0,43HOUTPUT VARIABLE : TOTAL NUMBER OF DAYS THAT,
     *15H TIME SERIES IS,2A4,F10.1 / 1X,15(1H-))
      GO TO 300
C
C WRITE NAME
C
300   WRITE (IPR,310) PESP(I+2),PESP(I+3)
310   FORMAT(// 11X,29HOUTPUT VARIABLE IDENTIFIER : ,2A4)
C
C WRITE DEBUG
C
      IF (IBUG.GE.1) WRITE(IODBUG,320) NEX
320   FORMAT(/ 11X,42HLOCATION IN PESP ARRAY FOR NEXT VARIABLE =,I3)
C
C PRINT HEADING INFORMATION,TS1 AND TS2.
C
      WRITE (IPR,400) (PESP(I+N),N=7,11)
400   FORMAT(/ 11X,22HHEADING INFORMATION : ,5A4)
C
C TIME SERIES DESCRIPTION
C
      DTYPE=PESP(I+14)
      ITA=PESP(I+15)
      IOSINA=0
      IF (PESP(I+16).EQ.SIM) IOSINA=3
      LOCDA=PESP(I+17)
C CHECK FOR MULTIVALUED TS
      MVFLAG=0
      TSNAM(1)=BLANK
      TSNAM(2)=BLANK
      N=(PESP(I+17)-IFIX(PESP(I+17)))*100. *2.-.89
      IF (DTYPE.NE.TSMV(1)) GO TO 410
      MVFLAG=1
      TSNAM(1)=XNAM1(N)
      TSNAM(2)=XNAM1(N+1)
      GO TO 420
410   IF (DTYPE.NE.TSMV(2)) GO TO 420
      MVFLAG=1
      TSNAM(1)=XNAM2(N)
      TSNAM(2)=XNAM2(N+1)
C
420   WRITE(IPR,500)
500   FORMAT(/ 11X,24HTIME SERIES    OBS - SIM,25X,12HDATA    TIME,
     * 8X,9HCARRYOVER
     */ 11X,53H   USED        DESCRIPTOR    TIME SERIES I.D.    TYPE,
     *4X,17HINTERVAL    VALUE)
      IF (MVFLAG.EQ.1) WRITE(IPR,501)
501   FORMAT(1H+,89X,22HNAME OF MULTI VALUE TS)
      WRITE(IPR,502)
502   FORMAT(11X,11(1H-),4X,10(1H-),4X,16(1H-),4X,4(1H-),
     *4X,21H--------    ---------)
      IF (MVFLAG.EQ.1) WRITE(IPR,503)
503   FORMAT(1H+,89X,22(1H-))
      WRITE(IPR,520) I1,(OBSIM(IOSINA+N),N=1,3),PESP(I+12),PESP(I+13),
     * DTYPE,ITA,PESP(I+18),TSNAM
C
      IF (PESP(I+25).EQ.BLANK) GO TO 540
      DTYPE=PESP(I+23)
      ITB=PESP(I+24)
      IOSINB=0
      IF (PESP(I+25).EQ.SIM) IOSINB=3
      LOCDB=PESP(I+26)
C CHECK FOR MULTIVALUED TS
      TSNAM(1)=BLANK
      TSNAM(2)=BLANK
      N=(PESP(I+26)-IFIX(PESP(I+26)))*100. *2.-.89
      IF (DTYPE.NE.TSMV(1)) GO TO 505
      TSNAM(1)=XNAM1(N)
      TSNAM(2)=XNAM1(N+1)
      GO TO 510
505   IF (DTYPE.NE.TSMV(2)) GO TO 510
      TSNAM(1)=XNAM2(N)
      TSNAM(2)=XNAM2(N+1)
510   WRITE(IPR,520) I2,(OBSIM(IOSINB+N),N=1,3),PESP(I+21),PESP(I+22),
     * DTYPE,ITB,PESP(I+27),TSNAM
520   FORMAT(15X,I1,2H.),8X,3A4,4X,2A4,10X,A4,6X,I3,6X,F8.1,3X,2A4)
C
C PRINT NOTE FOR SPECIAL CASE OF CONVERSION TO MEAN DAILY VALUES
C FOR OUPUT VAIABLES 7 & 8.
C
      IF (KODE.LT.0 .AND. ITYP.GE.7) WRITE(IPR,535)
535   FORMAT(/ 11X,33H**NOTE** COMPARISONS WILL BE MADE,
     * 25H USING MEAN DAILY VALUES.)
C
540   IF (IBUG.GE.1) WRITE(IODBUG,550) LOCDA,LOCDB,PESP(I+30)
550   FORMAT(/ 11X,I6,30H = LOCATION OF TS 1 IN D ARRAY
     * / 11X,I6,30H = LOCATION OF TS 2 IN D ARRAY
     * / 11X,47HSTANDARD METRIC UNITS FOR ACCUMULATED VALUES : ,A4)
C
C DISPLAY TYPE DESCRIPTION. CALL APPROPRIATE ROUTINE TO PRINT DISPLAY
C CONTINUE LOOPING THRU DISPLAY TYPES UNTIL CURRENT LOCATION (LP) IS
C EQUAL TO NEX (LOCATION OF NEXT OUTPUT VARIABLE).
C
      LP=I+35
C
      IF (NEX.GT.LP) WRITE(IPR,560)
560   FORMAT(/ 11X,49HDISPLAY INFORMATION FOLLOWS SHOWING DISPLAY TYPES,
     * 25H DESIRED AND ANY OPTIONS:)
C
600   IF (NEX.LE.LP) GO TO 900
      NDSP=PESP(LP)
C
      GO TO (601,602),NDSP
C
601   CALL EPRD01(PESP(LP),LPESP)
      GO TO 850
C
602   CALL EPRD02(PESP(LP),LPESP)
C
850   NUSE=PESP(LP+1)
      LP=LP+NUSE
      GO TO 600
C
C CHECK FOR END...NEX GT LPESP
C OTHERWISE LOOP BACK AND READ NEXT VARIABLE.
C
900   IF (NEX.LE.LPESP) GO TO 100
C
999   WRITE (IPR,1000)
1000  FORMAT(/ 1H0,37H** END OF THIS SEGMENT DESCRIPTION **)
C
C
C RESET ERROR TRACES IN CB/WHERE/
C
      IOPNUM=IOLDOP
      OPNAME(1)=OLDOPN(1)
      OPNAME(2)=OLDOPN(2)
C
      RETURN
      END
