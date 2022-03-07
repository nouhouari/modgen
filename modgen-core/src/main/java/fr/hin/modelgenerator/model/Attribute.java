package fr.hin.modelgenerator.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The type Attribute.
 */
public class Attribute {

	private String name;
	private boolean changeable;
	private String type;
	private boolean enumerate;
	private List<String> litterals = new ArrayList<String>();
	private boolean reference;
	private int multiplicity;
	private boolean wildcard = true;
	private int oppositeMultiplicity;
	private boolean location;
	private ObjectMetaModel model;
	private boolean containment;
	private List<Annotation> annotations = new ArrayList<>();
	private Map<String, List<Annotation>> annotationGroups = new HashMap<>();

	/**
	 * Constructor.
	 *
	 * @param attributeName        the attribute name
	 * @param changeable           the changeable
	 * @param type                 the type
	 * @param isReference          the is reference
	 * @param multiplicity         the multiplicity
	 * @param oppositeMultiplicity the opposite multiplicity
	 */
	public Attribute(String attributeName, boolean changeable, String type, boolean isReference, int multiplicity, int oppositeMultiplicity) {
		this.name = attributeName;
		this.changeable = changeable;
		this.type = type;
		this.reference = isReference;
		this.multiplicity = multiplicity;
		this.oppositeMultiplicity = oppositeMultiplicity;
	}

	/**
	 * Gets multiplicity.
	 *
	 * @return the multiplicity
	 */
	public int getMultiplicity() {
		return multiplicity;
	}

	/**
	 * Sets multiplicity.
	 *
	 * @param multiplicity the multiplicity to set
	 */
	public void setMultiplicity(int multiplicity) {
		this.multiplicity = multiplicity;
	}

	/**
	 * Is reference boolean.
	 *
	 * @return the reference
	 */
	public boolean isReference() {
		return reference;
	}

	/**
	 * Sets reference.
	 *
	 * @param reference the reference to set
	 */
	public void setReference(boolean reference) {
		this.reference = reference;
	}

	/**
	 * Gets name.
	 *
	 * @return name
	 */
	public String getName() {
		return name;
	}

	/**
	 * Sets name.
	 *
	 * @param name the name
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * Is changeable boolean.
	 *
	 * @return the changeable
	 */
	public boolean isChangeable() {
		return changeable;
	}

	/**
	 * Sets changeable.
	 *
	 * @param changeable the changeable to set
	 */
	public void setChangeable(boolean changeable) {
		this.changeable = changeable;
	}

	/**
	 * Gets type.
	 *
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * Sets type.
	 *
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Attribute [attributeName=" + name + ", changeable="
				+ changeable + ", type=" + type + ", enumerate=" + enumerate
				+ ", annotations=" + annotations
				+ ", litterals=" + litterals + "]";
	}

	/**
	 * Is enumerate boolean.
	 *
	 * @return the enumerate
	 */
	public boolean isEnumerate() {
		return enumerate;
	}

	/**
	 * Sets enumerate.
	 *
	 * @param enumerate the enumerate to set
	 */
	public void setEnumerate(boolean enumerate) {
		this.enumerate = enumerate;
	}

	/**
	 * Gets litterals.
	 *
	 * @return the litterals
	 */
	public List<String> getLitterals() {
		return litterals;
	}

	/**
	 * Sets litterals.
	 *
	 * @param litterals the litterals to set
	 */
	public void setLitterals(List<String> litterals) {
		this.litterals = litterals;
	}

	/**
	 * Gets opposite multiplicity.
	 *
	 * @return the oppositeMultiplicity
	 */
	public int getOppositeMultiplicity() {
		return oppositeMultiplicity;
	}

	/**
	 * Sets opposite multiplicity.
	 *
	 * @param oppositeMultiplicity the oppositeMultiplicity to set
	 */
	public void setOppositeMultiplicity(int oppositeMultiplicity) {
		this.oppositeMultiplicity = oppositeMultiplicity;
	}

	/**
	 * Is location boolean.
	 *
	 * @return the location
	 */
	public boolean isLocation() {
		return location;
	}

	/**
	 * Sets location.
	 *
	 * @param location the location to set
	 */
	public void setLocation(boolean location) {
		this.location = location;
	}

	/**
	 * Gets model.
	 *
	 * @return the model
	 */
	public ObjectMetaModel getModel() {
		return model;
	}

	/**
	 * Sets model.
	 *
	 * @param model the model to set
	 */
	public void setModel(ObjectMetaModel model) {
		this.model = model;
	}

	/**
	 * Is containment boolean.
	 *
	 * @return the containment
	 */
	public boolean isContainment() {
		return containment;
	}

	/**
	 * Sets containment.
	 *
	 * @param containment the containment to set
	 */
	public void setContainment(boolean containment) {
		this.containment = containment;
	}

	/**
	 * Gets annotations.
	 *
	 * @return annotations
	 */
	public List<Annotation> getAnnotations() {
		return annotations;
	}

	/**
	 * Sets annotations.
	 *
	 * @param stereotypes the stereotypes
	 */
	public void setAnnotations(List<Annotation> stereotypes) {
		this.annotations = stereotypes;
	}

	/**
	 * Has annotation boolean.
	 *
	 * @param stereotype the stereotype
	 * @return boolean
	 */
	public boolean hasAnnotation(Annotation stereotype){
		return this.annotations.contains(stereotype );
	}

	/**
	 * Has annotation boolean.
	 *
	 * @param stereotype the stereotype
	 * @return boolean
	 */
	public boolean hasAnnotation(String stereotype){
		return this.annotations.contains(new Annotation(stereotype));
	}
	
	/**
	 * Return one of the annotation with the stereotype.
	 * @param stereotype annotation stereotype
	 * @return one of the annotation with the same stereotype.
	 */
	public Annotation getAnnotation(String stereotype) {
	  return this.annotations.get(this.annotations.indexOf(new Annotation(stereotype)));
	}

	/**
	 * Gets annotation groups.
	 *
	 * @return annotation groups
	 */
	public Map<String, List<Annotation>> getAnnotationGroups() {
		return annotationGroups;
	}

	/**
	 * Sets annotation groups.
	 *
	 * @param annotationGroups the annotation groups
	 */
	public void setAnnotationGroups(Map<String, List<Annotation>> annotationGroups) {
		this.annotationGroups = annotationGroups;
	}

	/**
	 * Is wildcard boolean.
	 *
	 * @return the boolean
	 */
	public boolean isWildcard() {
		return wildcard;
	}

	/**
	 * Sets wildcard.
	 *
	 * @param wildcard the wildcard
	 */
	public void setWildcard(boolean wildcard) {
		this.wildcard = wildcard;
	}

	/**
	 * returns true if this attribute has VALIDATION annotations supplied from model otherwise returns false.
	 *
	 * @return boolean
	 */
	public boolean hasValidations() {
		return this.getAnnotationGroups().containsKey("VALIDATIONS");
	}


}
