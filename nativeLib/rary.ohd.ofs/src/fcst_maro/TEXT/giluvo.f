C MEMBER GILUVO
C  (from old member PPGILUVO)
C
C                             LAST UPDATE: 04/12/95.12:21:27 BY $WC20SV
C
C @PROCESS LVL(77)
C
      SUBROUTINE GILUVO
C
C.....THIS ROUTINE IS USED PRIMARILY TO FILL THE REMAINDER OF THE
C.....IMPORTANT COMMON BLOCKS USED BY THE MARO FUNCTION.  THE COMMON
C.....BLOCKS ARE FILLED PRIMARILY FROM TECHNIQUES.
C
C.....ORIGINALLY WRITTEN BY:
C
C.....JERRY M. NUNN     WGRFC, FT. WORTH, TEXAS     MARCH 22, 1988
C
      INCLUDE 'gcommon/explicit'
      DIMENSION SNAME(2), BLNKID(2), IARG(60), USERID(2), WORK(100)
      DIMENSION TNAME(2), TNPF(2), TNSF(4)
C
      INCLUDE 'common/where'
      INCLUDE 'common/ionum'
      INCLUDE 'common/errdat'
      INCLUDE 'common/killcd'
      INCLUDE 'common/pudbug'
      INCLUDE 'common/fctime'
      INCLUDE 'gcommon/gdispl'
      INCLUDE 'gcommon/boxtrc'
      INCLUDE 'gcommon/gboxot'
      INCLUDE 'gcommon/gmdr'
      INCLUDE 'gcommon/gsize'
      INCLUDE 'gcommon/gopt'
      INCLUDE 'udebug'
      INCLUDE 'udsi'
      INCLUDE 'scommon/sudbgx'
C
C
C.....'HARD WIRE' IN THE COMMON BLOCK /HDFLTS/.  WE NEED TO EXTRACT
C.....TWO VARIABLES FROM IT...AND INSERT THEM INTO /FCTIME/.
C
      COMMON /HDFLTS/ NDFLTS(25)
C
C    ================================= RCS keyword statements ==========
      CHARACTER*68     RCSKW1,RCSKW2
      DATA             RCSKW1,RCSKW2 /                                 '
     .$Source: /fs/hseb/ob72/rfc/ofs/src/fcst_maro/RCS/giluvo.f,v $
     . $',                                                             '
     .$Id: giluvo.f,v 1.1 1995/09/17 19:01:49 dws Exp $
     . $' /
C    ===================================================================
C
C
      DATA SNAME, BLNKID /4HGILU, 4HVO  , 2*4H    /
      DATA CPALL, BLANK, USER /4HALL , 4H    , 4HUSER/
      DATA IAPI, IRNF, IP24 /4HAPIG, 4HGRNF, 4HPG24/
      DATA TNPF, TNSF /4HAPIM, 4HAPIR, 4HAX  , 4HIN  , 4HCMIN, 4HEC  /
