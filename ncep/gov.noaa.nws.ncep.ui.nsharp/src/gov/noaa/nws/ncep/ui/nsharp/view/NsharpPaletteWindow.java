/**
 * 
 * gov.noaa.nws.ncep.ui.nsharp.palette.NsharpPaletteWindow
 * 
 * This java class performs the NSHARP GUI construction.
 * This code has been developed by the NCEP-SIB for use in the AWIPS2 system.
 * 
 * <pre>
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    	Engineer    Description
 * -------		------- 	-------- 	-----------
 * 03/16/2010	229			Chin Chen	Initial coding
 *
 * </pre>
 * 
 * @author Chin Chen
 * @version 1.0
 */
package gov.noaa.nws.ncep.ui.nsharp.view;

import gov.noaa.nws.ncep.ui.nsharp.NsharpConstants;
import gov.noaa.nws.ncep.ui.nsharp.display.NsharpEditor;
import gov.noaa.nws.ncep.ui.nsharp.display.rsc.NsharpResourceHandler;
import gov.noaa.nws.ncep.ui.nsharp.display.map.NsharpMapResource;
import gov.noaa.nws.ncep.ui.nsharp.view.NsharpLoadDialog;
import gov.noaa.nws.ncep.ui.nsharp.view.NsharpUnloadDialog;
import gov.noaa.nws.ncep.viz.ui.display.NCMapEditor;

import org.eclipse.swt.SWT;
import org.eclipse.swt.events.DisposeEvent;
import org.eclipse.swt.events.DisposeListener;
import org.eclipse.swt.events.SelectionEvent;
import org.eclipse.swt.events.SelectionListener;
import org.eclipse.swt.graphics.Color;
import org.eclipse.swt.graphics.Font;
import org.eclipse.swt.graphics.FontData;
import org.eclipse.swt.layout.GridData;
import org.eclipse.swt.layout.GridLayout;
//import org.eclipse.swt.layout.RowData;
import org.eclipse.swt.layout.RowLayout;
import org.eclipse.swt.widgets.Button;
import org.eclipse.swt.widgets.Composite;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Event;
import org.eclipse.swt.widgets.Group;
import org.eclipse.swt.widgets.Listener;
import org.eclipse.swt.widgets.MessageBox;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.IPartListener;
import org.eclipse.ui.IViewSite;
import org.eclipse.ui.IWorkbenchPage;
import org.eclipse.ui.IWorkbenchPart;
import org.eclipse.ui.PartInitException;
import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.part.ViewPart;

//import com.raytheon.uf.viz.core.drawables.IFont;
import com.raytheon.uf.viz.core.drawables.IRenderableDisplay;
import com.raytheon.uf.viz.core.drawables.ResourcePair;
import com.raytheon.viz.ui.UiUtil;


