//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2012.01.10 at 11:00:08 AM CST 
//


package org.isotc211._2005.gmd;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for EX_GeographicDescription_Type complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="EX_GeographicDescription_Type">
 *   &lt;complexContent>
 *     &lt;extension base="{http://www.isotc211.org/2005/gmd}AbstractEX_GeographicExtent_Type">
 *       &lt;sequence>
 *         &lt;element name="geographicIdentifier" type="{http://www.isotc211.org/2005/gmd}MD_Identifier_PropertyType"/>
 *       &lt;/sequence>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "EX_GeographicDescription_Type", propOrder = {
    "geographicIdentifier"
})
public class EXGeographicDescriptionType
    extends AbstractEXGeographicExtentType
{

    @XmlElement(required = true)
    protected MDIdentifierPropertyType geographicIdentifier;

    /**
     * Gets the value of the geographicIdentifier property.
     * 
     * @return
     *     possible object is
     *     {@link MDIdentifierPropertyType }
     *     
     */
    public MDIdentifierPropertyType getGeographicIdentifier() {
        return geographicIdentifier;
    }

    /**
     * Sets the value of the geographicIdentifier property.
     * 
     * @param value
     *     allowed object is
     *     {@link MDIdentifierPropertyType }
     *     
     */
    public void setGeographicIdentifier(MDIdentifierPropertyType value) {
        this.geographicIdentifier = value;
    }

}
