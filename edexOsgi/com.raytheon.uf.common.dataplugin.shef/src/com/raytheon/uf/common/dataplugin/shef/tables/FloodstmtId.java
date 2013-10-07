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
package com.raytheon.uf.common.dataplugin.shef.tables;
// default package
// Generated Oct 17, 2008 2:22:17 PM by Hibernate Tools 3.2.2.GA

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * FloodstmtId generated by hbm2java
 * 
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Oct 17, 2008                        Initial generation by hbm2java
 * Aug 19, 2011      10672     jkorman Move refactor to new project
 * Oct 07, 2013       2361     njensen Removed XML annotations
 * 
 * </pre>
 * 
 * @author jkorman
 * @version 1.1
 */
@Embeddable
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class FloodstmtId extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String lid;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double impactValue;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String rf;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String datestart;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String dateend;

    public FloodstmtId() {
    }

    public FloodstmtId(String lid, double impactValue, String rf,
            String datestart, String dateend) {
        this.lid = lid;
        this.impactValue = impactValue;
        this.rf = rf;
        this.datestart = datestart;
        this.dateend = dateend;
    }

    @Column(name = "lid", nullable = false, length = 8)
    public String getLid() {
        return this.lid;
    }

    public void setLid(String lid) {
        this.lid = lid;
    }

    @Column(name = "impact_value", nullable = false, precision = 17, scale = 17)
    public double getImpactValue() {
        return this.impactValue;
    }

    public void setImpactValue(double impactValue) {
        this.impactValue = impactValue;
    }

    @Column(name = "rf", nullable = false, length = 1)
    public String getRf() {
        return this.rf;
    }

    public void setRf(String rf) {
        this.rf = rf;
    }

    @Column(name = "datestart", nullable = false, length = 5)
    public String getDatestart() {
        return this.datestart;
    }

    public void setDatestart(String datestart) {
        this.datestart = datestart;
    }

    @Column(name = "dateend", nullable = false, length = 5)
    public String getDateend() {
        return this.dateend;
    }

    public void setDateend(String dateend) {
        this.dateend = dateend;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof FloodstmtId))
            return false;
        FloodstmtId castOther = (FloodstmtId) other;

        return ((this.getLid() == castOther.getLid()) || (this.getLid() != null
                && castOther.getLid() != null && this.getLid().equals(
                castOther.getLid())))
                && (this.getImpactValue() == castOther.getImpactValue())
                && ((this.getRf() == castOther.getRf()) || (this.getRf() != null
                        && castOther.getRf() != null && this.getRf().equals(
                        castOther.getRf())))
                && ((this.getDatestart() == castOther.getDatestart()) || (this
                        .getDatestart() != null
                        && castOther.getDatestart() != null && this
                        .getDatestart().equals(castOther.getDatestart())))
                && ((this.getDateend() == castOther.getDateend()) || (this
                        .getDateend() != null
                        && castOther.getDateend() != null && this.getDateend()
                        .equals(castOther.getDateend())));
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result
                + (getLid() == null ? 0 : this.getLid().hashCode());
        result = 37 * result + (int) this.getImpactValue();
        result = 37 * result + (getRf() == null ? 0 : this.getRf().hashCode());
        result = 37 * result
                + (getDatestart() == null ? 0 : this.getDatestart().hashCode());
        result = 37 * result
                + (getDateend() == null ? 0 : this.getDateend().hashCode());
        return result;
    }

}
