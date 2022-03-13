/**
 * 
 */
package com.hin.modelgen.generators.service;

import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.hin.modelgen.generators.utils.TypeUtils;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author nourreddine
 *
 */
public class SecurityRolesGenerator extends AbstractGenerator {

  private String rolesTemplate = "service/security/role.ftl";
  private String packageName;

  public SecurityRolesGenerator(String outputDir, String packageName) {
    super(outputDir);
    this.packageName = packageName;
  }

  @Override
  protected void onEachEntityStart() {
  }

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_TODAY, new Date().toString());
    input.put(STR_PACKAGE, packageName);
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
   
    getMetaModels().values().forEach(m -> {
      if (m.getType() == ClassifierType.CLASS) {
        input.put(STR_ENTITY, m);
        String fileName = m.getName() + "Roles.java";
        Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), rolesTemplate, fileName);
      }
      
    });
  }

  @Override
  protected void setNameAndVersion() {
    setName("SecurityRoles generator.");
    setVersion("0.0.1");
  }

}
