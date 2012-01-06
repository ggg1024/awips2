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
 * LinesegsId generated by hbm2java
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
public class LinesegsId extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String areaId;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private int hrapRow;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private int hrapBegCol;

    public LinesegsId() {
    }

    public LinesegsId(String areaId, int hrapRow, int hrapBegCol) {
        this.areaId = areaId;
        this.hrapRow = hrapRow;
        this.hrapBegCol = hrapBegCol;
    }

    @Column(name = "area_id", nullable = false, length = 8)
    public String getAreaId() {
        return this.areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    @Column(name = "hrap_row", nullable = false)
    public int getHrapRow() {
        return this.hrapRow;
    }

    public void setHrapRow(int hrapRow) {
        this.hrapRow = hrapRow;
    }

    @Column(name = "hrap_beg_col", nullable = false)
    public int getHrapBegCol() {
        return this.hrapBegCol;
    }

    public void setHrapBegCol(int hrapBegCol) {
        this.hrapBegCol = hrapBegCol;
    }

    public boolean equals(Object other) {
        if ((this == other))
            return true;
        if ((other == null))
            return false;
        if (!(other instanceof LinesegsId))
            return false;
        LinesegsId castOther = (LinesegsId) other;

        return ((this.getAreaId() == castOther.getAreaId()) || (this
                .getAreaId() != null
                && castOther.getAreaId() != null && this.getAreaId().equals(
                castOther.getAreaId())))
                && (this.getHrapRow() == castOther.getHrapRow())
                && (this.getHrapBegCol() == castOther.getHrapBegCol());
    }

    public int hashCode() {
        int result = 17;

        result = 37 * result
                + (getAreaId() == null ? 0 : this.getAreaId().hashCode());
        result = 37 * result + this.getHrapRow();
        result = 37 * result + this.getHrapBegCol();
        return result;
    }

}
