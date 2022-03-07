/**
 * 
 */
package fr.hin.modelgenerator.model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author nourredine
 *
 */
public class ObjectMetaModel {

	private String name;
	private String doc;
	private List<Attribute> attributes = new ArrayList<>();
	private List<Annotation> annotations = new ArrayList<>();
	private List<ObjectRelationModel> relations = new ArrayList<>();
	private ClassifierType type = ClassifierType.CLASS;
	private Attribute primaryAttribute;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the doc
	 */
	public String getDoc() {
		return doc;
	}

	/**
	 * @param doc the doc to set
	 */
	public void setDoc(String doc) {
		this.doc = doc;
	}

	/**
	 * @return the attributes
	 */
	public List<Attribute> getAttributes() {
		return attributes;
	}
	
	/**
	 * @return the attributes
	 */
	public List<Attribute> getAttributesByAnnotation(String annotation) {
		List<Attribute> result = new ArrayList<>();
		attributes.stream().filter((a)->a.hasAnnotation(annotation)).forEach((a)->result.add(a));
		return result;
	}

	/**
	 * @param attributes
	 *            the attributes to set
	 */
	public void setAttributes(List<Attribute> attributes) {
		this.attributes = attributes;
	}

	/**
	 * 
	 * @return
	 */
	public List<Annotation> getStereotypes() {
		return annotations;
	}

	/**
	 * 
	 * @param stereotypes
	 */
	public void setAnnotations(List<Annotation> stereotypes) {
		this.annotations = stereotypes;
	}

	/**
   * @return the annotations
   */
  public List<Annotation> getAnnotations() {
    return annotations;
  }

  /**
	 * @return the relations
	 */
	public List<ObjectRelationModel> getRelations() {
		return relations;
	}

	/**
	 * @param relations
	 *            the relations to set
	 */
	public void setRelations(List<ObjectRelationModel> relations) {
		this.relations = relations;
	}

	/**
	 * 
	 * @param stereotype
	 * @return
	 */
	public boolean hasAnnotation(Annotation stereotype) {
		return this.annotations.contains(stereotype);
	}

	/**
	 * 
	 * @param stereotype
	 * @return
	 */
	public boolean hasAnnotation(String stereotype) {
		return this.annotations.contains(new Annotation(stereotype));
	}
	
	/**
	 * Check if the entity has at least one of the annotation.
	 * @param annotations List of annotations
	 * @return true if annotation is present
	 */
	public boolean hasOneOfAnnotation(String[] annotations) {
		for (int i = 0; i < annotations.length; i++) {
			String annotation = annotations[i];
			if (this.annotations.contains(new Annotation(annotation))){
				return true;
			}
		}
		return false;
	}
	

	/**
	 * @return the type
	 */
	public ClassifierType getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(ClassifierType type) {
		this.type = type;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Entity [name=" + name + ", attributes=" + attributes + ", stereotypes=" + annotations + "]";
	}

	public Attribute getPrimaryAttribute() {
		return primaryAttribute;
	}

	public void setPrimaryAttribute(Attribute primaryAttribute) {
		this.primaryAttribute = primaryAttribute;
	}

}
