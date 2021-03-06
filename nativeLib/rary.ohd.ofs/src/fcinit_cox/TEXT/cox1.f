C MEMBER COX1
C  (from old member FCCOX1)
C
      SUBROUTINE COX1(PO,CO,PN,CN)
C.......................................
C     THIS IS THE CARRYOVER TRANSFER SUBROUTINE FOR THE SACRAMENTO
C        SOIL MOISTURE ACCOUNTING OPERATION.  NEW CARRYOVER (CN)
C        VALUES ARE DETERMINE FROM OLD CARRYOVER (CO) AND
C        OLD AND NEW PARAMETERS (PO AND PN RESPECTIVELY) WHENEVER
C        POSSIBLE.  IF CARRYOVER CAN NOT BE CONVERTED DEFAULT
C        VALUES INITIALLY CONTAINED IN CN ARE KEPT.  THE
C        ORDER OF INFORMATION STORED IN PO AND PN IS THE
C        SAME AS FOR ARRAY PL USED IN THE OTHER SUBROUTINES
C        FOR THIS OPERATION.  INFORMATION ORDER FOR CO AND CN
C        IS THE SAME AS FOR CL( ).
C.......................................
C     SUBROUTINE INITIALLY WRITTEN BY. . .
C            ERIC ANDERSON - HRL     APRIL 1979     VERSION 1
C.......................................
      DIMENSION PO(1),CO(1),PN(1),CN(1)
      REAL LZTWCO,LZFSCO,LZFPCO,LZTWMO,LZSKO,LZPKO,LZTWM,LZFSM,LZFPM,
     1LZSK,LZPK,LZTWC,LZFSC,LZFPC
C
C     COMMON BLOCKS.
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_cox/RCS/cox1.f,v $
     . $',                                                             '
     .$Id: cox1.f,v 1.1 1995/09/17 18:47:07 dws Exp $
     . $' /
C    ===================================================================
C
C.......................................
C     CHECK TRACE LEVEL -- TRACE LEVEL FOR THIS SUBROUTINE=1.
      IF (ITRACE.GE.1) WRITE (IODBUG,900)
  900 FORMAT (1H0,15H** COX1 ENTERED)
C.......................................
C     CHECK TO SEE IF DEBUG OUTPUT IS NEEDED FOR THIS OPERATION.
      IBUG=0
      IF (IDBALL.GT.0) IBUG=1
      IF (NDEBUG.EQ.0) GO TO 100
      DO 10 I=1,NDEBUG
      IF (IDEBUG(I).EQ.1) GO TO 11
   10 CONTINUE
      GO TO 100
   11 IBUG=1
C
C     GET LOCATION OF PARAMETER VALUES
  100 IPM=PN(20)
      LPN=PN(25)
      LPO=PO(25)
      NXCN=PN(23)
      IFZN=PN(24)
      NCN=NXCN+6
      IF(IFZN.EQ.0) GO TO 101
      NXFN=PN(IFZN+6)
      NCN=NCN+6+NXFN
  101 NXCO=PO(23)
      IFZO=PO(24)
      NCO=NXCO+6
      IF(IFZO.EQ.0) GO TO 102
      NXFO=PO(IFZO+6)
      NCO=NCO+6+NXFO
  102 IF (IBUG.EQ.0) GO TO 110
C
C     DEBUG OUTPUT - NEW AND OLD PARAMETERS AND CARRYOVER.
      WRITE (IODBUG,902)
  902 FORMAT (1H0,51HSAC-SMA DEBUG--NEW AND OLD PARAMETERS AND CARRYOVER
     1)
      WRITE (IODBUG,901) (PO(I),I=1,LPO)
  901 FORMAT (1H0,15F8.3)
      WRITE (IODBUG,901) (CO(I),I=1,NCO)
      WRITE (IODBUG,901) (PN(I),I=1,LPN)
      WRITE (IODBUG,901) (CN(I),I=1,NCN)
C.......................................
C     GET VALUES NEEDED FOR TRANSFER OF SOIL-MOISTURE VARIABLES.
  110 UZTWCO=CO(1)
      UZFWCO=CO(2)
      LZTWCO=CO(3)
      LZFSCO=CO(4)
      LZFPCO=CO(5)
      ADIMCO=CO(6)
      UZTWMO=PO(IPM+2)
      LZTWMO=PO(IPM+10)
      LZSKO=PO(IPM+13)
      LZPKO=PO(IPM+14)
      SIDEO=PO(IPM+17)
      UZTWM=PN(IPM+2)
      UZFWM=PN(IPM+3)
      LZTWM=PN(IPM+10)
      LZFSM=PN(IPM+11)
      LZFPM=PN(IPM+12)
      LZSK=PN(IPM+13)
      LZPK=PN(IPM+14)
      SIDE=PN(IPM+17)
