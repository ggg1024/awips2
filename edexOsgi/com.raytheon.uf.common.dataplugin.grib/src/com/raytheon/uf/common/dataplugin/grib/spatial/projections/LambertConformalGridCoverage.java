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

package com.raytheon.uf.common.dataplugin.grib.spatial.projections;

import javax.measure.converter.UnitConverter;
import javax.measure.unit.SI;
import javax.measure.unit.Unit;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.HashCodeBuilder;
import org.opengis.referencing.operation.MathTransform;

import com.raytheon.uf.common.dataplugin.grib.exception.GribException;
import com.raytheon.uf.common.dataplugin.grib.spatial.projections.TrimUtil.Trim;
import com.raytheon.uf.common.dataplugin.grib.subgrid.SubGrid;
import com.raytheon.uf.common.dataplugin.grib.subgrid.SubGridDef;
import com.raytheon.uf.common.geospatial.MapUtil;
import com.raytheon.uf.common.serialization.annotations.DynamicSerialize;
import com.raytheon.uf.common.serialization.annotations.DynamicSerializeElement;
import com.raytheon.uf.common.status.IUFStatusHandler;
import com.raytheon.uf.common.status.UFStatus;
import com.raytheon.uf.common.status.UFStatus.Priority;

/**
 * Defines a Lambert Conformal grid coverage. This class is generally used to
 * describe grids described by GDS Template 30 as specified in Table 3.1
 * 
 * <pre>
 * 
 * SOFTWARE HISTORY
 * 
 * Date         Ticket#     Engineer    Description
 * ------------ ----------  ----------- --------------------------
 * 4/7/09       1994        bphillip    Initial Creation
 * 
 * </pre>
 * 
 * @author bphillip
 * @version 1
 */
@Entity
@Table(name = "grib_lambertconformal_coverages")
@XmlRootElement
@XmlAccessorType(XmlAccessType.NONE)
@DynamicSerialize
public class LambertConformalGridCoverage extends GridCoverage {
    private static final transient IUFStatusHandler statusHandler = UFStatus
            .getHandler(LambertConformalGridCoverage.class);

    private static final long serialVersionUID = 5113332463602932317L;

    /** The name of the projectio */
    public static final String PROJECTION_TYPE = "Lambert Conformal";

    /** The minor axis of the Earth */
    @Column
    @XmlElement
    @DynamicSerializeElement
    private double minorAxis;

    /** The major axis of the Earth */
    @Column
    @XmlElement
    @DynamicSerializeElement
    private double majorAxis;

    /**
     * Longitude of meridian parallel to y-axis along which latitude increases
     * as the y-coordinate increases
     */
    @Column
    @XmlElement
    @DynamicSerializeElement
    private double lov;

    /** First latitude from the pole at which the secant cone cuts the sphere **/
    @Column
    @XmlElement
    @DynamicSerializeElement
    private double latin1;

    /** Second latitude from the pole at which the secant cone cuts the sphere **/
    @Column
    @XmlElement
    @DynamicSerializeElement
    private double latin2;

    @Override
    public int generateHash() {
        HashCodeBuilder hashBuilder = new HashCodeBuilder();
        hashBuilder.append(super.generateHash());
        hashBuilder.append(lov);
        hashBuilder.append(latin1);
        hashBuilder.append(latin2);
        return hashBuilder.toHashCode();
    }

    @Override
    public void initialize() throws GribException {
        crs = MapUtil.constructLambertConformal(majorAxis, minorAxis, latin1,
                latin2, lov);
        crsWKT = crs.toWKT();
        generateGeometry();
        id = generateHash();
    }

    public void generateName() {
        String nameAndDescription = "Unknown " + nx + " X " + ny + " "
                + Math.round(dx) + " " + spacingUnit + " "
                + getProjectionType() + " grid";
        this.setName(nameAndDescription);
        this.setDescription(nameAndDescription);
    }

