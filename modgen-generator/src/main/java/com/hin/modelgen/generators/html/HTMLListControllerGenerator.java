/**
 * 
 */
package com.hin.modelgen.generators.html;

import static com.hin.modelgen.generators.GenAppConstants.STR_APP_MODULE;
import static com.hin.modelgen.generators.GenAppConstants.STR_CONTEXT_PATH;
import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_REST_PREFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_SERVER_ADDRESS;
import static com.hin.modelgen.generators.GenAppConstants.STR_SERVER_PORT;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;

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
public class HTMLListControllerGenerator extends AbstractGenerator {

	private String angularControllerTemplate = "html/controller.ftl";
	private String angularServiceTemplate = "html/service.ftl";
	private String contextRoot;
	private String restPath;
	private String serverHost;
	private String serverPort;
	private String angularModule;
	private List<Attribute> searchableAttributes = new ArrayList<>();
	private ArrayList<Attribute> primaryKeyAttributes = new ArrayList<>();

	public HTMLListControllerGenerator(String outputDir, String contextRoot, String restPath, String serverHost,
			String serverPort, String angularModule) {
		super(outputDir);
		this.contextRoot = contextRoot;
		this.restPath = restPath;
		this.serverHost = serverHost;
		this.serverPort = serverPort;
		this.angularModule = angularModule;
	}

	@Override
	protected void onEachEntityStart() {
		searchableAttributes = new ArrayList<>();
		primaryKeyAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_CONTEXT_PATH, this.contextRoot);
		input.put(STR_REST_PREFIX, this.restPath);
		input.put(STR_SERVER_ADDRESS, this.serverHost);
		input.put(STR_SERVER_PORT, this.serverPort);
		input.put(STR_APP_MODULE, this.angularModule);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		// NOTHING
	}

	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir() + "/services");
		Utils.checkDirectoryOrCreate(getOutputDir() + "/controllers");
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
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		input.put(STR_PRIMARY_ATTRIBUTES, primaryKeyAttributes);
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, primaryKeyAttributes);
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		
		getMetaModels().values().forEach(m -> {
			searchableAttributes.clear();

			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);

				buildAttributeGroups(m);

				String name = m.getName().toLowerCase();
				String fileName = name + ".js";
				String serviceFileName = name + "-service.js";
				Utils.generateTemplate(cfg, input, getOutputDir() + "/controllers", angularControllerTemplate, fileName);	
				Utils.generateTemplate(cfg, input, getOutputDir() + "/services", angularServiceTemplate, serviceFileName);
			}
		});
	}
	
	/**
	 * Populate attributes according to their annotation.
	 * @param m
	 */
	private void buildAttributeGroups(ObjectMetaModel m) {
		searchableAttributes.clear();
		primaryKeyAttributes.clear();
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
	}

	@Override
	protected void setNameAndVersion() {
		setName("HTML List View");
		setVersion("0.0.2");
	}

}
