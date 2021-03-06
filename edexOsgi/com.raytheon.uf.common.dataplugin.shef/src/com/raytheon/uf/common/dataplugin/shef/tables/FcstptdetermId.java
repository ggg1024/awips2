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
 * FcstptdetermId generated by hbm2java
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
public class FcstptdetermId extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable {

    private static final long serialVersionUID = 1L;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String lid;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String snowMethod;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String hydrolMethod;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String reservoirModel;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String upstreamSeg;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String hydraulMethod;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String defIssueCrit;

    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private short hoursQpf;

    public FcstptdetermId() {
    }

    public FcstptdetermId(String lid, String snowMethod, String hydrolMethod,
            String reservoirModel, String upstreamSeg, String hydraulMethod,
            String defIssueCrit, short hoursQpf) {
        this.lid = lid;
        this.snowMethod = snowMethod;
        this.hydrolMethod = hydrolMethod;
        this.reservoirModel = reservoirModel;
        this.upstreamSeg = upstreamSeg;
        this.hydraulMethod = hydraulMethod;
        this.defIssueCrit = defIssueCrit;
        this.hoursQpf = hoursQpf;
    }

    @Column(name = "lid", nullable = false, length = 8)
    public String getLid() {
        return this.lid;
    }

    public void setLid(String lid) {
        this.lid = lid;
    }

    @Column(name = "snow_method", nullable = false, length = 30)
    public String getSnowMethod() {
        return this.snowMethod;
    }

    public void setSnowMethod(String snowMethod) {
        this.snowMethod = snowMethod;
    }

    @Column(name = "hydrol_method", nullable = false, length = 30)
    public String getHydrolMethod() {
        return this.hydrolMethod;
    }

    public void setHydrolMethod(String hydrolMethod) {
        this.hydrolMethod = hydrolMethod;
    }

    @Column(name = "reservoir_model", nullable = false, length = 30)
    public String getReservoirModel() {
        return this.reservoirModel;
    }

    public void setReservoirModel(String reservoirModel) {
        this.reservoirModel = reservoirModel;
    }

    @Column(name = "upstream_seg", nullable = false, length = 8)
    public String getUpstreamSeg() {
        return this.upstreamSeg;
    }

    public void setUpstreamSeg(String upstreamSeg) {
        this.upstreamSeg = upstreamSeg;
    }

    @Column(name = "hydraul_method", nullable = false, length = 30)
    public String getHydraulMethod() {
        return this.hydraulMethod;
    }

    public void setHydraulMethod(String hydraulMethod) {
        this.hydraulMethod = hydraulMethod;
    }

    @Column(name = "def_issue_crit", nullable = false, length = 50)
    public String getDefIssueCrit() {
        return this.defIssueCrit;
    }

    public void setDefIssueCrit(String defIssueCrit) {
        this.defIssueCrit = defIssueCrit;
    }

    @Column(name = "hours_qpf", nullable = false)
    public short getHoursQpf() {
        return this.hoursQpf;
    }

    public void setHoursQpf(short hoursQpf) {
        this.hoursQpf = hoursQpf;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof FcstptdetermId))
            return false;
        FcstptdetermId castOther = (FcstptdetermId) other;

        return ((this.getLid() == castOther.getLid()) || (this.getLid() != null
                && castOther.getLid() != null && this.getLid().equals(
                castOther.getLid())))
                && ((this.getSnowMethod() == castOther.getSnowMethod()) || (this
                        .getSnowMethod() != null
                        && castOther.getSnowMethod() != null && this
                        .getSnowMethod().equals(castOther.getSnowMethod())))
                && ((this.getHydrolMethod() == castOther.getHydrolMethod()) || (this
                        .getHydrolMethod() != null
                        && castOther.getHydrolMethod() != null && this
                        .getHydrolMethod().equals(castOther.getHydrolMethod())))
                && ((this.getReservoirModel() == castOther.getReservoirModel()) || (this
                        .getReservoirModel() != null
                        && castOther.getReservoirModel() != null && this
                        .getReservoirModel().equals(
                                castOther.getReservoirModel())))
                && ((this.getUpstreamSeg() == castOther.getUpstreamSeg()) || (this
                        .getUpstreamSeg() != null
                        && castOther.getUpstreamSeg() != null && this
                        .getUpstreamSeg().equals(castOther.getUpstreamSeg())))
                && ((this.getHydraulMethod() == castOther.getHydraulMethod()) || (this
                        .getHydraulMethod() != null
                        && castOther.getHydraulMethod() != null && this
                        .getHydraulMethod()
                        .equals(castOther.getHydraulMethod())))
                && ((this.getDefIssueCrit() == castOther.getDefIssueCrit()) || (this
                        .getDefIssueCrit() != null
                        && castOther.getDefIssueCrit() != null && this
                        .getDefIssueCrit().equals(castOther.getDefIssueCrit())))
                && (this.getHoursQpf() == castOther.getHoursQpf());
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result
                + (getLid() == null ? 0 : this.getLid().hashCode());
        result = 37
                * result
                + (getSnowMethod() == null ? 0 : this.getSnowMethod()
                        .hashCode());
        result = 37
                * result
                + (getHydrolMethod() == null ? 0 : this.getHydrolMethod()
                        .hashCode());
        result = 37
                * result
                + (getReservoirModel() == null ? 0 : this.getReservoirModel()
                        .hashCode());
        result = 37
                * result
                + (getUpstreamSeg() == null ? 0 : this.getUpstreamSeg()
                        .hashCode());
        result = 37
                * result
                + (getHydraulMethod() == null ? 0 : this.getHydraulMethod()
                        .hashCode());
        result = 37
                * result
                + (getDefIssueCrit() == null ? 0 : this.getDefIssueCrit()
                        .hashCode());
        result = 37 * result + this.getHoursQpf();
        return result;
    }

}
