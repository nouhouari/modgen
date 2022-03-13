/**
 * 
 */
package com.hin.modelgen.generators.service;

import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_REPOSITORY_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_PROTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_REPO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static com.hin.modelgen.generators.GenAppConstants.STR_TRANSF_PACKAGE;
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
public class GrpcEntityServiceGenerator extends AbstractGenerator {

	private String serviceTemplate = "service/grpc/grpc_entity_service.ftl";
	private String validationInterfaceTemplate = "service/grpc/serviceEntityValidationInterface.ftl";
	private String queryConstraintInterfaceTemplate = "service/grpc/serviceQueryConstraintInterface.ftl";
  private String serviceListenerInterfaceTemplate = "service/grpc/serviceListenerInterface.ftl";
  private String validationUtilTemplate = "service/grpc/PotValidationUtil.java.ftl";
	private String threadLocalTemplate = "service/grpc/ThreadLocalErrorContext.java.ftl";
	private String serviceImplTemplate = "service/grpc/grpc_entity_service_impl.ftl";
	private String genericServiceTemplate = "service/generic_entity_service.ftl";
	private String genericServiceImplTemplate = "service/generic_entity_service_impl.ftl";

	private String resultTemplate = "controller/ResultPage.ftl";
	private String packageName;
	private String entityPackage;
	private String entitySuffix;
	private String dtoSuffix;
	private String entityRepositorySuffix;
	private String dtoPackage;
	private String repositoryPackage;
	private String transformersPackage;
  private String protoBuffPackage;
  private String validationPackage;
  
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> searchableAttributes = new ArrayList<>();



	public GrpcEntityServiceGenerator(String outputDir, String packageName, String entityPackage,String entitySuffix,
									  String entityRepositorySuffix, String dtoPackage, String repositoryPackage,
									  String transformersPackage, String dtoSuffix, String protoBuffPackage,
									  String validationPackage) {
		super(outputDir);
		this.packageName = packageName;
		this.entityPackage = entityPackage;
		this.entitySuffix = entitySuffix;
		this.entityRepositorySuffix = entityRepositorySuffix;
		this.dtoPackage = dtoPackage;
		this.repositoryPackage = repositoryPackage;
		this.transformersPackage = transformersPackage;
		this.dtoSuffix = dtoSuffix;
		this.protoBuffPackage = protoBuffPackage;
		this.validationPackage = validationPackage;
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
		input.put(STR_ENTITY_PACKAGE, entityPackage);
		input.put(STR_ENTITY_SUFFIX, entitySuffix);
		input.put(STR_ENTITY_REPOSITORY_SUFFIX, entityRepositorySuffix);
		input.put(STR_DTO_PACKAGE, dtoPackage);
		input.put(STR_REPO_PACKAGE, repositoryPackage);
		input.put(STR_TRANSF_PACKAGE, transformersPackage);
		input.put("dto_suffix", dtoSuffix);
		input.put(STR_PROTO_PACKAGE, protoBuffPackage);
		input.put("validationPackage", validationPackage);
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
				
				String fileName = m.getName() + "Service.java";
				Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), serviceTemplate, fileName);

				fileName = m.getName() + "ServiceImpl.java";
				Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), serviceImplTemplate, fileName);
				
				// Validation interface
				fileName = m.getName() + "ValidationListener.java";
        Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), validationInterfaceTemplate, fileName);

        // Service listener interface
        fileName = m.getName() + "ServiceListener.java";
        Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), serviceListenerInterfaceTemplate, fileName);
        
        // Query constaint interface
        fileName = m.getName() + "QueryConstraintListener.java";
        Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), queryConstraintInterfaceTemplate, fileName); 
			}
		});

		// Common Class
		Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), genericServiceTemplate, "GenericEntityService.java");
		Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), genericServiceImplTemplate, "GenericEntityServiceImpl.java");
		Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+packageName.replaceAll("\\.", "\\/"), resultTemplate, "ResultPage.java");

		Utils.checkDirectoryOrCreate(getOutputDir()+File.separatorChar+validationPackage.replaceAll("\\.", "\\/"));
		Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+validationPackage.replaceAll("\\.", "\\/"), validationUtilTemplate, "PotValidationUtil.java");
		Utils.generateTemplate(cfg, input, getOutputDir()+File.separatorChar+validationPackage.replaceAll("\\.", "\\/"), threadLocalTemplate, "ThreadLocalErrorContext.java");
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
