C MEMBER WPLT21
C  (from old member FCWPLT21)
C DESC -- THIS SUBROUTINE DETERMINES WHICH HYDROGRAPHS ARE TO BE PLOTTED
C
C                             LAST UPDATE: 09/27/94.12:41:47 BY $WC30JL
C
C @PROCESS LVL(77)
C
      SUBROUTINE WPLT21(TII,QTC,LOQTC,FS,FFS,STC,LOSTC,STT,LOSTT,NRT1,
     1 STTNAM,NT,FHT,STM,T1,KHR,KDA,KMO,KYR,ISTRT,INOW,ST0,QT0,YDI,QDI,
     2 NB,ZONE,KU,GZ)
C
C           THIS SUBROUTINE WAS WRITTEN ORIGINALLY BY:
C           DR. DANNY FREAD   HRL   APRIL 1978
C
C           THIS SUBROUTINE WAS MODIFIED TO MEET VER. NO. 5 STANDARDS
C           OF THE NWSRFS BY:
C           JANICE LEWIS      HRL   NOVEMBER,1982     VERSION NO. 1
C
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
      COMMON/IONUM/IN,IPR,IPU
      COMMON/M121/N,NU,NS1,JN,JJ,KIT,G,DT,TT,TIMF,F1,GZN,NYQD
      COMMON/M621/KTIME,DHF,J1,KX
      COMMON/M3221/KTERM,KPL,KPL2,JNK,TE,TM,KITPR
      COMMON/KTT21/IPLT,TMPR
C
      DIMENSION TII(*),QTC(*),LOQTC(*),FS(*),FFS(*),NT(*),NB(*),KU(*)
      DIMENSION FHT(*),STC(*),LOSTC(*),STT(*),LOSTT(*),NRT1(*),QDI(*)
      DIMENSION STTNAM(3,*),SNAME(2),T1(*),STM(*),ST0(*),QT0(*),YDI(*)
      DIMENSION GZ(*)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_dwoper/RCS/wplt21.f,v $
     . $',                                                             '
     .$Id: wplt21.f,v 1.3 1997/04/04 15:46:43 page Exp $
     . $' /
C    ===================================================================
C
C
      DATA SNAME/4HWPLT,4H21  /
C
C
      CALL FPRBUG(SNAME,1,21,IBUG)
C
      KTIMI=KTIME
      TMPRI=TMPR
      KKPP = 0
      IF (KPL2.EQ.0) KKPP = 1
      KKP = 1
      DO 1880 J=1,JN
      LKJ=LCAT21(1,J,NRT1)-1
      IJ=LCAT21(1,J,NB)-1
      J1 = J
      NRT=NRT1(J)
      IF(KPL) 1870,1870,1750
 1750 IF(KPL-2) 1760,1810,1760
 1760 IF(NRT) 1810,1810,1770
 1770 DO 1800 K=1,NRT
      NTT=NT(K+LKJ)
      GZERO=GZ(LKJ+K)
C     WRITE(6,888) J1,LKJ,K,GZERO
C 888 FORMAT(2X,'***** J=',I1,'  LKJ=',I2,'  K=',I2,'  GZERO=',F10.2)
cew force first values to be the same for plotting
      FFS(1)=ST0(K+LKJ)
      FS(1)=ST0(K+LKJ)
      IF(KPL.EQ.1) GO TO 1775
      FFS(1)=FFS(1)-GZERO
      FS(1)=FS(1)-GZERO
 1775 LOSC=LOSTC(K+LKJ)-1
      LOST=LOSTT(K+LKJ)-1
