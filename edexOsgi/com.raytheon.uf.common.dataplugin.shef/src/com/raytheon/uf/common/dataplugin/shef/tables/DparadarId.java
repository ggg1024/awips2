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

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * DparadarId generated by hbm2java
 * 
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * Date         Ticket#    Engineer    Description
 * ------------ ---------- ----------- --------------------------
 * Oct 17, 2008                        Initial generation by hbm2java
 * Aug 19, 2011      10672     jkorman Move refactor to new project
 * 
 * </pre>
 * 
 * @author jkorman
 * @version 1.1
 */
@Embeddable
@javax.xml.bind.annotation.XmlRootElement
@javax.xml.bind.annotation.XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.NONE)
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class DparadarId extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String radid;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Date obstime;

    public DparadarId() {
    }

    public DparadarId(String radid, Date obstime) {
        this.radid = radid;
        this.obstime = obstime;
    }

    @Column(name = "radid", nullable = false, length = 3)
    public String getRadid() {
        return this.radid;
    }

    public void setRadid(String radid) {
        this.radid = radid;
    }

    @Column(name = "obstime", nullable = false, length = 29)
    public Date getObstime() {
        return this.obstime;
    }

    public void setObstime(Date obstime) {
        this.obstime = obstime;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof DparadarId))
            return false;
        DparadarId castOther = (DparadarId) other;

        return ((this.getRadid() == castOther.getRadid()) || (this.getRadid() != null
                && castOther.getRadid() != null && this.getRadid().equals(
                castOther.getRadid())))
                && ((this.getObstime() == castOther.getObstime()) || (this
                        .getObstime() != null
                        && castOther.getObstime() != null && this.getObstime()
                        .equals(castOther.getObstime())));
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result
                + (getRadid() == null ? 0 : this.getRadid().hashCode());
        result = 37 * result
                + (getObstime() == null ? 0 : this.getObstime().hashCode());
        return result;
    }

}