public class NsharpPaletteWindow extends ViewPart implements SelectionListener,
DisposeListener, IPartListener{
	private MessageBox mb ;
	protected Button loadBtn, unloadBtn, overlayBtn,  interpBtn,dataEditBtn,  compareStnBtn,compareTmBtn, graphEditBtn,graphModeBtnSkew, graphModeBtnIcing,graphModeBtnTurb;
	private Shell shell;
	private boolean overlayIsOn=false, compareStnIsOn=false, compareTmIsOn=false;
	protected boolean interpolateIsOn=false, editGraphOn=false;
	private static String INTP_OFF = "  Interp(off)    ";
	private static String INTP_ON = "  Interp(on)     ";
	private static String COMP_STN_OFF= "CompStn(off)";
	private static String COMP_STN_ON=  "CompStn(on)  ";
	private static String COMP_TM_OFF= "CompTm(off)";
	private static String COMP_TM_ON=  "CompTm(on)  ";
	private static String OVLY_OFF= "Ovrlay2(off)  ";
	private static String OVLY_ON=  "Ovrlay2(on)   ";
	protected static String EDIT_GRAPH_OFF= "EditGraph(off)";
	protected static String EDIT_GRAPH_ON= "EditGraph(on) ";
	private IWorkbenchPage page;
	private NsharpPrintHandle printHandle; 
	private Font newFont ;
	private boolean isEditorVisible=true;
	private static NsharpPaletteWindow instance;
	private static int currentGraphMode= NsharpConstants.GRAPH_SKEWT;
	
	public static NsharpPaletteWindow getInstance() {
		return instance;
	}
	public static int getCurrentGraphMode() {
		return currentGraphMode;
	}
	private Color colorGrey = new Color(Display.getDefault(), 211,211,211);
	private Color colorButtonOriginalBg;

	public void setAndOpenMb(String msg) {
		if (mb != null) {
			mb.setMessage(msg);
			try {
				mb.open();
			}catch (Exception e) {

				//e.printStackTrace();
			}
		}
	}
	public NsharpPaletteWindow() {
		super();
		instance = this;
		//System.out.println("NsharpPaletteWindow condtructed!!");
		printHandle = NsharpPrintHandle.getPrintHandle();
		shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  

		mb = new MessageBox(shell, SWT.ICON_WARNING
				| SWT.OK );
		mb.setMessage( "Data is not loaded yet!");
	}

	/**
	 * Invoked by the workbench to initialize this View.
	 */
	public void init( IViewSite site ) {
		//System.out.println("NsharpPaletteWindow inited!!");
		try {

			super.init( site );

		} catch ( PartInitException pie ) {

			pie.printStackTrace();

		}

		page = site.getPage();
		page.addPartListener(this);

		NsharpMapResource.registerMouseHandler();
		//Chin : to fix Ticket#11034::::
		//get several control information back from SkewT resource, in the case that
		//NsharpPaletteWindow view was disposed and re-constructed while SkewT resource is still alive.
		//This case applied to D2D implementation. 
		NsharpResourceHandler rsc = getRscHandler();
		if(rsc!= null) {
			interpolateIsOn = rsc.isInterpolateIsOn();
			overlayIsOn = rsc.isOverlayIsOn();
			compareStnIsOn = rsc.isCompareStnIsOn();
			editGraphOn = rsc.isEditGraphOn();				
		}

	}

	/**
	 * Disposes resource.  invoked by the workbench
	 */
	public void dispose() {
		//System.out.println("NsharpPaletteWindow dispose() called!! isEditorVisible="+ isEditorVisible);
		if ( ! isEditorVisible ) {
			NsharpMapResource.unregisterMouseHandler();
			return;
		}
		else {
			super.dispose();
			currentGraphMode= NsharpConstants.GRAPH_SKEWT;
			isEditorVisible = false;
			NCMapEditor editor = NsharpMapResource.getMapEditor();
			if(editor!=null){
				for ( IRenderableDisplay display : UiUtil.getDisplaysFromContainer(editor) ) {
					//System.out.println("display " + display.toString());
					for ( ResourcePair rp : display.getDescriptor().getResourceList() ) {
						if ( rp.getResource() instanceof NsharpMapResource ) {
							NsharpMapResource rsc = (NsharpMapResource)rp.getResource();
							rsc.unload();
							display.getDescriptor().getResourceList().removePreRemoveListener(rsc);

						}
					}
				}
			}
			if(newFont!= null){
				newFont.dispose();
				newFont=null;
			}		/*
			 * remove the workbench part listener
			 */
			page.removePartListener(this);

			try{
				if(NsharpLoadDialog.getAccess()!= null){        
					NsharpLoadDialog.getAccess().close();
				}
			}catch (Exception e) {

			}
			instance= null;
		}
	}
	protected boolean checkLoadedData() {
		NsharpEditor editor = NsharpEditor.getActiveNsharpEditor();
		if (editor == null) {
			mb.open();
			return false;
		}
		NsharpResourceHandler rsc = editor.getRscHandler();
		if (rsc == null ) {
			mb.open();
			return false;
		}
		return true;
	}
	protected NsharpResourceHandler getRscHandler(){
		NsharpEditor editor = NsharpEditor.getActiveNsharpEditor();
		if (editor == null) {
			
			return null;
		}
		NsharpResourceHandler rsc = editor.getRscHandler();
		if (rsc == null)
			return null;
		
		return rsc;
	}

	public void createDataControlGp(Composite parent){
		Group textModeGp = new Group(parent,SWT.SHADOW_OUT);
		textModeGp.setLayout( new RowLayout(SWT.HORIZONTAL) );
		textModeGp.setLayoutData( new GridData(GridData.FILL_HORIZONTAL) );
		Font font = textModeGp.getFont();
		FontData[] fontData = font.getFontData();
		for (int i = 0; i < fontData.length; i++) {
			fontData[i].setHeight(7);				
			//fontData[i].setName("courier");
		}
		newFont = new Font(font.getDevice(), fontData);
		
		loadBtn = new Button(textModeGp, SWT.PUSH);
		loadBtn.setFont(newFont);
		loadBtn.setText("      Load        ");
		loadBtn.setEnabled( true );
		//loadBtn.setSize(btnWidth,pushbtnHeight);
		loadBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  	

				NsharpLoadDialog loadDia = NsharpLoadDialog.getInstance(shell);

				if ( loadDia != null ) {
					//System.out.println("Load Button is calling dialog open()");
					loadDia.open();
				} 				
			}          		            	 	
		} );

		unloadBtn = new Button(textModeGp, SWT.PUSH);
		unloadBtn.setFont(newFont);
		unloadBtn.setText("     UnLoad     ");
		unloadBtn.setEnabled( true );
		//loadBtn.setSize(btnWidth,pushbtnHeight);
		unloadBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				if(checkLoadedData()) {
					Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  	

					NsharpUnloadDialog unloadDia = NsharpUnloadDialog.getInstance(shell);

					if ( unloadDia != null ) {
						//System.out.println("Load Button is calling dialog open()");
						unloadDia.open();

					} 		
				}
			}          		            	 	
		} );
		// Push buttons for SAVE
		Button saveBtn = new Button(textModeGp, SWT.PUSH);
		saveBtn.setFont(newFont);
		saveBtn.setText("      Save        ");
		saveBtn.setEnabled( true );
		//saveBtn.setSize(btnWidth,pushbtnHeight);
		saveBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           

				if(checkLoadedData()) {
					// Action to save text report 
					NsharpSaveHandle.saveFile(shell);
				}
			}

		} );

		// Push buttons for CONFIGURE
		Button cfgBtn = new Button(textModeGp, SWT.PUSH);
		cfgBtn.setFont(newFont);
		cfgBtn.setText("  Configure    ");
		cfgBtn.setEnabled(true);
		//cfgBtn.setSize(btnWidth,pushbtnHeight);
		cfgBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  
				//CHin, new develop if(checkLoadedData()) {
					//NsharpParametersSelectionConfigDialog dia = NsharpParametersSelectionConfigDialog.getInstance(shell);
					NsharpConfigDialog dia = NsharpConfigDialog.getInstance(shell);
					if ( dia != null ) {
						dia.open();
					}
				//} 

			}          		            	 	
		} );

		Button resetBtn = new Button(textModeGp, SWT.PUSH);
		resetBtn.setFont(newFont);
		resetBtn.setText("     Reset        ");
		resetBtn.setEnabled( true );
		resetBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {
				//RESET should turn off everything...
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 

				overlayIsOn = false;
				overlayBtn.setText(OVLY_OFF);
				overlayBtn.setEnabled(true);
				compareStnIsOn = false;
				compareStnBtn.setText(COMP_STN_OFF);
				compareStnBtn.setEnabled(true);
				compareTmIsOn = false;
				compareTmBtn.setText(COMP_TM_OFF);
				compareTmBtn.setEnabled(true);
				interpolateIsOn = false;
				interpBtn.setText(INTP_OFF);
				editGraphOn = false;
				graphModeBtnIcing.setEnabled(true);
				graphModeBtnTurb.setEnabled(true);
				graphEditBtn.setText(EDIT_GRAPH_OFF);
				currentGraphMode= NsharpConstants.GRAPH_SKEWT;
				NsharpEditor editor = NsharpEditor.getActiveNsharpEditor();
				if(editor != null){
					//note: resetRsc will reset currentPage, overlay, compare, interpolate flag in Resource
					editor.getRscHandler().resetRsc();
					//editor.getNsharpSkewTDescriptor().getSkewtResource().resetRsc();// need to called it twice to make refresh worked...dont know why
					//know that current editor is NsharpSkewT editor, refresh it.
					editor.refresh();
					NsharpShowTextDialog textarea =  NsharpShowTextDialog.getAccess();
					if(textarea != null){
						textarea.refreshTextData();
					}
				}
				if(NsharpParcelDialog.getAccess() != null){
					NsharpParcelDialog.getAccess().resetUserDefParcel();
				}
			}          		            	 	
		} );
		Button resetGfBtn = new Button(textModeGp, SWT.PUSH);
		resetGfBtn.setFont(newFont);
		resetGfBtn.setText("Reset Display");
		resetGfBtn.setEnabled( true );
		resetGfBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {
				NsharpEditor editor = NsharpEditor.getActiveNsharpEditor();
				editor.resetGraph();
			}
		});

		Button parcelBtn = new Button(textModeGp, SWT.PUSH);
		parcelBtn.setFont(newFont);
		parcelBtn.setText("     Parcel       ");
		parcelBtn.setEnabled( true );
		//parcelBtn.setSize(btnWidth,pushbtnHeight);
		parcelBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  	
				if(checkLoadedData()) {
					NsharpParcelDialog parcelDia = NsharpParcelDialog.getInstance(shell);

					if ( parcelDia != null ) {
						//System.out.println("calling parcel dialog open()");
						parcelDia.open();

					} 
				}
			}          		            	 	
		} );

		// Push buttons for NEXT PAGE info
		Button nextpageBtn = new Button(textModeGp, SWT.PUSH);
		nextpageBtn.setFont(newFont);
		nextpageBtn.setText("  Next Data    ");
		nextpageBtn.setEnabled(true);
		nextpageBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(checkLoadedData()) {
					NsharpResourceHandler rsc = getRscHandler();
					if(rsc!= null){
						rsc.setNextTextChapter();
						rsc.refreshPane();
					}
				}
			}          		            	 	
		} );
		
		// Push buttons for NEXT INSET PAGE info
		Button nextInsetBtn = new Button(textModeGp, SWT.PUSH);
		nextInsetBtn.setFont(newFont);
		nextInsetBtn.setText("  Next Inset    ");
		nextInsetBtn.setEnabled(true);
		nextInsetBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(checkLoadedData()) {
					NsharpResourceHandler rsc = getRscHandler();
					if(rsc!= null){
						rsc.setNextInsetPage();
						rsc.refreshPane();
					}
				}
			}          		            	 	
		} );
		
		
		// Push buttons for interpolate
		interpBtn = new Button(textModeGp, SWT.PUSH);
		interpBtn.setFont(newFont);
		interpBtn.setEnabled( true );		
		if(interpolateIsOn) {
			interpBtn.setText(INTP_ON);
		}
		else{
			interpBtn.setText(INTP_OFF);
		}
		interpBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {  
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(checkLoadedData()) {
					
					if(interpolateIsOn == false){
						interpolateIsOn = true;
						interpBtn.setText(INTP_ON);
					}
					else {
						interpolateIsOn = false;
						interpBtn.setText(INTP_OFF);
					}
					//note:call resetInfoOnInterpolate() and pass interpolate flag to Resource
					NsharpEditor editor = NsharpEditor.getActiveNsharpEditor();
					if(editor != null){
						try {
							editor.getRscHandler().resetInfoOnInterpolate(interpolateIsOn);
						} catch (CloneNotSupportedException e) {
							e.printStackTrace();
						}
						//know that current editor is NsharpSkewT editor, refresh it.
						editor.refresh();
						
						NsharpShowTextDialog textarea =  NsharpShowTextDialog.getAccess();
						if(textarea != null){
							textarea.refreshTextData();
						}
					}
				}
			}          		            	 	
		} );

		NsharpResourceHandler rsc = getRscHandler();
		
		// Push buttons for OVERLAY info
		overlayBtn = new Button(textModeGp, SWT.PUSH);	
		overlayBtn.setFont(newFont);
		if(overlayIsOn){
			overlayBtn.setText(OVLY_ON);
			overlayBtn.setEnabled( true );
		}
		else{
			overlayBtn.setText(OVLY_OFF);
			//comparison and overlay is mutual exclusive
			if((rsc!= null) && (rsc.isCompareStnIsOn() || rsc.isCompareTmIsOn()))
				overlayBtn.setEnabled( false );
			else
				overlayBtn.setEnabled( true );
		}
		overlayBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(overlayIsOn == false){

					overlayIsOn = true;
					overlayBtn.setText(OVLY_ON);
					compareStnBtn.setEnabled(false);
					compareTmBtn.setEnabled(false);
				}
				else {
					overlayIsOn = false;
					overlayBtn.setText(OVLY_OFF);
					compareStnBtn.setEnabled(true);
					compareTmBtn.setEnabled(true);
				}
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null){
					rsc.setOverlayIsOn(overlayIsOn);
					rsc.refreshPane();
				}
			}          		            	 	
		} );
		// Push buttons for CompByStn info
		compareStnBtn = new Button(textModeGp, SWT.PUSH);
		compareStnBtn.setFont(newFont);
		if(compareStnIsOn){
			compareStnBtn.setText(COMP_STN_ON);
			compareStnBtn.setEnabled( true );
		}
		else{
			//comparison and overlay is mutual exclusive
			compareStnBtn.setText(COMP_STN_OFF);
			if((rsc!= null) && (rsc.isOverlayIsOn() || rsc.isCompareTmIsOn()))
				compareStnBtn.setEnabled( false );
			else
				compareStnBtn.setEnabled( true );
		}		
		compareStnBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(compareStnIsOn == false){

					compareStnIsOn = true;
					compareStnBtn.setText(COMP_STN_ON);
					overlayBtn.setEnabled(false);
					compareTmBtn.setEnabled( false );
				}
				else {
					compareStnIsOn = false;
					compareStnBtn.setText(COMP_STN_OFF);
					overlayBtn.setEnabled(true);
					compareTmBtn.setEnabled( true );
				}
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null){
					rsc.setCompareStnIsOn(compareStnIsOn);
					rsc.refreshPane();
				}
				
			}          		            	 	
		} );
		// Push buttons for CompByTm info
		compareTmBtn = new Button(textModeGp, SWT.PUSH);
		compareTmBtn.setFont(newFont);
		if(compareTmIsOn){
			compareTmBtn.setText(COMP_TM_ON);
			compareTmBtn.setEnabled( true );
		}
		else{
			//comparison and overlay is mutual exclusive
			compareTmBtn.setText(COMP_TM_OFF);
			if((rsc!= null) && (rsc.isOverlayIsOn() || rsc.isCompareStnIsOn()))
				compareTmBtn.setEnabled( false );
			else
				compareTmBtn.setEnabled( true );
		}
		compareTmBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(compareTmIsOn == false){

					compareTmIsOn = true;
					compareTmBtn.setText(COMP_TM_ON);
					overlayBtn.setEnabled(false);
					compareStnBtn.setEnabled( false );
				}
				else {
					compareTmIsOn = false;
					compareTmBtn.setText(COMP_TM_OFF);
					overlayBtn.setEnabled(true);
					compareStnBtn.setEnabled( true );
				}
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null){
					rsc.setCompareTmIsOn(compareTmIsOn);
					rsc.refreshPane();
				}
				
			}          		            	 	
		} );
		dataEditBtn = new Button(textModeGp, SWT.PUSH);
		dataEditBtn.setFont(newFont);
		dataEditBtn.setText("   Edit  Data    ");
		dataEditBtn.setEnabled( true );
		dataEditBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				if(checkLoadedData()) {
					Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();  	
					NsharpEditDataDialog editDia = NsharpEditDataDialog.getInstance(shell);
					if ( editDia != null ) {						
						editDia.open();
					} 
				}
			}          		            	 	
		} ); 

		graphEditBtn = new Button(textModeGp, SWT.PUSH);
		graphEditBtn.setFont(newFont);
		graphEditBtn.setEnabled( true );		
		if(editGraphOn) {
			graphEditBtn.setText(EDIT_GRAPH_ON);
		}
		else{
			graphEditBtn.setText(EDIT_GRAPH_OFF);
		}
		graphEditBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				if(checkLoadedData()) {
					if(editGraphOn){
						editGraphOn=false;
						graphEditBtn.setText(EDIT_GRAPH_OFF);
						graphModeBtnIcing.setEnabled(true);
						graphModeBtnTurb.setEnabled(true);
						
					}
					else{
						editGraphOn= true;
						graphEditBtn.setText(EDIT_GRAPH_ON);
						graphModeBtnIcing.setEnabled(false);
						graphModeBtnTurb.setEnabled(false);
						
					}
					NsharpResourceHandler rsc = getRscHandler();
					if(rsc!= null) {
						rsc.setEditGraphOn(editGraphOn);
						rsc.refreshPane();
					}
				}
			}          		            	 	
		} ); 
		/*Button bndryMotionBtn = new Button(textModeGp, SWT.PUSH);
		bndryMotionBtn.setText("BoundaryMotion");
		bndryMotionBtn.setEnabled( true );
		bndryMotionBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {  
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(checkLoadedData()) {
					NsharpShowTextDialog osDia =  NsharpShowTextDialog.getInstance( shell );    
					if(osDia != null)
						osDia.open();
				}
			}          		            	 	
		} );*/
		
		// Push buttons for show text info
		Button showtextBtn = new Button(textModeGp, SWT.PUSH);
		showtextBtn.setFont(newFont);
		showtextBtn.setText("  Show  Text   ");
		showtextBtn.setEnabled( true );
		showtextBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {  
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				if(checkLoadedData()) {
					NsharpShowTextDialog osDia =  NsharpShowTextDialog.getInstance( shell );    
					if(osDia != null)
						osDia.open();
				}
			}          		            	 	
		} );
		Group graphModeGp = new Group(textModeGp,SWT.SHADOW_ETCHED_IN);
		graphModeGp.setLayout(new RowLayout(SWT.HORIZONTAL) );//new GridLayout( 2, false ) );
		
		// Push buttons for graphMode
		graphModeBtnSkew = new Button(graphModeGp, SWT.PUSH );
		graphModeBtnSkew.setFont(newFont);
		graphModeBtnSkew.setText("S");
		graphModeBtnSkew.setEnabled( true );
		colorButtonOriginalBg= graphModeBtnSkew.getBackground();
		rsc = getRscHandler();
		if(rsc!= null ){
			currentGraphMode = rsc.getCurrentGraphMode();
		}
		graphModeBtnSkew.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				currentGraphMode= NsharpConstants.GRAPH_SKEWT;
				graphModeBtnSkew.setBackground(colorGrey);
				graphModeBtnTurb.setBackground(colorButtonOriginalBg);
				graphModeBtnIcing.setBackground(colorButtonOriginalBg);
				graphEditBtn.setEnabled(true);
				dataEditBtn.setEnabled(true);
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null ) {
					rsc.setCurrentGraphMode(currentGraphMode);
				}
			}          		            	 	
		} );
		graphModeBtnTurb = new Button(graphModeGp, SWT.PUSH);
		graphModeBtnTurb.setFont(newFont);
		graphModeBtnTurb.setText("T");
		graphModeBtnTurb.setEnabled( true );
		graphModeBtnTurb.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				currentGraphMode= NsharpConstants.GRAPH_TURB;
				graphModeBtnTurb.setBackground(colorGrey);
				graphModeBtnSkew.setBackground(colorButtonOriginalBg);
				graphModeBtnIcing.setBackground(colorButtonOriginalBg);
				graphEditBtn.setEnabled(false);
				dataEditBtn.setEnabled(false);
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null ) {
					rsc.setCurrentGraphMode(currentGraphMode);
				}
			}          		            	 	
		} );
		graphModeBtnIcing = new Button(graphModeGp, SWT.PUSH);
		graphModeBtnIcing.setFont(newFont);
		graphModeBtnIcing.setText("I");
		graphModeBtnIcing.setEnabled( true );
		graphModeBtnIcing.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				currentGraphMode= NsharpConstants.GRAPH_ICING;
				graphModeBtnIcing.setBackground(colorGrey);
				graphModeBtnSkew.setBackground(colorButtonOriginalBg);
				graphModeBtnTurb.setBackground(colorButtonOriginalBg);
				graphEditBtn.setEnabled(false);
				dataEditBtn.setEnabled(false);
				NsharpResourceHandler rsc = getRscHandler();
				if(rsc!= null ) {
					rsc.setCurrentGraphMode(currentGraphMode);
				}
			}          		            	 	
		} );
		if(currentGraphMode== NsharpConstants.GRAPH_SKEWT){
			graphModeBtnSkew.setBackground(colorGrey);
		}
		else if(currentGraphMode== NsharpConstants.GRAPH_TURB){
			graphModeBtnTurb.setBackground(colorGrey);
		}
		else if(currentGraphMode== NsharpConstants.GRAPH_ICING){
			graphModeBtnIcing.setBackground(colorGrey);
		}

		// Push buttons for Print
		Button printBtn = new Button(textModeGp, SWT.PUSH);
		printBtn.setFont(newFont);
		printBtn.setText("      Print         ");
		printBtn.setEnabled( true );
		printBtn.addListener( SWT.MouseUp, new Listener() {
			public void handleEvent(Event event) {           
				shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell(); 
				//12.7.1 testing if(checkLoadedData()) { 
				if(true){
					printHandle.handlePrint("");
				}
			}          		            	 	
		} );
		textModeGp.redraw();

	}

	public boolean isEditorVisible() {
		return isEditorVisible;
	}
	public void setEditorVisible(boolean isEditorVisible) {
		this.isEditorVisible = isEditorVisible;
	}
	/**
	 * Invoked by the workbench, this method sets up the SWT controls for the nsharp palette
	 */

	@Override
	public void createPartControl(Composite parent) {
		//System.out.println("nlist @"+NsharpConstants.getNlistFile());
		parent.setLayout( new GridLayout( 1, true ) );
		createDataControlGp(parent);
	}

	@Override
	public void widgetDefaultSelected(SelectionEvent e) {
		// TODO Auto-generated method stub

	}
	@Override
	public void widgetSelected(SelectionEvent e) {
		// TODO Auto-generated method stub

	}
	@Override
	public void widgetDisposed(DisposeEvent e) {


	}
	@Override
	public void partActivated(IWorkbenchPart part) {
		// TODO Auto-generated method stub

	}
	@Override
	public void partBroughtToTop(IWorkbenchPart part) {
		// TODO Auto-generated method stub

	}
	@Override
	public void partClosed(IWorkbenchPart part) {
	}
	@Override
	public void partDeactivated(IWorkbenchPart part) {
		// TODO Auto-generated method stub

	}
	@Override
	public void partOpened(IWorkbenchPart part) {
		// TODO Auto-generated method stub

	}
	@Override
	public void setFocus() {
		// TODO Auto-generated method stub

	}
}
