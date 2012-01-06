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

package com.raytheon.uf.viz.core.rsc.updater;

import com.raytheon.uf.viz.core.datastructure.DecisionTree;
import com.raytheon.uf.viz.core.rsc.AbstractVizResource;

/**
 * TODO Add Description
 * 
 * <pre>
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Jul 5, 2007             chammack    Initial Creation.
 * 
 * </pre>
 * 
 * @author chammack
 * @version 1.0
 */

public class DataUpdateTree extends DecisionTree<AbstractVizResource<?, ?>> {

    private static DataUpdateTree instance;

    public static synchronized DataUpdateTree getInstance() {
        if (instance == null) {
            instance = new DataUpdateTree();
        }

        return instance;
    }

    public DataUpdateTree() {
        super();
    }

}
