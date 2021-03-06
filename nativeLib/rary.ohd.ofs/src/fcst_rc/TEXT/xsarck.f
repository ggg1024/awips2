C MEMBER XSARCK
C  (from old member FCXSARCK)
C
C @PROCESS LVL(77)
C  DESC - DETERMINES MANNING ROUGHNESS COEFF FOR EACH ELEVATION
C                             LAST UPDATE: 10/27/94.11:16:14 BY $WC30KH
C
C
C....................................................................
C
       SUBROUTINE XSARCK(IBUG)
C
C  ALL VARIABLES ARE IN ENGLISH UNITS
C  SUBROUTINE XSARCK DETERMINES, USING THE MANNING EQUATION AND THE
C     CROSS-SECTIONAL DATA, THE MANNINGS N ASSOCIATED WITH EACH STAGE OF
C     THE RATING CURVE.  THESE VALUES ARE SAVED IN THE FORM OF A
C     CONVEYANCE COEFFICIENT (CKARAY(I)=(1.000/N(I))*SQRT(SLOPE) WHERE
C     N(I) IS THE COMPUTER MANNING N FOR STAGE(I).
C
C     THE SUBROUTINE GOES ON TO DETERMINE (BY INTERPOLATING/EXTRAPOLATIN
C     FLOWS) TO DETERMINE THE MANNINGS N ASSOCIATED WITH EACH CROSS-
C     SECTIONAL ELEVATION.
C
C.......................................................................
C
C   SUBROUTINE ORIGINALLY WRITTEN BY --
C       JONATHAN WETMORE - HRL - 811015
C   MODIFIED 11/87 EJV TO HANDLE NEW SHIFT FACTOR
C
C.......................................................................
      INCLUDE 'common/fratng'
C
      INCLUDE 'common/facxsc'
C
      INCLUDE 'common/fxsctn'
C
      INCLUDE 'common/ionum'
C
      INCLUDE 'common/fdbug'
C
      INCLUDE 'common/where'
C
       DIMENSION SUBNAM(2),OLDSUB(2)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_rc/RCS/xsarck.f,v $
     . $',                                                             '
     .$Id: xsarck.f,v 1.1 1998/07/02 17:11:54 page Exp $
     . $' /
C    ===================================================================
C
       DATA SUBNAM/4HXSAR,4HCK  /
C  SET /WHERE/ INFO
C
      DO 600 I=1,2
      OLDSUB(I) = OPNAME(I)
  600 OPNAME(I) = SUBNAM(I)
      IOLDOP = IOPNUM
      IOPNUM = 0
C
C
      IF (ITRACE.GE.1) WRITE(IODBUG,601)
  601  FORMAT(1H0,20H *** ENTER XSARCK **)
C
      LH1=LOCH
      LHN=LH1+NRCPTS-1
      LQ1=LOCQ
      LQN=LQ1+NRCPTS-1
      LXE1=LXELEV
      LXT1=LXTOPW
      RCMXH=XRC(LHN)
      RCMXEL=RCMXH+GZERO
C
      XAREA(1)=ABELOW
      DO 2140  II=2,NCROSS
      XAREA(II)=XAREA(II-1)+((XRC(LXT1-1+II)+XRC(LXT1-1+II-1))/2.)*
     1(XRC(LXE1-1+II)-XRC(LXE1-1+II-1))
 2140 CONTINUE
C
C  NOW DET. CK VALUE (1.000/N S**(1/2)) ASSOCIATED WITH EACH STAGE
C       IF LOWEST R.C. STAGE IS CHANNEL INVERT, CKARAY(1) WILL BE SET
C                                              EQUAL TO CKARAY(2)
       KCHECK=0
       IRC=0
      DO 2141 I=1,NRCPTS
      ELRC=XRC(LH1-1+I)+GZERO
      IF(IRC.LE.0) THEN
        IF(ELRC.LT.XRC(LXE1)) GO TO 2141
        IRC=I
      END IF
      CALL FTERPL(ELRC,XRC(LXE1),NCROSS,XRC(LXT1),BRC,0)
       DO 1105 IK=2,NCROSS
       KEEPIK=IK
       IF(ELRC.LT.XRC(LXE1-1+IK)) GO TO 1106
 1105  CONTINUE
 1106  KEEPIM=KEEPIK-1
       ELDIF=ELRC-XRC(LXE1-1+KEEPIM)
       ADIF=(XRC(LXT1-1+KEEPIM)+BRC)/2.
       ARC=XAREA(KEEPIM)+(ADIF*ELDIF)
       IF(ARC.LT.0.01.OR.BRC.LT.0.01) KCHECK=1
       IF(ARC.LT.0.01.OR.BRC.LT.0.01) GO TO 2141
      QRC=XRC(LOCQ-1+I)
       IF(QRC.LT.0.0001) KCHECK=1
      CKARAY(I)=QRC*BRC**(2./3.)/ARC**(5./3.)
       IF(CKARAY(I).LT.0.01) GO TO 2141
       CMN=(1.000/CKARAY(I))*SQRT(SLOPE)
C
C  PRINT DBUG INFO ON MANNINGS N
      STG=XRC(LH1-1+I)
      IF(IBUG.GE.1)
     &WRITE(IODBUG,6059) I,STG,QRC,BRC,ARC,CKARAY(I),CMN
 6059 FORMAT(5X,2HI=,I2,5X,4HSTG=,F6.2,2X,4HQRC=,F10.0,2X,
     14HBRC=,F6.0,2X,4HARC=,F10.0,2X,11HCKARAY(I)= ,F6.4,2X,
     24HCMN=,F6.4)
 2141 CONTINUE
       IF(KCHECK.GT.0) CKARAY(1)=CKARAY(2)
       IRCM=IRC-1
       IF(IRCM.LE.0) GO TO 2143
       DO 2142 I=1,IRCM
 2142 CKARAY(I)=CKARAY(IRC)
C  NOW DETERMINE N VALUES ASSOCIATED WITH EACH X-SECTION ELEVATION
C
 2143 CONTINUE
      DO 2149 I=1,NCROSS
C  CHECK TO SEE IF ROUGHNESS IS INPUTED
       XSTG=XRC(LXE1+I-1)-GZERO
       IF(FLOODN.GT.1.0) THEN
          LXMN=LXT1+NCROSS
          CMANGN(I)=XRC(LXMN+I-1)
          GO TO 113
       ENDIF
C  CHECK TO SEE IF COMPOSIT ROUGHNESS IS TO BE USED BASED ON INPUT
C  F.P. "N" AND COMPUTED X-SECT TOP "N"
       XTOPW=XRC(LXT1+I-1)
       IF(XSTG.LE.XRC(LHN)) GO TO 112
       IF(FLOODN.LE.0.0) GO TO 112
       CKTOP=CKARAY(LHN)
       CMNTOP=(1.000/CKTOP)*SQRT(SLOPE)
       IF(CMNTOP.LT.0.010) CKTOP=(1.000/0.010)*SQRT(SLOPE)
       IF(CMNTOP.GT.0.30) CKTOP=(1.000/0.30)*SQRT(SLOPE)
       CMNTOP=(1.000/CKTOP)*SQRT(SLOPE)
       CALL FTERPL(RCMXEL,XRC(LXE1),NCROSS,XRC(LXT1),RCMXW,0)
        SQUARN=RCMXW*CMNTOP*CMNTOP+(XTOPW-RCMXW)
     1  *FLOODN*FLOODN
        CMANGN(I)=SQRT(SQUARN/XTOPW)
        GO TO 113
 112  CONTINUE
C  MAINTAIN CONSTANT CONVEYANCE ABOVE RATING CURVE
      IF(XSTG.LT.XRC(LH1)) CKVAL=CKARAY(LH1)
      IF(XSTG.GT.XRC(LHN)) CKVAL=CKARAY(LHN)
      IF(XSTG.GE.XRC(LH1).AND.XSTG.LE.XRC(LHN))
     1CALL FTERPL(XSTG,XRC(LH1),NRCPTS,CKARAY,CKVAL,0)
      CMANGN(I)=(1.000/CKVAL)*SQRT(SLOPE)
 113  CONTINUE
      IF(IBUG.GE.1) WRITE(IODBUG,6060) 
     & I,XRC(LXE1-1+I),XSTG,XTOPW,XAREA(I),CMANGN(I)
 6060 FORMAT(2X,2HI=,I2,5X,13H X-S ELEV(I)=,F10.2,7H  XSTG=,F10.2,
     1'  TOPW,AREA=',2F10.0,8H   CMN= ,F10.5)
 2149  CONTINUE
 2120  CONTINUE
C
C
      IF (ITRACE.GE.1) WRITE(IODBUG,602)
  602  FORMAT(1H0,20H *** EXIT XSARCK ***)
C
      OPNAME(1) = OLDSUB(1)
      OPNAME(2) = OLDSUB(2)
      IOPNUM = IOLDOP
      RETURN
       END
