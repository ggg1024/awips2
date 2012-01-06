/**
 * This software was developed and / or modified by Raytheon Company,
 * pursuant to Contract DG133W-05-CQ-1067 with the US Government.
 * 
 * U.S. EXPORT CONTROLLED TECHNICAL DATA
 * This software product contains export-restricted data whose
 * export/transfer/disclosure is restricted by U.S. law. Dissemination
 * to non-U.S. persons whether in the United States or abroad requires
 * an export license or other authorization.
 * 
 * Contractor Name:        Raytheon Company
 * Contractor Address:     6825 Pine Street, Suite 340
 *                         Mail Stop B8
 *                         Omaha, NE 68106
 *                         402.291.0100
 * 
 * See the AWIPS II Master Rights File ("Master Rights File.pdf") for
 * further licensing information.
 **/

package com.raytheon.viz.awipstools.ui.layer;

import java.util.ArrayList;
import java.util.Collection;

import javax.measure.converter.UnitConverter;
import javax.measure.unit.NonSI;
import javax.measure.unit.SI;

import org.eclipse.jface.action.IMenuManager;
import org.eclipse.swt.graphics.RGB;
import org.geotools.referencing.GeodeticCalculator;
import org.opengis.referencing.FactoryException;
import org.opengis.referencing.operation.TransformException;

import com.raytheon.uf.common.geospatial.ReferencedCoordinate;
import com.raytheon.uf.viz.core.DrawableString;
import com.raytheon.uf.viz.core.IDisplayPaneContainer;
import com.raytheon.uf.viz.core.IGraphicsTarget;
import com.raytheon.uf.viz.core.IGraphicsTarget.HorizontalAlignment;
import com.raytheon.uf.viz.core.IGraphicsTarget.TextStyle;
import com.raytheon.uf.viz.core.drawables.PaintProperties;
import com.raytheon.uf.viz.core.exception.VizException;
import com.raytheon.uf.viz.core.rsc.LoadProperties;
import com.raytheon.uf.viz.core.rsc.capabilities.ColorableCapability;
import com.raytheon.viz.awipstools.IToolChangedListener;
import com.raytheon.viz.awipstools.ToolsDataManager;
import com.raytheon.viz.awipstools.ui.display.AwipsToolsResourceData;
import com.raytheon.viz.ui.cmenu.AbstractRightClickAction;
import com.raytheon.viz.ui.cmenu.IContextMenuContributor;
import com.vividsolutions.jts.geom.Coordinate;

/**
 * Implements a home drawing layer.
 * 
 * <pre>
 * 
 *  SOFTWARE HISTORY
 * 
 *  Date         Ticket#     Engineer    Description
 *  ------------ ----------  ----------- --------------------------
 *  19Dec2007    #647        ebabin     Fix mouse following issue..
 *  20Dec2007   #656         ebabin     Updated to refresh location after clicking GO.
 *                                      from put home cursor.
 *  20Dec2007    #645        ebabin     Updated to fix sampling.           
 *  15Jan2007                ebabin     Update for lat/lon put home cursor bug.
 *  10-21-09     #1049       bsteffen    Refactor to common MovableTool model
 * </pre>
 * 
 * @author ebabin
 * 
 * 
 */

