      SUBROUTINE W3FI82_SUB (IFLD,FVAL1,FDIFF1,NPTS,PDS,IGDS)
C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:  W3FI82        CONVERT TO SECOND DIFF ARRAY
C   PRGMMR: CAVANAUGH        ORG: NMC421      DATE:93-08-18
C
C ABSTRACT: ACCEPT AN INPUT ARRAY, CONVERT TO ARRAY OF SECOND
C   DIFFERENCES.  RETURN THE ORIGINAL FIRST VALUE AND THE FIRST
C   FIRST-DIFFERENCE AS SEPARATE VALUES. ALIGN DATA IN
C   BOUSTREPHEDONIC STYLE, (ALTERNATE ROW REVERSAL).
C
C PROGRAM HISTORY LOG:
C   93-07-14  CAVANAUGH
C   94-01-27  CAVANAUGH   ADDED REVERSAL OF EVEN NUMBERED ROWS
C                         (BOUSTROPHEDONIC PROCESSING)
C   94-03-02  CAVANAUGH   CORRECTED IMPROPER ORDERING OF EVEN
C                         NUMBERED ROWS
C   99-12-06  EBISUZAKI   LINUX PORT
C
C USAGE:    CALL W3FI82 (IFLD,FVAL1,FDIFF1,NPTS,PDS,IGDS)
C   INPUT ARGUMENT LIST:
C     IFLD     - INTEGER INPUT ARRAY
C     NPTS     - NUMBER OF POINTS IN ARRAY
C     IGDS(5)  - NUMBER OF ROWS IN ARRAY
C     IGDS(4)  - NUMBER OF COLUMNS IN ARRAY
C     PDS(8)   - FLAG INDICATING PRESENCE OF GDS SECTION
C
C   OUTPUT ARGUMENT LIST:
C     IFLD     - SECOND DIFFERENCED FIELD
C     FVAL1    - FLOATING POINT ORIGINAL FIRST VALUE
C     FDIFF1   -     "      "   FIRST FIRST-DIFFERENCE
C
C REMARKS: LIST CAVEATS, OTHER HELPFUL HINTS OR INFORMATION
C
C ATTRIBUTES:
C   LANGUAGE: IBM370 VS FORTRAN 77, CRAY CFT77 FORTRAN
C   MACHINE:  HDS, CRAY C916-128, CRAY Y-MP8/864, CRAY Y-MP EL2/256
C
C$$$
C
      REAL        FVAL1,FDIFF1
C
      INTEGER     IFLD(*),NPTS,NBOUST(300),IGDS(*)
C
      CHARACTER*1 PDS(*)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob81/ohd/pproc/src/gribit_sub/RCS/w3fi82.f,v $
     . $',                                                             '
     .$Id: w3fi82.f,v 1.1 2006/10/19 16:06:04 dsa Exp $
     . $' /
C    ===================================================================
C
C
C  ---------------------------------------------
C                  TEST FOR PRESENCE OF GDS
C
c looks like an error      CALL GBYTE(PDS,IQQ,56,8)
      call gbytec(PDS,IQQ,56,1)
      IF (IQQ.NE.0) THEN
          NROW  = IGDS(5)
          NCOL  = IGDS(4)
C
C      LAY OUT DATA BOUSTROPHEDONIC STYLE
C
C         PRINT*, '  DATA SET UP BOUSTROPHEDON'
C
          DO 210 I = 2, NROW, 2
C
C          REVERSE THE EVEN NUMBERED ROWS
C
              DO 200 J = 1, NCOL
                  NPOS  = I * NCOL - J + 1
                  NBOUST(J) = IFLD(NPOS)
  200         CONTINUE
              DO 201 J = 1, NCOL
                  NPOS  = NCOL * (I-1) + J
                  IFLD(NPOS)  = NBOUST(J)
  201         CONTINUE
  210     CONTINUE
C
C
      END IF
C  =================================================================
          DO 4000 I = NPTS, 2, -1
              IFLD(I)  = IFLD(I) - IFLD(I-1)
 4000     CONTINUE
          DO 5000 I = NPTS, 3, -1
              IFLD(I)  = IFLD(I) - IFLD(I-1)
 5000     CONTINUE
C
C                      SPECIAL FOR GRIB
C                         FLOAT OUTPUT OF FIRST POINTS TO ANTICIPATE
C                         GRIB FLOATING POINT OUTPUT
C
          FVAL1    = IFLD(1)
          FDIFF1   = IFLD(2)
C
C       SET FIRST TWO POINTS TO SECOND DIFF VALUE FOR BETTER PACKING
C
          IFLD(1)  = IFLD(3)
          IFLD(2)  = IFLD(3)
C  -----------------------------------------------------------
      RETURN
      END
