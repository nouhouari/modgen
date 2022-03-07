/**
 * 
 */
package fr.hin.modelgenerator.generator;

import fr.hin.modelgenerator.ecore.EPackage;

/**
 * @author nourredine
 *
 */
public interface IGenerator {

	/**
	 * Generate a Ecore package.
	 * @param packache ECore package.
	 * @param settings Configuration to use.
	 */
	public void generateModel(EPackage packache, Settings settings);
	/**
	 * Name of the generator.
	 * @return name.
	 */
	public String getName();
	/**
	 * Version of the generator.
	 * @return version.
	 */
	public String getVersion();
	
}
