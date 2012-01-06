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
import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Sacsmaparams generated by hbm2java
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
@Table(name = "sacsmaparams")
@javax.xml.bind.annotation.XmlRootElement
@javax.xml.bind.annotation.XmlAccessorType(javax.xml.bind.annotation.XmlAccessType.NONE)
@com.raytheon.uf.common.serialization.annotations.DynamicSerialize
public class Sacsmaparams extends com.raytheon.uf.common.dataplugin.persist.PersistableDataObject implements java.io.Serializable, com.raytheon.uf.common.serialization.ISerializableObject {

    private static final long serialVersionUID = 1L;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private SacsmaparamsId id;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private Date postingtime;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double uztwm;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double uzfwm;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double uzk;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double pctim;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double adimp;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double riva;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double zperc;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double rexp;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double lztwm;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double lzfsm;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double lzfpm;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double lzsk;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double lzpk;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double pfree;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double rserv;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double side;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double peadj;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double pxadj;

    @javax.xml.bind.annotation.XmlElement
    @com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement
    private double efc;

    public Sacsmaparams() {
    }

    public Sacsmaparams(SacsmaparamsId id, Date postingtime, double uztwm,
            double uzfwm, double uzk, double pctim, double adimp, double riva,
            double zperc, double rexp, double lztwm, double lzfsm,
            double lzfpm, double lzsk, double lzpk, double pfree, double rserv,
            double side, double peadj, double pxadj, double efc) {
        this.id = id;
        this.postingtime = postingtime;
        this.uztwm = uztwm;
        this.uzfwm = uzfwm;
        this.uzk = uzk;
        this.pctim = pctim;
        this.adimp = adimp;
        this.riva = riva;
        this.zperc = zperc;
        this.rexp = rexp;
        this.lztwm = lztwm;
        this.lzfsm = lzfsm;
        this.lzfpm = lzfpm;
        this.lzsk = lzsk;
        this.lzpk = lzpk;
        this.pfree = pfree;
        this.rserv = rserv;
        this.side = side;
        this.peadj = peadj;
        this.pxadj = pxadj;
        this.efc = efc;
    }

    @EmbeddedId
    @AttributeOverrides( {
            @AttributeOverride(name = "basinId", column = @Column(name = "basin_id", nullable = false, length = 8)),
            @AttributeOverride(name = "source", column = @Column(name = "source", nullable = false, length = 20)),
            @AttributeOverride(name = "validtime", column = @Column(name = "validtime", nullable = false, length = 29)) })
    public SacsmaparamsId getId() {
        return this.id;
    }

    public void setId(SacsmaparamsId id) {
        this.id = id;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "postingtime", nullable = false, length = 29)
    public Date getPostingtime() {
        return this.postingtime;
    }

    public void setPostingtime(Date postingtime) {
        this.postingtime = postingtime;
    }

    @Column(name = "uztwm", nullable = false, precision = 17, scale = 17)
    public double getUztwm() {
        return this.uztwm;
    }

    public void setUztwm(double uztwm) {
        this.uztwm = uztwm;
    }

    @Column(name = "uzfwm", nullable = false, precision = 17, scale = 17)
    public double getUzfwm() {
        return this.uzfwm;
    }

    public void setUzfwm(double uzfwm) {
        this.uzfwm = uzfwm;
    }

    @Column(name = "uzk", nullable = false, precision = 17, scale = 17)
    public double getUzk() {
        return this.uzk;
    }

    public void setUzk(double uzk) {
        this.uzk = uzk;
    }

    @Column(name = "pctim", nullable = false, precision = 17, scale = 17)
    public double getPctim() {
        return this.pctim;
    }

    public void setPctim(double pctim) {
        this.pctim = pctim;
    }

    @Column(name = "adimp", nullable = false, precision = 17, scale = 17)
    public double getAdimp() {
        return this.adimp;
    }

    public void setAdimp(double adimp) {
        this.adimp = adimp;
    }

    @Column(name = "riva", nullable = false, precision = 17, scale = 17)
    public double getRiva() {
        return this.riva;
    }

    public void setRiva(double riva) {
        this.riva = riva;
    }

    @Column(name = "zperc", nullable = false, precision = 17, scale = 17)
    public double getZperc() {
        return this.zperc;
    }

    public void setZperc(double zperc) {
        this.zperc = zperc;
    }

    @Column(name = "rexp", nullable = false, precision = 17, scale = 17)
    public double getRexp() {
        return this.rexp;
    }

    public void setRexp(double rexp) {
        this.rexp = rexp;
    }

    @Column(name = "lztwm", nullable = false, precision = 17, scale = 17)
    public double getLztwm() {
        return this.lztwm;
    }

    public void setLztwm(double lztwm) {
        this.lztwm = lztwm;
    }

    @Column(name = "lzfsm", nullable = false, precision = 17, scale = 17)
    public double getLzfsm() {
        return this.lzfsm;
    }

    public void setLzfsm(double lzfsm) {
        this.lzfsm = lzfsm;
    }

    @Column(name = "lzfpm", nullable = false, precision = 17, scale = 17)
    public double getLzfpm() {
        return this.lzfpm;
    }

    public void setLzfpm(double lzfpm) {
        this.lzfpm = lzfpm;
    }

    @Column(name = "lzsk", nullable = false, precision = 17, scale = 17)
    public double getLzsk() {
        return this.lzsk;
    }

    public void setLzsk(double lzsk) {
        this.lzsk = lzsk;
    }

    @Column(name = "lzpk", nullable = false, precision = 17, scale = 17)
    public double getLzpk() {
        return this.lzpk;
    }

    public void setLzpk(double lzpk) {
        this.lzpk = lzpk;
    }

    @Column(name = "pfree", nullable = false, precision = 17, scale = 17)
    public double getPfree() {
        return this.pfree;
    }

    public void setPfree(double pfree) {
        this.pfree = pfree;
    }

    @Column(name = "rserv", nullable = false, precision = 17, scale = 17)
    public double getRserv() {
        return this.rserv;
    }

    public void setRserv(double rserv) {
        this.rserv = rserv;
    }

    @Column(name = "side", nullable = false, precision = 17, scale = 17)
    public double getSide() {
        return this.side;
    }

    public void setSide(double side) {
        this.side = side;
    }

    @Column(name = "peadj", nullable = false, precision = 17, scale = 17)
    public double getPeadj() {
        return this.peadj;
    }

    public void setPeadj(double peadj) {
        this.peadj = peadj;
    }

    @Column(name = "pxadj", nullable = false, precision = 17, scale = 17)
    public double getPxadj() {
        return this.pxadj;
    }

    public void setPxadj(double pxadj) {
        this.pxadj = pxadj;
    }

    @Column(name = "efc", nullable = false, precision = 17, scale = 17)
    public double getEfc() {
        return this.efc;
    }

    public void setEfc(double efc) {
        this.efc = efc;
    }

}
