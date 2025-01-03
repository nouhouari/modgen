//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2019.06.27 at 12:11:15 PM MYT 
//


package fr.hin.modelgenerator.ecore;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for EOperation complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="EOperation">
 *   &lt;complexContent>
 *     &lt;extension base="{http://www.eclipse.org/emf/2002/Ecore}ETypedElement">
 *       &lt;sequence>
 *         &lt;element name="eTypeParameters" type="{http://www.eclipse.org/emf/2002/Ecore}ETypeParameter" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="eParameters" type="{http://www.eclipse.org/emf/2002/Ecore}EParameter" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="eGenericExceptions" type="{http://www.eclipse.org/emf/2002/Ecore}EGenericType" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="eExceptions">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *     &lt;/extension>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "EOperation", propOrder = {
    "eTypeParameters",
    "eParameters",
    "eGenericExceptions"
})
public class EOperation
    extends ETypedElement
{

    protected List<ETypeParameter> eTypeParameters;
    protected List<EParameter> eParameters;
    protected List<EGenericType> eGenericExceptions;
    @XmlAttribute(name = "eExceptions")
    protected List<String> eExceptions;

    /**
     * Gets the value of the eTypeParameters property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eTypeParameters property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getETypeParameters().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ETypeParameter }
     * 
     * 
     */
    public List<ETypeParameter> getETypeParameters() {
        if (eTypeParameters == null) {
            eTypeParameters = new ArrayList<ETypeParameter>();
        }
        return this.eTypeParameters;
    }

    /**
     * Gets the value of the eParameters property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eParameters property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEParameters().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link EParameter }
     * 
     * 
     */
    public List<EParameter> getEParameters() {
        if (eParameters == null) {
            eParameters = new ArrayList<EParameter>();
        }
        return this.eParameters;
    }

    /**
     * Gets the value of the eGenericExceptions property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eGenericExceptions property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEGenericExceptions().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link EGenericType }
     * 
     * 
     */
    public List<EGenericType> getEGenericExceptions() {
        if (eGenericExceptions == null) {
            eGenericExceptions = new ArrayList<EGenericType>();
        }
        return this.eGenericExceptions;
    }

    /**
     * Gets the value of the eExceptions property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eExceptions property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEExceptions().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEExceptions() {
        if (eExceptions == null) {
            eExceptions = new ArrayList<String>();
        }
        return this.eExceptions;
    }

}
