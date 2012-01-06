/*
** Generated by X-Designer
*/
/*
**LIBS: -lXm -lXt -lX11
*/

#include <stdlib.h>
#include <X11/Xatom.h>
#include <X11/Intrinsic.h>
#include <X11/Shell.h>

#include <Xm/Xm.h>
#include <Xm/DialogS.h>
#include <Xm/Form.h>
#include <Xm/Frame.h>
#include <Xm/Label.h>
#include <Xm/List.h>
#include <Xm/PushB.h>
#include <Xm/RowColumn.h>
#include <Xm/ScrollBar.h>
#include <Xm/Separator.h>
#include <Xm/Text.h>
#include <Xm/CascadeBG.h>
#include <Xm/LabelG.h>


Widget hgstationDS = (Widget) NULL;
Widget hgstationFO = (Widget) NULL;
Widget hgstationFR = (Widget) NULL;
Widget hgslistFO = (Widget) NULL;
Widget hgslistLA = (Widget) NULL;
Widget hgslistSW = (Widget) NULL;
Widget hgslistHSB = (Widget) NULL;
Widget hgslistVSB = (Widget) NULL;
Widget hgslistLI = (Widget) NULL;
Widget hgsummaryLA = (Widget) NULL;
Widget hgsitemFR = (Widget) NULL;
Widget hgsitemFO = (Widget) NULL;
Widget hgsitem_locLA = (Widget) NULL;
Widget hgsitem_locTE = (Widget) NULL;
Widget hgsitem_tsOM = (Widget) NULL;
Widget hgsitem_tsLA = (Widget) NULL;
Widget hgsitem_tsCB = (Widget) NULL;
Widget hgsitem_tsPDM = (Widget) NULL;
Widget hgsitem_fcsttsOM = (Widget) NULL;
Widget hgsitem_fcsttsLA = (Widget) NULL;
Widget hgsitem_fcsttsCB = (Widget) NULL;
Widget hgsitem_fcsttsPDM = (Widget) NULL;
Widget hgsitem_peLA = (Widget) NULL;
Widget hgsitem_peSW = (Widget) NULL;
Widget hgsitem_peHSB = (Widget) NULL;
Widget hgsitem_peVSB = (Widget) NULL;
Widget hgsitem_peLI = (Widget) NULL;
Widget hgsitemLA = (Widget) NULL;
Widget hgssepSE = (Widget) NULL;
Widget hgs_applyPB = (Widget) NULL;
Widget hgs_closePB = (Widget) NULL;
Widget hgs_deletePB = (Widget) NULL;



