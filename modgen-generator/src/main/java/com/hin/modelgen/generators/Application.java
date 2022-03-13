/**
 * 
 */
package com.hin.modelgen.generators;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.base.CaseFormat;
import com.hin.modelgen.generators.controller.EntityControllerGenerator;
import com.hin.modelgen.generators.dart.DartModelGenerator;
import com.hin.modelgen.generators.dto.EntityDTOGenerator;
import com.hin.modelgen.generators.dto.EntityDTOTransformerGenerator;
import com.hin.modelgen.generators.grpc.ProtoGenerator;
import com.hin.modelgen.generators.jpa.entity.JPAEntityGenerator;
import com.hin.modelgen.generators.jpa.entity.JPAEnumGenerator;
import com.hin.modelgen.generators.jpa.repository.JPAEntityRepositoryGenerator;
import com.hin.modelgen.generators.jpa.repository.JPAEntitySpecificationGenerator;
import com.hin.modelgen.generators.jpa.repository.SpringDataPrimaryPostProcessorGenerator;
import com.hin.modelgen.generators.service.EntityServiceGenerator;
import com.hin.modelgen.generators.service.SecurityRolesGenerator;
import com.hin.modelgen.generators.service.SecurityRolesInjectorGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptComponentGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptCreateGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptDetailsGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptEditGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptListComponentGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptMainGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptModelGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptQuickSearchGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptSearchGenerator;
import com.hin.modelgen.generators.typescript.TypeScriptServiceGenerator;

import fr.hin.modelgenerator.ecore.EPackage;
import fr.hin.modelgenerator.generator.AbstractGeneratorEngine;
import fr.hin.modelgenerator.generator.IGenerator;
import fr.hin.modelgenerator.generator.Settings;

/**
 * @author nourreddine
 *
 */
public class Application extends AbstractGeneratorEngine {

  private List<IGenerator> generators = new ArrayList<>();
  private Settings configuration;
  private static Logger LOGGER = LoggerFactory.getLogger(Application.class);

  /**
   * Generator sample code.
   * 
   * @param args
   */
  public static void main(String[] args) {

    Application app = new Application();

    String modelFilePath = "../modgen-model-sample/src/sample.ecore";
    String component = "horizon";
    String projectsOutputDir = "../";
    String rootPackage = "com.hin.modgen.sample.event";

    String apiOutputDir = null;
    String frontendOutputDir = null;
    String componentOutputDir = null;
    String dartOutputDir = "../modgen_model_lib";
    String serviceOutputDir = "../modgen-spring-boot-sample";
    String frontendAngular4OutputDir = "../modgen-webapp-sample/";

    String bffOutputDir =  serviceOutputDir;
    String javaOutputSourceDir = "/target/generated-sources/modgen";
    String javaOutputTestDir = "/src/test/generated";
    String typeScriptOutputSourceDir = "/src/app/generated/";
    String protoOutputSourceDir = "/src/";
    
    Settings configuration = new Settings(
    		rootPackage, modelFilePath, projectsOutputDir, apiOutputDir, serviceOutputDir,
    		bffOutputDir, frontendOutputDir, frontendAngular4OutputDir, componentOutputDir, 
    		javaOutputSourceDir, javaOutputTestDir,typeScriptOutputSourceDir, 
    		protoOutputSourceDir, modelFilePath, component, dartOutputDir);
    app.setConfiguration(configuration);
    configuration.setOwner(true);
    app.configure();

    long start = System.currentTimeMillis();
    app.start(app.getConfiguration().getModelPath());
    long end = System.currentTimeMillis();

    if (LOGGER.isInfoEnabled()) {
      LOGGER.info("Generation done in : " + (end - start) + " ms.");
    }

  }

  /**
   * {@inheritDoc}
   */
  @Override
  public void generatePackage(EPackage ePackage) {
    LOGGER.info("Generate package : " + ePackage);
    for (IGenerator generator : generators) {
      generator.generateModel(ePackage, configuration);
    }
  }

  /**
   * Add a generator to the engine.
   * 
   * @param generator
   */
  public void addGenerator(IGenerator generator) {
    this.generators.add(generator);
  }

  /**
   * @param configuration
   *          the configuration to set
   */
  public void setConfiguration(Settings configuration) {
    this.configuration = configuration;
  }

  /**
   * Get application configuration.
   * 
   * @return
   */
  public Settings getConfiguration() {
    return configuration;
  }

