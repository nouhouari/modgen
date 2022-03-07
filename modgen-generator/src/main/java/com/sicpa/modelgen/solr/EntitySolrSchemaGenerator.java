/**
 * 
 */
package com.sicpa.modelgen.solr;

import static com.sicpa.modelgen.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_SEARCHABLE_ATTRIBUTES;
import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ATTRIBUTES;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_UDT;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.apache.commons.io.FileUtils;

import com.sicpa.modelgen.GenAppConstants;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Annotation;
import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class EntitySolrSchemaGenerator extends AbstractGenerator {
	
	private String cqlTemplate = "solr/schema.ftl";
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	
	public EntitySolrSchemaGenerator(String outputDir) {
		super(outputDir);
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();	
	}
	
	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
	}
	

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		//NOTHING
	}
	
	@Override
	protected void onCreateDirectories() {
	}
	
	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		
		if(feature.getEAnnotations().stream().anyMatch(a->a.getSource().equalsIgnoreCase("PK")||a.getSource().equalsIgnoreCase("CC"))){
			primaryAttributes.add(attribute);
		}
		if(feature.getEAnnotations().stream().anyMatch(a->a.getSource().equalsIgnoreCase("LOCATION"))){
			attribute.setLocation(true);
		}
		attributes.add(attribute);
	}
	
	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, primaryAttributes);
	}
	
	@Override
	protected void generateFiles(Map<String, Object> input) {
//		getEntities().forEach((key, value) -> {
//			//No Solr index generation for UDT
//			if(value.get(STR_UDT)==null || (Boolean)value.get(STR_UDT)==false){
//				
//				ArrayList<Attribute> localAttributes = new ArrayList<>();
//
//				ArrayList<Attribute> attributes = (ArrayList<Attribute>) value.get(STR_ATTRIBUTES);
//				
//				attributes.forEach(attribute -> {
//
//					if (attribute.isReference()) {
//						getLogger().trace("Referrence Name {} Type {} Multiplicity {} Opposite Multiplicity {}",
//								attribute.getName(), attribute.getType(), attribute.getMultiplicity(),
//								attribute.getOppositeMultiplicity());
//
//						if ((attribute.getMultiplicity() == 0 || attribute.getMultiplicity() == 1)
//								&& (attribute.getOppositeMultiplicity() == 0 || attribute.getOppositeMultiplicity() == 1)) {
//							getLogger().info("Encountered ONE to ONE relationship on {}", attribute.getType());
//
//							Map<String, Object> foreignEntityAttributes = getEntities().get(attribute.getType());
//
//							EClass entity = (EClass) foreignEntityAttributes.get(STR_ENTITY);
//
//							if (entity.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("UDT"))) {
//								localAttributes.add(attribute);
//							} else {
//
//								ArrayList<Attribute> foreignPrimaryAttributes = (ArrayList<Attribute>) foreignEntityAttributes
//										.get(GenAppConstants.STR_PRIMARY_ATTRIBUTES);
//								foreignPrimaryAttributes.forEach(foreignPrimaryAttribute -> {
//									Attribute attr = new Attribute(
//											foreignPrimaryAttribute.getModel().getName() + "_" + foreignPrimaryAttribute.getName(), false,
//											foreignPrimaryAttribute.getType(), false, 0, 0);
//									localAttributes.add(attr);
//								});
//							}
//						} else if (attribute.getMultiplicity() == -1) {
//							getLogger().info("Encountered ONE to MANY relationship on {}", attribute.getType());
//							Map<String, Object> foreignEntityAttributes = getEntities().get(attribute.getType());
//							EClass entity = (EClass) foreignEntityAttributes.get(STR_ENTITY);
//							
//							ArrayList<Attribute> primaryAttributes = (ArrayList<Attribute>) value.get(GenAppConstants.STR_PRIMARY_ATTRIBUTES);
//							
//							primaryAttributes.forEach(primaryAttribute -> {
//								Attribute attr = new Attribute(
//										primaryAttribute.getModel().getName().toLowerCase() + "_" + primaryAttribute.getName(), false,
//										primaryAttribute.getType(), false, 0, 0);
//								ArrayList<Attribute> flAttributes = (ArrayList<Attribute>) foreignEntityAttributes.get(STR_ATTRIBUTES);
//								flAttributes.add(attr);
//								attr.getAnnotations().add(new Annotation("QUERY"));
//								foreignEntityAttributes.put(STR_ATTRIBUTES, flAttributes);
//								
//							});
//						} else {
//							getLogger().info("UNKNOWN relationship on {}", attribute.getType());
//						}
//					} else {
//						localAttributes.add(attribute);
//					}
//				});
//				value.put(STR_ATTRIBUTES, localAttributes);
//				
//				String fileName = ((EClass)value.get(STR_ENTITY)).getName() + "Schema.xml";
//				Utils.generateTemplate(cfg, value, getOutputDir(), cqlTemplate, fileName);
//				
//				try {
//					FileUtils.copyInputStreamToFile(this.getClass().getResourceAsStream("/templates/solr/solrconfig.xml"), new File(getOutputDir()+File.separator+"solrconfig.xml"));
//					FileUtils.copyInputStreamToFile(this.getClass().getResourceAsStream("/templates/solr/install.sh"), new File(getOutputDir()+File.separator+"install.sh"));
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//		});
	}

	@Override
	protected void setNameAndVersion() {
		setName("EntitySolrSchema");
		setVersion("0.0.1");
	}
}
