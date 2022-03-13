/**
 * 
 */
package com.hin.modelgen.generators.dto;

import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_DTO_SUFFIX;
import static com.hin.modelgen.generators.GenAppConstants.STR_ENTITY_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_PROTO_PACKAGE;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_GENERATOR;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;
import static fr.hin.modelgenerator.GeneratorConstants.STR_VERSION;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.hin.modelgen.generators.GenAppConstants;
import com.hin.modelgen.generators.utils.StringUtils;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;
import fr.hin.modelgenerator.model.ObjectMetaModel;
import fr.hin.modelgenerator.model.ObjectRelationModel;
import freemarker.template.utility.StringUtil;

/**
 * @author VKoneru
 *
 */
public class EntityProtoTransformerGenerator extends AbstractGenerator {

	private String transformerInterfaceTemplate = "dto/transformers/entity_proto_transformer_interface.ftl";
	private String transformerTemplate = "dto/transformers/entity_proto_transformer_impl.ftl";
	
	private String packageName;
	private String dtoPackage;
	private String entityPackage;
	private String protoPackage;
	private String entitySuffix;
	private String dtoSuffix;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();
	
	public EntityProtoTransformerGenerator(String outputDir, String packageName, String dtoPackage,
			String entityPackage, String protoPackage, String entitySuffix, String dtoSuffix) {
		super(outputDir);
		this.packageName = packageName;
		this.dtoPackage = dtoPackage;
		this.entityPackage = entityPackage;
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
		input.put(STR_ENTITY_PACKAGE, entityPackage);
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
			String fileName = m.getName() + "EntityProtoMapperImpl.java";
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
				transformerInterfaceTemplate, "GenericEntityProtoMapper.java");
	}

	@Override
	protected void setNameAndVersion() {
		setName("ProtoTransformer");
		setVersion("0.0.1");
	}
	
	 /**
   * 
   * @return
   */
  public Set<String> getImports(ObjectMetaModel model) {
    Set<String> imports = new HashSet<>();

    imports.add("import java.util.ArrayList;");
    imports.add("import org.springframework.beans.factory.annotation.Autowired;");
    imports.add("org.springframework.stereotype.Component;");
    
    List<ObjectRelationModel> relations = model.getRelations();
    for (ObjectRelationModel relation : relations) {
      imports.add("import " + entityPackage+ "."+relation.getModel().getName() +"." + entitySuffix + ";");
      imports.add("import " + dtoPackage + "." + relation.getModel().getName() + ";");
      imports.add("import " + packageName + "." + StringUtils.capFirst(relation.getModel().getName()) + entitySuffix + ";");
      imports.add("import " + dtoPackage + "." + relation.getModel().getName() + ";");
    } 
    
    imports.add("");
    imports.add("");
    imports.add("");
    imports.add("");
    imports.add("");
    
    
    /*
    <#assign imports = [
    "", 
    "import java.util.List;",
    "import org.springframework.beans.factory.annotation.Autowired;",
    "import org.springframework.stereotype.Component;"]>

    <#list entity.relations as relation>
    <#assign imports = imports + ["import " + entityPackage+ "."+relation.model.name +"." + entity_suffix + ";"] >
    <#assign imports = imports + ["import " + dtoPackage + "." + relation.model.name + ";"]>

    import ${entityPackage}.${relation.model.name?cap_first}${entity_suffix};
    import ${dtoPackage}.${relation.model.name};
    </#list>
    import ${entityPackage}.${entity.name?cap_first}${entity_suffix};
    <#list entity.attributes as attribute>
      <#if attribute.reference>
    import ${entityPackage}.${attribute.model.name?cap_first}${entity_suffix};
      </#if>
    </#list>

    import ${dtoPackage}.${entity.name?cap_first};
    import ${package}.GenericEntityMapper;
    <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#if attribute.multiplicity==1>
    import ${dtoPackage}.${attribute.type};
    </#if>
    </#if>
    </#list>
    import java.util.ArrayList;
    import java.util.List;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Component;
    <#if hasGeometry>
    import com.vividsolutions.jts.io.ParseException;
    import com.vividsolutions.jts.io.WKTReader;
    </#if>
    */

    return imports;
  }

}
