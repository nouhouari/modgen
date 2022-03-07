/**
 * 
 */
package com.sicpa.modelgen.controller;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_SUFFIX;
import static com.sicpa.modelgen.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_SERVICE_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_GENERATOR;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_UDT;
import static fr.hin.modelgenerator.GeneratorConstants.STR_VERSION;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author nourreddine
 *
 */
public class EntityControllerGenerator extends AbstractGenerator {

	private String controllerTemplate = "controller/entity_controller.ftl";
	private String resultPageControllerTemplate = "controller/ResultPage.ftl";
  
	
	private String packageName;
	private String entityPackage;
	private String entitySuffix;
	private String dtoPackage;
	private String dtoSuffix;
	private String servicePackage;
	private ArrayList<Attribute> primaryKeyAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public EntityControllerGenerator(String outputDir, String packageName, String entityPackage,String entitySuffix, String dtoPackage,
			String servicePackage, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.entitySuffix = entitySuffix;
		this.dtoPackage = dtoPackage;
		this.servicePackage = servicePackage;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
		primaryKeyAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_PACKAGE, entityPackage);
		input.put(STR_ENTITY_SUFFIX, entitySuffix);
		input.put(STR_DTO_PACKAGE, dtoPackage);
		input.put(STR_SERVICE_PACKAGE, servicePackage);
		input.put(STR_GENERATOR, getName());
		input.put(STR_VERSION, getVersion());
		input.put("dto_suffix",dtoSuffix);
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
		// Convert primitive types to object types.
		attribute.setType(Utils.convertToJavaObjectType(feature.getEType()));
		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, primaryKeyAttributes);
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		
		getMetaModels().values().forEach( m -> {
			
			primaryKeyAttributes.clear();
			searchableAttributes.clear();
			
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);

				m.getAttributes().forEach(a -> {
					if(a.hasAnnotation("PK")||a.hasAnnotation("CC")){
						primaryKeyAttributes.add(a);
					}
					if(a.hasAnnotation("QUERY")){
						searchableAttributes.add(a);
					}
					if(a.hasAnnotation("LOCATION")){
						a.setLocation(true);
					}
				});
				
				String fileName = m.getName() + "Controller.java";
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), controllerTemplate,
						fileName);
			}
		});
		Utils.generateTemplate(cfg, input, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"),
		    resultPageControllerTemplate, "ResultPage.java");
	}

	@Override
	protected void setNameAndVersion() {
		setName("EntityController");
		setVersion("0.0.2");
	}

}
