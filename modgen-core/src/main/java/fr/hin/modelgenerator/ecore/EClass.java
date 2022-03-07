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
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for EClass complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="EClass">
 *   &lt;complexContent>
 *     &lt;extension base="{http://www.eclipse.org/emf/2002/Ecore}EClassifier">
 *       &lt;sequence>
 *         &lt;element name="eOperations" type="{http://www.eclipse.org/emf/2002/Ecore}EOperation" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="eStructuralFeatures" type="{http://www.eclipse.org/emf/2002/Ecore}EStructuralFeature" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element name="eGenericSuperTypes" type="{http://www.eclipse.org/emf/2002/Ecore}EGenericType" maxOccurs="unbounded" minOccurs="0"/>
 *       &lt;/sequence>
 *       &lt;attribute name="abstract" type="{http://www.eclipse.org/emf/2002/Ecore}EBoolean" />
 *       &lt;attribute name="interface" type="{http://www.eclipse.org/emf/2002/Ecore}EBoolean" />
 *       &lt;attribute name="eSuperTypes">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllAttributes">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllReferences">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eReferences">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAttributes">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllContainments">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllOperations">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllStructuralFeatures">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eAllSuperTypes">
 *         &lt;simpleType>
 *           &lt;list itemType="{http://www.w3.org/2001/XMLSchema}anyURI" />
 *         &lt;/simpleType>
 *       &lt;/attribute>
 *       &lt;attribute name="eIDAttribute" type="{http://www.w3.org/2001/XMLSchema}IDREF" />
 *       &lt;attribute name="eAllGenericSuperTypes">
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
@XmlType(name = "EClass", propOrder = {
    "eOperations",
    "eStructuralFeatures",
    "eGenericSuperTypes"
})
public class EClass
    extends EClassifier
{

    protected List<EOperation> eOperations;
    protected List<EStructuralFeature> eStructuralFeatures;
    protected List<EGenericType> eGenericSuperTypes;
    @XmlAttribute(name = "abstract")
    protected String _abstract;
    @XmlAttribute(name = "interface")
    protected String _interface;
    @XmlAttribute(name = "eSuperTypes")
    protected List<String> eSuperTypes;
    @XmlAttribute(name = "eAllAttributes")
    protected List<String> eAllAttributes;
    @XmlAttribute(name = "eAllReferences")
    protected List<String> eAllReferences;
    @XmlAttribute(name = "eReferences")
    protected List<String> eReferences;
    @XmlAttribute(name = "eAttributes")
    protected List<String> eAttributes;
    @XmlAttribute(name = "eAllContainments")
    protected List<String> eAllContainments;
    @XmlAttribute(name = "eAllOperations")
    protected List<String> eAllOperations;
    @XmlAttribute(name = "eAllStructuralFeatures")
    protected List<String> eAllStructuralFeatures;
    @XmlAttribute(name = "eAllSuperTypes")
    protected List<String> eAllSuperTypes;
    @XmlAttribute(name = "eIDAttribute")
    @XmlIDREF
    @XmlSchemaType(name = "IDREF")
    protected Object eidAttribute;
    @XmlAttribute(name = "eAllGenericSuperTypes")
    protected List<String> eAllGenericSuperTypes;

    /**
     * Gets the value of the eOperations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eOperations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEOperations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link EOperation }
     * 
     * 
     */
    public List<EOperation> getEOperations() {
        if (eOperations == null) {
            eOperations = new ArrayList<EOperation>();
        }
        return this.eOperations;
    }

    /**
     * Gets the value of the eStructuralFeatures property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eStructuralFeatures property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEStructuralFeatures().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link EStructuralFeature }
     * 
     * 
     */
    public List<EStructuralFeature> getEStructuralFeatures() {
        if (eStructuralFeatures == null) {
            eStructuralFeatures = new ArrayList<EStructuralFeature>();
        }
        return this.eStructuralFeatures;
    }

    /**
     * Gets the value of the eGenericSuperTypes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eGenericSuperTypes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEGenericSuperTypes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link EGenericType }
     * 
     * 
     */
    public List<EGenericType> getEGenericSuperTypes() {
        if (eGenericSuperTypes == null) {
            eGenericSuperTypes = new ArrayList<EGenericType>();
        }
        return this.eGenericSuperTypes;
    }

    /**
     * Gets the value of the abstract property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAbstract() {
        return _abstract;
    }

    /**
     * Sets the value of the abstract property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAbstract(String value) {
        this._abstract = value;
    }

    /**
     * Gets the value of the interface property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInterface() {
        return _interface;
    }

    /**
     * Sets the value of the interface property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInterface(String value) {
        this._interface = value;
    }

    /**
     * Gets the value of the eSuperTypes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eSuperTypes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getESuperTypes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getESuperTypes() {
        if (eSuperTypes == null) {
            eSuperTypes = new ArrayList<String>();
        }
        return this.eSuperTypes;
    }

    /**
     * Gets the value of the eAllAttributes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllAttributes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllAttributes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllAttributes() {
        if (eAllAttributes == null) {
            eAllAttributes = new ArrayList<String>();
        }
        return this.eAllAttributes;
    }

    /**
     * Gets the value of the eAllReferences property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllReferences property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllReferences().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllReferences() {
        if (eAllReferences == null) {
            eAllReferences = new ArrayList<String>();
        }
        return this.eAllReferences;
    }

    /**
     * Gets the value of the eReferences property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eReferences property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEReferences().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEReferences() {
        if (eReferences == null) {
            eReferences = new ArrayList<String>();
        }
        return this.eReferences;
    }

    /**
     * Gets the value of the eAttributes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAttributes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAttributes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAttributes() {
        if (eAttributes == null) {
            eAttributes = new ArrayList<String>();
        }
        return this.eAttributes;
    }

    /**
     * Gets the value of the eAllContainments property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllContainments property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllContainments().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllContainments() {
        if (eAllContainments == null) {
            eAllContainments = new ArrayList<String>();
        }
        return this.eAllContainments;
    }

    /**
     * Gets the value of the eAllOperations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllOperations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllOperations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllOperations() {
        if (eAllOperations == null) {
            eAllOperations = new ArrayList<String>();
        }
        return this.eAllOperations;
    }

    /**
     * Gets the value of the eAllStructuralFeatures property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllStructuralFeatures property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllStructuralFeatures().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllStructuralFeatures() {
        if (eAllStructuralFeatures == null) {
            eAllStructuralFeatures = new ArrayList<String>();
        }
        return this.eAllStructuralFeatures;
    }

    /**
     * Gets the value of the eAllSuperTypes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllSuperTypes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllSuperTypes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllSuperTypes() {
        if (eAllSuperTypes == null) {
            eAllSuperTypes = new ArrayList<String>();
        }
        return this.eAllSuperTypes;
    }

    /**
     * Gets the value of the eidAttribute property.
     * 
     * @return
     *     possible object is
     *     {@link Object }
     *     
     */
    public Object getEIDAttribute() {
        return eidAttribute;
    }

    /**
     * Sets the value of the eidAttribute property.
     * 
     * @param value
     *     allowed object is
     *     {@link Object }
     *     
     */
    public void setEIDAttribute(Object value) {
        this.eidAttribute = value;
    }

    /**
     * Gets the value of the eAllGenericSuperTypes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the eAllGenericSuperTypes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getEAllGenericSuperTypes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getEAllGenericSuperTypes() {
        if (eAllGenericSuperTypes == null) {
            eAllGenericSuperTypes = new ArrayList<String>();
        }
        return this.eAllGenericSuperTypes;
    }

}