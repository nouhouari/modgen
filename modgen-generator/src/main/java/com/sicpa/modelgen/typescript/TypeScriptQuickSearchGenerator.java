/**
 * 
 */
package com.sicpa.modelgen.typescript;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_SUFFIX;
import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import com.sicpa.modelgen.GenAppConstants;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
public class TypeScriptQuickSearchGenerator extends AbstractGenerator {

  private String componentHtlmTemplate = "typescript/quick-search/component.html.ftl";
  private String componentTsTemplate = "typescript/quick-search/component.ts.ftl";
  private String indexTemplate = "typescript/quick-search/index.ts.ftl";
	
	private String packageName;
	private String entityPackage;
	private String dtoSuffix;
  private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public TypeScriptQuickSearchGenerator(String outputDir, String packageName, String entityPackage, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
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
	  List<Object> entities = new ArrayList<>();
    getMetaModels().values().forEach( m -> {
      if(m.getType() == ClassifierType.CLASS){
        entities.add(m);
				input.put(STR_ENTITY, m);
				buildAttributeGroups(m);
				
				String outputDir = getOutputDir()+"/"+m.getName().toLowerCase()+"s/"+m.getName().toLowerCase()+"-quicksearch";
				Utils.checkDirectoryOrCreate(outputDir);
				
        String fileName = m.getName().toLowerCase() + "-quicksearch.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentHtlmTemplate, fileName);
				
				fileName = m.getName().toLowerCase() + "-quicksearch.component.ts";
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
    searchableAttributes.clear();
    m.getAttributes().forEach(a -> {
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
		setName("TypeScript Component Quick search");
		setVersion("0.0.1");
	}

}
