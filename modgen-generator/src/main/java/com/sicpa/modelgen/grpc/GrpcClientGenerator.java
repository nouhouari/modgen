/**
 * 
 */
package com.sicpa.modelgen.grpc;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_PROTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static com.sicpa.modelgen.GenAppConstants.STR_TRANSF_PACKAGE;
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
import fr.hin.modelgenerator.model.ObjectMetaModel;

/**
 * @author nourreddine
 *
 */
public class GrpcClientGenerator extends AbstractGenerator {

	private String clientTemplate = "grpc/grpcclient.ftl";

	private String packageName;
	private String dtoSuffix;
	private String dtoPackage;
	private String transformersPackage;
  private String protoBuffPackage;
  
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();

	public GrpcClientGenerator(String outputDir, String packageName, String dtoPackage, String transformersPackage, String dtoSuffix, String protoBuffPackage) {
		super(outputDir);
		this.packageName = packageName;
		this.dtoPackage = dtoPackage;
		this.transformersPackage = transformersPackage;
		this.dtoSuffix = dtoSuffix;
		this.protoBuffPackage = protoBuffPackage;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		searchableAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_DTO_PACKAGE, dtoPackage);
		input.put(STR_TRANSF_PACKAGE, transformersPackage);
		input.put("dto_suffix", dtoSuffix);
		input.put(STR_PROTO_PACKAGE, protoBuffPackage);
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
	}

	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"));
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {

		//Convert primitive types to object types.
		attribute.setType(Utils.convertToJavaObjectType(feature.getEType()));
		attributes.add(attribute);	
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, primaryAttributes);
		input.put(STR_SEARCHABLE_ATTRIBUTES, searchableAttributes);
		getMetaModels().values().forEach( m -> {
			
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				
				buildAttributeGroups(m);
				
				String fileName = m.getName() + "GrpcClient.java";
				Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), clientTemplate, fileName);
				
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

	@Override
	protected void setNameAndVersion() {
		setName("EntityService");
		setVersion("0.0.2");
	}

}
