/**
 * 
 */
package com.hin.modelgen.generators.jpa.repository;

import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_REPOSITORY_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_SERVICE_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import fr.hin.modelgenerator.model.Annotation;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.hin.modelgen.generators.GenAppConstants;
import com.hin.modelgen.generators.utils.TypeUtils;

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
public class JPAEntitySpecificationGenerator extends AbstractGenerator {

	private String jpaEntityTemplate = "jpa/repository/jpa_entity_specification.ftl";
	private String jpaEntityQuickSearchTemplate = "jpa/repository/jpa_entity_quickSearchSpecification.ftl";
	private String packageName;
	private String entityRepositorySuffix;
	private String entityPackage;
	private String entitySuffix;
	private String servicePackage;
	
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public JPAEntitySpecificationGenerator(String outputDir, String packageName, String entityPackage, String entitySuffix,String entityReposotorySuffix, String servicePackage) {
		super(outputDir);
		this.packageName = packageName;
		this.entityRepositorySuffix = entityReposotorySuffix;
		this.entityPackage = entityPackage;
		this.entitySuffix = entitySuffix;
		this.servicePackage = servicePackage;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void setNameAndVersion() {
		setName("JPA Entity Specification");
		setVersion("0.0.1");
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_REPOSITORY_SUFFIX, entityRepositorySuffix);
		input.put("entity_package", entityPackage);
		input.put("entity_suffix", entitySuffix);
		input.put(STR_SERVICE_PACKAGE, servicePackage);
    
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

		TypeUtils.convertPrimaryTypeToObjectType(attribute);
		
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
			searchableAttributes.clear();
			
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				
				buildAttributeGroups(m);
				
				// Normal search
				String fileName = m.getName() + "Specification.java";
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityTemplate, fileName);
				
				// Quick search
				fileName = m.getName() + "QuickSearchSpecification.java";
        Utils.generateTemplate(cfg, input,
            getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityQuickSearchTemplate, fileName);   
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
				a.getAnnotations().stream().filter(x -> x.getName().equals("QUERY")).forEach(y -> {

					if(y.getDetails().containsKey("EQUAL")){
						a.setWildcard(false);
					}
				});
				searchableAttributes.add(a);
			}
			if(a.hasAnnotation("LOCATION")){
				a.setLocation(true);
			}
		});
	}

}
