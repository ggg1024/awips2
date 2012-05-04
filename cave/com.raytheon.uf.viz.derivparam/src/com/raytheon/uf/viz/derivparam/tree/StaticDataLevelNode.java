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
package com.raytheon.uf.viz.derivparam.tree;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.raytheon.uf.common.dataplugin.level.Level;
import com.raytheon.uf.common.dataquery.requests.DbQueryRequest;
import com.raytheon.uf.common.dataquery.requests.TimeQueryRequest;
import com.raytheon.uf.common.time.DataTime;
import com.raytheon.uf.viz.core.catalog.LayerProperty;
import com.raytheon.uf.viz.core.exception.VizException;
import com.raytheon.uf.viz.derivparam.data.AbstractRequestableData;
import com.raytheon.uf.viz.derivparam.library.DerivParamDesc;
import com.raytheon.uf.viz.derivparam.library.DerivParamMethod;

/**
 * 
 * A Node which contains IRequestableData rather than real grib records. It is
 * currently assumed that these nodes are available for all times, and when
 * queried for data they will build RequestableDataRecords for each time
 * requested. This class also implements IRequestableData and will just return
 * it's source data, this is done so nodes which can handle
 * IRequestableData(like DerivedLevelNode) can use the RequestableData objects
 * more derictly rather than building a Record.
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Feb 24, 2010            bsteffen     Initial creation
 * 
 * </pre>
 * 
 * @author bsteffen
 * @version 1.0
 */
public class StaticDataLevelNode extends AbstractDerivedLevelNode {

    @Override
    protected DbQueryRequest getDataQueryInternal(
            LayerProperty property,
            int timeOut,
            Map<AbstractRequestableLevelNode, List<AbstractRequestableData>> cache)
            throws VizException {
        return null;
    }

    protected static final String TIME_FIELD = "dataTime";

    protected AbstractRequestableData source;

    public StaticDataLevelNode(StaticDataLevelNode that) {
        super(that);
        this.source = that.source;
    }

    public StaticDataLevelNode(Level level, DerivParamDesc desc,
            DerivParamMethod method, AbstractRequestableData source,
            String modelName) {
        super(level, desc, method, modelName);
        this.source = source;
    }

    public StaticDataLevelNode(Level level, DerivParamDesc desc,
            AbstractRequestableData source, String modelName) {
        super(level, desc, modelName);
        this.source = source;
    }

    public List<AbstractRequestableData> getDataInternal(
            LayerProperty property,
            int timeOut,
            Map<AbstractRequestableLevelNode, List<AbstractRequestableData>> cache)
            throws VizException {
        return Arrays.asList(source);
    }

    @Override
    public Set<DataTime> timeQueryInternal(TimeQueryRequest originalRequest,
            boolean latestOnly,
            Map<AbstractRequestableLevelNode, Set<DataTime>> cache,
            Map<AbstractRequestableLevelNode, Set<DataTime>> latestOnlyCache)
            throws VizException {
        return TIME_AGNOSTIC;
    }

    @Override
    protected TimeQueryRequest getTimeQueryInternal(
            TimeQueryRequest originalRequest, boolean latestOnly,
            Map<AbstractRequestableLevelNode, Set<DataTime>> cache)
            throws VizException {
        return null;
    }

    @Override
    public boolean isConstant() {
        return true;
    }

    @Override
    public boolean isTimeAgnostic() {
        return true;
    }

    /*
     * (non-Javadoc)
     * 
     * @seecom.raytheon.uf.viz.derivparam.tree.AbstractRequestableLevelNode#
     * getDependencies()
     */
    @Override
    public List<Dependency> getDependencies() {
        return Collections.emptyList();
    }

    @Override
    public StaticDataLevelNode clone() {
        return new StaticDataLevelNode(this);
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#hashCode()
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = super.hashCode();
        result = prime * result + ((source == null) ? 0 : source.hashCode());
        return result;
    }

    /*
     * (non-Javadoc)
     * 
     * @see java.lang.Object#equals(java.lang.Object)
     */
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (!super.equals(obj))
            return false;
        if (getClass() != obj.getClass())
            return false;
        StaticDataLevelNode other = (StaticDataLevelNode) obj;
        if (source == null) {
            if (other.source != null)
                return false;
        } else if (!source.equals(other.source))
            return false;
        return true;
    }

}