void create_hgstationDS (Widget parent)
{
	Widget children[6];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XtPointer tmp_value;             /* ditto */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNwidth, 645); ac++;
	XtSetArg(al[ac], XmNheight, 630); ac++;
	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "HydroGen Configuration"); ac++;
	XtSetArg(al[ac], XmNminWidth, 645); ac++;
	XtSetArg(al[ac], XmNminHeight, 630); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 645); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 630); ac++;
	XtSetArg(al[ac], XmNbaseWidth, 645); ac++;
	XtSetArg(al[ac], XmNbaseHeight, 630); ac++;
	hgstationDS = XmCreateDialogShell ( parent, (char *) "hgstationDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 645); ac++;
	XtSetArg(al[ac], XmNheight, 630); ac++;
	XtSetArg(al[ac], XmNresizePolicy, XmRESIZE_NONE); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	hgstationFO = XmCreateForm ( hgstationDS, (char *) "hgstationFO", al, ac );
	ac = 0;
	hgstationFR = XmCreateFrame ( hgstationFO, (char *) "hgstationFR", al, ac );
	hgslistFO = XmCreateForm ( hgstationFR, (char *) "hgslistFO", al, ac );
	XtSetArg(al[ac], XmNwidth, 510); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Location    HSA    PE     TS    Forecast TS", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	hgslistLA = XmCreateLabel ( hgslistFO, (char *) "hgslistLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNautomaticSelection, XmAUTO_SELECT); ac++;
	XtSetArg(al[ac], XmNselectionPolicy, XmBROWSE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmAS_NEEDED); ac++;
	XtSetArg(al[ac], XmNlistSizePolicy, XmCONSTANT); ac++;
	hgslistLI = XmCreateScrolledList ( hgslistFO, (char *) "hgslistLI", al, ac );
	ac = 0;
	hgslistSW = XtParent ( hgslistLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &hgslistHSB); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &hgslistVSB); ac++;
	XtGetValues(hgslistSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 1); ac++;
	XtSetArg(al[ac], XmNmappedWhenManaged, FALSE); ac++;
	if (hgslistHSB)
		XtSetValues ( hgslistHSB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 305); ac++;
	if (hgslistSW)
		XtSetValues ( hgslistSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNframeChildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Summary by Location of HgStation", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgsummaryLA = XmCreateLabel ( hgstationFR, (char *) "hgsummaryLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNheight, 200); ac++;
	hgsitemFR = XmCreateFrame ( hgstationFO, (char *) "hgsitemFR", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 200); ac++;
	hgsitemFO = XmCreateForm ( hgsitemFR, (char *) "hgsitemFO", al, ac );
	ac = 0;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Location:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	hgsitem_locLA = XmCreateLabel ( hgsitemFO, (char *) "hgsitem_locLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	XtSetArg(al[ac], XmNcolumns, 9); ac++;
	hgsitem_locTE = XmCreateText ( hgsitemFO, (char *) "hgsitem_locTE", al, ac );
	ac = 0;
	XmTextSetString(hgsitem_locTE, "");
	XtSetArg(al[ac], XmNspacing, 10); ac++;
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	xmstrings[0] = XmStringGenerate((XtPointer) "TypeSource:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	xmstrings[0] = XmStringCreateLtoR("TypeSource:", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgsitem_tsOM = XmCreateOptionMenu ( hgsitemFO, (char *) "hgsitem_tsOM", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	hgsitem_tsLA = XmOptionLabelGadget ( hgsitem_tsOM );
	hgsitem_tsCB = XmOptionButtonGadget ( hgsitem_tsOM );
	hgsitem_tsPDM = XmCreatePulldownMenu ( hgsitem_tsOM, (char *) "hgsitem_tsPDM", al, ac );
	XtSetArg(al[ac], XmNwidth, 188); ac++;
	XtSetArg(al[ac], XmNheight, 33); ac++;
	if (hgsitem_tsCB)
		XtSetValues ( hgsitem_tsCB, al, ac );
	ac = 0;
#if       ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20))
	xmstrings[0] = XmStringGenerate((XtPointer) "Forecast TypeSource:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL);
#else  /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	xmstrings[0] = XmStringCreateLtoR("Forecast TypeSource:", (XmStringCharSet) XmFONTLIST_DEFAULT_TAG);
#endif /* ((XmVERSION > 1) && (XmREVISION == 1) && (XmUPDATE_LEVEL < 20)) */
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgsitem_fcsttsOM = XmCreateOptionMenu ( hgsitemFO, (char *) "hgsitem_fcsttsOM", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	hgsitem_fcsttsLA = XmOptionLabelGadget ( hgsitem_fcsttsOM );
	hgsitem_fcsttsCB = XmOptionButtonGadget ( hgsitem_fcsttsOM );
	hgsitem_fcsttsPDM = XmCreatePulldownMenu ( hgsitem_fcsttsOM, (char *) "hgsitem_fcsttsPDM", al, ac );
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Physical Elements:", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgsitem_peLA = XmCreateLabel ( hgsitemFO, (char *) "hgsitem_peLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	hgsitem_peLI = XmCreateScrolledList ( hgsitemFO, (char *) "hgsitem_peLI", al, ac );
	hgsitem_peSW = XtParent ( hgsitem_peLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &hgsitem_peHSB); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &hgsitem_peVSB); ac++;
	XtGetValues(hgsitem_peSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNframeChildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Selected Item", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgsitemLA = XmCreateLabel ( hgsitemFR, (char *) "hgsitemLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	hgssepSE = XmCreateSeparator ( hgstationFO, (char *) "hgssepSE", al, ac );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Save", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgs_applyPB = XmCreatePushButton ( hgstationFO, (char *) "hgs_applyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Close", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgs_closePB = XmCreatePushButton ( hgstationFO, (char *) "hgs_closePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringGenerate ( (XtPointer) "Delete", XmFONTLIST_DEFAULT_TAG, XmCHARSET_TEXT, NULL );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	hgs_deletePB = XmCreatePushButton ( hgstationFO, (char *) "hgs_deletePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -312); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -640); ac++;
	XtSetValues ( hgstationFR, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 318); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -540); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 3); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -642); ac++;
	XtSetValues ( hgsitemFR, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 546); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -561); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 6); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -641); ac++;
	XtSetValues ( hgssepSE, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 570); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -605); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 40); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -195); ac++;
	XtSetValues ( hgs_applyPB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 570); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -605); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 435); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -590); ac++;
	XtSetValues ( hgs_closePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 570); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -605); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 235); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -390); ac++;
	XtSetValues ( hgs_deletePB, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -20); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( hgslistLA, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 20); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -279); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -622); ac++;
	XtSetValues ( hgslistSW, al, ac );
	ac = 0;
	if (hgslistLI != (Widget) 0) { XtManageChild(hgslistLI); }
	if ((children[ac] = hgslistLA) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = hgslistFO) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsummaryLA) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 4); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -36); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 46); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -114); ac++;
	XtSetValues ( hgsitem_locLA, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 4); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -34); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 116); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -194); ac++;
	XtSetValues ( hgsitem_locTE, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 48); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -90); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 42); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -378); ac++;
	XtSetValues ( hgsitem_tsOM, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -40); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 245); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( hgsitem_fcsttsOM, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 102); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -126); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 42); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -180); ac++;
	XtSetValues ( hgsitem_peLA, al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 102); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -186); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 186); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -426); ac++;
	XtSetValues ( hgsitem_peSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNsubMenuId, hgsitem_tsPDM); ac++;
	XtSetValues(hgsitem_tsCB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNsubMenuId, hgsitem_fcsttsPDM); ac++;
	XtSetValues(hgsitem_fcsttsCB, al, ac );
	ac = 0;
	if (hgsitem_peLI != (Widget) 0) { XtManageChild(hgsitem_peLI); }
	if ((children[ac] = hgsitem_locLA) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitem_locTE) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitem_tsOM) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitem_fcsttsOM) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitem_peLA) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = hgsitemFO) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitemLA) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
	if ((children[ac] = hgstationFR) != (Widget) 0) { ac++; }
	if ((children[ac] = hgsitemFR) != (Widget) 0) { ac++; }
	if ((children[ac] = hgssepSE) != (Widget) 0) { ac++; }
	if ((children[ac] = hgs_applyPB) != (Widget) 0) { ac++; }
	if ((children[ac] = hgs_closePB) != (Widget) 0) { ac++; }
	if ((children[ac] = hgs_deletePB) != (Widget) 0) { ac++; }
	if (ac > 0) { XtManageChildren(children, ac); }
	ac = 0;
}

