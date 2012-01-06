C     MEMBER OSACIN
C
      SUBROUTINE OSACIN(OPID,NUMOP,OPNEW,PARM,DELTA,CHECKL,CHECKU,NOTHER
     *,OA,MOA,P,MP,A,MA,NPARM,IU,LEFTOA,IERO)
C
C.......................................
C     THIS SUBROUTINE FILLS THE A AND OA ARRAYS WITH OPT3 INFORMATION
C     FOR THE SAC-SMA OPERATION AND PRINTS THE INPUT.
C.......................................
C     SUBROUTINE INITIALLY WRITTEN BY
C            LARRY BRAZIL - HRL   APRIL 1981   VERSION 1
C.......................................
C
      DIMENSION P(MP),A(MA),OA(MOA),PARM(2),OPID(2),OPNEW(2)
      DIMENSION PMNAM(2,21),ABSL(21),ABSU(21),IRD(21),DIFF(3),RATIO(3)
      DIMENSION OPIDD(2),OPNEWW(2),RDIFF(3),SAC(2)
      DIMENSION OLDOPN(2)
C
      INCLUDE 'common/ionum'
      INCLUDE 'common/fdbug'
      INCLUDE 'ocommon/opschm'
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/calb/src/opt3_shared/RCS/osacin.f,v $
     . $',                                                             '
     .$Id: osacin.f,v 1.2 1996/07/11 20:54:51 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA PMNAM/4HPXAD,4HJ   ,4HPEAD,4HJ   ,4HUZTW,4HM   ,
     *           4HUZFW,4HM   ,4HUZK ,4H    ,4HPCTI,4HM   ,
     *           4HADIM,4HP   ,4HRIVA,4H    ,4HZPER,4HC   ,
     *           4HREXP,4H    ,4HLZTW,4HM   ,4HLZFS,4HM   ,
     *           4HLZFP,4HM   ,4HLZSK,4H    ,4HLZPK,4H    ,
     *           4HPFRE,4HE   ,4HRSER,4HV   ,4HSIDE,4H    ,
     *           4HEFC ,4H    ,4HETHI,4HGH  ,4HETLO,4HW   /
      DATA ABSL/0.0,0.0,0.1,0.1,0.1,0.0,0.0,0.0,0.01,1.0,0.0,0.0,0.0,
     *0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0/
      DATA ABSU/10.0,10.0,1000.,1000.,1.0,100.,1000.,1.0,1000.,10.0,
     *2000.,2000.,2000.,1.0,1.0,1.0,1.0,10.0,1.0,10.,10./
      DATA IRD/1,1,0,0,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1/
      DATA DIFF/4H DIF,4HFERE,4HNCE /
      DATA RATIO/4H   R,4HATIO,4H    /
      DATA IBUG/4HOPT /
      DATA SAC/4HSAC-,4HSMA /
C
C     TRACE LEVEL FOR THIS SUBROUTINE=1.
      IF(ITRACE.GE.1) WRITE(IODBUG,1000)
 1000 FORMAT(1H0,17H** OSACIN ENTERED)
C
      CALL FSTWHR('OSACIN  ',0,OLDOPN,IOLDOP)
C
C     INITIALIZE VARIABLES.
      IPLUS=0
      LOCP=0
      NOTH=1
C
C     CHECK AVAILABLE SPACE IN OA().
C
      IF(NOTHER.GT.0) IPLUS=2
      IUSE=10+(NOTHER*4)+IPLUS
      IF(LEFTOA.GE.IUSE) GO TO 112
C
      WRITE(IPR,900)
  900 FORMAT(1H0,10X,79H**ERROR** THIS PARAMETER REQUIRES MORE SPACE THA
     *N IS AVAILABLE IN THE OA ARRAY.)
C
      CALL ERROR
C
      IERO=1
      GO TO 9999
C
C     SPACE IS AVAILABLE IN OA().
C     STORE PARAMETER INFO IN OA() AND A().
  112 CONTINUE
C
      LEFTOA=LEFTOA-IUSE
C
C
      IPNUM=0
C
      DO 120 I=1,21
      IPNUM=IPNUM+1
      IF(PARM(1).EQ.PMNAM(1,I).AND.PARM(2).EQ.PMNAM(2,I)) GO TO 122
  120 CONTINUE
C
      WRITE(IPR,902) PARM
  902 FORMAT(1H0,10X,12H**WARNING** ,2A4,42H IS NOT A PARAMETER THAT CAN
     * BE OPTIMIZED.)
