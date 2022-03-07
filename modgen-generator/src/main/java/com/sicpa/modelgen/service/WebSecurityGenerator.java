/**
 * 
 */
package com.sicpa.modelgen.service;

import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import com.sicpa.modelgen.utils.TypeUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import fr.hin.modelgenerator.GeneratorConstants;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author nourreddine
 *
 */
public class WebSecurityGenerator extends AbstractGenerator {

  private String webSecurityTemplate = "service/security/WebSecurity.ftl";
  private String packageName;
  private String rolePackage;

  public WebSecurityGenerator(String outputDir, String packageName, String rolePackage) {
    super(outputDir);
    this.packageName = packageName;
    this.rolePackage = rolePackage;
  }

  @Override
  protected void onEachEntityStart() {
  }

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_TODAY, new Date().toString());
    input.put(STR_PACKAGE, packageName);
    input.put("rolePackage", rolePackage);
  }

  @Override
  protected void onEnumAttributeAdded(Attribute e) {
    // NOTHING
  }

  @Override
  protected void onCreateDirectories() {
    Utils.checkDirectoryOrCreate(getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"));
  }

  @Override
  protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
    TypeUtils.convertPrimaryTypeToObjectType(attribute);
    attributes.add(attribute);
  }

  @Override
  protected void onAttributesAdded(Map<String, Object> input) {
  }

  @Override
  protected void generateFiles(Map<String, Object> input) {
   
//    getMetaModels().values().forEach(m -> {
//      if (m.getType() == ClassifierType.CLASS) {
//        input.put(STR_ENTITY, m);
//        Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), webSecurityTemplate, fileName);
//      }
//    });
    
    // Generate all entities in same file
    String fileName = "WebSecurityConfiguration.java";
    input.put(GeneratorConstants.STR_ENTITIES, getMetaModels().values());
    Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), webSecurityTemplate, fileName);
  }

  @Override
  protected void setNameAndVersion() {
    setName("WebSecurity generator.");
    setVersion("0.0.1");
  }

}
