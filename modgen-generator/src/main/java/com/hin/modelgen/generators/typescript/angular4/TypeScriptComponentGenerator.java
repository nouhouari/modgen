/**
 * 
 */
package com.hin.modelgen.generators.typescript.angular4;

import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_PACKAGE;
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
public class TypeScriptComponentGenerator extends AbstractGenerator {

	private String componentListTemplate = "typescript/angular4/list/component.ts.ftl";
	private String componentListHtlmTemplate = "typescript/angular4/list/component.html.ftl";
	private String componentListScssTemplate = "typescript/angular4/list/component.scss.ftl";

	private String componentCreateTemplate = "typescript/angular4/create/component.ts.ftl";
	private String componentCreateHtlmTemplate = "typescript/angular4/create/component.html.ftl";

	private String componentEditTemplate = "typescript/angular4/edit/component.ts.ftl";
	private String componentEditHtlmTemplate = "typescript/angular4/edit/component.html.ftl";
	
	private String componentViewTemplate = "typescript/angular4/view/component.ts.ftl";
	private String componentViewHtlmTemplate = "typescript/angular4/view/component.html.ftl";

	private String componentUpdateTemplate = "typescript/angular4/update/component.ts.ftl";
	private String componentUpdateHtlmTemplate = "typescript/angular4/update/component.html.ftl";

	private String componentSearchTemplate = "typescript/angular4/search/component.ts.ftl";
	private String componentSearchHtlmTemplate = "typescript/angular4/search/component.html.ftl";

	private String componentFormTemplate = "typescript/angular4/component.form.ts.ftl";
	
	private String mapHtmlTemplate = "typescript/angular4/map/map.html.ftl";
	private String mapScssTemplate = "typescript/angular4/map/map.scss.ftl";
	private String mapComponentTemplate = "typescript/angular4/map/map.ts.ftl";
	
	private String dialogTemplate = "typescript/angular4/dialog/component.ts.ftl";
	private String dialogHtlmTemplate = "typescript/angular4/dialog/component.html.ftl";
	
	private String quickSearchTemplate = "typescript/angular4/quicksearch/component.ts.ftl";
	private String quickSearchHtlmTemplate = "typescript/angular4/quicksearch/component.html.ftl";
	
	private String constantTemplate = "typescript/angular4/app-constant.ts.ftl";
	private String sharedModuleTemplate = "typescript/angular4/shared-module.ts.ftl";
	private String moduleTemplate = "typescript/angular4/modules.ts.ftl";
	

