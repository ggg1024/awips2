C MEMBER COX11
C  (from old member FCCOX11)
C
      SUBROUTINE COX11(POLD,COLD,PNEW,CNEW)
C
C     THIS IS THE CARRYOVER TRANSFER SUBROUTINE FOR THE
C     LAYERED COEFFICIENT ROUTING OPERATION
C
C
C     THIS SUBROUTINE INITIALLY WRITTEN BY
C           DAVID REED-HRL       OCT 1979
C
      DIMENSION POLD(1),COLD(1),PNEW(1),CNEW(1)
C
C     COMMON BLOCKS
C
      COMMON/FDBUG/IODBUG,ITRACE,IDBALL,NDEBUG,IDEBUG(20)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcinit_cox/RCS/cox11.f,v $
     . $',                                                             '
     .$Id: cox11.f,v 1.1 1995/09/17 18:47:09 dws Exp $
     . $' /
C    ===================================================================
C
C
C     CHECK TRACE LEVEL--FOR THIS SUBROUTINE=1
C
      IF(ITRACE.GE.1)WRITE(IODBUG,900)
  900 FORMAT(1H0,16H** COX11 ENTERED)
C
C     CHECK TO SEE IF DEBUG OUTPUT IS NEEDED
C
      IBUG=0
      IF(IDBALL.GT.0)IBUG=1
      IF(NDEBUG.EQ.0)GO TO 12
      DO 10 I=1,NDEBUG
      IF(IDEBUG(I).EQ.11)GO TO 11
   10 CONTINUE
      GO TO 12
   11 IBUG=1
   12 NC=POLD(16)
      NQLST=16+2*NC-1
      NLNEW=PNEW(16)
      NLOLD=POLD(16)
      NQNST=17+NLNEW
      NQOST=17+NLOLD
      NLNM1=NLNEW-1
      NLNM2=NLNEW-2
      NLOM1=NLOLD-1
      NLOM2=NLOLD-2
      IF(IBUG.EQ.0)GO TO 100
      WRITE(IODBUG,901)
  901 FORMAT(1H0,10X,20HOLD CARRYOVER VALUES)
      WRITE(IODBUG,902)(COLD(I),I=1,NLOLD)
  902 FORMAT(1H0,1X,14(F8.3,1X))
C
C     CHECK TO SEE IF THE NUMBER OF LAYERS IS THE SAME
C
  100 IF(NLNEW.NE.NLOLD)GO TO 300
      IF(NLNEW.EQ.1)GO TO 103
C
C     CHECK TO SEE IF FLOW LIMITS ARE THE SAME
C
      IERFLG=0
      DO 141 I=1,NLNM1
      DIFF=ABS(POLD(NQOST+I-1)-PNEW(NQOST+I-1))
      IF(DIFF.LT.0.0001)GO TO 141
      IERFLG=1
  141 CONTINUE
      IF(IERFLG.EQ.1)GO TO 300
