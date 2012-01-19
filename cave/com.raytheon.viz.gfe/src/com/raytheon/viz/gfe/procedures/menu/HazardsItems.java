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
package com.raytheon.viz.gfe.procedures.menu;

import org.eclipse.ui.PlatformUI;
import org.eclipse.ui.menus.CommandContributionItem;
import org.eclipse.ui.menus.CommandContributionItemParameter;

/**
 * Specific contribution item for contributing procedures to the Hazards menu
 * 
 * <pre>
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Nov 5, 2008            njensen     Initial creation
 * </pre>
 * 
 * @author njensen
 * @version 1.0
 */

public class HazardsItems extends AbstractProcedureMenuItems {

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.viz.gfe.procedures.menu.AbstractProcedureMenuItems#getId()
     */
    @Override
    public String getId() {
        return "com.raytheon.viz.gfe.procedures.menu.HazardsItems";
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.viz.gfe.procedures.menu.AbstractProcedureMenuItems#getMenuName
     * ()
     */
    @Override
    public String getMenuName() {
        return "Hazards";
    }

    /*
     * (non-Javadoc)
     * 
     * @seecom.raytheon.viz.gfe.procedures.menu.AbstractProcedureMenuItems#
     * getAdditionalItems()
     */
    @Override
    protected CommandContributionItemParameter[] getAdditionalItems() {
        return new CommandContributionItemParameter[] { new CommandContributionItemParameter(
                PlatformUI.getWorkbench(), getId(),
                "com.raytheon.viz.ghg.openmakehazards", null, null, null, null,
                "MakeHazard", null, null, CommandContributionItem.STYLE_PUSH,
                null, true) };
    }
}