	private String packageName;
	private String entityPackage;
	private String dtoSuffix;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public TypeScriptComponentGenerator(String outputDir, String packageName, String entityPackage, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		clusteringAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_ENTITY_PACKAGE, entityPackage);
		input.put(STR_DTO_SUFFIX, this.dtoSuffix);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		// NOTHING
	}

	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir() + "/shared");
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		// Change type of byte and short to int
		if ("byte".equalsIgnoreCase(attribute.getType()) || "short".equalsIgnoreCase(attribute.getType())
				|| "int".equalsIgnoreCase(attribute.getType()) || "long".equalsIgnoreCase(attribute.getType())
				|| "float".equalsIgnoreCase(attribute.getType()) || "double".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("number");
		} else if ("String".equalsIgnoreCase(attribute.getType())) {
			attribute.setType("string");
		}

		if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("PK"))) {
			primaryAttributes.add(attribute);
		} else if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("CC"))) {
			clusteringAttributes.add(attribute);
		}

		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		input.put(GenAppConstants.STR_PRIMARY_ATTRIBUTES, primaryAttributes);
		input.put(GenAppConstants.STR_CLUSTERING_ATTRIBUTES, clusteringAttributes);
		input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		input.put(GenAppConstants.STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		List<Object> entities = new ArrayList<>();
		getMetaModels().values().forEach(m -> {
			if (m.getType() == ClassifierType.CLASS) {
				entities.add(m);
				input.put(STR_ENTITY, m);
				buildAttributeGroups(m);
				// List component
				String fileName = m.getName().toLowerCase() + ".component.ts";
				String outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-list";
				Utils.checkDirectoryOrCreate(outputDir);
				Utils.generateTemplate(cfg, input, outputDir,
						componentListTemplate, fileName);
				fileName = m.getName().toLowerCase() + ".component.html";
				Utils.generateTemplate(cfg, input, outputDir,
						componentListHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + ".component.scss";
				Utils.generateTemplate(cfg, input, outputDir,
						componentListScssTemplate, fileName);
				
				// Form component
				fileName = m.getName().toLowerCase() + ".form.ts";
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-form";
				Utils.checkDirectoryOrCreate(outputDir);
				Utils.generateTemplate(cfg, input, outputDir,
						componentFormTemplate, fileName);
				fileName = m.getName().toLowerCase() + ".component.scss";
				Utils.generateTemplate(cfg, input, outputDir,
						componentListScssTemplate, fileName);

				// Create component
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-create";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-create.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentCreateHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-create.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, componentCreateTemplate, fileName);

				// Edit component
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-edit";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-edit.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentEditHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-edit.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, componentEditTemplate, fileName);
				
				// View component
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-view";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-view.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentViewHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-view.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, componentViewTemplate, fileName);

				// Update component
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-update";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-update.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentUpdateHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-update.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, componentUpdateTemplate, fileName);

				// Search
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-search";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-search.component.html";
				Utils.generateTemplate(cfg, input, outputDir, componentSearchHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-search.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, componentSearchTemplate, fileName);
				
				// Quick search
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-quicksearch";
				Utils.checkDirectoryOrCreate(outputDir);
				fileName = m.getName().toLowerCase() + "-quicksearch.component.html";
				Utils.generateTemplate(cfg, input, outputDir, quickSearchHtlmTemplate, fileName);
				fileName = m.getName().toLowerCase() + "-quicksearch.component.ts";
				Utils.generateTemplate(cfg, input, outputDir, quickSearchTemplate, fileName);
				
				// Location
				if (m.getAttributesByAnnotation("LOCATION").size() > 0) {
					outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase() + "/components/" + m.getName().toLowerCase() + "-map";
					Utils.checkDirectoryOrCreate(outputDir);
					fileName = m.getName().toLowerCase() + "-map.component.html";
					Utils.generateTemplate(cfg, input, outputDir, mapHtmlTemplate, fileName);
					fileName = m.getName().toLowerCase() + "-map.component.ts";
					Utils.generateTemplate(cfg, input, outputDir, mapComponentTemplate, fileName);
					fileName = m.getName().toLowerCase() + "-map.component.scss";
					Utils.generateTemplate(cfg, input, outputDir, mapScssTemplate, fileName);
				}
				
				// Module
				fileName =  m.getName().toLowerCase() + ".module.ts";
				outputDir = getOutputDir() + "/shared/modules/" + m.getName().toLowerCase();
				Utils.checkDirectoryOrCreate(outputDir);
				Utils.generateTemplate(cfg, input, outputDir,moduleTemplate, fileName);
			}
		});
		String fileName = "dialog.component.ts";
		String outputDir = getOutputDir() + "/shared/modules/shared/components/dialog";
		Utils.checkDirectoryOrCreate(outputDir);
		Utils.generateTemplate(cfg, input, outputDir,
				dialogTemplate, fileName);
		fileName =  "dialog.component.html";
		Utils.generateTemplate(cfg, input, outputDir,
				dialogHtlmTemplate, fileName);
		
		fileName = "app.constant.ts";
		outputDir = getOutputDir() + "/shared/modules/shared/util";
		Utils.checkDirectoryOrCreate(outputDir);
		Utils.generateTemplate(cfg, input, outputDir,constantTemplate, fileName);
		
		fileName = "shared.module.ts";
		outputDir = getOutputDir() + "/shared/modules/shared";
		Utils.checkDirectoryOrCreate(outputDir);
		Utils.generateTemplate(cfg, input, outputDir,sharedModuleTemplate, fileName);
		
	}

	@Override
	protected void setNameAndVersion() {
		setName("TypeScript Angular Component");
		setVersion("0.0.1");
	}

	/**
	 * Populate attributes according to their annotation.
	 * 
	 * @param m
	 */
	private void buildAttributeGroups(ObjectMetaModel m) {
		primaryAttributes.clear();
		m.getAttributes().forEach(a -> {
			if (a.hasAnnotation("PK") || a.hasAnnotation("CC")) {
				primaryAttributes.add(a);
			}
			if (a.hasAnnotation("LOCATION")) {
				a.setLocation(true);
			}
		});
		searchableAttributes.clear();
		m.getAttributes().forEach(a -> {
			if (a.hasAnnotation("QUERY")) {
				searchableAttributes.add(a);
			}
			if (a.hasAnnotation("LOCATION")) {
				a.setLocation(true);
			}
		});
	}

}
