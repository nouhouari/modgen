/**
 * 
 */
package fr.hin.modelgenerator.model;

import java.util.HashMap;
import java.util.Map;

/**
 * @author nourreddine
 *
 */
public class Annotation {

	private String name;
	private Map<String,String> details = new HashMap<>();
	private String type;
	
	/**
	 * 
	 * @param name
	 */
	public Annotation(String name) {
		this.name = name;
	}
	
	/**
	 * 
	 * @param name
	 */
	public Annotation(String name, Map<String, String> keyValue) {
		this.name = name;
		if(keyValue != null){
			this.details.putAll(keyValue);			
		}
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
	 * @return the details
	 */
	public Map<String, String> getDetails() {
		return details;
	}

	/**
	 * @param details the details to set
	 */
	public void setDetails(Map<String, String> details) {
		this.details = details;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * 
	 * @param name
	 * @return
	 */
	public boolean hasDetail(String name){
		return this.details.containsKey(name);
	}
	
	/**
	 * 
	 * @param name detail name.
	 * @return
	 */
	public String getDetailValue(String name){
		return this.details.get(name);
	}

	@Override
	public boolean equals(Object obj) {
		if(obj instanceof Annotation){
			Annotation s = (Annotation) obj;
			return this.name.equalsIgnoreCase(s.name);
		}
		return super.equals(obj);
	}
	
	@Override
	public String toString() {
		return this.name;
	}
	
}
