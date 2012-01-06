      SUBROUTINE PK_SECT6(KFILDO,IB,NXY,IPACK,ND5,LOCN,IPOS,
     1                    IS6,NS6,IPKOPT,L3264B,IER,ISEVERE,*)
C
C        MARCH    2000   GLAHN   TDL   FOR GRIB2
C        JANUARY  2001   GLAHN   COMMENTS; ADDED CHECK ON SIZE OF
C                                IS5( ) AND ON IS6(5) = 6
C        JANUARY  2001   GLAHN/LAWRENCE COMMNETS; REMOVED IS6(5) = 6
C        MARCH    2001   LAWRENCE REMOVED TEST THAT DETERMINES WHETHER
C                        OR NOT SECTION 6 IS LARGE ENOUGH TO CONTAIN
C                        THE ENTIRE BIT-MAP.  SECTION 6 NEED ONLY BE
C                        6 OCTETS LARGE.  THE BITMAP IS STORED IN 
C                        IB( ).
C        NOVEMBER 2001   GLAHN   REVERSED ORDER OF IER = 601 AND 602  
C
C        PURPOSE
C            PACKS SECTION 6, THE BIT MAP SECTION, OF A GRIB2 MESSAGE.
C
C        DATA SET USE
C           KFILDO - UNIT NUMBER FOR OUTPUT (PRINT) FILE. (OUTPUT)
C
C        VARIABLES
C              KFILDO = UNIT NUMBER FOR OUTPUT (PRINT) FILE. (INPUT)
C               IB(J) = BIT MAP TO PACK (J=1,NXY).  (INPUT)
C                 NXY = THE NUMBER OF VALUES IN IB( ).  (INPUT)
C            IPACK(J) = THE ARRAY THAT HOLDS THE ACTUAL PACKED MESSAGE
C                       (J=1,ND5). (INPUT/OUTPUT)
C                 ND5 = THE SIZE OF THE ARRAY IPACK( ). (INPUT)
C                LOCN = THE WORD POSITION TO PLACE THE NEXT VALUE.
C                       (INPUT/OUTPUT)
C                IPOS = THE BIT POSITION IN LOCN TO START PLACING
C                       THE NEXT VALUE. (INPUT/OUTPUT)
C              IS6(J) = CONTAINS THE BIT MAP INFORMATION 
C                       CORRESPONDING TO SECTION 6 OF GRIB2 (J=1,NS6).
C                       (INPUT/OUTPUT)
C                 NS6 = SIZE OF IS6( ). (INPUT)
C              IPKOPT = PACKING INDICATOR:
C                       0 = ERROR, DON'T PACK
C                       1 = PACK IA( ), SIMPLE
C                       2 = PACK IA( ) AND IB( ), SIMPLE
C                       3 = PACK COMPLEX OR SPATIAL DIFFERENCING
C                       4 = PACK COMPLEX.
C                       (OUTPUT)
C              L3264B = THE INTEGER WORD LENGTH IN BITS OF THE MACHINE
C                       BEING USED. VALUES OF 32 AND 64 ARE
C                       ACCOMMODATED. (INPUT)
C                 IER = RETURN STATUS CODE. (OUTPUT)
C                         0 = GOOD RETURN.
C                       1-4 = ERROR CODES GENERATED BY PKBG. SEE
C                             THE DOCUMENTATION IN THE PKBG
C                             ROUTINE.
C                       601 = IS6(5) DOES NOT INDICATE SECTION 6.
C                       602 = IS6( ) HAS NOT BEEN DIMENSIONED LARGE 
C                             ENOUGH TO CONTAIN SECTION 6.
C             ISEVERE = THE SEVERITY LEVEL OF THE ERROR.  THE ONLY
C                       VALUE RETUNED IS:
C                       2 = A FATAL ERROR  (OUTPUT)
C                   * = ALTERNATE RETURN WHEN IER NE 0.
C
C             LOCAL VARIABLES
C                   N = L3264B = THE INTEGER WORD LENGTH IN BITS OF
C                       THE MACHINE BEING USED. VALUES OF 32 AND
C                       64 ARE ACCOMMODATED.
C               IZERO = 0.
C               IFILL = NUMBER OF BITS NECESSARY TO FILL OUT AN OCTET.
C             LOCN6_1 = THE WORD POSITION TO STORE THE LENGTH
C                       OF SECTION 6 INTO.
C             IPOS6_1 = THE BIT POSITION IN LOCN6_1 TO STORE THE
C                       LENGTH OF SECTION 6 INTO.
C
C        NON SYSTEM SUBROUTINES CALLED
C           PK_BMAP,PKBG
C
      DIMENSION IPACK(ND5),IS6(NS6)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/util/src/grib2packer/RCS/pk_sect6.f,v $
     . $',                                                             '
     .$Id: pk_sect6.f,v 1.1 2004/09/16 16:52:29 dsa Exp $
     . $' /
C    ===================================================================
C
C
      DATA IZERO/0/
C
      N=L3264B
      IER=0
C
C        ALL ERRORS GENERATED BY THIS ROUTINE ARE FATAL.
      ISEVERE=2
C
C        THE LENGTH OF THE MANDATORY SECTION IS 6 OCTETS.
C
      IF(NS6.LT.6)THEN
         IER=602
         GO TO 900
      ENDIF
C
      IF(IS6(5).NE.6)THEN
C           A SECTION 6 IS REQUIRED EVEN THOUGH THERE IS NO BITMAP.
         IER=601
         GO TO 900
      ENDIF
C
C        SAVE THE WORD AND BIT POSITIONS TO PACK THE TOTAL LENGTH
C        OF SECTION 6 INTO. 
      LOCN6_1=LOCN
      IPOS6_1=IPOS
      CALL PKBG(KFILDO,IPACK,ND5,LOCN,IPOS,IZERO,32,N,IER,*900)
C
C        PACK THE SECTION NUMBER.
      CALL PKBG(KFILDO,IPACK,ND5,LOCN,IPOS,IS6(5),8,N,IER,*900)
C
C        PACK THE BIT-MAP INDICATOR
      CALL PKBG(KFILDO,IPACK,ND5,LOCN,IPOS,IS6(6),8,N,IER,*900)
C
      IF(IPKOPT.EQ.2)THEN
C           PACK THE BIT MAP.
         CALL PK_BMAP(KFILDO,IB,NXY,IPACK,ND5,LOCN,IPOS,
     1                L3264B,IER,*900)
      ENDIF
C
C        PAD WITH ZEROS TO FILL OUT AN OCTET, IF NECESSARY.
C
      IFILL=MOD(33-IPOS,8)
C
      IF(IFILL.NE.0)THEN
         CALL PKBG(KFILDO,IPACK,ND5,LOCN,IPOS,IZERO,IFILL,N,IER,*900)
      ENDIF
C
      IS6(1)=LENGTH(KFILDO,IPACK,ND5,N,LOCN6_1,IPOS6_1,LOCN,
     1              IPOS,IER)
C***D     WRITE(KFILDO,800)LOCN6_1,IPOS6_1,LOCN,IPOS,LENTGH
C***D800  FORMAT(/' IN PK_SECT6 AT 800--LOCN6_1,IPOS6_1,LOCN,IPOS,LENTGH',
C***D    1       5I9)
C
C        ERROR RETURN SECTION
C
 900  IF(IER.NE.0)RETURN 1
C
      RETURN
      END
