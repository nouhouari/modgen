/**
 * 
 */
package com.hin.modelgen.generators.html;

import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_UDT;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.hin.modelgen.generators.GenAppConstants;

import fr.hin.modelgenerator.ecore.EClass;
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
public class HTMLListViewGenerator extends AbstractGenerator {

	private String listTemplate   = "html/listView.ftl";
	private String formTemplate   = "html/form.ftl";
	private String viewTemplate   = "html/details.ftl";
	private String newTemplate    = "html/edit.ftl";
	private String searchTemplate = "html/search.ftl";
	private String tableTemplate  = "html/table.ftl";
	private String viewDir;
	private String jsDir;
	
	private List<Attribute> searchableAttributes = new ArrayList<>();

	public HTMLListViewGenerator(String outputDir, String viewDir) {
		super(outputDir + '/' +viewDir);
		this.viewDir = viewDir;
	}

	@Override
	protected void onEachEntityStart() {
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put("viewDir", viewDir);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		// NOTHING
	}

	@Override
	protected void onCreateDirectories() {
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		// Convert primitive types to object types.
		attribute.setType(Utils.convertToJavaObjectType(feature.getEType()));
		if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("LOCATION"))) {
			attribute.setLocation(true);
		}
		attributes.add(attribute);
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		
		getMetaModels().values().forEach(m -> {
			
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				
				buildAttributeGroups(m);
				
				String entityName = m.getName().toLowerCase();
				String fileName = entityName + ".html";
				Utils.generateTemplate(cfg, input, getOutputDir(), listTemplate, fileName);
				
				fileName = entityName + "-form.html";
				Utils.generateTemplate(cfg, input, getOutputDir(), formTemplate, fileName);
				
				fileName = entityName + "-edit.html";
				Utils.generateTemplate(cfg, input, getOutputDir(), newTemplate, fileName);
				
				fileName = entityName + "-details.html";
				Utils.generateTemplate(cfg, input, getOutputDir(), viewTemplate, fileName);
				
				fileName = entityName + "-search.html";
				Utils.generateTemplate(cfg, input, getOutputDir(), searchTemplate, fileName);
				
				fileName = entityName + "-table.html";
				Utils.generateTemplate(cfg, input, getOutputDir(), tableTemplate, fileName);
								
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
		setName("HTML List View");
		setVersion("0.0.3");
	}

}
