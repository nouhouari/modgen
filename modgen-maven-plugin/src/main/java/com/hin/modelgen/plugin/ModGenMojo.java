package com.hin.modelgen.plugin;

import fr.hin.modelgenerator.generator.Settings;
import org.apache.maven.plugin.AbstractMojo;
import org.apache.maven.plugin.MojoExecutionException;
import org.apache.maven.plugins.annotations.LifecyclePhase;
import org.apache.maven.plugins.annotations.Mojo;
import org.apache.maven.plugins.annotations.Parameter;
import org.apache.maven.plugins.annotations.ResolutionScope;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.hin.modelgen.generators.Application;


/**
 * Goal to generate source file from a model.
 */
@Mojo(name = "gen", 
defaultPhase = LifecyclePhase.INITIALIZE, 
requiresDependencyResolution = ResolutionScope.COMPILE)
public class ModGenMojo extends AbstractMojo {

	private static final Logger LOGGER = LoggerFactory.getLogger(ModGenMojo.class);

	/**
	 * model file path
	 */
	@Parameter(defaultValue = "domain.ecore")
	private Model[] models;

	/**
	 * Projects root folder.
	 */
	@Parameter(defaultValue = "/output")
	private String projectsOutputDir;

	/**
	 * API project directory.
	 */
	@Parameter
	private String apiOutputDir;

	/**
	 * Service project directory.
	 */
	@Parameter
	private String serviceOutputDir;

	/**
	 * BFF project directory.
	 */
	@Parameter
	private String bffOutputDir;

	/**
	 * Front end project directory.
	 */
	@Parameter
	private String frontendOutputDir;

	/**
	 * Angular4 front end project directory.
	 */
	@Parameter
	private String frontendAngular4OutputDir;

	/**
	 * Component project directory.
	 */
	@Parameter
	private String componentOutputDir;

	@Parameter(defaultValue = "/target/generated-sources/modgen")
	private String javaOutputSourceDir;

	@Parameter(defaultValue = "/target/generated-test-sources/modgen")
	private String javaOutputTestDir;

	@Parameter(defaultValue = "/src/app/generated/")
	private String typeScriptOutputSourceDir;

	@Parameter(defaultValue = "/src/")
	private String protoOutputSourceDir;
	
	@Parameter(defaultValue = "/dart/")
	private String dartOutputSourceDir;
	

	/**
	 * {@inheritDoc}
	 */
	public void execute() throws MojoExecutionException {
		getLog().info("Generating sources from model... " + models);

		// TODO update with latest application
//		Application app = new Application();
//
//		for (int i = 0; i < models.length; i++) {
//			Settings configuration = new Settings(models[i].getRootPackage(), models[i].getModelPath(),
//					projectsOutputDir, apiOutputDir, serviceOutputDir, bffOutputDir, frontendOutputDir,
//					frontendAngular4OutputDir, componentOutputDir, javaOutputSourceDir, javaOutputTestDir,
//					typeScriptOutputSourceDir, protoOutputSourceDir, models[i].getModelPath(),
//					models[i].getComponent(), dartOutputSourceDir);
//			configuration.setOwner(models[i].isOwner());
//			app.setConfiguration(configuration);
//			app.configure();
//
//			long start = System.currentTimeMillis();
//			try {
//				LOGGER.info(app.getConfiguration().getModelPath());
//				app.start(app.getConfiguration().getModelPath());
//			} catch (Exception e) {
//				LOGGER.error("Exception in generator.", e);
//			}
//
//			long end = System.currentTimeMillis();
//
//			if (LOGGER.isInfoEnabled()) {
//				LOGGER.info("Generation done in : " + (end - start) + " ms.");
//			}
//		}
	}

	/**
	 * @return the models
	 */
	public Model[] getModels() {
		return models;
	}

	/**
	 * @param models the models to set
	 */
	public void setModels(Model[] models) {
		this.models = models;
	}

	/**
	 * @return the projectsOutputDir
	 */
	public String getProjectsOutputDir() {
		return projectsOutputDir;
	}

