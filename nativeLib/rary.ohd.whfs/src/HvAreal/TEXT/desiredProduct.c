/*
** Generated by X-Designer 
*/
/*
**LIBS: -lXm -lXt -lX11
*/

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
#include <Xm/ToggleBG.h>


Widget desiredProductDS = (Widget) NULL;
Widget desiredProductFO = (Widget) NULL;
Widget dp_closePB = (Widget) NULL;
Widget dp_controlSE = (Widget) NULL;
Widget dp_absFR = (Widget) NULL;
Widget dp_absFO = (Widget) NULL;
Widget dp_absSL = (Widget) NULL;
Widget dp_absHSB = (Widget) NULL;
Widget dp_absVSB = (Widget) NULL;
Widget dp_absLI = (Widget) NULL;
Widget dp_absRB = (Widget) NULL;
Widget dp_absActiveTB = (Widget) NULL;
Widget dp_absInactiveTB = (Widget) NULL;
Widget dp_absEndHourLA = (Widget) NULL;
Widget dp_absEndHourTE = (Widget) NULL;
Widget dp_absDurLA = (Widget) NULL;
Widget dp_absDurTE = (Widget) NULL;
Widget dp_absLookbackHoursLA = (Widget) NULL;
Widget dp_absLookbackHoursTE = (Widget) NULL;
Widget dp_absApplyPB = (Widget) NULL;
Widget dp_absDeletePB = (Widget) NULL;
Widget do_absControlSE = (Widget) NULL;
Widget dp_absLILA = (Widget) NULL;
Widget dp_absFRLA = (Widget) NULL;
Widget dp_relFR = (Widget) NULL;
Widget dp_relFO = (Widget) NULL;
Widget dp_relSL = (Widget) NULL;
Widget dp_relHSB = (Widget) NULL;
Widget dp_relVSB = (Widget) NULL;
Widget dp_relLI = (Widget) NULL;
Widget dp_relEndHourOffsetTE = (Widget) NULL;
Widget dp_relDurTE = (Widget) NULL;
Widget dp_relEndHourOffsetLA = (Widget) NULL;
Widget dp_relDurLA = (Widget) NULL;
Widget dp_relRB = (Widget) NULL;
Widget dp_relActiveTB = (Widget) NULL;
Widget dp_relInactiveTB = (Widget) NULL;
Widget dp_relApplyPB = (Widget) NULL;
Widget dp_relDeletePB = (Widget) NULL;
Widget dp_relSE = (Widget) NULL;
Widget dp_relLILA = (Widget) NULL;
Widget dp_relFRLA = (Widget) NULL;
Widget dp_resultFR = (Widget) NULL;
Widget dp_resultFO = (Widget) NULL;
Widget dp_resultSL = (Widget) NULL;
Widget dp_resultHSB = (Widget) NULL;
Widget dp_resultVSB = (Widget) NULL;
Widget dp_resultLI = (Widget) NULL;
Widget dp_resultLILA = (Widget) NULL;
Widget dp_resultFRLA = (Widget) NULL;