C
      CALL WARN
C
      NPARM=NPARM-1
C
      IF(NOTHER.EQ.0) GO TO 9999
      DO 121 II=1,NOTHER
      READ(IN,800) OPIDD,OPNEWW
  121 CONTINUE
C
      GO TO 9999
C
  122 CONTINUE
      CALL FSERCH(NUMOP,OPNEW,LOCP,P,MP)
      IF(LOCP.NE.0) GO TO 124
      WRITE(IPR,903) OPID,OPNEW
  903 FORMAT(1H0,10X,15H**WARNING** ID(,2A4,7H) NAME(,2A4,39H) HAS NOT B
     *EEN DEFINED AS AN OPERATION.)
      CALL WARN
      NPARM=NPARM-1
      GO TO 9999
  124 CONTINUE
      OA(IU+1)=LOCP+0.01
      OA(IU+2)=NUMOP+0.01
      OA(IU+3)=PARM(1)
      OA(IU+4)=PARM(2)
      IPLPM=P(LOCP+19)
      IF(IPNUM.EQ.20.OR.IPNUM.EQ.21) GO TO 130
      IPLOC=LOCP+IPLPM+IPNUM-2
      IF(IPNUM.EQ.19) IPLOC=IPLOC+1
      OA(IU+5)=IPLOC+0.01
      OA(IU+6)=DELTA
      OA(IU+10)=1.01
      A(NPARM)=P(IPLOC)
      GO TO 136
C
  130 IPLET=P(LOCP+20)
      IPLOC=LOCP+IPLET-1
      OA(IU+5)=IPLOC+0.01
      OA(IU+6)=DELTA
      OA(IU+10)=12.01
      A(NPARM)=1.0
  136 CONTINUE
C
C     CHECK LOWER AND UPPER BOUNDS.
C
      IF(CHECKL.LT.CHECKU) GO TO 138
C
C   INVALID USER BOUNDS
C
      WRITE(IPR,909) PARM,CHECKL,CHECKU,ABSL(IPNUM),ABSU(IPNUM)
  909 FORMAT(1H0,1X,'** WARNING **  PARAMETER (',2A4,') LOWER BOUND (',
     *F8.2,') IS GREATER OR EQUAL TO THE UPPER LIMIT (',F8.2,')',/17X,
     *'THE USER BOUNDS HAVE BEEN REPLACED WITH THE ABSOLUTE LIMITS (',
     *F8.2,',',F8.2,')')
      CALL WARN
      OA(IU+7)=ABSL(IPNUM)
      OA(IU+8)=ABSU(IPNUM)
      GO TO 143
  138 IF(CHECKL.GE.ABSL(IPNUM)) GO TO 140
C
      WRITE(IPR,904) CHECKL,PARM,ABSL(IPNUM)
  904 FORMAT(1H0,6X,12H**WARNING** ,27HTHE SPECIFIED LOWER BOUND (,
     *F8.2,6H) FOR ,2A4,53H HAS BEEN REPLACED BY THE ABSOLUTE LOWER CONS
     *TRAINT (,F8.2,2H).)
C
      CALL WARN
C
      OA(IU+7)=ABSL(IPNUM)
      GO TO 141
  140 OA(IU+7)=CHECKL
  141 IF(CHECKU.LE.ABSU(IPNUM)) GO TO 142
      WRITE(IPR,906) CHECKU,PARM,ABSU(IPNUM)
  906 FORMAT(1H0,6X,12H**WARNING** ,27HTHE SPECIFIED UPPER BOUND (,F8.2,
     *6H) FOR ,2A4,53H HAS BEEN REPLACED BY THE ABSOLUTE UPPER CONSTRAIN
     *T (,F8.2,2H).)
C
      CALL WARN
C
      OA(IU+8)=ABSU(IPNUM)
      GO TO 143
  142 OA(IU+8)=CHECKU
  143 CONTINUE
C     CHECK TO SEE THAT INITIAL VALUE IS NOT TOO CLOSE TO BOUNDS.
C
      ICLOSE=0
      CALL OBNDCK(PARM,OPID,OPNEW,A(NPARM),DELTA,OA(IU+7),OA(IU+8),
     *NPER,ICLOSE)
      IF(ICLOSE.NE.1) GO TO 145
      NPARM=NPARM-1
