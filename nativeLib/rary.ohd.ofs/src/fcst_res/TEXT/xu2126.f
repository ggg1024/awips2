C MEMBER XU2126
C  (from old member FCXU2126)
C
      SUBROUTINE XU2126(SUNUM,PO,W,LOCWS,LOCOWS)
C---------------------------------------------------------------------
C  SUBROUTINE TO GET PARAMETER AND CARRYOVER VALUES FOR THE ENTRY-INTO-
C  SURCHARGE UTILITY (#21) AND CALL ROUTINE TO DETERMINE IF RESERVOIR
C  OPERATION SHOULD GO INTO SURCHARGE MODE (INDICATED BY .TRUE. VALUE
C  FOR SURCHG IN /SRCG26/.
C---------------------------------------------------------------------
C  WRITTEN BY - JOE OSTROWSKI - HRL - AUGUST 1983
C---------------------------------------------------------------------
C
      INCLUDE 'common/resv26'
      INCLUDE 'common/exg26'
      INCLUDE 'common/fdbug'
      INCLUDE 'common/srcg26'
C
      DIMENSION PO(*),W(*),LOCWS(*),LOCOWS(*)
      DIMENSION EMTY(10),NEEDIT(8),NEEDVA(8,10),LISTOP(10)
      LOGICAL NEEDIT,NEEDVA
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_res/RCS/xu2126.f,v $
     . $',                                                             '
     .$Id: xu2126.f,v 1.4 2000/03/13 21:06:47 page Exp $
     . $' /
C    ===================================================================
C
      DATA NEEDVA/.TRUE.,6*.FALSE.,2*.TRUE.,7*.FALSE.,
     3    .FALSE.,.TRUE.,.TRUE.,.TRUE.,.TRUE.,.FALSE.,.TRUE.,.TRUE.,
     4    .FALSE.,.TRUE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,
     5    .TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.TRUE.,
     6    .TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,
     7    .FALSE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,.TRUE.,.FALSE.,
     8    .FALSE.,6*.TRUE.,.FALSE.,
     9    8*.TRUE.,7*.TRUE.,.FALSE./
C
      IF (IBUG.GE.1) WRITE(IODBUG,1600)
 1600 FORMAT('   *** ENTER XU2126 ***')
C
C  IF ALREADY IN SURCHARGE OPERATION, NO NEED TO DETERMINE NEED TO GO IN
C  LET SURCHARGE OP. DETERMINE NEED TO GET OUT.
C
      IF (SURCHG) GO TO 9000
C
C  GET LEVEL OF THIS UTILITY
C
ccc      CALL XBLV26(SUNUM,IBASE,LEVEL)
      ISUNUM=SUNUM
      IBASE=ISUNUM/10
      LEVEL=ISUNUM-IBASE*10
C
C  THE PARMS AND CO FOR THIS UTILITY ARE ACTUALLY HELD IN THE DEFINITION
C  OF THE COMPANION INDUCED SURCHARGE SCHEME (THE ONE WITH THE SAME
C  LEVEL). THE PIN ROUTINE GUARANTEES THAT THIS COMPANIONSHIP EXISTS.
C
      COMPAN = 1110.01 + LEVEL
      CALL XPTR26(COMPAN,PO,IORD,IBASE,LEVEL,LOCPM,LOCTS,LOCCO)
C
C  POINTER FOR ADDITIONAL VARIABLES FOR 1993 FEBRUARY MANUAL
      LO=LOCPM+4
      NSCQI=PO(LO)
      NSCEL=PO(LO+1)
      LOCFLO=LOCPM+6
      SCQI1=PO(LOCFLO)
      LO=LO+1
      LO=LO+NSCQI
      SCQIN=PO(LO-1)
      SCQO1=PO(LO)
      LO=LO+NSCEL
      NSCQO=NSCQI*NSCEL
      LO=LO+NSCQO+2
      NDT=PO(LO)
      LO=LO+1
      DO 7110 J=1,10
 7110 EMTY(J)=BLANK
      NLINES=PO(LO)
      LO=LO+1
      IF(NDT.GT.3)GO TO 7112
      DO 7114 J=1,NLINES
      N=PO(LO+1)
      EMTY(N)=AMP
      LO=LO+2
 7114 CONTINUE
      GO TO 7118
C
 7112 DO 7116 J=1,NLINES
      N=PO(LO+2)
      EMTY(N)=AMP
      LO=LO+3
 7116 CONTINUE
 7118 NOPT=0
      KI=0
      DO 7120 J=1,10
      IF(EMTY(J).EQ.BLANK)GO TO 7120
      KI=KI+1
      LISTOP(KI)=J
      NOPT=KI
 7120 CONTINUE
      DO 7122 J=1,8
 7122 NEEDIT(J)=.FALSE.
      DO 7124 KK=1,NOPT
      IOPT=LISTOP(KK)
      DO 7126 N=1,8
      NEEDIT(N)=NEEDIT(N).OR.NEEDVA(N,IOPT)
 7126 CONTINUE
 7124 CONTINUE
      IF(NEEDIT(1)) LO=LO+1
      IF(NEEDIT(2)) LO=LO+1
      IF(NEEDIT(3)) LO=LO+1
      IF(NEEDIT(4)) LO=LO+1
      IF(NEEDIT(5)) LO=LO+1
      IF(NEEDIT(6)) LO=LO+1
      IF(NEEDIT(7)) LO=LO+1
      IF(.NOT.NEEDIT(8)) GO TO 7154
      NGEL=PO(LO)
      LO=LO+1
      NGO=PO(LO)
      LO=LO+NGEL
      LO=LO+NGO
      NGA=NGEL*NGO
      LO=LO+NGA+2
7154  LO=LO+1
      NR=PO(LO)
      IF(NR.GT.0) LO=LO+2*NR+1
      LO=LO+1
      L9302=LO
      I9302=PO(L9302)
C
C  NOW FILL NECESSARY PARAMETER VALUES
C
C
C      EUPRND = PO(LOCPM)
      HUPPER = PO(LOCPM)
C
C      ELWRND = PO(LOCPM+1)
      HCHECK = PO(LOCPM+1)
C
C  FALELB = HLOWER, ELEVATION TO TERMINATE SURCHARGE COMPUTATION
      FALELB = PO(LOCPM+2)
      HLOWER = FALELB
      DT = MINODT
      FRACT  = PO(LOCPM+3)/DT
C
C  COMPUTE THE SURCHARGE ENTRY CURVE
C
      LOCENT = LOCPM + 4
      LOCEL = LOCOWS(8)
      LOCQI = LOCEL + NSE
C      CALL XENT26(PO,LOCENT,W,LOCOWS)
C
C  SET COUNTERS AND LOCATIONS FOR THE SURCHARGE RELATION.
C
      NSCQI = PO(LOCPM+4)
      NSCEL  = PO(LOCPM+5)
      LOCFLO = LOCPM + 6
      SCQI1 = PO(LOCFLO)
      LOCPOO = LOCFLO + NSCQI
      SCEL1  = PO(LOCPOO)
      LOCSCC = LOCPOO + NSCEL
C
      QCHECK=-999.0
      IF(I9302.NE.199302) GO TO 8000
      QCHECK=PO(L9302+2)
      SCQIMN=PO(L9302+9)
      IF(IFMSNG(SCQIMN).EQ.1) THEN
        IF(SCQIN.GE.100.0) THEN
          SCQIMN=SCQI1
        ELSE
          SCQIMN=SCQO1
        ENDIF
      ENDIF
      IF(IFMSNG(QCHECK).EQ.1) QCHECK=SCQIMN
 8000 CONTINUE
C
C  GET CARRYOVER VALUES
C
      IOFFCO = LOCWS(4) + LOCCO - 2
      QIBAC1 = W(IOFFCO+1)
      ELBAC1 = W(IOFFCO+2)
      TENDCY = W(IOFFCO+3)
      ELVMAX = W(IOFFCO+4)
      IF (NS2.EQ.1 .AND. IFMSNG(ELVMAX).EQ.0) SURCHG = .TRUE.
      IF (SURCHG) GO TO 9000
C
C  NOW SET SURCHARGE FLAG
C
      CALL SURC26(W(LOCEL),W(LOCQI),PO(LESSTO),PO(LESELV))
C
C  NO NEED TO SAVE ANY CARRYOVER, SO THAT'S IT!
C
 9000 CONTINUE
      IF (IBUG.GE.1) WRITE(IODBUG,1699)
 1699 FORMAT('    *** EXIT XU2126 ***')
      RETURN
      END
