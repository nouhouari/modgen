/**
 * 
 */
package com.sicpa.modelgen.cassandra.entity;

import static com.sicpa.modelgen.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.sicpa.modelgen.GenAppConstants;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class TableGenerator extends AbstractGenerator {
	private String cqlTemplate = "cassandra/cassandra_entity.ftl";
	private String packageName;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();

	public TableGenerator(String outputDir, String packageName) {
		super(outputDir);
		this.packageName = packageName;
	}

	@Override
	protected void onEachEntityStart() {
		primaryAttributes = new ArrayList<>();
		clusteringAttributes = new ArrayList<>();
	}

	@Override
	protected void setNameAndVersion() {
		setName("Cassandra Entity");
		setVersion("0.0.2");
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
		input.put(STR_PACKAGE, packageName);
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
//		getEntities().forEach((key, value) -> {
//			
//			//Get Relations
//			value.put("relations", getMetaModels().get(key).getRelations());
//			
//			String fileName = ((EClass) value.get(STR_ENTITY)).getName() + ".java";
//			Utils.generateTemplate(cfg, value,
//					getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), cqlTemplate, fileName);
//		});

	}

}
