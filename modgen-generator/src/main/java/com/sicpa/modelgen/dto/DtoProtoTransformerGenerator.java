/**
 * 
 */
package com.sicpa.modelgen.dto;

import static com.sicpa.modelgen.GenAppConstants.STR_DTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_DTO_SUFFIX;
import static com.sicpa.modelgen.GenAppConstants.STR_PROTO_PACKAGE;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_GENERATOR;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_VERSION;

import com.sicpa.modelgen.GenAppConstants;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author VKoneru
 *
 */
public class DtoProtoTransformerGenerator extends AbstractGenerator {

	private String transformerInterfaceTemplate = "dto/transformers/proto_dto_transformer_interface.ftl";
	private String transformerTemplate = "dto/transformers/proto_dto_transformer_impl.ftl";
	
	private String packageName;
	private String dtoPackage;
	private String protoPackage;
	private String entitySuffix;
	private String dtoSuffix;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();
	
	public DtoProtoTransformerGenerator(String outputDir, String packageName, String dtoPackage,
			String protoPackage, String entitySuffix, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.dtoPackage = dtoPackage;
		this.protoPackage = protoPackage;
		this.entitySuffix = entitySuffix;
		this.dtoSuffix = dtoSuffix;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		clusteringAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
		input.put(STR_DTO_PACKAGE, dtoPackage);
		input.put("entity_suffix", entitySuffix);
		input.put(STR_DTO_SUFFIX,this.dtoSuffix);
		input.put(STR_PROTO_PACKAGE, protoPackage);
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
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		
		getMetaModels().values().forEach( m -> {
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
			String fileName = m.getName() + "DTOProtoMapperImpl.java";
			Utils.generateTemplate(cfg, input,
					getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"),
					transformerTemplate, fileName);
			}
		});
		// Common Class
		Map<String, Object> input2 = new HashMap<>();
		addInputs(input2);
		input2.put(STR_GENERATOR, getName());
		input2.put(STR_VERSION, getVersion());
		
		Utils.generateTemplate(cfg, input2, getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"),
				transformerInterfaceTemplate, "GenericProtoDTOTransformer.java");
	}

	@Override
	protected void setNameAndVersion() {
		setName("ProtoTransformer");
		setVersion("0.0.1");
	} 

}
