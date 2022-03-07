package com.sicpa.modelgen.jpa.repository;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import java.io.File;
import java.util.ArrayList;
import java.util.Map;

import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

public class SpringDataPrimaryPostProcessorGenerator extends AbstractGenerator {
  private static final String templatePath = "jpa/repository/SpringDataPrimaryPostProcessor.java.ftl";
  private static final String outputFileName = "SpringDataPrimaryPostProcessor.java";

  private final String outputFilePath;
  private final String packageName;

  public SpringDataPrimaryPostProcessorGenerator(String outputDir, String packageName) {
    super(outputDir);
    this.outputFilePath = outputDir + File.separatorChar + packageName.replaceAll("\\.", "\\/");

    this.packageName = packageName;
  }

  @Override
  protected void setNameAndVersion() {
    setName("SpringData Primary PostProcessor generator.");
    setVersion("0.0.1");
  }

  @Override
  protected void onEachEntityStart() {}

  @Override
  protected void onCreateDirectories() {
    Utils.checkDirectoryOrCreate(outputFilePath);
  }

  @Override
  protected void generateFiles(Map<String, Object> input) {
    Utils.generateTemplate(cfg, input, outputFilePath, templatePath, outputFileName);
  }

  @Override
  protected void onAttributesAdded(Map<String, Object> input) {}

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_PACKAGE, packageName);
  }

  @Override
  protected void onEnumAttributeAdded(Attribute e) {}

  @Override
  protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {}
}
