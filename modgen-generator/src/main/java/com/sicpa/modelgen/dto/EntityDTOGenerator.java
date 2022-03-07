/**
 * 
 */
package com.sicpa.modelgen.dto;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_SUFFIX;
import static com.sicpa.modelgen.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author nourreddine
 *
 */
public class EntityDTOGenerator extends AbstractGenerator {

  private String dtoTemplate = "dto/entity_dto.ftl";
  private String dtoSaveResultTemplate = "dto/dto_save_result.ftl";
  private String dtoEnumTemplate = "jpa/entity/jpa_enum.ftl"; // Same as entity
	private String saveResultStatusEnumTemplate = "dto/dto_save_result_status_enum.ftl";

  
	private String packageName;
	private String entityPackage;
	private String dtoSuffix;

	public EntityDTOGenerator(String outputDir, String packageName, String entityPackage, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
		// NOTHING
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
		Utils.checkDirectoryOrCreate(getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"));
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		// Change type of byte and short to int
		if ("byte".equalsIgnoreCase(attribute.getType()) || "short".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("int");
		}
		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		getMetaModels().values().forEach( m -> {
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				String fileName = m.getName() + this.dtoSuffix + ".java";
				String saveResultFileName = m.getName() + this.dtoSuffix + "SaveResult.java";
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), dtoTemplate, fileName);
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), dtoSaveResultTemplate, saveResultFileName);
			} else if(m.getType() == ClassifierType.ENUM) {
			  input.put(STR_ENTITY, m);
        String fileName = m.getName() + ".java";
        Utils.generateTemplate(cfg, input,
            getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), dtoEnumTemplate, fileName);
			}
		});

		Utils.generateTemplate(cfg, input,
				getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), saveResultStatusEnumTemplate, "SaveStatus.java");
	}

	@Override
	protected void setNameAndVersion() {
		setName("DTO");
		setVersion("0.0.2");
	}

}
