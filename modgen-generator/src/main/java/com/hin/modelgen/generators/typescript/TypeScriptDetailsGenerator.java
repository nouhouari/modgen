/**
 * 
 */
package com.hin.modelgen.generators.typescript;

import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.hin.modelgen.generators.GenAppConstants;

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
public class TypeScriptDetailsGenerator extends AbstractGenerator {

  private String componentHtlmTemplate = "typescript/details/component.html.ftl";
  private String componentTsTemplate = "typescript/details/component.ts.ftl";
  private String indexTemplate = "typescript/details/index.ts.ftl";
	
	private String packageName;
	private String entityPackage;
	private String dtoSuffix;
  private ArrayList<Attribute> searchableAttributes = new ArrayList<>();
  private ArrayList<Attribute> primaryAttributes = new ArrayList<>();

	public TypeScriptDetailsGenerator(String outputDir, String packageName, String entityPackage, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
    primaryAttributes = new ArrayList<>();
	  searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_PACKAGE, entityPackage);
		input.put(STR_DTO_SUFFIX,this.dtoSuffix);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		// NOTHING
	}

	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir());
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		// Change type of byte and short to int
		if ("byte".equalsIgnoreCase(attribute.getType()) || "short".equalsIgnoreCase(attribute.getType()) ||
		    "int".equalsIgnoreCase(attribute.getType()) || "long".equalsIgnoreCase(attribute.getType()) ||
		    "float".equalsIgnoreCase(attribute.getType()) || "double".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("number");
		} else if("String".equalsIgnoreCase(attribute.getType())){
		  attribute.setType("string");
		}
		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
	  input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
	  input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
	  input.put(STR_PRIMARY_ATTRIBUTES, primaryAttributes);
	  
	  List<Object> entities = new ArrayList<>();
    getMetaModels().values().forEach( m -> {
      if(m.getType() == ClassifierType.CLASS){
        entities.add(m);
				input.put(STR_ENTITY, m);
				buildAttributeGroups(m);
				
				String outputDir = getOutputDir()+"/"+m.getName().toLowerCase()+"s/"+m.getName().toLowerCase()+"-details";
				Utils.checkDirectoryOrCreate(outputDir);
				
        String fileName = m.getName().toLowerCase() + "-details.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentHtlmTemplate, fileName);
				
				fileName = m.getName().toLowerCase() + "-details.component.ts";
        Utils.generateTemplate(cfg, input, outputDir, componentTsTemplate, fileName);
        
        fileName = "index.ts";
        Utils.generateTemplate(cfg, input, outputDir, indexTemplate, fileName);
			}
		});
	}
	

  /**
   * Populate attributes according to their annotation.
   * @param m
   */
  private void buildAttributeGroups(ObjectMetaModel m) {
    primaryAttributes.clear();
    searchableAttributes.clear();
    m.getAttributes().forEach(a -> {
      if(a.hasAnnotation("PK")||a.hasAnnotation("CC")){
        primaryAttributes.add(a);
      }
      if(a.hasAnnotation("QUERY")){
        searchableAttributes.add(a);
      }
      if(a.hasAnnotation("LOCATION")){
        a.setLocation(true);
      }
    });
  }

	@Override
	protected void setNameAndVersion() {
		setName("TypeScript Component details");
		setVersion("0.0.1");
	}

}
