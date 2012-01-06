C MEMBER FSACTL
C  (from old member FCFPRSAC)
C
      SUBROUTINE FSACTL(METRIC)
C.......................................
C     THIS SUBROUTINE PRINTS THE TITLE PAGE FOR THE SAC-SMA OPERATION
C     DISPLAY UNDER THE PRINTOPS COMMAND.
C.......................................
C     WRITTEN BY...  ERIC ANDERSON - HRL - DEC 1982
C.......................................
      DIMENSION DEPTH(2),DENG(2),DMET(2)
C
C     COMMON BLOCK
      INCLUDE 'common/ionum'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_printops/RCS/fsactl.f,v $
     . $',                                                             '
     .$Id: fsactl.f,v 1.1 1995/09/17 19:04:49 dws Exp $
     . $' /
C    ===================================================================
C
C
C     DATA STATEMENTS
      DATA DENG,DMET,TENG,TMET/4HINCH,4HES  ,4HMM  ,4H    ,4HDEGF,
     14HDEGC/
C.......................................
C     INITIAL VALUES.
      IF(METRIC.EQ.1) GO TO 11
      DEPTH(1)=DENG(1)
      DEPTH(2)=DENG(2)
      TEMP=TENG
      GO TO 10
   11 DEPTH(1)=DMET(1)
      DEPTH(2)=DMET(2)
      TEMP=TMET
C.......................................
C     PRINT TITLE PAGE
   10 WRITE(IPR,900)
  900 FORMAT(1H1)
      DO 12 I=1,8
   12 WRITE(IPR,901)
  901 FORMAT(1H0)
      WRITE(IPR,902)
  902 FORMAT(1H0,40X,45HGLOSSARY OF NAMES USED IN THE SAC-SMA DISPLAY)
      WRITE(IPR,901)
      WRITE(IPR,903)
  903 FORMAT(1H0,20X,4HNAME,31X,11HDESCRIPTION,33X,5HUNITS,/21X,4H****,
     131X,11H***********,33X,5H*****)
      WRITE(IPR,904)DEPTH
  904 FORMAT(1H0,20X,5HUZTWD,10X,58HUPPER ZONE TENSION WATER DEFICIT (CA
     1PACITY MINUS CONTENTS),2(' . '),2A4)
      WRITE(IPR,905)DEPTH
  905 FORMAT(1H ,20X,5HLZTWD,10X,
     158HLOWER ZONE TENSION WATER DEFICIT (CAPACITY MINUS CONTENTS),
     2   2(' . '),2A4)
      WRITE(IPR,906)DEPTH
  906 FORMAT(1H ,20X,9HUZTWC  1/,6X,
     133HUPPER ZONE TENSION WATER CONTENTS,1X,10(' . '),2A4)
      WRITE(IPR,907)DEPTH
  907 FORMAT(1H ,20X,9HUZFWC  1/,6X,30HUPPER ZONE FREE WATER CONTENTS,
     1 1X,11(' . '),2A4)
      WRITE(IPR,908)DEPTH
  908 FORMAT(1H ,20X,9HLZTWC  1/,6X,
     133HLOWER ZONE TENSION WATER CONTENTS,1X,10(' . '),2A4)
      WRITE(IPR,909)DEPTH
  909 FORMAT(1H ,20X,9HLZFSC  1/,6X,
     137HLOWER ZONE FREE SUPPLEMENTAL CONTENTS,9(' . '),2A4)
      WRITE(IPR,910) DEPTH
  910 FORMAT(1H ,20X,9HLZFPC  1/,6X,32HLOWER ZONE FREE PRIMARY CONTENTS,
     1 2X,10(' . '),2A4)
      WRITE(IPR,911) DEPTH
  911 FORMAT(1H ,20X,9HADIMC  1/,6X,
     1 54HTENSION WATER CONTENTS OF THE VARIABLE IMPERVIOUS AREA,
     2 1X,3(' . '),2A4)
      WRITE(IPR,912)TEMP
  912 FORMAT(1H ,20X,4HFGIX,11X,19HFROZEN GROUND INDEX,15(' . '),A4)
      WRITE(IPR,913)
  913 FORMAT(1H ,20X,3HUZK,12X,
     137HUPPER ZONE FREE WATER WITHDRAWAL RATE,9(' . '),2H2/)
      WRITE(IPR,914)
  914 FORMAT(1H ,20X,4HLZSK,11X,
     144HLOWER ZONE FREE SUPPLEMENTAL WITHDRAWAL RATE,2X,6(' . '),2H2/)
      WRITE(IPR,915)
  915 FORMAT(1H ,20X,4HLZPK,11X,
     139HLOWER ZONE FREE PRIMARY WITHDRAWAL RATE,1X,8(' . '),2H2/)
      WRITE(IPR,916)
  916 FORMAT(1H ,20X,5HPCTIM,10X,25HPERMANENT IMPERVIOUS AREA,
     1 13(' . '),2H3/)
      WRITE(IPR,917)
  917 FORMAT(1H ,20X,5HADIMP,10X,26HADDITIONAL IMPERVIOUS AREA,
     1 2X,12(' . '),2H3/)
      WRITE(IPR,918)
  918 FORMAT(1H ,20X,7HOP-NAME,8X,
     133HOPERATION NAME WITHIN THE SEGMENT)
      WRITE(IPR,901)
      WRITE(IPR,919)
  919 FORMAT(1H ,20X,70HNOTES... 1. CAPACITIES OF THESE ZONES GIVEN IN P
     1ARENTHESES ON DISPLAY.)
      WRITE(IPR,920)
  920 FORMAT(1H ,29X,63H2. WITHDRAWAL RATES ARE IN TERMS OF FRACTION WIT
     1HDRAWN PER DAY.)
      WRITE(IPR,921)
  921 FORMAT(1H ,29X,42H3. INDICATES FRACTION OF AREA REPRESENTED.)
C.......................................
      RETURN
      END
