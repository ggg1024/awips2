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

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Pseudogageval generated by hbm2java
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
@Entity
@Table(name = "pseudogageval")
@javax.xml.bind.annotation.XmlRootElement
@javax.xml.bind.annotation.XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.NONE)
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Pseudogageval extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private PseudogagevalId id;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double lat;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double lon;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Float gageValue;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String manEdited;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Float prevGageValue;

    public Pseudogageval() {
    }

    public Pseudogageval(PseudogagevalId id) {
        this.id = id;
    }

    public Pseudogageval(PseudogagevalId id, Double lat, Double lon,
            Float gageValue, String manEdited, Float prevGageValue) {
        this.id = id;
        this.lat = lat;
        this.lon = lon;
        this.gageValue = gageValue;
        this.manEdited = manEdited;
        this.prevGageValue = prevGageValue;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "pseudoGageId", column = @Column(name = "pseudo_gage_id", nullable = false, length = 8)),
            @AttributeOverride(name = "obstime", column = @Column(name = "obstime", nullable = false, length = 29)) })
    public PseudogagevalId getId() {
        return this.id;
    }

    public void setId(PseudogagevalId id) {
        this.id = id;
    }

    @Column(name = "lat", precision = 17, scale = 17)
    public Double getLat() {
        return this.lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    @Column(name = "lon", precision = 17, scale = 17)
    public Double getLon() {
        return this.lon;
    }

    public void setLon(Double lon) {
        this.lon = lon;
    }

    @Column(name = "gage_value", precision = 8, scale = 8)
    public Float getGageValue() {
        return this.gageValue;
    }

    public void setGageValue(Float gageValue) {
        this.gageValue = gageValue;
    }

    @Column(name = "man_edited", length = 1)
    public String getManEdited() {
        return this.manEdited;
    }

    public void setManEdited(String manEdited) {
        this.manEdited = manEdited;
    }

    @Column(name = "prev_gage_value", precision = 8, scale = 8)
    public Float getPrevGageValue() {
        return this.prevGageValue;
    }

    public void setPrevGageValue(Float prevGageValue) {
        this.prevGageValue = prevGageValue;
    }

}
