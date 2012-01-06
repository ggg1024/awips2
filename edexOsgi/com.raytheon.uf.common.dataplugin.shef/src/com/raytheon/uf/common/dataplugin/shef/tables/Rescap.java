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
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Rescap generated by hbm2java
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
@Table(name = "rescap")
@javax.xml.bind.annotation.XmlRootElement
@javax.xml.bind.annotation.XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.NONE)
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Rescap extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private RescapId id;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Reservoir reservoir;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Double storage;

    public Rescap() {
    }

    public Rescap(RescapId id, Reservoir reservoir) {
        this.id = id;
        this.reservoir = reservoir;
    }

    public Rescap(RescapId id, Reservoir reservoir, Double storage) {
        this.id = id;
        this.reservoir = reservoir;
        this.storage = storage;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "lid", column = @Column(name = "lid", nullable = false, length = 8)),
            @AttributeOverride(name = "elev", column = @Column(name = "elev", nullable = false, precision = 17, scale = 17)) })
    public RescapId getId() {
        return this.id;
    }

    public void setId(RescapId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "lid", nullable = false, insertable = false, updatable = false)
    public Reservoir getReservoir() {
        return this.reservoir;
    }

    public void setReservoir(Reservoir reservoir) {
        this.reservoir = reservoir;
    }

    @Column(name = "storage", precision = 17, scale = 17)
    public Double getStorage() {
        return this.storage;
    }

    public void setStorage(Double storage) {
        this.storage = storage;
    }

}
