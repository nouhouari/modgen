/**
 * 
 */
package com.sicpa.modelgen.repository;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_GENERATOR;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_UDT;
import static fr.hin.modelgenerator.GeneratorConstants.STR_VERSION;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class EntityRepositoryGenerator extends AbstractGenerator {
	private String cqlTemplate = "repository/entity_repository.ftl";
	private String packageName;
	private String entityPackage;
	private String dtoPackage;
	private ArrayList<Attribute> primaryKeyAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();
	

	public EntityRepositoryGenerator(String outputDir, String packageName, String entityPackage, String dtoPackage) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.dtoPackage = dtoPackage;
	}
	
	@Override
	protected void onEachEntityStart() {
		primaryKeyAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_GENERATOR, getName());
		input.put(STR_VERSION, getVersion());
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_PACKAGE, entityPackage);
		input.put(STR_DTO_PACKAGE, dtoPackage);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		//NOTHING
	}
	
	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"));
	}
	
	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		
		//Convert primitive types to object types.
		attribute.setType(Utils.convertToJavaObjectType(feature.getEType()));
		
		if(feature.getEAnnotations().stream().anyMatch(a->a.getSource().equalsIgnoreCase("PK")||a.getSource().equalsIgnoreCase("CC"))){
			primaryKeyAttributes.add(attribute);
		}
		if(feature.getEAnnotations().stream().anyMatch(a->a.getSource().equalsIgnoreCase("PK")||a.getSource().equalsIgnoreCase("CC")||a.getSource().equalsIgnoreCase("QUERY"))){
			searchableAttributes.add(attribute);
		}
		if(feature.getEAnnotations().stream().anyMatch(a->a.getSource().equalsIgnoreCase("LOCATION"))){
			attribute.setLocation(true);
		}
		attributes.add(attribute);
	}
	
	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, primaryKeyAttributes);
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
	}
	
	@Override
	protected void generateFiles(Map<String, Object> input) {
//		getEntities().forEach((key, input) -> {
//			//Do not generate repository for User Define Type
//			if(input.get(STR_UDT)==null || (Boolean)input.get(STR_UDT)==false){
//				String fileName = ((EClass)input.get(STR_ENTITY)).getName() + "Repository.java";
//				Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), cqlTemplate, fileName);			
//			}
//		});
	}

	@Override
	protected void setNameAndVersion() {
		setName("EntityRepository");
		setVersion("0.0.2");
	}
	
}