public class HomeToolLayer extends AbstractMovableToolLayer<Coordinate>
        implements IContextMenuContributor, IToolChangedListener {

    public static final String DEFAULT_NAME = "Home Location";

    private final AbstractRightClickAction selectLocationAction;

    private final AbstractRightClickAction moveElementAction;

    private ToolsDataManager dataManager = ToolsDataManager.getInstance();

    private GeodeticCalculator gc;

    public HomeToolLayer(AwipsToolsResourceData<HomeToolLayer> resourceData,
            LoadProperties loadProperties) {
        super(resourceData, loadProperties, false);
        selectLocationAction = new AbstractRightClickAction() {
            @Override
            public void run() {
                save(null, lastMouseLoc);
                resetHome();
            }
        };
        selectLocationAction.setText("Select Location");
        moveElementAction = new AbstractRightClickAction() {
            @Override
            public void run() {
                makeSelectedLive();
            }
        };
        moveElementAction.setText("Move Entire Element");
        this.rightClickMovesToCoord = true;
    }

    @Override
    protected void disposeInternal() {
        super.disposeInternal();
        dataManager.removeHomeChangedListener(this);
    }

    @Override
    protected void initInternal(IGraphicsTarget target) throws VizException {
        super.initInternal(target);
        resetHome();
        gc = new GeodeticCalculator(descriptor.getCRS());
        dataManager.addHomeChangedListener(this);
    }

    private void resetHome() {
        Coordinate home = ToolsDataManager.getInstance().getHome();
        Collection<Coordinate> dummy = new ArrayList<Coordinate>();
        dummy.add(home);
        setObjects(dummy);
    }

    @Override
    protected void paint(IGraphicsTarget target, PaintProperties paintProps,
            Coordinate home, SelectionStatus status) throws VizException {
        RGB color = getCapability(ColorableCapability.class).getColor();
        if (status == SelectionStatus.SELECTED) {
            color = GRAY;
        }
        double radius = (MAGIC_X_RADIUS * paintProps.getZoomLevel());
        double[] center = descriptor
                .worldToPixel(new double[] { home.x, home.y });
        double[] p1 = target.getPointOnCircle(center[0], center[1], 0.0,
                radius, 45);
        double[] p2 = target.getPointOnCircle(center[0], center[1], 0.0,
                radius, 225);
        target.drawLine(p1[0], p1[1], 0, p2[0], p2[1], 0, color, 1.0f);
        p1 = target.getPointOnCircle(center[0], center[1], 0.0, radius, 135);
        p2 = target.getPointOnCircle(center[0], center[1], 0.0, radius, 315);
        target.drawLine(p1[0], p1[1], 0, p2[0], p2[1], 0, color, 1.0f);
        double labelLoc[] = target.getPointOnCircle(center[0], center[1], 0.0,
                radius, 0);
        DrawableString dString = new DrawableString("Home", color);
        dString.basics.x = labelLoc[0];
        dString.basics.y = labelLoc[1];
        dString.basics.z = 0.0;
        dString.textStyle = TextStyle.NORMAL;
        dString.horizontalAlignment = HorizontalAlignment.LEFT;
        target.drawStrings(dString);

    }

    @Override
    public String getDefaultName() {
        return DEFAULT_NAME;
    }

    @Override
    public String inspect(ReferencedCoordinate refCoord) throws VizException {

        Coordinate dest;
        try {
            dest = refCoord.asLatLon();
        } catch (TransformException e) {
            throw new VizException("Error inspecting Home Point", e);
        } catch (FactoryException e) {
            throw new VizException("Error inspecting Home Point", e);
        }
        return inspect(dest);
    }

    private String inspect(Coordinate dest) {

        String rangeAndAzimuth = "0mi@0";

        double azimuth = 000;

        Coordinate home = ToolsDataManager.getInstance().getHome();

        gc.setStartingGeographicPoint(home.x, home.y);
        gc.setDestinationGeographicPoint(dest.x, dest.y);

        azimuth = gc.getAzimuth();

        if (azimuth < 0) {
            azimuth = 360 + azimuth;
        }

        UnitConverter conv = SI.METER.getConverterTo(NonSI.MILE);

        String s = String.valueOf((int) azimuth);
        if (s.length() == 2) {
            s = "0" + s;
        } else if (s.length() == 1) {
            s = "00" + s;
        }

        rangeAndAzimuth = (int) conv.convert(gc.getOrthodromicDistance())
                + "mi@" + s;

        return rangeAndAzimuth;
    }

    @Override
    public void addContextMenuItems(IMenuManager menuManager, int x, int y) {
        if (isEditable() && selectedObject != null) {
            menuManager.add(moveElementAction);
        }
        if (isEditable()) {
            menuManager.add(selectLocationAction);
        }
    }

    @Override
    public void toolChanged() {
        resetHome();
        issueRefresh();
    }

    @Override
    protected boolean isClicked(IDisplayPaneContainer container,
            Coordinate mouseLoc, Coordinate object) {
        this.endpointClicked = false;
        double[] pointPixel = container.translateInverseClick(object);
        double distance = (mouseLoc.x - pointPixel[0])
                * (mouseLoc.x - pointPixel[0]) + (mouseLoc.y - pointPixel[1])
                * (mouseLoc.y - pointPixel[1]);
        if (distance < MAGIC_CLICK_DISTANCE * MAGIC_CLICK_DISTANCE) {
            this.endpointClicked = true;
            return true;
        }
        return false;
    }

    @Override
    protected Coordinate makeLive(Coordinate object) {
        return new Coordinate(object);
    }

    @Override
    protected Coordinate move(Coordinate lastMouseLoc, Coordinate mouseLoc,
            Coordinate object) {
        return new Coordinate(mouseLoc != null ? mouseLoc : lastMouseLoc);
    }

    @Override
    protected void save(Coordinate oldCoordinate, Coordinate coordinate) {
        ToolsDataManager.getInstance().setHome(coordinate);
        resourceData.fireChangeListeners(ChangeType.DATA_UPDATE, null);
    }
}