    @Override
    public GridCoverage trim(SubGridDef subGridDef, SubGrid subGrid) {
        LambertConformalGridCoverage rval = new LambertConformalGridCoverage();
        rval.description = this.description;
        rval.dx = this.dx;
        rval.dy = this.dy;
        rval.spacingUnit = this.spacingUnit;
        rval.latin1 = this.latin1;
        rval.latin2 = this.latin2;
        rval.lov = this.lov;
        rval.majorAxis = this.majorAxis;
        rval.minorAxis = this.minorAxis;

        rval.setName(this.name + "-SubGrid-" + subGrid.getModelName());

        try {
            Unit<?> spacingUnitObj = Unit.valueOf(spacingUnit);
            if (spacingUnitObj.isCompatible(SI.METRE)) {
                UnitConverter converter = spacingUnitObj
                        .getConverterTo(SI.METRE);
                double dxMeter = converter.convert(dx);
                double dyMeter = converter.convert(dy);
                MathTransform fromLatLon = MapUtil
                        .getTransformFromLatLon(getCrs());
                MathTransform toLatLon = fromLatLon.inverse();

                Trim trim = null;
                try {
                    trim = TrimUtil.trimMeterSpace(getLowerLeftLat(),
                            getLowerLeftLon(), subGridDef, this.nx, this.ny,
                            dxMeter, dyMeter, fromLatLon, toLatLon, true);
                } catch (GribException e) {
                    statusHandler.handle(Priority.WARN, "Grib coverage ["
                            + this.getName() + "] not applicable to this site");
                    return null;
                }

                subGrid.setUpperLeftX(trim.upperLeftX);
                subGrid.setUpperLeftY(trim.upperLeftY);

                subGrid.setNX(trim.nx);
                subGrid.setNY(trim.ny);

                rval.firstGridPointCorner = Corner.LowerLeft;
                rval.lo1 = trim.lowerLeftLon;
                rval.la1 = trim.lowerLeftLat;
                rval.nx = trim.nx;
                rval.ny = trim.ny;

                rval.setId(rval.hashCode());
            } else {
                statusHandler.handle(
                        Priority.PROBLEM,
                        "Error creating sub grid definition ["
                                + subGrid.getModelName()
                                + "], units are not compatible with meter ["
                                + spacingUnit + "]");
                rval = null;
            }
        } catch (Exception e) {
            statusHandler.handle(Priority.PROBLEM,
                    "Error creating sub grid definition", e);
            rval = null;
        }

        return rval;
    }

    @Override
    public String getProjectionType() {
        return PROJECTION_TYPE;
    }

    /**
     * Gets the minor axis
     * 
     * @return The minor axis
     */
    public double getMinorAxis() {
        return minorAxis;
    }

    /**
     * Sets the minor axis
     * 
     * @param minorAxis
     *            The minor axis
     */
    public void setMinorAxis(double minorAxis) {
        this.minorAxis = minorAxis;
    }

    /**
     * Gets the major axis
     * 
     * @return The major axis
     */
    public double getMajorAxis() {
        return majorAxis;
    }

    /**
     * Sets the major axis
     * 
     * @param majorAxis
     *            The major axis
     */
    public void setMajorAxis(double majorAxis) {
        this.majorAxis = majorAxis;
    }

    /**
     * Gets lov
     * 
     * @return Lov longitude value
     */
    public double getLov() {
        return lov;
    }

    /**
     * Sets lov
     * 
     * @param lov
     *            lov longitude value
     */
    public void setLov(double lov) {
        this.lov = lov;
    }

    /**
     * Gets latin1
     * 
     * @return Gets the latin1 latitude value
     */
    public double getLatin1() {
        return latin1;
    }

    /**
     * Sets latin1
     * 
     * @param latin1
     *            The latin1 latitude value
     */
    public void setLatin1(double latin1) {
        this.latin1 = latin1;
    }

    /**
     * Gets latin2
     * 
     * @return The latin2 latitude value
     */
    public double getLatin2() {
        return latin2;
    }

    /**
     * Sets latin2
     * 
     * @param latin2
     *            The latin2 latitude value
     */
    public void setLatin2(double latin2) {
        this.latin2 = latin2;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        if (!super.equals(obj)) {
            return false;
        }
        LambertConformalGridCoverage other = (LambertConformalGridCoverage) obj;
        if (Double.doubleToLongBits(latin1) != Double
                .doubleToLongBits(other.latin1))
            return false;
        if (Double.doubleToLongBits(latin2) != Double
                .doubleToLongBits(other.latin2))
            return false;
        if (Double.doubleToLongBits(lov) != Double.doubleToLongBits(other.lov))
            return false;
        if (Double.doubleToLongBits(majorAxis) != Double
                .doubleToLongBits(other.majorAxis))
            return false;
        if (Double.doubleToLongBits(minorAxis) != Double
                .doubleToLongBits(other.minorAxis))
            return false;
        return true;
    }

    public LambertConformalGridCoverage() {
        super();
    }

    public LambertConformalGridCoverage(LambertConformalGridCoverage coverage) {
        super(coverage);
        this.latin1 = coverage.latin1;
        this.latin2 = coverage.latin2;
        this.lov = coverage.lov;
        this.majorAxis = coverage.majorAxis;
        this.minorAxis = coverage.minorAxis;
    }

}
