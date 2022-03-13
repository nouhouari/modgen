/**
 * 
 */
package com.hin.modgen.mavenplugin;

import static org.junit.Assert.assertNotNull;

import org.apache.maven.plugin.MojoExecutionException;
import org.junit.Test;

import com.hin.modelgen.plugin.ModGenMojo;
import com.hin.modelgen.plugin.Model;

/**
 * @author nhouari
 *
 */
public class PluginTest {

	@Test
	public void PluginExecuteTest() throws MojoExecutionException {
		ModGenMojo mojo = new ModGenMojo();
		assertNotNull(mojo);

		// Create a model
		Model[] models = new Model[1];
		Model testModel = new Model();
		testModel.setModelPath("src/test/resources/test.ecore");
		testModel.setComponent("activation");
		testModel.setRootPackage("com.hin.modgen.mavenplugin.test");

		models[0] = testModel;
		mojo.setModels(models);
		mojo.setJavaOutputSourceDir("/src/main/java");

		// Set paths
		mojo.setApiOutputDir("./target");

		mojo.execute();

	}

}
