/**
 * Copyright 09/24/12 Raytheon Company.
 *
 * Unlimited Rights
 * This software was developed pursuant to Contract Number 
 * DTFAWA-10-D-00028 with the US Government. The US Government’s rights 
 * in and to this copyrighted software are as specified in DFARS
 * 252.227-7014 which was made part of the above contract. 
 */
package com.raytheon.uf.edex.wcs.soap1_1_2;

import java.util.HashMap;
import java.util.Map;

import javax.activation.DataHandler;
import javax.annotation.Resource;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

import net.opengis.wcs.v_1_1_2.Capabilities;
import net.opengis.wcs.v_1_1_2.CoverageDescriptions;
import net.opengis.wcs.v_1_1_2.CoveragesType;
import net.opengis.wcs.v_1_1_2.DescribeCoverage;
import net.opengis.wcs.v_1_1_2.GetCapabilities;
import net.opengis.wcs.v_1_1_2.GetCoverage;

import com.raytheon.uf.common.status.IUFStatusHandler;
import com.raytheon.uf.common.status.UFStatus;
import com.raytheon.uf.edex.ogc.common.soap.AbstractOwsService;
import com.raytheon.uf.edex.ogc.common.soap.ServiceExceptionReport;
import com.raytheon.uf.edex.ogc.common.stats.OgcStatsRecorder;
import com.raytheon.uf.edex.ogc.common.stats.StatsRecorderFinder;
import com.raytheon.uf.edex.wcs.CoveragesHolder;
import com.raytheon.uf.edex.wcs.WcsException;
import com.raytheon.uf.edex.wcs.WcsException.Code;
import com.raytheon.uf.edex.wcs.provider.OgcWcsProvider;
import com.raytheon.uf.edex.wcs.request.DescCoverageRequest;
import com.raytheon.uf.edex.wcs.request.GetCoverageRequest;

/**
 * TODO Add Description
 * 
 * <pre>
 * R
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Nov 28, 2012            bclement     Initial creation
 * 
 * </pre>
 * 
 * @author bclement
 * @version 1.0
 */

public class WcsImpl extends AbstractOwsService implements IWcsPortType {

    protected OgcWcsProvider provider;

    @Resource
    protected WebServiceContext context;

    private static final String VERSION = "1.1.2";

    protected IUFStatusHandler log = UFStatus.getHandler(this.getClass());

    public WcsImpl(OgcWcsProvider provider) {
        this.provider = provider;
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.uf.edex.wcs.soap1_1_2.WcsPortType#getCapabilitiesOperation
     * (net.opengis.wcs.v_1_1_2.GetCapabilities)
     */
    @Override
    public Capabilities getCapabilitiesOperation(GetCapabilities body)
            throws ServiceExceptionReport {
        long start = System.nanoTime();
        boolean success = true;
        try {
            return provider.getCapabilities(getInfo(), body);
        } catch (Exception e) {
            success = false;
            log.error("Problem with get coverage", e);
            throw getReport(Code.InternalServerError.toString(),
                    "Internal Server Error", VERSION);
        } finally {
            OgcStatsRecorder statRecorder = StatsRecorderFinder.find();
            statRecorder.recordRequest(System.currentTimeMillis(),
                    System.nanoTime() - start, "WCS", success);
        }
    }

    protected ServiceExceptionReport getReport(WcsException e) {
        return super.getReport(e.getCode().toString(), e.getMessage(), VERSION);
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.uf.edex.wcs.soap1_1_2.WcsPortType#describeCoverageOperation
     * (net.opengis.wcs.v_1_1_2.DescribeCoverage)
     */
    @Override
    public CoverageDescriptions describeCoverageOperation(DescribeCoverage body)
            throws ServiceExceptionReport {
        long start = System.nanoTime();
        boolean success = true;
        try {
            return provider.describeCoverage(getInfo(),
                    new DescCoverageRequest(body));
        } catch (WcsException e) {
            success = false;
            throw getReport(e);
        } finally {
            OgcStatsRecorder statRecorder = StatsRecorderFinder.find();
            statRecorder.recordRequest(System.currentTimeMillis(),
                    System.nanoTime() - start, "WCS", success);
        }
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.raytheon.uf.edex.wcs.soap1_1_2.WcsPortType#getCoverageOperation(net
     * .opengis.wcs.v_1_1_2.GetCoverage)
     */
    @Override
    public CoveragesType getCoverageOperation(GetCoverage body)
            throws ServiceExceptionReport {
        long start = System.nanoTime();
        boolean success = true;
        try {
            CoveragesHolder holder = provider.getCoverage(getInfo(),
                    new GetCoverageRequest(body));
            Map<String, Object> attachments = getAttachments(holder);
            context.getMessageContext().put(
                    MessageContext.OUTBOUND_MESSAGE_ATTACHMENTS, attachments);
            return holder.getMetadata();
        } catch (WcsException e) {
            success = false;
            throw getReport(e);
        } catch (Exception e) {
            success = false;
            log.error("Problem with get coverage", e);
            throw getReport(Code.InternalServerError.toString(),
                    "Internal Server Error", VERSION);
        } finally {
            OgcStatsRecorder statRecorder = StatsRecorderFinder.find();
            statRecorder.recordRequest(System.currentTimeMillis(),
                    System.nanoTime() - start, "WCS", success);
        }
    }

    /**
     * Wrap attachments in data handlers
     * 
     * @param holder
     * @return
     */
    private Map<String, Object> getAttachments(CoveragesHolder holder) {
        String contentType = holder.getContentType();
        Map<String, byte[]> data = holder.getData();
        Map<String, Object> rval = new HashMap<String, Object>(data.size());
        for (String id : data.keySet()) {
            DataHandler h = new DataHandler(data.get(id), contentType);
            rval.put(id, h);
        }
        return rval;
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.raytheon.uf.edex.ogc.common.soap.AbstractOwsService#getContext()
     */
    @Override
    protected WebServiceContext getContext() {
        return context;
    }

}
