/**
 * 
 */
package fr.hin.modelgenerator.model;

/**
 * @author VKoneru
 *
 */
public class ObjectRelationModel {
	private String relationName;
	private ObjectMetaModel model;
	private boolean containment;
	private int multiplicity;
	private int oppositeMultiplicity;
  
	
	/**
	 * @return the relationName
	 */
	public String getRelationName() {
		return relationName;
	}

	/**
	 * @param relationName the relationName to set
	 */
	public void setRelationName(String relationName) {
		this.relationName = relationName;
	}

	/**
	 * @return the model
	 */
	public ObjectMetaModel getModel() {
		return model;
	}

	/**
	 * @param model the model to set
	 */
	public void setModel(ObjectMetaModel model) {
		this.model = model;
	}

	/**
	 * @return the containment
	 */
	public boolean isContainment() {
		return containment;
	}

	/**
	 * @param containment the containment to set
	 */
	public void setContainment(boolean containment) {
		this.containment = containment;
	}

	/**
	 * Set the relation multiplicity
	 * @param multiplicity
	 */
	public void setMultiplicity(int multiplicity) {
		this.multiplicity = multiplicity;
	}
	
	/**
	 * Return the relation multiplicity.
	 * @return
	 */
	public int getMultiplicity() {
		return multiplicity;
	}

  /**
   * @return the oppositeMultiplicity
   */
  public int getOppositeMultiplicity() {
    return oppositeMultiplicity;
  }

  /**
   * @param oppositeMultiplicity the oppositeMultiplicity to set
   */
  public void setOppositeMultiplicity(int oppositeMultiplicity) {
    this.oppositeMultiplicity = oppositeMultiplicity;
  }
	
}