C     WRITE(6,999) KTIME,K,LKJ,LOSC,LOST,ST0(K+LKJ),FS(1),FFS(1)
C 999 FORMAT(3X,'KTIME  K LKJ   LOSC   LOST       ST0        FS       FF
C    1S='/1X,I5,1X,I3,I4,2I7,3F10.2,5X,'***BEFORE ARRAY FILLED')
C     IFFS=KTIME*DHF/TMPR + 0.5
C     IFS=KTIME
C     WRITE(6,9992) (STC(IX+LOSC),IX=1,IFS)
C9992 FORMAT(1X,'STC=',10F10.2)
C     WRITE(6,9994) (STT(IX+LOST),IX=1,IFFS)
C9994 FORMAT(1X,'STT=',10F10.2)
      IF (KKPP.NE.1) KKP = 0
      KX = K
      KI=0
      NKI=1
      LKI=TMPR/DHF+0.0001
      IF(IPLT.EQ.0) KKP=2
      IF(KKP.NE.2) GO TO 1774
      IT1=1
      DO 1772 KP=1,NU
      FFS(KP+1)=STT(KP+LOST)
      FS(KP+1)=TERP21(T1(KP),KTIME,IT1,IT2,TII,STC,LOSC)
      IF(KPL.EQ.1) GO TO 1772
      IK=IFMSNG(FFS(KP+1))
      IF(IK.NE.1) FFS(KP+1)=FFS(KP+1)-GZERO
      FS(KP+1)=FS(KP+1)-GZERO
 1772 CONTINUE
      TMPR=DHF
      KTIME=NU
      GO TO 1782
 1774 DO 1780 KP=1,KTIME
      IF(KKP.EQ.1) GO TO 1778
      IF(TMPR.GE.DHF) GO TO 1776
      IF(KP.NE.NKI) GO TO 1778
      KI=KI+1
      NKI=KI*DHF/TMPR+1.001
      FFS(KI+1)=STT(KI+LOST)
      IK=IFMSNG(FFS(KI+1))
      IF(KPL.EQ.3.AND.IK.NE.1) FFS(KI+1)=FFS(KI+1)-GZERO
      GO TO 1778
 1776 DO 1777 KPI=1,LKI
      KI=KI+1
      FFS(KI+1)=STT(KI+LOST)
      IK=IFMSNG(FFS(KI+1))
      IF(KPL.EQ.3.AND.IK.NE.1) FFS(KI+1)=FFS(KI+1)-GZERO
 1777 CONTINUE
 1778 FS(KP+1)=STC(KP+LOSC)
      IF(KPL.EQ.3) FS(KP+1)=FS(KP+1)-GZERO
 1780 CONTINUE
C     IFS=KP+1
C     IFFS=KI+1
C     WRITE(6,9991) (FS(IX), IX=1,IFS)
C9991 FORMAT(2X,'FS=',10F10.2)
C     WRITE(6,9993) (FFS(IX), IX=1,IFFS)
C9993 FORMAT(2X,'FFS=',10F10.2)
 1782 WRITE(IPR,2140)J,NTT,(STTNAM(KK,K+LKJ),KK=1,2),FHT(K+LKJ),ZONE
      WRITE(IPR,1790)
 1790 FORMAT (10X,30H*----COMPUTED    +----OBSERVED,15X,
     2  24H              STAGE (FT))
C     WRITE(6,998) FS(1),FFS(1)
C 998 FORMAT('  AFTER ARRAY FILLED    FS(1)=',F10.2,'  FFS(1)=',F10.2)
      CALL PLOT21(TII,QTC,LOQTC,STC,LOSTC,FS,FFS,KPL,KKP,FHT(K+LKJ),NRT1
     1,T1,KTIMI,KHR,KDA,KMO,KYR,ISTRT,INOW,STM,NTT,ST0,QT0,KU,GZERO)
      KTIME=KTIMI
      TMPR=TMPRI
 1800 CONTINUE
 1810 IF(KPL-2) 1870,1820,1870
 1820 IF(NRT) 1870,1870,1830
 1830 DO 1860 K=1,NRT
      NTT=NT(K+LKJ)
      FFS(1)=QDI(NTT+IJ)*0.001
      FS(1)=QT0(K+LKJ)
      LOQC=LOQTC(K+LKJ)
      LOST=LOSTT(K+LKJ)-1
      IF (KKPP.NE.1) KKP = 0
      KX = K
      KI=0
      NKI=1
      LKI=TMPR/DHF+0.0001
      IF(IPLT.EQ.0) KKP=2
      IF(KKP.NE.2) GO TO 1834
      IT1=1
      DO 1832 KP=1,NU
      FFS(KP+1)=STT(KP+LOST)*0.001
      FS(KP+1)=TERP21(T1(KP),KTIME,IT1,IT2,TII,QTC,LOQC)
 1832 CONTINUE
      TMPR=DHF
      KTIME=NU
      GO TO 1842
 1834 DO 1840 KP=1,KTIME
      IF(KKP.EQ.1) GO TO 1838
      IF(TMPR.GE.DHF) GO TO 1836
      IF(KP.NE.NKI) GO TO 1838
      KI=KI+1
      NKI=KI*DHF/TMPR+1.001
      FFS(KI+1)=STT(KI+LOST)*0.001
      GO TO 1838
 1836 DO 1837 KPI=1,LKI
      KI=KI+1
      FFS(KI+1)=STT(KI+LOST)*0.001
 1837 CONTINUE
 1838 FS(KP+1)=QTC(KP+LOQC)
 1840 CONTINUE
 1842 WRITE(IPR,2140)J,NTT,(STTNAM(KK,K+LKJ),KK=1,2),FHT(K+LKJ),ZONE
      WRITE(IPR,1850)
 1850 FORMAT (10X,30H*----COMPUTED    +----OBSERVED,15X,
     2  20HDISCHARGE (1000 CFS))
      CALL PLOT21(TII,QTC,LOQTC,STC,LOSTC,FS,FFS,KPL,KKP,FHT(K+LKJ),NRT1
     1,T1,KTIMI,KHR,KDA,KMO,KYR,ISTRT,INOW,STM,NTT,ST0,QT0,KU,GZERO)
      KTIME=KTIMI
      TMPR=TMPRI
 1860 CONTINUE
 1870 CONTINUE
 1880 CONTINUE
 2050 FORMAT (8I10)
 2060 FORMAT (8F15.2)
 2070 FORMAT (8F10.2)
 2090 FORMAT (8F10.4)
 2100 FORMAT (30X,I5,4F20.2)
 2140 FORMAT (/ 17H           RIVER ,I3,10H, STATION ,I3,5X,2A4,
     1   5X,14HFLOOD STAGE = ,F10.2,5H FEET,5X,11HTIME ZONE= ,A4)
C
 8000 IF(ITRACE.EQ.1) WRITE(IODBUG,9000) SNAME
 9000 FORMAT(1H0,2H**,1X,2A4,8H EXITED.)
      RETURN
      END
