/**
 * 
 */
package com.hin.modelgen.generators.grpc;

import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.hin.modelgen.generators.utils.TypeUtils;

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
public class ProtoGenerator extends AbstractGenerator {

  private String protoTemplate = "grpc/proto.ftl";
  private String enumprotoTemplate = "grpc/enumproto.ftl";
  private String pageTemplate = "grpc/page.proto.ftl";
  private String packageName;

  public ProtoGenerator(String outputDir, String packageName) {
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
    
    String fileName = "model.proto";
    // Generate all entities in same file
    input.put(GeneratorConstants.STR_ENTITIES, getMetaModels().values());
    Utils.generateTemplate(cfg, input, getOutputDir(), protoTemplate, fileName);
  
    String pageFileName = "Page.proto";
    Utils.generateTemplate(cfg, input, getOutputDir(), pageTemplate, pageFileName);
  }

  @Override
  protected void setNameAndVersion() {
    setName("Protobuf generator.");
    setVersion("0.0.1");
  }

}
