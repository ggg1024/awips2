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
#include <Xm/TextF.h>
#include <Xm/CascadeBG.h>
#include <Xm/LabelG.h>


Widget adjustDS = (Widget) NULL;
Widget adjustFO = (Widget) NULL;
Widget aflistFR = (Widget) NULL;
Widget aflistFO = (Widget) NULL;
Widget aflistLA = (Widget) NULL;
Widget aflistSW = (Widget) NULL;
Widget aflistHSB = (Widget) NULL;
Widget aflistVSB = (Widget) NULL;
Widget aflistLI = (Widget) NULL;
Widget afequationLA = (Widget) NULL;
Widget afcontentsLA = (Widget) NULL;
Widget afitemFR = (Widget) NULL;
Widget afitemFO = (Widget) NULL;
Widget afitem_locLA = (Widget) NULL;
Widget afitem_locTE = (Widget) NULL;
Widget afitem_durOM = (Widget) NULL;
Widget afitem_durLA = (Widget) NULL;
Widget afitem_durCB = (Widget) NULL;
Widget afitem_durPDM = (Widget) NULL;
Widget afitem_tsOM = (Widget) NULL;
Widget afitem_tsLA = (Widget) NULL;
Widget afitem_tsCB = (Widget) NULL;
Widget afitem_tsPDM = (Widget) NULL;
Widget afitem_extOM = (Widget) NULL;
Widget afitem_extLA = (Widget) NULL;
Widget afitem_extCB = (Widget) NULL;
Widget afitem_extPDM = (Widget) NULL;
Widget afitem_peLA = (Widget) NULL;
Widget afitem_peSW = (Widget) NULL;
Widget afitem_peHSB = (Widget) NULL;
Widget afitem_peVSB = (Widget) NULL;
Widget afitem_peLI = (Widget) NULL;
Widget afdivisorLA = (Widget) NULL;
Widget afdivisorTE = (Widget) NULL;
Widget afbaseLA = (Widget) NULL;
Widget afbaseTE = (Widget) NULL;
Widget afmultiplierLA = (Widget) NULL;
Widget afmultiplierTE = (Widget) NULL;
Widget afadderLA = (Widget) NULL;
Widget afadderTE = (Widget) NULL;
Widget afitemLA = (Widget) NULL;
Widget adjustsepSE = (Widget) NULL;
Widget adjust_applyPB = (Widget) NULL;
Widget adjust_cancelPB = (Widget) NULL;
Widget adjust_deletePB = (Widget) NULL;



