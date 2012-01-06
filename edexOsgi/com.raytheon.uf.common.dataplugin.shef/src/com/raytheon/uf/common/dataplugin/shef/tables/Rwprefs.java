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
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Rwprefs generated by hbm2java
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
@Table(name = "rwprefs")
@javax.xml.bind.annotation.XmlRootElement
@javax.xml.bind.annotation.XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.NONE)
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Rwprefs extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String userid;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String stateOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String cityOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String countyOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String riverOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String basinOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String radarOverlay;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Short numHoursWind;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private String defDisplayType;

    public Rwprefs() {
    }

    public Rwprefs(String userid) {
        this.userid = userid;
    }

    public Rwprefs(String userid, String stateOverlay, String cityOverlay,
            String countyOverlay, String riverOverlay, String basinOverlay,
            String radarOverlay, Short numHoursWind, String defDisplayType) {
        this.userid = userid;
        this.stateOverlay = stateOverlay;
        this.cityOverlay = cityOverlay;
        this.countyOverlay = countyOverlay;
        this.riverOverlay = riverOverlay;
        this.basinOverlay = basinOverlay;
        this.radarOverlay = radarOverlay;
        this.numHoursWind = numHoursWind;
        this.defDisplayType = defDisplayType;
    }

    @Id
    @Column(name = "userid", unique = true, nullable = false, length = 32)
    public String getUserid() {
        return this.userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    @Column(name = "state_overlay", length = 3)
    public String getStateOverlay() {
        return this.stateOverlay;
    }

    public void setStateOverlay(String stateOverlay) {
        this.stateOverlay = stateOverlay;
    }

    @Column(name = "city_overlay", length = 3)
    public String getCityOverlay() {
        return this.cityOverlay;
    }

    public void setCityOverlay(String cityOverlay) {
        this.cityOverlay = cityOverlay;
    }

    @Column(name = "county_overlay", length = 3)
    public String getCountyOverlay() {
        return this.countyOverlay;
    }

    public void setCountyOverlay(String countyOverlay) {
        this.countyOverlay = countyOverlay;
    }

    @Column(name = "river_overlay", length = 3)
    public String getRiverOverlay() {
        return this.riverOverlay;
    }

    public void setRiverOverlay(String riverOverlay) {
        this.riverOverlay = riverOverlay;
    }

    @Column(name = "basin_overlay", length = 3)
    public String getBasinOverlay() {
        return this.basinOverlay;
    }

    public void setBasinOverlay(String basinOverlay) {
        this.basinOverlay = basinOverlay;
    }

    @Column(name = "radar_overlay", length = 3)
    public String getRadarOverlay() {
        return this.radarOverlay;
    }

    public void setRadarOverlay(String radarOverlay) {
        this.radarOverlay = radarOverlay;
    }

    @Column(name = "num_hours_wind")
    public Short getNumHoursWind() {
        return this.numHoursWind;
    }

    public void setNumHoursWind(Short numHoursWind) {
        this.numHoursWind = numHoursWind;
    }

    @Column(name = "def_display_type", length = 10)
    public String getDefDisplayType() {
        return this.defDisplayType;
    }

    public void setDefDisplayType(String defDisplayType) {
        this.defDisplayType = defDisplayType;
    }

}