C
C     APPLY COEFFICIENT ADJUSTMENT
C
  103 DO 102 I=1,NLOLD
      IF(POLD(16+I).GT.0.999)GO TO 102
      CNEW(I)=COLD(I)*(1.-PNEW(16+I))/(1.-POLD(16+I))
  102 CONTINUE
      GO TO 999
  300 IF(NLOLD.GT.1)GO TO 310
      CNEW(1)=COLD(1)
      GO TO 999
  310 IF(NLNEW.GT.1)GO TO 320
      COVER=0.
      DO 311 I=1,NLOLD
      IF(POLD(16+I).GT.0.999)GO TO 311
      COVER=COVER+COLD(I)*(1.-PNEW(17))/(1.-POLD(16+I))
  311 CONTINUE
      CNEW(1)=COVER
      GO TO 999
  320 LAYERB=1
      DO 400 I=1,NLNEW
      IF(LAYERB.EQ.NLOLD)GO TO 999
      IF(I.LT.NLNEW)GO TO 307
      J=NLOLD
      GO TO 342
  307 DO 341 J=LAYERB,NLOLD
      IF(J.EQ.NLOLD)GO TO 342
      IF(J.GT.1)GO TO 343
      IF(PNEW(NQNST+I-1).LE.POLD(NQOST))GO TO 342
      GO TO 341
  343 IF((PNEW(NQNST+I-1).LE.POLD(NQOST+J-1)).AND.
     1(PNEW(NQNST+I-1).GT.POLD(NQOST+J-2))) GO TO 342
  341 CONTINUE
  342 LAYERT=J
      IF(LAYERT.NE.LAYERB)GO TO 350
      IF(LAYERB.NE.1)GO TO 351
      DIFOLD=POLD(NQOST)
      IF(I.EQ.1)GO TO 352
      DIFNEW=PNEW(NQNST+I-1)-PNEW(NQNST+I-2)
      GO TO 401
  352 DIFNEW=PNEW(NQNST)
      GO TO 401
  351 DIFOLD=POLD(NQOST+LAYERB-1)-POLD(NQOST+LAYERB-2)
      DIFNEW=PNEW(NQNST+I-1)-PNEW(NQNST+I-2)
  401 IF(POLD(16+LAYERT).GT.0.999)GO TO 602
      CNEW(I)=COLD(LAYERT)*DIFNEW*(1.-PNEW(16+I))/DIFOLD/
     1(1.-POLD(16+LAYERT))
  602 CONTINUE
      GO TO 399
  350 COVER=0.
      DO 450 J=LAYERB,LAYERT
      IF(LAYERB.EQ.NLOLD)GO TO 999
      IF(J.GT.LAYERB)GO TO 360
      IF(LAYERB.EQ.1)GO TO 361
      DIFOLD=POLD(NQOST+J-1)-POLD(NQOST+J-2)
      GO TO 362
  361 DIFOLD=POLD(NQOST)
  362 IF(I.GT.1)GO TO 363
      IF(POLD(16+J).GT.0.999)GO TO 603
      COVER=COVER+COLD(1)*(1.-PNEW(17))/(1.-POLD(16+J))
  603 GO TO 451
  363 DIFNEW=POLD(NQOST+J-1)-PNEW(NQNST+I-2)
      IF(POLD(16+J).GT.0.999)GO TO 604
      COVER=COVER+COLD(J)*(1.-PNEW(16+I))/(1.-POLD(16+J))*DIFNEW/DIFOLD
  604 GO TO 451
  360 IF(J.EQ.LAYERT)GO TO 370
      IF(POLD(16+J).GT.0.999)GO TO 605
      COVER=COVER+COLD(J)*(1.-PNEW(16+I))/(1.-POLD(16+J))
  605 GO TO 451
  370 IF(I.LT.NLNEW)GO TO 380
      IF(POLD(16+J).GT.0.999)GO TO 606
      COVER=COVER+COLD(J)*(1.-PNEW(16+I))/(1.-POLD(16+J))
  606 GO TO 451
  380 IF(J.LT.NLOLD)GO TO 381
      IF(POLD(16+J).GT.0.999)GO TO 607
      COVER=COVER+COLD(I)*(1.-PNEW(16+I))/(1.-POLD(16+J))
  607 GO TO 451
  381 DIFOLD=POLD(NQOST+J-1)-POLD(NQOST+J-2)
      DIFNEW=PNEW(NQNST+I-1)-POLD(NQOST+J-2)
      IF(POLD(16+J).GT.0.999)GO TO 451
      COVER=COVER+COLD(J)*(1.-PNEW(16+I))*DIFNEW/(1.-POLD(16+J))/DIFOLD
  451 CONTINUE
  450 CNEW(I)=COVER
  399 LAYERB=LAYERT
  400 CONTINUE
  999 IF(IBUG.EQ.0)GO TO 998
      WRITE(IODBUG,920)
  920 FORMAT(1H0,10X,20HNEW CARRYOVER VALUES)
      WRITE(IODBUG,902)(CNEW(I),I=1,NLNEW)
  998 RETURN
      END