C
      IF(NOTHER.EQ.0) GO TO 9999
      DO 147 II=1,NOTHER
      READ(IN,800) OPIDD,OPNEWW
  147 CONTINUE
C
      GO TO 9999
  145 CONTINUE
C
C     PRINT PARAMETER INPUT INFORMATION.
C
      WRITE(IPR,908) NPARM,OPID,OPNEW,PARM,A(NPARM),OA(IU+7),OA(IU+8),
     *OA(IU+6)
  908 FORMAT(1H0,I2,2H. ,2A4,2X,2A4,3X,2A4,2X,F9.3,1X,F9.3,1X,F9.3,5X,F9
     *.3)
C
C     CHECK TO SEE IF OTHER AREAS ARE AFFECTED.
C
      N=NOTHER
      IF(NOTHER.EQ.0) GO TO 200
      IULOC=IU+10
      OA(IULOC+1)=ABSL(IPNUM)
      OA(IULOC+2)=ABSU(IPNUM)
C
      DO 160 I=1,NOTHER
      READ(IN,800) OPIDD,OPNEWW
  800 FORMAT(2A4,2X,2A4)
C
C     CHECK OPERATION I.D. AND GET INTERNAL NUMBER.
C
      CALL FOPCDE(OPIDD,NUMOPP)
      IF(NUMOPP.NE.0.AND.OPIDD(1).EQ.SAC(1).AND.OPIDD(2).EQ.SAC(2)) GO
     *TO 144
      CALL OBADID(OPIDD)
      N=N-1
C
      GO TO 160
  144 CONTINUE
C
      LOCPP=0
      CALL FSERCH(NUMOPP,OPNEWW,LOCPP,P,MP)
      IF (LOCPP.NE.0) GO TO 148
      WRITE(IPR,903) OPIDD,OPNEWW
      CALL WARN
      N=N-1
      GO TO 160
  148 ILOCC=IULOC+3+(NOTH-1)*4
      NOTH=NOTH+1
      OA(ILOCC)=IRD(IPNUM)+0.01
      OA(ILOCC+1)=LOCPP+0.01
C
      IPLPMM=P(LOCPP+19)
      IF(IPNUM.EQ.20.OR.IPNUM.EQ.21) GO TO 146
      IPLOCC=LOCPP+IPLPMM+IPNUM-2
      IF(IPNUM.EQ.19) IPLOCC=IPLOCC + 1
      OA(ILOCC+2)=IPLOCC+0.01
      OA(ILOCC+3)=1.01
      GO TO 149
  146 IPLETT=P(LOCPP+20)
      IPLOCC=LOCPP+IPLETT-1
      OA(ILOCC+2)=IPLOCC+0.01
      OA(ILOCC+3)=12.01
C
  149 CONTINUE
C
C     PRINT PARAMETER INPUT INFORMATION FOR OTHER AREAS.
C
C
      IF(IRD(IPNUM).EQ.1) GO TO 175
      DO 170 IDR=1,3
  170 RDIFF(IDR)=DIFF(IDR)
      GO TO 184
  175 DO 180 IDR=1,3
  180 RDIFF(IDR)=RATIO(IDR)
  184 CONTINUE
C
      IF(I.NE.1) GO TO 150
      WRITE(IPR,910) OPNEWW,RDIFF
  910 FORMAT(1H+,88X,2A4,15X,3A4)
C
      GO TO 160
  150 WRITE(IPR,912) OPNEWW,RDIFF
  912 FORMAT(1H ,88X,2A4,15X,3A4)
  160 CONTINUE
  200 CONTINUE
      OA(IU+9)=N+0.01
      IUSE=10+(N*4)+IPLUS
C
C     CHECK IF DEBUG IS NEEDED.
C
      IF(IFBUG(IBUG).NE.1) GO TO 210
      WRITE(IODBUG,919) OA(IU+3),OA(IU+4)
  919 FORMAT(1H0,'OSACIN DEBUG--PARAMETER=',2A4)
      I=IU+1
      II=IU+IUSE
      WRITE (IODBUG,920) (OA(KK),KK=I,II)
  920 FORMAT(1H0,12F10.3)
C
  210 IU=IU+IUSE
C
 9999 CALL FSTWHR(OLDOPN,IOLDOP,OLDOPN,IOLDOP)
C
      IF(ITRACE.GE.1) WRITE(IODBUG,1002)
 1002 FORMAT(1H0,14H** EXIT OSACIN)
      RETURN
      END
