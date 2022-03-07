/**
 * 
 */
package fr.hin.modelgenerator.model;

import java.util.ArrayList;
import java.util.List;

/**
 * @author sismaris
 *
 */
public class Method {

	private String name;
	private String returnType;
	private List<Attribute> parameters = new ArrayList<Attribute>();
	
	public Method(String name) {
		this.name = name;
	}
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the returnType
	 */
	public String getReturnType() {
		return returnType;
	}

	/**
	 * @param returnType the returnType to set
	 */
	public void setReturnType(String returnType) {
		this.returnType = returnType;
	}

	/**
	 * @return the parameters
	 */
	public List<Attribute> getParameters() {
		return parameters;
	}

	/**
	 * @param parameters the parameters to set
	 */
	public void setParameters(List<Attribute> parameters) {
		this.parameters = parameters;
	}

}
