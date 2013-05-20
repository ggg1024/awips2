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
package com.raytheon.uf.viz.datadelivery.handlers;

import java.util.List;

import com.raytheon.uf.common.datadelivery.registry.SubscriptionDeleteRequest;
import com.raytheon.uf.common.datadelivery.registry.handlers.ISharedSubscriptionHandler;
import com.raytheon.uf.common.datadelivery.registry.handlers.ISiteSubscriptionHandler;
import com.raytheon.uf.common.datadelivery.registry.handlers.ISubscriptionHandler;
import com.raytheon.uf.common.datadelivery.registry.handlers.SubscriptionHandler;
import com.raytheon.uf.common.datadelivery.request.DataDeliveryConstants;
import com.raytheon.uf.common.registry.handler.RegistryHandlerException;
import com.raytheon.uf.common.serialization.comm.RequestRouter;

/**
 * Extends the {@link SubscriptionHandler} to pass deletion requests to the
 * server since they must execute several registry interactions in one atomic
 * transaction.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Sep 27, 2012 1187       djohnson     Initial creation
 * Nov 15, 2012 1286       djohnson     Use server-keyed routing.
 * Mar 29, 2013 1841       djohnson     Composes a userSubscriptionsHandler.
 * Apr 05, 2013 1841       djohnson     Add shared subscription support.
 * May 21, 2013 2020       mpduff       Rename UserSubscription to SiteSubscription.
 * 
 * </pre>
 * 
 * @author djohnson
 * @version 1.0
 */
public class VizSubscriptionHandler extends SubscriptionHandler {

    /**
     * Constructor.
     * 
     * @param siteSubscriptionHandler
     * @param sharedSubscriptionHandler
     */
    public VizSubscriptionHandler(
            ISiteSubscriptionHandler siteSubscriptionHandler,
            ISharedSubscriptionHandler sharedSubscriptionHandler) {
        super(siteSubscriptionHandler, sharedSubscriptionHandler);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    public void deleteByIds(String username, List<String> ids)
            throws RegistryHandlerException {
        
        SubscriptionDeleteRequest request = new SubscriptionDeleteRequest(ids,
                ISubscriptionHandler.class, username);

        try {
            RequestRouter.route(request,
                    DataDeliveryConstants.DATA_DELIVERY_SERVER);
        } catch (Exception e) {
            throw new RegistryHandlerException(
                    "Unable to delete subscriptions.", e);
        }
    }

}
