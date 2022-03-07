/**
 * 
 */
package com.sicpa.modelgen.jpa.repository;

import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_REPOSITORY_SUFFIX;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.sicpa.modelgen.GenAppConstants;

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
public class JPAEntityRepositoryGenerator extends AbstractGenerator {

	private String jpaEntityTemplate = "jpa/repository/jpa_entity_repository.ftl";
	private String packageName;
	private String entityRepositorySuffix;
	private String entityPackage;
	private String entitySuffix;
	
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public JPAEntityRepositoryGenerator(String outputDir, String packageName, String entityPackage, String entitySuffix,String entityReposotorySuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityRepositorySuffix = entityReposotorySuffix;
		this.entityPackage = entityPackage;
		this.entitySuffix = entitySuffix;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void setNameAndVersion() {
		setName("JPA Entity Repository");
		setVersion("0.0.1");
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_REPOSITORY_SUFFIX, entityRepositorySuffix);
		input.put("entity_package", entityPackage);
		input.put("entity_suffix", entitySuffix);
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
		if ("byte".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Byte");
		}
		if ("short".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Short");
		}
		if ("int".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Integer");
		}
		if ("long".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("Long");
		}
		
		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		input.put(GenAppConstants.STR_PRIMARY_ATTRIBUTES, primaryAttributes);
		input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		
		input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		getMetaModels().values().forEach(m -> {
			
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				
				buildAttributeGroups(m);
				
				String fileName = m.getName() + this.entityRepositorySuffix + ".java";
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityTemplate, fileName);				
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

}
