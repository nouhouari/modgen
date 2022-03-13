/**
 * 
 */
package com.hin.modelgen.generators.grpc;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.hin.modelgen.generators.GenAppConstants.STR_COMPONENT_CLASS_NAME_PREFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_REPOSITORY_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_PROTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_REPO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static com.hin.modelgen.generators.GenAppConstants.STR_TRANSF_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

/**
 * @author nourreddine
 *
 */
public class GRPCClientConfigurationGenerator extends AbstractGenerator {

  private String configTemplate = "grpc/grpcclientconfig.ftl";

  private String packageName;
  private String entityPackage;
  private String entitySuffix;
  private String dtoSuffix;
  private String entityRepositorySuffix;
  private String dtoPackage;
  private String repositoryPackage;
  private String transformersPackage;
  private String protoBuffPackage;
  private String componentClassNamePrefix;

  public GRPCClientConfigurationGenerator(String outputDir, String packageName, String entityPackage, String entitySuffix,
      String entityRepositorySuffix, String dtoPackage, String repositoryPackage, String transformersPackage, String dtoSuffix,
      String protoBuffPackage, String componentClassNamePrefix) {
    super(outputDir);
    this.packageName = packageName;
    this.entityPackage = entityPackage;
    this.entitySuffix = entitySuffix;
    this.entityRepositorySuffix = entityRepositorySuffix;
    this.dtoPackage = dtoPackage;
    this.repositoryPackage = repositoryPackage;
    this.transformersPackage = transformersPackage;
    this.dtoSuffix = dtoSuffix;
    this.protoBuffPackage = protoBuffPackage;
    this.componentClassNamePrefix = componentClassNamePrefix;
  }

  @Override
  protected void onEachEntityStart() {
  }

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_TODAY, new Date().toString());
    input.put(STR_PACKAGE, packageName);
    input.put(STR_ENTITY_PACKAGE, entityPackage);
    input.put(STR_ENTITY_SUFFIX, entitySuffix);
    input.put(STR_ENTITY_REPOSITORY_SUFFIX, entityRepositorySuffix);
    input.put(STR_DTO_PACKAGE, dtoPackage);
    input.put(STR_REPO_PACKAGE, repositoryPackage);
    input.put(STR_TRANSF_PACKAGE, transformersPackage);
    input.put("dto_suffix", dtoSuffix);
    input.put(STR_PROTO_PACKAGE, protoBuffPackage);
    input.put(STR_COMPONENT_CLASS_NAME_PREFIX, componentClassNamePrefix);
  }

  @Override
  protected void onEnumAttributeAdded(Attribute e) {
    // NOTHING
  }

  @Override
  protected void onCreateDirectories() {
    // NOTHING
  }

  @Override
  protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
    // NOTHING
  }

  @Override
  protected void onAttributesAdded(Map<String, Object> input) {
    // NOTHING
  }

  @Override
  protected void generateFiles(Map<String, Object> input) {
    List<Object> entities = new ArrayList<>();
    input.put("entities", entities);
    getMetaModels().values().forEach(m -> {

      if (m.getType() == ClassifierType.CLASS) {
        entities.add(m);
      }
    });

    String fileName = componentClassNamePrefix + "GrpcClientConfig.java";
    Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), configTemplate, fileName);
  }

  @Override
  protected void setNameAndVersion() {
    setName("GRCPClientConfigurationGenerator");
    setVersion("0.0.1");
  }
}
