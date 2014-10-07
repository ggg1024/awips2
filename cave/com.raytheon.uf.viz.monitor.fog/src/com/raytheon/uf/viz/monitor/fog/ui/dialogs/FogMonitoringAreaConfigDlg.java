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
package com.raytheon.uf.viz.monitor.fog.ui.dialogs;

import org.eclipse.swt.SWT;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;

import com.raytheon.uf.common.monitor.config.FSSObsMonitorConfigurationManager;
import com.raytheon.uf.common.monitor.config.FSSObsMonitorConfigurationManager.MonName;
import com.raytheon.uf.common.monitor.data.CommonConfig;
import com.raytheon.uf.common.monitor.data.CommonConfig.AppName;
import com.raytheon.uf.common.monitor.data.ObConst.DataUsageKey;
import com.raytheon.uf.viz.monitor.events.IMonitorConfigurationEvent;
import com.raytheon.uf.viz.monitor.fog.FogMonitor;
import com.raytheon.uf.viz.monitor.fog.threshold.FogThresholdMgr;
import com.raytheon.uf.viz.monitor.ui.dialogs.MonitoringAreaConfigDlg;
import com.raytheon.viz.ui.dialogs.ICloseCallback;

/**
 * Fog Monitor area configuration dialog.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Jan  5, 2010            mpduff       Initial creation
 * Nov 27, 2012 1351       skorolev     Changes for non-blocking dialog.
 * Jan 29, 2014 2757       skorolev     Changed OK button handler.
 * Apr 23, 2014 3054       skorolev     Fixed issue with removing a new station from list.
 * Apr 28, 2014 3086       skorolev     Updated getConfigManager.
 * Sep 04, 2014 3220       skorolev     Added fireConfigUpdateEvent method. Updated handler.
 * Sep 19, 2014 2757       skorolev     Updated handlers for dialog buttons.
 * 
 * 
 * </pre>
 * 
 * @author mpduff
 * @version 1.0
 */

public class FogMonitoringAreaConfigDlg extends MonitoringAreaConfigDlg {

    private FogMonDispThreshDlg fogMonitorDlg;

    /**
     * Constructor.
     * 
     * @param parent
     * @param title
     */
    public FogMonitoringAreaConfigDlg(Shell parent, String title) {
        super(parent, title, AppName.FOG);
        FogMonitor.getInstance();
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.raytheon.uf.viz.monitor.ui.dialogs.MonitoringAreaConfigDlg#
     * handleOkBtnSelection()
     */
    @Override
    protected void handleOkBtnSelection() {
        if (dataIsChanged()) {
            int choice = showMessage(shell, SWT.OK | SWT.CANCEL,
                    "Fog Monitor Confirm Changes",
                    "Want to Update Fog Monitor's Setup files?");
            if (choice == SWT.OK) {
                // Save the configuration xml file
                getValues();
                resetStatus();
                configMgr.saveConfigXml();
                configMgr.saveAdjancentAreaConfigXml();
                /**
                 * DR#11279: re-initialize threshold manager and the monitor
                 * using new monitor area configuration
                 */
                FogThresholdMgr.reInitialize();
                fireConfigUpdateEvent();
                if ((!configMgr.getAddedZones().isEmpty())
                        || (!configMgr.getAddedStations().isEmpty())) {
                    if (editDialog() == SWT.YES) {
                        fogMonitorDlg = new FogMonDispThreshDlg(shell,
                                CommonConfig.AppName.FOG, DataUsageKey.MONITOR);
                        fogMonitorDlg.setCloseCallback(new ICloseCallback() {
                            @Override
                            public void dialogClosed(Object returnValue) {
                                // Clean added zones and stations. Close dialog.
                                configMgr.getAddedZones().clear();
                                configMgr.getAddedStations().clear();
                                setReturnValue(true);
                                close();
                            }
                        });
                        fogMonitorDlg.open();
                    }
                    // Clean added zones and stations.
                    configMgr.getAddedZones().clear();
                    configMgr.getAddedStations().clear();
                }
            }
        }
        if (fogMonitorDlg == null || fogMonitorDlg.isDisposed()) {
            setReturnValue(true);
            close();
        }
    }

    /**
     * Fire Table reload event.
     */
    private void fireConfigUpdateEvent() {
        final IMonitorConfigurationEvent me = new IMonitorConfigurationEvent(
                configMgr);
        shell.setCursor(getDisplay().getSystemCursor(SWT.CURSOR_WAIT));
        Display.getDefault().asyncExec(new Runnable() {
            @Override
            public void run() {
                FogMonitor.getInstance().configUpdate(me);
            }
        });
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.uf.viz.monitor.ui.dialogs.MonitoringAreaConfigDlg#getInstance
     * ()
     */
    protected FSSObsMonitorConfigurationManager getInstance() {
        if (configMgr == null) {
            configMgr = new FSSObsMonitorConfigurationManager(
                    MonName.fog.name());
        }
        return (FSSObsMonitorConfigurationManager) configMgr;
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.uf.viz.monitor.ui.dialogs.MonitoringAreaConfigDlg#disposed()
     */
    @Override
    protected void disposed() {
        configMgr = null;
    }

}
