/**
 * 
 */
package com.hin.modelgen.generators.jpa.entity;

import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.hin.modelgen.generators.utils.TypeUtils;

import fr.hin.modelgenerator.GeneratorConstants;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class JPASQLGenerator extends AbstractGenerator {

  private String protoTemplate = "jpa/entity/jpa_entity_sql.ftl";
  private String entitySuffix = "Entity";

  public JPASQLGenerator(String outputDir, String entitySuffix) {
    super(outputDir);
    this.entitySuffix = entitySuffix;
  }

  @Override
  protected void onEachEntityStart() {
  }

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_TODAY, new Date().toString());
    input.put("entity_suffix", entitySuffix);
  }

  @Override
  protected void onEnumAttributeAdded(Attribute e) {
    // NOTHING
  }

  @Override
  protected void onCreateDirectories() {
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
    
    String fileName = "V1_0_0_001__DDL.sql";
    // Generate all entities in same file
    input.put(GeneratorConstants.STR_ENTITIES, getMetaModels().values());
    Utils.generateTemplate(cfg, input, getOutputDir(), protoTemplate, fileName);
  }

  @Override
  protected void setNameAndVersion() {
    setName("SQL generator.");
    setVersion("0.0.1");
  }

}
