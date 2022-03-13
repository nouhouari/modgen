/**
 * 
 */
package com.hin.modelgen.generators.cassandra.cql;

import static com.hin.modelgen.generators.GenAppConstants.STR_CLUSTERING_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_PRIMARY_ATTRIBUTES;
import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;

/**
 * @author nourreddine
 *
 */
public class CQLGenerator extends AbstractGenerator {

	private String cqlTemplate = "cassandra/cassandra_cql.ftl";
	private String keyspace;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();

	public CQLGenerator(String outputDir, String keyspace) {
		super(outputDir);
		this.keyspace = keyspace;
	}

	@Override
	protected void onEachEntityStart() {
		this.primaryAttributes = new ArrayList<>();
		this.clusteringAttributes = new ArrayList<>();
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		input.put(STR_TODAY, new Date().toString());
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

		if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("PK"))) {
			primaryAttributes.add(attribute);
		} else if (feature.getEAnnotations().stream().anyMatch(a -> a.getSource().equalsIgnoreCase("CC"))) {
			clusteringAttributes.add(attribute);
		}
		attributes.add(attribute);

	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		input.put(STR_PRIMARY_ATTRIBUTES, this.primaryAttributes);
		input.put(STR_CLUSTERING_ATTRIBUTES, this.clusteringAttributes);
		
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		
		input.put("keyspace", this.keyspace);
		
		getMetaModels().values().forEach( m -> {
			if(m.getType() == ClassifierType.CLASS){
				input.put(STR_ENTITY, m);
				String fileName = m.getName() + ".cql";
				Utils.generateTemplate(cfg, input, getOutputDir(), cqlTemplate, fileName);
			}
		});
	}

	@Override
	protected void setNameAndVersion() {
		setName("Cassandra CQL");
		setVersion("0.0.3");
	}

}