void create_desiredProductDS (parent)
Widget parent;
{
	Widget children[12];      /* Children to manage */
	Arg al[64];                    /* Arg List */
	register int ac = 0;           /* Arg Count */
	XmString xmstrings[16];    /* temporary storage for XmStrings */

	XtSetArg(al[ac], XmNallowShellResize, TRUE); ac++;
	XtSetArg(al[ac], XmNtitle, "Desired Product Settings"); ac++;
	XtSetArg(al[ac], XmNminWidth, 750); ac++;
	XtSetArg(al[ac], XmNminHeight, 900); ac++;
	XtSetArg(al[ac], XmNmaxWidth, 750); ac++;
	XtSetArg(al[ac], XmNmaxHeight, 900); ac++;
	desiredProductDS = XmCreateDialogShell ( parent, "desiredProductDS", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNautoUnmanage, FALSE); ac++;
	desiredProductFO = XmCreateForm ( desiredProductDS, "desiredProductFO", al, ac );
	ac = 0;
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR("Close", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_closePB = XmCreatePushButton ( desiredProductFO, "dp_closePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_controlSE = XmCreateSeparator ( desiredProductFO, "dp_controlSE", al, ac );
	dp_absFR = XmCreateFrame ( desiredProductFO, "dp_absFR", al, ac );
	dp_absFO = XmCreateForm ( dp_absFR, "dp_absFO", al, ac );
	XtSetArg(al[ac], XmNlistSizePolicy, XmRESIZE_IF_POSSIBLE); ac++;
	dp_absLI = XmCreateScrolledList ( dp_absFO, "dp_absLI", al, ac );
	ac = 0;
	dp_absSL = XtParent ( dp_absLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &dp_absHSB ); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &dp_absVSB ); ac++;
	XtGetValues(dp_absSL, al, ac );
	ac = 0;
	dp_absRB = XmCreateRadioBox ( dp_absFO, "dp_absRB", al, ac );
	xmstrings[0] = XmStringCreateLtoR("Active", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absActiveTB = XmCreateToggleButtonGadget ( dp_absRB, "dp_absActiveTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR("Inactive", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absInactiveTB = XmCreateToggleButtonGadget ( dp_absRB, "dp_absInactiveTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR("End Hour:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absEndHourLA = XmCreateLabel ( dp_absFO, "dp_absEndHourLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_absEndHourTE = XmCreateText ( dp_absFO, "dp_absEndHourTE", al, ac );
	xmstrings[0] = XmStringCreateLtoR("Duration (hours):", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absDurLA = XmCreateLabel ( dp_absFO, "dp_absDurLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_absDurTE = XmCreateText ( dp_absFO, "dp_absDurTE", al, ac );
	xmstrings[0] = XmStringCreateLtoR("Hours to Look Back:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absLookbackHoursLA = XmCreateLabel ( dp_absFO, "dp_absLookbackHoursLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_absLookbackHoursTE = XmCreateText ( dp_absFO, "dp_absLookbackHoursTE", al, ac );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR("Apply", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absApplyPB = XmCreatePushButton ( dp_absFO, "dp_absApplyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR("Delete", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absDeletePB = XmCreatePushButton ( dp_absFO, "dp_absDeletePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	do_absControlSE = XmCreateSeparator ( dp_absFO, "do_absControlSE", al, ac );
	xmstrings[0] = XmStringCreateLtoR("End Hour       Duration      LookBack    Activity", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absLILA = XmCreateLabel ( dp_absFO, "dp_absLILA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNchildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringCreateLtoR("Hour Settings", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_absFRLA = XmCreateLabel ( dp_absFR, "dp_absFRLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_relFR = XmCreateFrame ( desiredProductFO, "dp_relFR", al, ac );
	dp_relFO = XmCreateForm ( dp_relFR, "dp_relFO", al, ac );
	XtSetArg(al[ac], XmNlistSizePolicy, XmRESIZE_IF_POSSIBLE); ac++;
	dp_relLI = XmCreateScrolledList ( dp_relFO, "dp_relLI", al, ac );
	ac = 0;
	dp_relSL = XtParent ( dp_relLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &dp_relHSB ); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &dp_relVSB ); ac++;
	XtGetValues(dp_relSL, al, ac );
	ac = 0;
	dp_relEndHourOffsetTE = XmCreateText ( dp_relFO, "dp_relEndHourOffsetTE", al, ac );
	dp_relDurTE = XmCreateText ( dp_relFO, "dp_relDurTE", al, ac );
	xmstrings[0] = XmStringCreateLtoR("Hour Offset:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relEndHourOffsetLA = XmCreateLabel ( dp_relFO, "dp_relEndHourOffsetLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR("Duration (hours):", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relDurLA = XmCreateLabel ( dp_relFO, "dp_relDurLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNorientation, XmVERTICAL); ac++;
	dp_relRB = XmCreateRadioBox ( dp_relFO, "dp_relRB", al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR("Active", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relActiveTB = XmCreateToggleButtonGadget ( dp_relRB, "dp_relActiveTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	xmstrings[0] = XmStringCreateLtoR("Inactive", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relInactiveTB = XmCreateToggleButtonGadget ( dp_relRB, "dp_relInactiveTB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR("Apply", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relApplyPB = XmCreatePushButton ( dp_relFO, "dp_relApplyPB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNwidth, 85); ac++;
	XtSetArg(al[ac], XmNheight, 35); ac++;
	xmstrings[0] = XmStringCreateLtoR("Delete", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relDeletePB = XmCreatePushButton ( dp_relFO, "dp_relDeletePB", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_relSE = XmCreateSeparator ( dp_relFO, "dp_relSE", al, ac );
	xmstrings[0] = XmStringCreateLtoR("End Time (Hours Ago)   Duration    Activity", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relLILA = XmCreateLabel ( dp_relFO, "dp_relLILA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNchildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringCreateLtoR("Hour Offset Settings", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_relFRLA = XmCreateLabel ( dp_relFR, "dp_relFRLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	dp_resultFR = XmCreateFrame ( desiredProductFO, "dp_resultFR", al, ac );
	dp_resultFO = XmCreateForm ( dp_resultFR, "dp_resultFO", al, ac );
	XtSetArg(al[ac], XmNlistSizePolicy, XmRESIZE_IF_POSSIBLE); ac++;
	dp_resultLI = XmCreateScrolledList ( dp_resultFO, "dp_resultLI", al, ac );
	ac = 0;
	dp_resultSL = XtParent ( dp_resultLI );

	XtSetArg(al[ac], XmNhorizontalScrollBar, &dp_resultHSB ); ac++;
	XtSetArg(al[ac], XmNverticalScrollBar, &dp_resultVSB ); ac++;
	XtGetValues(dp_resultSL, al, ac );
	ac = 0;
	xmstrings[0] = XmStringCreateLtoR("Duration(hours)   End Time", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_resultLILA = XmCreateLabel ( dp_resultFO, "dp_resultLILA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );
	XtSetArg(al[ac], XmNchildType, XmFRAME_TITLE_CHILD); ac++;
	xmstrings[0] = XmStringCreateLtoR("Desired Products:", (XmStringCharSet)XmFONTLIST_DEFAULT_TAG);
	XtSetArg(al[ac], XmNlabelString, xmstrings[0]); ac++;
	dp_resultFRLA = XmCreateLabel ( dp_resultFR, "dp_resultFRLA", al, ac );
	ac = 0;
	XmStringFree ( xmstrings [ 0 ] );

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 860); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 365); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_closePB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 835); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -850); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -740); ac++;
	XtSetValues ( dp_controlSE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 10); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -415); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 10); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -450); ac++;
	XtSetValues ( dp_absFR,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 425); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -825); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 10); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -450); ac++;
	XtSetValues ( dp_relFR,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 10); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -825); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 460); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -740); ac++;
	XtSetValues ( dp_resultFR,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 30); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -195); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 15); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -425); ac++;
	XtSetValues ( dp_absSL,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 220); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -290); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 330); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -425); ac++;
	XtSetValues ( dp_absRB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 215); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -240); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 85); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -165); ac++;
	XtSetValues ( dp_absEndHourLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 210); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -245); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 170); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -265); ac++;
	XtSetValues ( dp_absEndHourTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 250); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -275); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 25); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -165); ac++;
	XtSetValues ( dp_absDurLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 245); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -280); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 170); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -265); ac++;
	XtSetValues ( dp_absDurTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 285); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -310); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -165); ac++;
	XtSetValues ( dp_absLookbackHoursLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 280); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -315); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 170); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -265); ac++;
	XtSetValues ( dp_absLookbackHoursTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 340); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 80); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_absApplyPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 340); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 335); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_absDeletePB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 320); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -335); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 0); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -570); ac++;
	XtSetValues ( do_absControlSE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 5); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 15); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_absLILA,al, ac );
	ac = 0;
	XtManageChild(dp_absLI);
	children[ac++] = dp_absActiveTB;
	children[ac++] = dp_absInactiveTB;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_absRB;
	children[ac++] = dp_absEndHourLA;
	children[ac++] = dp_absEndHourTE;
	children[ac++] = dp_absDurLA;
	children[ac++] = dp_absDurTE;
	children[ac++] = dp_absLookbackHoursLA;
	children[ac++] = dp_absLookbackHoursTE;
	children[ac++] = dp_absApplyPB;
	children[ac++] = dp_absDeletePB;
	children[ac++] = do_absControlSE;
	children[ac++] = dp_absLILA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_absFO;
	children[ac++] = dp_absFRLA;
	XtManageChildren(children, ac);
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 25); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -230); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 10); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -400); ac++;
	XtSetValues ( dp_relSL,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 235); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -270); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 170); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -270); ac++;
	XtSetValues ( dp_relEndHourOffsetTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 280); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -315); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 170); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -270); ac++;
	XtSetValues ( dp_relDurTE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 240); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 65); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_relEndHourOffsetLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 285); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 25); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_relDurLA,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 240); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -310); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 285); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -380); ac++;
	XtSetValues ( dp_relRB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 335); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -370); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 85); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -170); ac++;
	XtSetValues ( dp_relApplyPB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 335); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 325); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_relDeletePB,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 320); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -330); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 0); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -435); ac++;
	XtSetValues ( dp_relSE,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 0); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 5); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_relLILA,al, ac );
	ac = 0;
	XtManageChild(dp_relLI);
	children[ac++] = dp_relActiveTB;
	children[ac++] = dp_relInactiveTB;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_relEndHourOffsetTE;
	children[ac++] = dp_relDurTE;
	children[ac++] = dp_relEndHourOffsetLA;
	children[ac++] = dp_relDurLA;
	children[ac++] = dp_relRB;
	children[ac++] = dp_relApplyPB;
	children[ac++] = dp_relDeletePB;
	children[ac++] = dp_relSE;
	children[ac++] = dp_relLILA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_relFO;
	children[ac++] = dp_relFRLA;
	XtManageChildren(children, ac);
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 35); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNbottomOffset, -780); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 10); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_OPPOSITE_FORM); ac++;
	XtSetArg(al[ac], XmNrightOffset, -265); ac++;
	XtSetValues ( dp_resultSL,al, ac );
	ac = 0;

	XtSetArg(al[ac], XmNtopAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNtopOffset, 10); ac++;
	XtSetArg(al[ac], XmNbottomAttachment, XmATTACH_NONE); ac++;
	XtSetArg(al[ac], XmNleftAttachment, XmATTACH_FORM); ac++;
	XtSetArg(al[ac], XmNleftOffset, 10); ac++;
	XtSetArg(al[ac], XmNrightAttachment, XmATTACH_NONE); ac++;
	XtSetValues ( dp_resultLILA,al, ac );
	ac = 0;
	XtManageChild(dp_resultLI);
	children[ac++] = dp_resultLILA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_resultFO;
	children[ac++] = dp_resultFRLA;
	XtManageChildren(children, ac);
	ac = 0;
	children[ac++] = dp_closePB;
	children[ac++] = dp_controlSE;
	children[ac++] = dp_absFR;
	children[ac++] = dp_relFR;
	children[ac++] = dp_resultFR;
	XtManageChildren(children, ac);
	ac = 0;
}