C.......................................
C     MAKE CARRYOVER TRANSFERS OF SOIL-MOISTURE VARIABLES.
      UZFWC=UZFWCO
      IF (UZFWC.GT.UZFWM) UZFWC=UZFWM
      UZTWC=UZTWM-UZTWMO+UZTWCO
      IF (UZTWC.LT.0.0) UZTWC=0.0
      LZTWC=LZTWM-LZTWMO+LZTWCO
      IF (LZTWC.LT.0.0) LZTWC=0.0
      IF (LZSK.EQ.0.0) GO TO 111
      LZFSC=LZFSCO*(LZSKO/LZSK)*((1.0+SIDE)/(1.0+SIDEO))
      GO TO 112
  111 LZFSC=LZFSCO
  112 IF (LZFSC.GT.LZFSM) LZFSC=LZFSM
      IF (LZPK.EQ.0.0) GO TO 113
      LZFPC=LZFPCO*(LZPKO/LZPK)*((1.0+SIDE)/(1.0+SIDEO))
      GO TO 114
  113 LZFPC=LZFPCO
  114 IF (LZFPC.GT.LZFPM) LZFPC=LZFPM
      ADIMC=UZTWM+LZTWM-UZTWMO-LZTWMO+ADIMCO
      IF (ADIMC.LT.UZTWC) ADIMC=UZTWC
C.......................................
C     STORE NEW CARRYOVER VALUES FOR SOIL-MOISTURE VARIABLES.
      CN(1)=UZTWC
      CN(2)=UZFWC
      CN(3)=LZTWC
      CN(4)=LZFSC
      CN(5)=LZFPC
      CN(6)=ADIMC
C.......................................
C     FERFORM CARRYOVER TRANSFER FOR OTHER VARIABLES.
      IF(NXCN.EQ.0) GO TO 130
C
C     PREVIOUS PE.
      IN=PN(14)
      IO=PO(14)
      IF((IN.GT.0).AND.(IO.GT.0)) GO TO 115
      GO TO 120
C     KEEP OLD PE.
  115 IN=PN(IN+3)
      IO=PO(IO+3)
      CN(IN+6)=CO(IO+6)
C
C     PREVIOUS SNOW COVER.
  120 IN=PN(15)
      IO=PO(15)
      IF((IN.GT.0).AND.(IO.GT.0)) GO TO 121
      GO TO 125
C     KEEP OLD SNOW COVER.
  121 IN=PN(IN+4)
      IO=PO(IO+4)
      CN(IN+6)=CO(IO+6)
C
C     SUM OF RUNOFF COMPONENTS.
  125 IN=PN(16)
      IO=PO(16)
      IF((IN.GT.0).AND.(IO.GT.0)) GO TO 126
      GO TO 130
  126 IDTN=PN(2)
      IDTO=PO(2)
      IN=PN(IN+4)
      IO=PO(IO+4)
      IF(IDTN.GE.IDTO) GO TO 128
C     SET TO ZERO.
      DO 127 I=1,7
      JN=IN+6-1
  127 CN(JN+I)=0.0
      GO TO 130
C     KEEP OLD VALUES.
  128 DO 129 I=1,7
      JN=IN+6-1
      JO=IO+6-1
  129 CN(JN+I)=CO(JO+I)
  130 IF(IFZN.EQ.0) GO TO 140
      IF(IFZO.EQ.0) GO TO 140
C
C     FROZEN GROUND CARRYOVER TRANSFER.
      JN=NXCN+7
      JO=NXCO+7
      CALL FGCOX1(PO(IFZO),CO(JO),PN(IFZN),CN(JN))
  140 IF (IBUG.EQ.0) GO TO 199
C.......................................
C     DEBUG OUTPUT -- NEW CARRYOVERS.
      WRITE (IODBUG,903)
  903 FORMAT (1H0,18HADJUSTED CARRYOVER)
      WRITE (IODBUG,901) (CN(I),I=1,NCN)
C.......................................
C     CARRYOVER TRANSFER RULES FOR SOIL-MOISTURE VARIABLES.
C
C     1. UZFWC - KEEPS VALUE IF UZFWC.LE.UZFWM
C     2. UZTWC AND LZTWC - KEEPS DEFICIT AS LONG AS
C        CONTENTS DO NOT GO BELOW ZERO.
C     3. LZFSC AND LZFPC - KEEPS SAME WITHDRAWAL
C        AMOUNT FOR CHANNEL COMPONENT OF BASEFLOW
C        AS LONG AS CONTENTS.LE.CAPACITY.
C     4. ADIMC - KEEPS DEFICIT AS LONG AS CONTENTS
C        ARE .GE. UZTWC.
C
C     NONE OF THE DEFAULT VALUES ARE EVER KEPT.
C.......................................
  199 RETURN
      END