	/**
	 * @param projectsOutputDir the projectsOutputDir to set
	 */
	public void setProjectsOutputDir(String projectsOutputDir) {
		this.projectsOutputDir = projectsOutputDir;
	}

	/**
	 * @return the apiOutputDir
	 */
	public String getApiOutputDir() {
		return apiOutputDir;
	}

	/**
	 * @param apiOutputDir the apiOutputDir to set
	 */
	public void setApiOutputDir(String apiOutputDir) {
		this.apiOutputDir = apiOutputDir;
	}

	/**
	 * @return the serviceOutputDir
	 */
	public String getServiceOutputDir() {
		return serviceOutputDir;
	}

	/**
	 * @param serviceOutputDir the serviceOutputDir to set
	 */
	public void setServiceOutputDir(String serviceOutputDir) {
		this.serviceOutputDir = serviceOutputDir;
	}

	/**
	 * @return the bffOutputDir
	 */
	public String getBffOutputDir() {
		return bffOutputDir;
	}

	/**
	 * @param bffOutputDir the bffOutputDir to set
	 */
	public void setBffOutputDir(String bffOutputDir) {
		this.bffOutputDir = bffOutputDir;
	}

	/**
	 * @return the frontendOutputDir
	 */
	public String getFrontendOutputDir() {
		return frontendOutputDir;
	}

	/**
	 * @param frontendOutputDir the frontendOutputDir to set
	 */
	public void setFrontendOutputDir(String frontendOutputDir) {
		this.frontendOutputDir = frontendOutputDir;
	}

	/**
	 * @return the frontendAngular4OutputDir
	 */
	public String getFrontendAngular4OutputDir() {
		return frontendAngular4OutputDir;
	}

	/**
	 * @param frontendAngular4OutputDir the frontendAngular4OutputDir to set
	 */
	public void setFrontendAngular4OutputDir(String frontendAngular4OutputDir) {
		this.frontendAngular4OutputDir = frontendAngular4OutputDir;
	}

	/**
	 * @return the componentOutputDir
	 */
	public String getComponentOutputDir() {
		return componentOutputDir;
	}

	/**
	 * @param componentOutputDir the componentOutputDir to set
	 */
	public void setComponentOutputDir(String componentOutputDir) {
		this.componentOutputDir = componentOutputDir;
	}

	/**
	 * @return the javaOutputSourceDir
	 */
	public String getJavaOutputSourceDir() {
		return javaOutputSourceDir;
	}

	/**
	 * @param javaOutputSourceDir the javaOutputSourceDir to set
	 */
	public void setJavaOutputSourceDir(String javaOutputSourceDir) {
		this.javaOutputSourceDir = javaOutputSourceDir;
	}

	/**
	 * @return the javaOutputTestDir
	 */
	public String getJavaOutputTestDir() {
		return javaOutputTestDir;
	}

	/**
	 * @param javaOutputTestDir the javaOutputTestDir to set
	 */
	public void setJavaOutputTestDir(String javaOutputTestDir) {
		this.javaOutputTestDir = javaOutputTestDir;
	}

	/**
	 * @return the typeScriptOutputSourceDir
	 */
	public String getTypeScriptOutputSourceDir() {
		return typeScriptOutputSourceDir;
	}

	/**
	 * @param typeScriptOutputSourceDir the typeScriptOutputSourceDir to set
	 */
	public void setTypeScriptOutputSourceDir(String typeScriptOutputSourceDir) {
		this.typeScriptOutputSourceDir = typeScriptOutputSourceDir;
	}

	/**
	 * @return the protoOutputSourceDir
	 */
	public String getProtoOutputSourceDir() {
		return protoOutputSourceDir;
	}

	/**
	 * @param protoOutputSourceDir the protoOutputSourceDir to set
	 */
	public void setProtoOutputSourceDir(String protoOutputSourceDir) {
		this.protoOutputSourceDir = protoOutputSourceDir;
	}

}