  /**
   * Configure the generator with setting.
   */
  public void configure() {
    
    // Clear generators
    this.generators.clear();

    String componentName = this.getConfiguration().getComponent();
    String componentClassNamePrefix = componentName != null ?
        CaseFormat.LOWER_HYPHEN.to(CaseFormat.UPPER_CAMEL, componentName) :
        "";

    // Generate Service
    if (this.getConfiguration().getServiceOutputDir() != null) {

      // Server Service
      this.addGenerator(
          new EntityServiceGenerator(
        		  this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
        		  this.getConfiguration().getServicePackage(), 
        		  this.getConfiguration().getEntityPackage(),
        		  this.getConfiguration().getEntitySuffix(),
        		  this.getConfiguration().getEntityrepositorysuffix(),
        		  this.getConfiguration().getDtoPackage(),
        		  this.getConfiguration().getRepositoryPackage(),
        		  this.getConfiguration().getDtoEntityTransformerPackage(),
        		  this.getConfiguration().getDtoSuffix()
        		  ));

      // JPA Entity
      this.addGenerator(new JPAEntityGenerator(
          this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
          this.getConfiguration().getEntityPackage(), 
          this.getConfiguration().getEntitySuffix(), 
          this.getConfiguration().getDtoSuffix(),
          this.configuration.isOwner()));
      
      // SQL Entity
     /* this.addGenerator(new JPASQLGenerator(
    		  this.getConfiguration().getServiceOutputDir() + "/src/main/resources/db/migration",
    		  this.getConfiguration().getEntitySuffix())
      );*/
      
      // Enumeration
      this.addGenerator(
          new JPAEnumGenerator(this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
              this.getConfiguration().getEntityPackage()));

      // Entity repository
      this.addGenerator(
          new JPAEntityRepositoryGenerator(this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
              this.getConfiguration().getRepositoryPackage(), this.getConfiguration().getEntityPackage(),
              this.getConfiguration().getEntitySuffix(), this.getConfiguration().getEntityrepositorysuffix()));

      // JPA entity specification for entity search
      this.addGenerator(new JPAEntitySpecificationGenerator(
          this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
          this.getConfiguration().getRepositoryPackage(), this.getConfiguration().getEntityPackage(),
          this.getConfiguration().getEntitySuffix(), this.getConfiguration().getEntityrepositorysuffix(),
          this.getConfiguration().getServicePackage()));

      // SpringDataPrimaryPostProcessor
      this.addGenerator(new SpringDataPrimaryPostProcessorGenerator(
          this.getConfiguration().getServiceOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
          this.getConfiguration().getRepositoryPackage()));
    }

    // Generate BFF
    if (this.getConfiguration().getBffOutputDir() != null) {

      // REST Controller
      this.addGenerator(
          new EntityControllerGenerator(this.getConfiguration().getBffOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
              this.getConfiguration().getControllerPackage(), this.getConfiguration().getEntityPackage(),
              this.getConfiguration().getEntitySuffix(), this.getConfiguration().getDtoPackage(),
              this.getConfiguration().getServicePackage(), this.getConfiguration().getDtoSuffix()));

      // Entity DTO
      this.addGenerator(new EntityDTOGenerator(this.getConfiguration().getBffOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Transformers Entity/DTO
      this.addGenerator(new EntityDTOTransformerGenerator(
          this.getConfiguration().getBffOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
          this.getConfiguration().getDtoProtoTransformerPackage(),
          this.getConfiguration().getDtoPackage(),
          this.getConfiguration().getEntityPackage(),
          this.getConfiguration().getEntitySuffix(),
          this.getConfiguration().getDtoSuffix()));
      
      // BFF Web Security
//      this.addGenerator(
//          new WebSecurityGenerator(this.getConfiguration().getBffOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
//              this.getConfiguration().getRootPackage(), this.getConfiguration().getRolePackage()));
    }

    // Generate API
    if (this.getConfiguration().getApiOutputDir() != null) {
      // GRPC protobuf
      this.addGenerator(new ProtoGenerator(this.getConfiguration().getApiOutputDir()
          + this.getConfiguration().getProtoOutputSourceDir() + "/"
          + this.getConfiguration().getRootPackage().replaceAll("\\.", "/") + "/api/rpc", this.getConfiguration().getProtoBufPackage()));

      // Security roles
      this.addGenerator(
          new SecurityRolesGenerator(this.getConfiguration().getApiOutputDir() + this.getConfiguration().getJavaOutputSourceDir(),
              this.getConfiguration().getRolePackage()));
    }

    // Web application
    if (this.getConfiguration().getFrontendOutputDir() != null) {

      // Typescript model
      this.addGenerator(new TypeScriptModelGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript service
      this.addGenerator(new TypeScriptServiceGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component
      this.addGenerator(new TypeScriptComponentGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-create
      this.addGenerator(new TypeScriptCreateGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-details
      this.addGenerator(new TypeScriptDetailsGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-edit
      this.addGenerator(new TypeScriptEditGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-main
      this.addGenerator(new TypeScriptMainGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-search
      this.addGenerator(new TypeScriptSearchGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript component-search
      this.addGenerator(new TypeScriptQuickSearchGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript list component
      this.addGenerator(new TypeScriptListComponentGenerator(
          this.getConfiguration().getFrontendOutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));
    }

    if (this.getConfiguration().getFrontendAngular4OutputDir() != null) {
      // Typescript model
      this.addGenerator(new com.hin.modelgen.generators.typescript.angular4.TypeScriptModelGenerator(
          this.getConfiguration().getFrontendAngular4OutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));

      // Typescript service
      this.addGenerator(new com.hin.modelgen.generators.typescript.angular4.TypeScriptServiceGenerator(
          this.getConfiguration().getFrontendAngular4OutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));
      
      // Typescript component
      this.addGenerator(new com.hin.modelgen.generators.typescript.angular4.TypeScriptComponentGenerator(
          this.getConfiguration().getFrontendAngular4OutputDir() + this.getConfiguration().getTypeScriptOutputSourceDir(),
          this.getConfiguration().getDtoPackage(), this.getConfiguration().getEntityPackage(), this.getConfiguration().getDtoSuffix()));
    }

    // Component project
    if (this.getConfiguration().getComponentOutputDir() != null) {
      // Keycloak roles injector
      this.addGenerator(new SecurityRolesInjectorGenerator(
          this.getConfiguration().getComponentOutputDir() + this.getConfiguration().getJavaOutputTestDir(),
          this.getConfiguration().getRootPackage(), this.getConfiguration().getRolePackage(),
          this.getConfiguration().getComponent()));
    }
    
    // Dart
    if (this.getConfiguration().getDartOutputDir() != null) {
    	this.addGenerator(new DartModelGenerator(this.getConfiguration().getDartOutputDir()));
    }
  }
}