C
  900 FORMAT(1H0, '*** ROUTINE GILUVO ENTERED ***')
  901 FORMAT(1H0, '*** EXIT ROUTINE GILUVO ***')
  902 FORMAT(1H0, '*** ERROR ***  STATUS CODE OF ', I4, ' ENCOUNTERED IN
     * ROUTINE HGTSTR', /, 5X, 'WHILE PROCESSING PREPROCESSOR DEBUG ',
     *'CODE NO. ', I4, '. PROCESSING CONTINUES.')
  903 FORMAT(1H0, '*** ERROR ***  STATUS CODE OF ', I4, ' ENCOUNTERED IN
     * ROUTINE HGTSTR', /, 5X, 'WHILE PROCESSING BOXDUMP CODE NO. ',
     * I4, '. PROCESSING CONTINUES.')
  904 FORMAT(1H0, '** FATAL ERROR **  CANNOT INITIALIZE PPDB READ/WRITE
     *ROUTINES')
  905 FORMAT(1H0, '** FATAL ERROR **  CANNOT INITIALIZE PPPDB READ/WRITE
     * ROUTINES')
  906 FORMAT(1H0, '** FATAL ERROR **  THE ABOVE ERROR IS FATAL')
  907 FORMAT(1H0, 'RETURNED FROM RPPREC -- FILE TYPE = ', A4, ' STATUS C
     *ODE = ', I4)
  908 FORMAT(1H0, 'DATA FROM USER PARAMETRIC ARRAY IS AS FOLLOWS:', //,
     * 6X, 'PPUSER = ', 2A4, 3X, 'BGNG SUMMER AND WINTER MONTHS = ', I4,
     * ' AND', I4, //, 6X, 'BGNG MDR COL AND NO. OF COLS = ', I4,
     * ' AND', I4, 3X, 'BGNG MDR ROW AND NO. OF ROWS = ', I4, ' AND',
     * I4, //, 6X, 'PRECIP, TEMP, AND PE DIST WT EXPONENTS = ', 3F5.2,
     * 3X, 'SMALL PRECIP AMT = ', F5.2, //, 6X, 'NO. OF MDR SQUARES IN S
     *YSTEM = ', I5)
  909 FORMAT(1H0, 'OTHER USER DATA IS AS FOLLOWS:', //, 6X,
     * 'CONVECTIVE OPTION = ', I4, 3X, 'CONVECTIVE DISTANCE = ', F7.2,
     * //, 6X, 'ALAT = ', F7.2, 3X, 'SF = ', F7.2, 3X, 'DGRID = ', F7.2,
     * 3X, 'CVDISW = ', F9.4)
  910 FORMAT(1H0, 'NO. OF FULL WORDS IN PARAMETER ARRAY = ', I5,
     * 3X, 'NEXT POINTER = ', I5)
  911 FORMAT(1H0, 'RETURN CODE FROM PPPDB READ/WRITE CONTROL VARIABLE RE
     *TRIEVE ROUTINE IS ', I4)
  912 FORMAT(1H0, 'USER PARAMETRIC ARRAY ', /, 2X, F5.2, 2X, 2A4, 6F8.3,
     * /, 2X, 4F7.2, 2F10.2, /, 2X, 9F7.2, 2X, A4, 2X, /, 2X,
     * 6F10.4)
  913 FORMAT(1H0, '*** WARNING ***  TECHNIQUE VALUE OF 0 HAS BEEN ASSIGN
     *ED TO TECHNIQUE NAME ', 2A4, /, 6X, 'THIS VALUE MUST BE 1 AND HAS
     *BEEN RE-SET TO 1.  THE ARGUMENT IS SET TO ', F10.3)
  914 FORMAT(1H0, '*** WARNING *** TECHNIQUE CONVEC HAS ARGUMENT CNVDIS
     * OUTSIDE OF THE PERMISSIBLE RANGE.', /, 5X, 'THE PERMISSIBLE RANGE
     * IS FROM ', F5.1, ' TO ', F5.1, ' MILES. THE VALUE OF CNVDIS ENTER
     *ED IS ', F10.1, ' MILES.', /, 5X, 'THE VALUE OF CNVDIS HAS BEEN CH
     *ANGED TO ', F5.1, ' MILES. PROCESSING CONTINUES.')
C
      INCLUDE 'gcommon/setwhere'
C
      IF(IPTRCE .GT. 0) WRITE(IOPDBG,900)
C
C.....SET THE LOCAL TIME OFFSET AND TIME ZONE NUMBER OF LOCAL
C.....STANDARD TIME. GET THESE VALUES FROM /HDFLTS/, AND INSERT THEM
C.....INTO /FCTIME/.
C
      LOCAL = NDFLTS(22)
      NLSTZ = NDFLTS(23)
C
C.....BEGIN PROCESSING TECHNIQUES AND THEIR ARGUMENTS (IF ANY).
C.....FILL THE APPROPRIATE COMMON BLOCKS.
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....TIMING TECHNIQUES. FILL COMMON BLOCK FCTIME.
C
      CALL HPASTA('STARTRUN ', 60, ISTRUN, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'STARTRUN ')
      IDARUN = IARG(1)/24 + 1
      IHRRUN = IARG(1) - IDARUN*24 + 24
      IF(IHRRUN .EQ. 24) GOTO 90
      IHRRUN = 24
      IDARUN = IDARUN - 1
C
   90 CALL HPASTA('ENDRUN  ', 60, IENRUN, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'ENDRUN  ')
      LDARUN = IARG(1)/24 + 1
      LHRRUN = IARG(1) - LDARUN*24 + 24
      IF(LHRRUN .EQ. 0) GOTO 100
      LHRRUN = 24
      GOTO 110
C
  100 LDARUN = LDARUN - 1
      LHRRUN = 24
C
  110 CALL HPASTA('LSTCMPDY', 60, LSTOBS, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'LSTCMPDY')
      LDACPD = IARG(1)/24 + 1
      LHRCPD = IARG(1) - LDACPD*24 + 24
      IF(LHRCPD .NE. 0) GOTO 120
      LDACPD = LDACPD - 1
      LHRCPD = 24
C
  120 CALL HPAST('NOUTZ   ', NOUTZ, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'NOUTZ   ')
      CALL FTEKCK(NOUTZ, 'NOUTZ   ', 0, NOUTZ, -12, 12)
C
      CALL HPAST('NOUTDS  ', NOUTDS, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'NOUTDS  ')
      CALL FTEKCK(NOUTDS, 'NOUTDS  ', 0, NOUTDS, 0, 1)
C
C.....ROUTINE FSETNW FILLS THE PORTION OF THE FCTIME COMMON BLOCK
C.....THAT CONTAINS THE ARRAY 'NOW'.
C
      CALL FSETNW
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....FILL THE PUNCH UNIT (COMMON BLOCK IONUM).
C
      CALL HPAST('PUNCH   ', IPU, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PUNCH   ')
      CALL FTEKCK(IPU, 'PUNCH   ', 7, IPU, 7, 7)
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....GET THE DEBUG CODES FOR COMMON BLOCKS PUDBUG AND BOXTRC
C
      CALL HPASTA('PPDEBUG ', 60, IPDBG, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PPDEBUG ')
C
      NDBUG = 0
      IPALL = 0
C
      DO 150 NP = 1, 20
      CALL HGTSTR(1, IARG(1 + (NP-1)*3), CODE, NWORDS, ISTATC)
      IF(ISTATC .EQ. 0) GOTO 130
      WRITE(IPR,902) ISTATC, NP
      CALL ERROR
C
  130 IF(CODE .EQ. BLANK) GOTO 150
      IF(CODE .NE. CPALL) GOTO 140
      IPALL = 1
      GOTO 160
C
  140 NDBUG = NDBUG + 1
      PDBUG(NDBUG) = CODE
  150 CONTINUE
C
  160 CALL HPASTA('BOXDEBUG', 60, IBXDB, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'BOXDEBUG')
C
      CALL FTEKCK(IBXDB, 'BOXDEBUG', 0, IBXDB, 0, 1)
C
      NBXDBG = 0
C
      DO 170 NP = 1, 20
      IF(IARG(NP) .LE. 0) GOTO 170
      NBXDBG = NBXDBG + 1
      NTRBOX(NBXDBG) = IARG(NP)
  170 CONTINUE
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....GET OUTPUT OPTIONS FOR COMMON BLOCKS GBOXOT...GOPT...GSIZE...AND
C.....GDISPL.
C
      CALL HPASTA('BOXDUMP ', 60, IPRTBX, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'BOXDUMP ')
C
      NBXDSP = 0
C
      DO 190 NP = 1, 20
      IF(IARG(NP) .LE. 0) GOTO 190
      NBXDSP = NBXDSP + 1
      MPTBOX(NBXDSP) = IARG(NP)
  190 CONTINUE
C
      CALL HPASTA('BOXDKEY ', 60, JBXKEY, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'BOXDKEY ')
C
      NUPCPN = 0
      NUMAPI = 0
      NURNOF = 0
C
      DO 240 NP = 1, 3
      CALL HGTSTR(1, IARG(1+(NP-1)*3), IDUMP, NWORDS, ISTATC)
      IF(ISTATC .EQ. 0) GOTO 200
      WRITE(IPR,903) ISTATC, NP
      CALL ERROR
C
  200 IF(IDUMP .EQ. IAPI) GOTO 210
      IF(IDUMP .EQ. IRNF) GOTO 220
      IF(IDUMP .EQ. IP24) GOTO 230
      GOTO 240
C
  210 NUMAPI = NUMAPI + 1
      GOTO 240
C
  220 NURNOF = NURNOF + 1
      GOTO 240
C
  230 NUPCPN = NUPCPN + 1
C
  240 CONTINUE
C
      CALL HPAST('PAGESIZE', IFPAGE, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PAGESIZE')
      CALL FTEKCK(IFPAGE, 'PAGESIZE', 85, IFPAGE, 50, 88)
C
      CALL HPAST('PGSZMARO', NPAGE, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PGSZMARO')
      CALL FTEKCK(NPAGE, 'PGSZMARO', 30, NPAGE, 25, 36)
C
      CALL HPAST('PLOTPP24', IPLT24, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PLOTPP24')
      CALL FTEKCK(IPLT24, 'PLOTPP24', 0, IPLT24, 0, 2)
C
      CALL HPAST('PRTMARO ', MAROPT, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTMARO ')
      CALL FTEKCK(MAROPT, 'PRTMARO ', 0, MAROPT, 0, 1)
C
      CALL HPAST('PRTMDR  ', MDRPRT, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTMDR  ')
      CALL FTEKCK(MDRPRT, 'PRTMDR  ', 0, MDRPRT, 0, 2)
C
      CALL HPAST('PRTMDR6 ', MDRPR6, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTMDR6 ')
      CALL FTEKCK(MDRPR6, 'PRTMDR6 ', 0, MDRPR6, 0, 1)
C
      CALL HPAST('PRTPP6  ', IPRT6, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTPP6  ')
      CALL FTEKCK(IPRT6, 'PRTPP6  ', 0, IPRT6, 0, 1)
C
      CALL HPAST('PRTPP24 ', IPRT24, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTPP24 ')
      CALL FTEKCK(IPRT24, 'PRTPP24 ', 0, IPRT24, 0, 2)
C
      CALL HPAST('PRTPPZRO', IPRZRO, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PRTPPZRO')
      CALL FTEKCK(IPRZRO, 'PRTPPZRO', 0, IPRZRO, 0, 1)
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....FILL UP THE MDR USAGE TECHNIQUES -- THESE GO IN COMMON BLOCK
C.....NAMED /GMDR/.
C
      CALL HPASTA('MDREST24', 60, MDRSTA, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'MDREST24')
C
      CALL UMEMOV(IARG(1), SPCP, 1)
      ISMALL = SPCP*100. + 0.5
C
      CALL HPAST('FTWMDRDS', MDRST6, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'FTWMDRDS')
      CALL FTEKCK(MDRST6, 'FTWMDRDS', 0, MDRST6, 0, 1)
C
      CALL HPAST('MDREST6 ', MD6EST, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'MDREST6 ')
      CALL FTEKCK(MD6EST, 'MDREST6 ', 0, MD6EST, 0, 1)
C
      CALL HPAST('MDRTABLE', IUSTBL, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'MDRTABLE')
      CALL FTEKCK(IUSTBL, 'MDRTABLE', 0, IUSTBL, 0, 70)
C
      MDRUST = 0
      IF(IUSTBL .GT. 0) MDRUST = 1
C
C.....SET MDR FLAG...DEPENDING UPON MDR ESTIMATION LEVEL(S) ASKED FOR.
C
      MDR = 0
      IF(MDRSTA .GT. 0) MDR = 1
      IF(MDRST6 .GT. 0) MDR = 1
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....PRECIPITATION ESTIMATION TECHNIQUES...FILL IN COMMON BLOCKS
C.....NAMED /GOPT/ AND /GSIZE/.
C
      CALL HPASTA('CONVEC  ', 60, ICONVC, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'CONVEC  ')
C
      CALL UMEMOV(IARG(1), CNVDIS, 1)
C
      CALL HPAST('ESTFTW  ', IADJQP, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'ESTFTW  ')
      CALL FTEKCK(IADJQP, 'ESTFTW  ', 2, IADJQP, 0, 2)
C
      CALL HPAST('NOEST6HR', NOEST6, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'NOEST6HR')
      CALL FTEKCK(NOEST6, 'NOEST6HR', 1, NOEST6, 0, 1)
C
      CALL HPAST('NUMQDT  ', NUMQDT, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'NUMQDT  ')
      CALL FTEKCK(NUMQDT, 'NUMQDT  ', 1, NUMQDT, 1, 10)
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....QPF RUN TECHNIQUE ... FILL IN THE QPF RUN FLAG AND THE
C.....SIX-HOURLY DISTRIBUTION FACTORS IN COMMON BLOCK /GOPT/.
C
      CALL HPASTA('FTWQPF  ', 60, KQPFRN, NWORDS, IARG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'FTWQPF  ')
C
      DO 245 NP = 1, 4
      KQPFD(NP) = IARG(NP)
  245 CONTINUE
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....API-RUNOFF COMPUTATION TECHNIQUES -- FILL THE INFORMATION IN
C.....COMMON BLOCK /GOPT/.
C
C.....NOTE:  THE TECHNIQUE VALUES OF APIMAX, APIMIN, APIRCMIN, AND
C.....APIREC MUST ALWAYS BE SET TO 1.
C
      CALL HPASTA('APIMAX  ', 60, IAPMX, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APIMAX  ')
C
      CALL UMEMOV(IARG(1), APIMAX, 1)
      IF(IAPMX .EQ. 1) GOTO 250
      TNAME(1) = TNPF(1)
      TNAME(2) = TNSF(1)
      WRITE(IPR,913) TNAME, APIMAX
      IAPMX = 1
      CALL WARN
C
  250 CALL HPASTA('APIMIN  ', 60, IAPMN, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APIMIN  ')
C
      CALL UMEMOV(IARG(1), APIMIN, 1)
      IF(IAPMN .EQ. 1) GOTO 260
      TNAME(1) = TNPF(1)
      TNAME(2) = TNSF(2)
      WRITE(IPR,913) TNAME, APIMIN
      IAPMN = 1
      CALL WARN
C
  260 CALL HPASTA('APIRCMIN', 60, IAPRCM, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APIRCMIN')
C
      CALL UMEMOV(IARG(1), APIMNR, 1)
      IF(IAPRCM .EQ. 1) GOTO 270
      TNAME(1) = TNPF(2)
      TNAME(2) = TNSF(3)
      WRITE(IPR,913) TNAME, APIMNR
      IAPRCM = 1
      CALL WARN
C
  270 CALL HPASTA('APIREC  ', 60, IAPREC, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APIREC  ')
C
      CALL UMEMOV(IARG(1), REC, 1)
      IF(IAPREC .EQ. 1) GOTO 275
      TNAME(1) = TNPF(2)
      TNAME(2) = TNSF(4)
      WRITE(IPR,913) TNAME, REC
      IAPREC = 1
      CALL WARN
C
  275 NRCSET = 0
      IF(REC .GT. 0.50) NRCSET = 1
C
      CALL HPASTA('APISCON ', 60, IAPISC, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APISCON ')
C
      CALL UMEMOV(IARG(1), APIDEC, 1)
C
      CALL HPASTA('DUR     ', 60, IAPREC, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'DUR     ')
C
      CALL UMEMOV(IARG(1), DUR, 1)
C
      NDRSET = 0
      IF(DUR .GT. 0.0) NDRSET = 1
C
      CALL HPAST('WKLAG   ', NWLAG, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'WKLAG   ')
      CALL FTEKCK(NWLAG, 'WKLAG   ', 4, NWLAG, 1, 26)
C
      CALL HPASTA('APISET  ', 60, IRUN, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'APISET  ')
C
      CALL UMEMOV(IARG(1), APIV, 1)
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....NOW GET THE TECHNIQUE VALUES FOR UNITS...WARNING MESSAGES...AND
C.....MOD RUNTIME TECHNIQUES...THESE ARE CURRENTLY FILLED UP IN
C.....COMMON BLOCK /GDISPL/.
C
C
      CALL HPAST('METRIC  ', METRIC, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'METRIC  ')
      CALL FTEKCK(METRIC, 'METRIC  ', 0, METRIC, 0, 1)
C
      CALL HPASTA('MODTZC  ', 60, JMODTZ, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'MODTZC  ')
C
      CALL HGTSTR(1, IARG(1), IMTZC, NWORDS, ISTATC)
C
      CALL HPAST('MODUNITS', MUNITS, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'MODUNITS')
      CALL FTEKCK(MUNITS, 'MODUNITS', 2, MUNITS, 0, 2)
C
      CALL HPAST('MODWARN ', IPMWMS, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'MODWARN ')
      CALL FTEKCK(IPMWMS, 'MODWARN ', 1, IPMWMS, 0, 1)
C
C * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
C
C.....NOW PROCESS PRECIPITATION LIMITS AND WRITE TECHNIQUES...THESE
C.....PLACED IN COMMON BLOCK /GSIZE/.
C
      CALL HPASTA('PP24MAX ', 60, JPPMAX, NWORDS, IARG, ISTATC)
      IF(ISTATC .EQ. 0) CALL FPHPWN(ISTATC, 'PP24MAX ')
C
      CALL UMEMOV(IARG(1), PMAX, 1)
      KPMAX = PMAX*100. + 0.5
      IF(KPMAX .LE. 0) GOTO 277
      MAXPCP = KPMAX
      MAXPC6 = KPMAX
C
  277 CALL HPAST('PP24TIME', IPTCHK, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'PP24TIME')
      CALL FTEKCK(IPTCHK, 'PP24TIME', 0, IPTCHK, 0, 1)
C
      CALL HPAST('WTEST24 ', IWTEST, ISTATC)
      IF(ISTATC .NE. 0) CALL FPHPWN(ISTATC, 'WTEST24 ')
      CALL FTEKCK(IWTEST, 'WTEST24 ', 1, IWTEST, 0, 1)
C
C.....INITIALIZE THE PPDB READ/WRITE CONTROL VARIABLES.
C
      CALL RPPDCO(ISTATC)
      IF(ISTATC .EQ. 0) GOTO 280
      WRITE(IPR,904)
      CALL ERROR
      CALL KILLFN(8HMARO    )
      GOTO 999
C
C.....NOW INITIALIZE THE PPPDB READ/WRITE CONTROL VAIRABLES.
C
  280 CALL RPPPCO(ISTATC)
      IF(IPTRCE .GE. 3) WRITE(IOPDBG,911) ISTATC
      IF(ISTATC .EQ. 0) GOTO 290
      WRITE(IPR,905)
      CALL ERROR
      CALL KILLFN(8HMARO    )
      GOTO 999
C
C
C.....NOW READ THE SINGLE-RECORD FILE OF USER PARAMETERS.
C
  290 IPTR = 0
      USERID(1) = BLNKID(1)
      USERID(2) = BLNKID(2)
C
      IBUG = IPBUG(USER)
C
      CALL RPPREC(USERID, USER, IPTR, NWORK, WORK(1), NFILL, IPTNXT,
     * ISTATC)
C
      IF(IBUG .EQ. 1) WRITE(IOPDBG,907) USER, ISTATC
      IF(IBUG .EQ. 1) WRITE(IOPDBG,910) NFILL, IPTNXT
C
      IF(ISTATC .EQ. 0) GOTO 300
C
      CALL PSTRDC(ISTATC, USER, USERID, IPTR, NWORK, NFILL)
      WRITE(IPR,906)
      CALL KILLFN(8HMARO    )
      GOTO 999
C
  300 IF(IBUG .EQ. 1) WRITE(IOPDBG,912) (WORK(KP), KP = 1, NFILL)
C
C.....NOW REMOVE THE NEEDED VALUES FROM THE USER RECORD AND STORE THEM
C.....IN THEIR LOCAL2 VARIABLES.
C
      PPUSER(1) = WORK(2)
      PPUSER(2) = WORK(3)
      IMOSUM    = WORK(4)
      IMOWTR    = WORK(5)
      ICMDR     = WORK(6)
      NCMDR     = WORK(7)
      IRMDR     = WORK(8)
      NRMDR     = WORK(9)
      PCEXP     = WORK(20)
      TPEXP     = WORK(21)
      PEEXP     = WORK(22)
      SMALL     = WORK(23)
      NMDR      = NCMDR*NRMDR
      IF(IBUG .EQ. 1) WRITE(IOPDBG,908) PPUSER, IMOSUM, IMOWTR, ICMDR,
     * NCMDR, IRMDR, NRMDR, PCEXP, TPEXP, PEEXP, SMALL, NMDR
C
C.....COMPUTE OTHER COMMON BLOCK VARIABLES, SUCH AS CONVECTIVE DISTANCE
C.....WEIGHT.
C
      IF(ICONVC .EQ. 0) GOTO 320
C
      ALAT   = (WORK(10) + WORK(11))*0.5
      SF     = 1.866/(1.0 + SIN(ALAT*0.01745))
      DGRID  = (CNVDIS*1.61*SF)/0.47625
      CVDISW = 1.0/(DGRID*DGRID)
      IF(IBUG .EQ. 1) WRITE(IOPDBG,909) ICONVC, CNVDIS, ALAT, SF,
     * DGRID, CVDISW
      GOTO 320
C
C
C
C.....NOW 'HARD-WIRE' CERTAIN VARIABLES. THESE VARIABLES SPECIFY THAT
C.....CERTAIN TECHNIQUES CAN TAKE ON DIFFERENT VALUES...WHEN IN REALITY
C.....THESE TECHNIQUES CAN ASSUME ONLY ONE VALUE.
C
  320 IF(ICONVC .EQ. 0) ICONVC = 1
      IF(NOEST6 .EQ. 0) NOEST6 = 1
      IF(METRIC .EQ. 1) METRIC = 0
      IF(NURNOF .GE. 0) NURNOF = 0
      IF(IWTEST .EQ. 0) IWTEST = 1
C
C.....IF THE CONVECTIVE DISTANCE IS NOT BETWEEN THE MINIMUM AND THE
C.....MAXIMUM ALLOWABLE DISTANCES...SET A VALUE FOR IT. THE VALUE TO
C.....SET WILL BE EITHER THE MINIMUM OR THE MAXIMUM DISTANCE, DEPENDING
C.....ON WHICH ONE OF THESE PARAMETERS THE CONVECTIVE DISTANCE IS
C.....CLOSEST TO.
C
      IF(CNVDIS .GE. CVMIN) GOTO 330
      CV = CNVDIS
      CNVDIS = CVMIN
      GOTO 340
C
  330 IF(CNVDIS .LE. CVMAX) GOTO 999
      CV = CNVDIS
      CNVDIS = CVMAX
C
  340 WRITE(IPR,914) CVMIN, CVMAX, CV, CNVDIS
      CALL WARN
C
  999 IF(IPTRCE .GT. 0) WRITE(IOPDBG,901)
C
      RETURN
      END
