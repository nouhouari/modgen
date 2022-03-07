/**
 * 
 */
package com.sicpa.modelgen.utils;

import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class TypeUtils {

	/**
	 * Convert primary type to Object type.
	 * @param attribute
	 */
	public static void convertPrimaryTypeToObjectType(Attribute attribute) {
		// Change type of byte and short to int
		if ("byte".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Byte");
		}
		if ("short".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Short");
		}
		if ("int".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Integer");
		}
		if ("long".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Long");
		}
		if ("float".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Float");
		}
		if ("double".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Double");
		}
		if ("boolean".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Boolean");
		}
	  if ("char".equalsIgnoreCase(attribute.getType())) {
      attribute.setType("Character");
    }
	}

	
}
