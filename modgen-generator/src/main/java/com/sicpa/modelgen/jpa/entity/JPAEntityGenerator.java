/**
 * 
 */
package com.sicpa.modelgen.jpa.entity;

import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_IMPORT;

import com.sicpa.modelgen.GenAppConstants;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;
import fr.hin.modelgenerator.model.ObjectMetaModel;

/**
 * @author nourreddine
 *
 */
public class JPAEntityGenerator extends AbstractGenerator {

  private String jpaEntityTemplate = "jpa/entity/jpa_entity_generated.ftl";
  private String jpaEntityStateTemplate = "jpa/entity/jpa_entity_state_enum.ftl";
  private String jpaEntityExtension = "jpa/entity/jpa_extension.ftl";
  private String jpaJSONType = "jpa/entity/jpa_jsontype.ftl";
  private String packageName;
  private String entitySuffix = "Entity";
  private String dtoSuffix;
  private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
  private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();
  private boolean owner;

  // Check http://beanvalidation.org/latest-draft/spec/#builtinconstraints for the full description
  private static List<String> JSR_303_349_VALIDATIONS = Arrays.asList(
      "Null", 
      "NotNull", 
      "AssertTrue", 
      "AssertFalse", 
      "Min", 
      "Max", 
      "DecimalMin", 
      "DecimalMax", 
      "Negative",
      "NegativeOrZero",
      "Positive",
      "PositiveOrZero",
      "Size",
      "Digits", 
      "Past",
      "PastOrPresent",
      "Future",
      "FutureOrPresent",
      "Pattern", 
      "NotEmpty", 
      "NotBlank", 
      "Email"
      );

  public JPAEntityGenerator(String outputDir, String packageName, String entitySuffix, String dtoSuffix, boolean owner) {
    super(outputDir);
    this.packageName = packageName;
    this.entitySuffix = entitySuffix;
    this.owner = owner;
  }

  @Override
  protected void onEachEntityStart() {
    primaryAttributes = new ArrayList<>();
    clusteringAttributes = new ArrayList<>();
  }

  @Override
  protected void setNameAndVersion() {
    setName("JPA Entity");
    setVersion("0.0.1");
  }

  @Override
  protected void addInputs(Map<String, Object> input) {
    input.put(STR_TODAY, new Date().toString());
    input.put(STR_PACKAGE, packageName);
    input.put("entity_suffix", entitySuffix);
    input.put("dto_suffix", dtoSuffix);
    input.put("owner", this.owner);
  }

  @Override
  protected void onEnumAttributeAdded(Attribute e) {
    // NOTHING
  }

  @Override
  protected void onCreateDirectories() {
    Utils.checkDirectoryOrCreate(getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"));
  }

  @Override
  protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {

    // Change type of byte and short to int
    if ("byte".equalsIgnoreCase(attribute.getType()) || "short".equalsIgnoreCase(attribute.getType())) {
      attribute.setType("int");
    }

    if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("PK"))) {
      primaryAttributes.add(attribute);
    } else if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("CC"))) {
      clusteringAttributes.add(attribute);
    }
    attributes.add(attribute);

    // search for the validation annotations
    attribute.getAnnotations().forEach(annotation -> {
      if(JSR_303_349_VALIDATIONS.contains(annotation.getName())) {
        attribute.getAnnotationGroups().computeIfAbsent("VALIDATIONS", k -> new ArrayList<>());
        attribute.getAnnotationGroups().get("VALIDATIONS").add(annotation);
      }
    });
  }

  @Override
  protected void onAttributesAdded(Map<String, Object> input) {
    input.put(GenAppConstants.STR_PRIMARY_ATTRIBUTES, primaryAttributes);
    input.put(GenAppConstants.STR_CLUSTERING_ATTRIBUTES, clusteringAttributes);
  }

  @Override
  protected void generateFiles(Map<String, Object> input) {

    getMetaModels().values().forEach(m -> {
      if (m.getType() == ClassifierType.CLASS) {
        Object[] imports = getImports(m).toArray();
        List<String> importsList = new ArrayList<>();
        for (Object object : imports) {
          importsList.add(object.toString());
        }
        // Sort the imports
        importsList.sort(String::compareTo);
        
        input.put(STR_IMPORT, importsList);
        input.put(STR_ENTITY, m);
        String fileName = m.getName() + this.entitySuffix + ".java";
        Utils.generateTemplate(cfg, input, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityTemplate,
            fileName);
      }
    });

    Utils.generateTemplate(cfg, input, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityStateTemplate,
        "EntityState.java");
    // Add extension
    Utils.generateTemplate(cfg, input, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityExtension,
            "Extension.java");
//    Utils.generateTemplate(cfg, input, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaJSONType,
//            "JsonbUserType.java");
    
  }

  /**
   * 
   * @return
   */
  public Set<String> getImports(ObjectMetaModel model) {
    Set<String> imports = new HashSet<>();

    List<Attribute> attributes = model.getAttributes();
    attributes.stream().filter(Attribute::isReference).forEach(a->imports.add("import " + packageName + "." + a.getType() + entitySuffix + ";"));
    attributes.stream().filter(Attribute::isEnumerate).forEach(a->{
      imports.add("import " + packageName + "." + a.getType() + ";");
    });
    imports.add("import java.util.*;");
    imports.add("import javax.persistence.*;");
    imports.add("import org.hibernate.annotations.Type;");
    
    if (attributes.stream().filter(a -> a.hasAnnotation("LOCATION")).count() > 0) {
    	imports.add("import com.vividsolutions.jts.geom.Point;");
    }

    return imports;
  }
  
  @Override
  protected boolean canAddAttributeAnnotation(String annotation) {
    // Check if the current component is the owner of the entity
    if ("AUTO".equals(annotation) && !this.owner) {
      // Don't add the primary key as AUTO generated if not the owner of the entity
      System.out.println("Filtered Annotation AUTO");
      return false;
    }
    return super.canAddAttributeAnnotation(annotation);
  }

}
