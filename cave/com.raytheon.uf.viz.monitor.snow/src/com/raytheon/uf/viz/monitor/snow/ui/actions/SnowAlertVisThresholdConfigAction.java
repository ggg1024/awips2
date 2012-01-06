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
package com.raytheon.uf.viz.monitor.snow.ui.actions;

import org.eclipse.core.commands.AbstractHandler;
import org.eclipse.core.commands.ExecutionEvent;
import org.eclipse.core.commands.ExecutionException;
import org.eclipse.swt.widgets.Shell;
import org.eclipse.ui.PlatformUI;

import com.raytheon.uf.common.monitor.data.CommonConfig;
import com.raytheon.uf.common.monitor.data.ObConst.DataUsageKey;
import com.raytheon.uf.viz.monitor.snow.ui.dialogs.SnowMonDispThreshDlg;

/**
 * The Snow Threshold Action
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Dec 19 2009  3963       dhladky    Initial creation.
 * 
 * </pre>
 * 
 * @author dhladky
 * @version 1.0
 */

public class SnowAlertVisThresholdConfigAction extends AbstractHandler {
    
    private SnowMonDispThreshDlg snowMonDispThreshDlg;

    @Override
    public Object execute(ExecutionEvent arg0) throws ExecutionException {
        
        System.out.println("Activating/Action the Snow Alrt Vis Config...");
        
        Shell shell = PlatformUI.getWorkbench().getActiveWorkbenchWindow().getShell();
        
        if (snowMonDispThreshDlg == null)
        {
            snowMonDispThreshDlg = new SnowMonDispThreshDlg(shell, CommonConfig.AppName.SNOW, DataUsageKey.MONITOR);
            snowMonDispThreshDlg.open();
            snowMonDispThreshDlg = null;
        }
       
        // figure out what to do here in the future
        return null;
    }

}


