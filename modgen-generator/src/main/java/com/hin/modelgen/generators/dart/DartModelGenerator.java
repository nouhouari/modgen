/**
 * 
 */
package com.hin.modelgen.generators.dart;

import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import fr.hin.modelgenerator.GeneratorConstants;
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
public class DartModelGenerator extends AbstractGenerator {

	private String extensionTemplate = "dart/extension.ftl";
	private String pageableTemplate = "dart/pageable.ftl";
	private String sortTemplate = "dart/sort.ftl";
	private String modelTemplate = "dart/model.ftl";
	private String pageTemplate = "dart/page.ftl";
	private String enumTemplate = "dart/enum.ftl";
	private String apiTemplate = "dart/api.ftl";
	private String synchServerTemplate = "dart/synch_server.ftl";
	private String databaseTemplate = "dart/database.ftl";
//	private String mapperTemplate = "dart/mapper.ftl";
	

	public DartModelGenerator(String outputDir) {
		super(outputDir);
	}

	@Override
	protected void onEachEntityStart() {
		// NOTHING
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
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
		final String dartOutputDirectory = getOutputDir() + "/lib/model";
		Utils.checkDirectoryOrCreate(dartOutputDirectory);
		List<ObjectMetaModel> entities = new ArrayList<ObjectMetaModel>();
		getMetaModels().values().forEach(m -> {
			if (m.getType() == ClassifierType.CLASS) {
				entities.add(m);
				input.put(STR_ENTITY, m);
				String fileName = m.getName().toLowerCase() + ".dart";
				Utils.generateTemplate(cfg, input, dartOutputDirectory, modelTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-page.dart";
				Utils.generateTemplate(cfg, input, dartOutputDirectory, pageTemplate, fileName);
				
//				// Mapper
//				String mapperDirectory = dartOutputDirectory + "/mapper";
//				Utils.checkDirectoryOrCreate(mapperDirectory);
//				fileName = m.getName().toLowerCase() + "-mapper.dart";
//				Utils.generateTemplate(cfg, input, mapperDirectory, mapperTemplate, fileName);
				
				if (m.hasAnnotation("SYNCH_SERVER") || m.hasAnnotation("SYNCH_CLIENT")) {
					final String synchOutputDirectory = getOutputDir() + "/lib/synch";
					fileName = m.getName().toLowerCase() + "-synch.dart";
					Utils.checkDirectoryOrCreate(synchOutputDirectory);
					Utils.generateTemplate(cfg, input, synchOutputDirectory, synchServerTemplate, fileName);
				}
				
			} else if (m.getType() == ClassifierType.ENUM) {
				System.out.println("//////// ENUM " + m.getName());
				input.put(STR_ENTITY, m);
				String fileName = m.getName().toLowerCase() + ".dart";
				Utils.generateTemplate(cfg, input, dartOutputDirectory, enumTemplate, fileName);
			}
		});

		// Generate API
		String apiDirectory = getOutputDir() + "/lib/api";
		Utils.checkDirectoryOrCreate(apiDirectory);
		getMetaModels().values().forEach(m -> {
			if (m.getType() == ClassifierType.CLASS) {
				input.put(STR_ENTITY, m);
				String fileName = m.getName().toLowerCase() + ".api.dart";
				Utils.generateTemplate(cfg, input, apiDirectory, apiTemplate, fileName);
			}
		});

		// Generate common files
		String commonOutputDirectory = getOutputDir() + "/lib/model/common";
		Utils.checkDirectoryOrCreate(commonOutputDirectory);
		Utils.generateTemplate(cfg, input, commonOutputDirectory, extensionTemplate, "extension.dart");
		Utils.generateTemplate(cfg, input, commonOutputDirectory, pageableTemplate, "pageable.dart");
		Utils.generateTemplate(cfg, input, commonOutputDirectory, sortTemplate, "sort.dart");
		
		// Generate synch server
		String daoDirectory = getOutputDir()+"/lib/model/dao";
		Utils.checkDirectoryOrCreate(daoDirectory);
		input.put(GeneratorConstants.STR_ENTITIES, entities);
		Utils.generateTemplate(cfg, input, daoDirectory, databaseTemplate, "database.dart");
		
	}

	@Override
	protected void setNameAndVersion() {
		setName("Dart Model");
		setVersion("0.0.1");
	}

}