void create_adjustDS (Widget parent)
{
	Widget children[15];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNwidth, 645); ac++;
	XtSetArg(al[ac], XmNheight, 705); ac++;
	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "Data Adjustment Factors"); ac++;
	XtSetArg(al[ac], XmNminWidth, 645); ac++;
	XtSetArg(al[ac], XmNminHeight, 705); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 645); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 705); ac++;
	XtSetArg(al[ac], XmNbaseWidth, 645); ac++;
	XtSetArg(al[ac], XmNbaseHeight, 705); ac++;
	adjustDS = XmCreateDialogShell ( parent, "adjustDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 645); ac++;
	XtSetArg(al[ac], XmNheight, 705); ac++;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	adjustFO = XmCreateForm ( adjustDS, "adjustFO", al, ac );
	ac = 0;
	aflistFR = XmCreateFrame ( adjustFO, "aflistFR", al, ac );
	aflistFO = XmCreateForm ( aflistFR, "aflistFO", al, ac );
	XtSetArg(al[ac], XmNwidth, 510); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Location  PE  Dur  TS  Ext         Divisor           Base     Multiplier          Adder", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	aflistLA = XmCreateLabel ( aflistFO, "aflistLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNautomaticSelection, TRUE); ac++;
	XtSetArg(al[ac], XmNselectionPolicy, XmBROWSE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmAS_NEEDED); ac++;
	XtSetArg(al[ac], XmNlistSizePolicy, XmCONSTANT); ac++;
	aflistLI = XmCreateScrolledList ( aflistFO, "aflistLI", al, ac );
	ac = 0;
	aflistSW = XtParent ( aflistLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &aflistHSB); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &aflistVSB); ac++;
	XtGetValues(aflistSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 1); ac++;
	XtSetArg(al[ac], XmNmappedWhenManaged, FALSE); ac++;
	XtSetValues ( aflistHSB,al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNautomaticSelection, TRUE); ac++;
	XtSetArg(al[ac], XmNselectionPolicy, XmBROWSE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmAS_NEEDED); ac++;
	XtSetArg(al[ac], XmNlistSizePolicy, XmCONSTANT); ac++;
	XtSetValues ( aflistLI,al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNheight, 305); ac++;
	XtSetValues ( aflistSW,al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Adjusted Value = (((Raw Value / Divisor) + Base) * Multiplier) + Adder", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afequationLA = XmCreateLabel ( aflistFO, "afequationLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNchildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Summary by Location of Data Adjustment Factors", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afcontentsLA = XmCreateLabel ( aflistFR, "afcontentsLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	afitemFR = XmCreateFrame ( adjustFO, "afitemFR", al, ac );
	afitemFO = XmCreateForm ( afitemFR, "afitemFO", al, ac );
	xmstrings[0] = XmStringCreateLtoR ( "Location:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_END); ac++;
	afitem_locLA = XmCreateLabel ( afitemFO, "afitem_locLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	XtSetArg(al[ac], XmNcolumns, 8); ac++;
	afitem_locTE = XmCreateText ( afitemFO, "afitem_locTE", al, ac );
	ac = 0;
	XmTextSetString ( afitem_locTE, "" );
	XtSetArg(al[ac], XmNspacing, 10); ac++;
	xmstrings[0] = XmStringCreateLtoR("Duration:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afitem_durOM = XmCreateOptionMenu ( afitemFO, "afitem_durOM", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	afitem_durLA = XmOptionLabelGadget ( afitem_durOM );
	afitem_durCB = XmOptionButtonGadget ( afitem_durOM );
	afitem_durPDM = XmCreatePulldownMenu ( afitem_durOM, "afitem_durPDM", al, ac );
	XtSetArg(al[ac], XmNspacing, 10); ac++;
	xmstrings[0] = XmStringCreateLtoR("TypeSource:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afitem_tsOM = XmCreateOptionMenu ( afitemFO, "afitem_tsOM", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	afitem_tsLA = XmOptionLabelGadget ( afitem_tsOM );
	afitem_tsCB = XmOptionButtonGadget ( afitem_tsOM );
	afitem_tsPDM = XmCreatePulldownMenu ( afitem_tsOM, "afitem_tsPDM", al, ac );
	XtSetArg(al[ac], XmNspacing, 10); ac++;
	xmstrings[0] = XmStringCreateLtoR("Extremum:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afitem_extOM = XmCreateOptionMenu ( afitemFO, "afitem_extOM", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	afitem_extLA = XmOptionLabelGadget ( afitem_extOM );
	afitem_extCB = XmOptionButtonGadget ( afitem_extOM );
	afitem_extPDM = XmCreatePulldownMenu ( afitem_extOM, "afitem_extPDM", al, ac );
	xmstrings[0] = XmStringCreateLtoR ( "Physical Element:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	afitem_peLA = XmCreateLabel ( afitemFO, "afitem_peLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNautomaticSelection, FALSE); ac++;
	XtSetArg(al[ac], XmNselectionPolicy, XmSINGLE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmAS_NEEDED); ac++;
	XtSetArg(al[ac], XmNlistSizePolicy, XmCONSTANT); ac++;
	afitem_peLI = XmCreateScrolledList ( afitemFO, "afitem_peLI", al, ac );
	ac = 0;
	afitem_peSW = XtParent ( afitem_peLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &afitem_peHSB); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &afitem_peVSB); ac++;
	XtGetValues(afitem_peSW, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNautomaticSelection, FALSE); ac++;
	XtSetArg(al[ac], XmNselectionPolicy, XmSINGLE_SELECT); ac++;
	XtSetArg(al[ac], XmNscrollBarDisplayPolicy, XmAS_NEEDED); ac++;
	XtSetArg(al[ac], XmNlistSizePolicy, XmCONSTANT); ac++;
	XtSetValues ( afitem_peLI,al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 275); ac++;
	XtSetArg(al[ac], XmNheight, 123); ac++;
	XtSetValues ( afitem_peSW,al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Divisor:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	afdivisorLA = XmCreateLabel ( afitemFO, "afdivisorLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	afdivisorTE = XmCreateTextField ( afitemFO, "afdivisorTE", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Base:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	afbaseLA = XmCreateLabel ( afitemFO, "afbaseLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	afbaseTE = XmCreateTextField ( afitemFO, "afbaseTE", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Multiplier:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	afmultiplierLA = XmCreateLabel ( afitemFO, "afmultiplierLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	afmultiplierTE = XmCreateTextField ( afitemFO, "afmultiplierTE", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR ( "Adder:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	XtSetArg(al[ac], XmNalignment, XmALIGNMENT_BEGINNING); ac++;
	afadderLA = XmCreateLabel ( afitemFO, "afadderLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNmaxLength, 8); ac++;
	afadderTE = XmCreateTextField ( afitemFO, "afadderTE", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNchildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Selected Item", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	afitemLA = XmCreateLabel ( afitemFR, "afitemLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	adjustsepSE = XmCreateSeparator ( adjustFO, "adjustsepSE", al, ac );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Update/Insert", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	adjust_applyPB = XmCreatePushButton ( adjustFO, "adjust_applyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Close", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	adjust_cancelPB = XmCreatePushButton ( adjustFO, "adjust_cancelPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR ( "Delete", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG );
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	adjust_deletePB = XmCreatePushButton ( adjustFO, "adjust_deletePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );


	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -375); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -640); ac++;
	XtSetValues ( aflistFR,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 380); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -640); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -640); ac++;
	XtSetValues ( afitemFR,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 645); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -660); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -640); ac++;
	XtSetValues ( adjustsepSE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 665); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -700); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 245); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -400); ac++;
	XtSetValues ( adjust_applyPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 665); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -700); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 20); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -175); ac++;
	XtSetValues ( adjust_cancelPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 665); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -700); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 455); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -610); ac++;
	XtSetValues ( adjust_deletePB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -20); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( aflistLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 20); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -305); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( aflistSW,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 315); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -335); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -625); ac++;
	XtSetValues ( afequationLA,al, ac );
	ac = 0;
	XtManageChild(aflistLI);
	children[ac++] = aflistLA;
	children[ac++] = afequationLA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = aflistFO;
	children[ac++] = afcontentsLA;
	XtManageChildren(children, ac);
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 40); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( afitem_locLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 0); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 120); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( afitem_locTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 42); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 35); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( afitem_durOM,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 82); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( afitem_tsOM,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 122); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 23); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( afitem_extOM,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 0); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -25); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 400); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -560); ac++;
	XtSetValues ( afitem_peLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 25); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -155); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 400); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -620); ac++;
	XtSetValues ( afitem_peSW,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 170); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -190); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 30); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -140); ac++;
	XtSetValues ( afdivisorLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 190); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -225); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 30); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -140); ac++;
	XtSetValues ( afdivisorTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 170); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -190); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 180); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -290); ac++;
	XtSetValues ( afbaseLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 190); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -225); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 180); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -290); ac++;
	XtSetValues ( afbaseTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 170); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -190); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 330); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -440); ac++;
	XtSetValues ( afmultiplierLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 190); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -225); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 330); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -440); ac++;
	XtSetValues ( afmultiplierTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 170); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -190); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 480); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -590); ac++;
	XtSetValues ( afadderLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 190); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -225); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 480); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -590); ac++;
	XtSetValues ( afadderTE,al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNsubMenuId, afitem_durPDM); ac++;
	XtSetValues(afitem_durCB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNsubMenuId, afitem_tsPDM); ac++;
	XtSetValues(afitem_tsCB, al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNsubMenuId, afitem_extPDM); ac++;
	XtSetValues(afitem_extCB, al, ac );
	ac = 0;
	XtManageChild(afitem_peLI);
	children[ac++] = afitem_locLA;
	children[ac++] = afitem_locTE;
	children[ac++] = afitem_durOM;
	children[ac++] = afitem_tsOM;
	children[ac++] = afitem_extOM;
	children[ac++] = afitem_peLA;
	children[ac++] = afdivisorLA;
	children[ac++] = afdivisorTE;
	children[ac++] = afbaseLA;
	children[ac++] = afbaseTE;
	children[ac++] = afmultiplierLA;
	children[ac++] = afmultiplierTE;
	children[ac++] = afadderLA;
	children[ac++] = afadderTE;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = afitemFO;
	children[ac++] = afitemLA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = aflistFR;
	children[ac++] = afitemFR;
	children[ac++] = adjustsepSE;
	children[ac++] = adjust_applyPB;
	children[ac++] = adjust_cancelPB;
	children[ac++] = adjust_deletePB;
	XtManageChildren(children, ac);
	ac = 0;
}

