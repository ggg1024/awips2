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
package com.raytheon.uf.edex.datadelivery.bandwidth;

import org.junit.After;
import org.junit.Before;

import com.raytheon.uf.edex.core.EDEXUtil;
import com.raytheon.uf.edex.database.dao.DatabaseUtil;
import com.raytheon.uf.edex.datadelivery.bandwidth.hibernate.HibernateBandwidthDao;

/**
 * Implementation of {@link AbstractBandwidthDaoTest} for
 * {@link HibernateBandwidthDao}.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Nov 13, 2012 1286       djohnson     Initial creation
 * 
 * </pre>
 * 
 * @author djohnson
 * @version 1.0
 */

public class HibernateBandwidthDaoTest extends
        AbstractBandwidthDaoTest<HibernateBandwidthDao> {

    @Override
    @Before
    public void setUp() {
        DatabaseUtil.start();

        // The database must be started before constructing the DAO for
        // Hibernate
        super.setUp();
    }

    @After
    public void tearDown() {
        DatabaseUtil.shutdown();
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected HibernateBandwidthDao getDao() {
        return (HibernateBandwidthDao) EDEXUtil
                .getESBComponent("hibernateBandwidthDao");
    }

}
