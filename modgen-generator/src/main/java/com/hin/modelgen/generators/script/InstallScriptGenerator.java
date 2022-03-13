/**
 * 
 */
package com.hin.modelgen.generators.script;

import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_UDT;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;

/**
 * @author nourreddine
 *
 */
public class InstallScriptGenerator extends AbstractGenerator {

	private String cqlTemplate = "scripts/scripts.ftl";
	private String keyspace;
	private String solrServerAddress;
	private String cassandraServerAddress;

	public InstallScriptGenerator(String outputDir, String cassandraServerAddress, String solrServerAddress, String keyspace) {
		super(outputDir);
		this.cassandraServerAddress = cassandraServerAddress;
		this.keyspace = keyspace;
		this.solrServerAddress = solrServerAddress;
	}

	@Override
	protected void onEachEntityStart() {}

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
		//NOTHING
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		//NOTHING
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		//NOTHING
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {

//		HashMap<String, Object> values = new HashMap<>();
//		values.put(STR_TODAY, new Date().toString());
//		values.put("generator", getName());
//		values.put("version", getVersion());
//		values.put("keyspace", this.keyspace);
//		values.put("solrServerAddress", this.solrServerAddress);
//		values.put("cassandraServerAddress", this.cassandraServerAddress);
//
//		List<String> udts = new ArrayList<>();
//		values.put("udts", udts);
//		List<String> entitiesName = new ArrayList<>();
//		values.put("entities", entitiesName);
//		
//		getEntities().forEach((key, value) -> {
//			Boolean isUDT = (Boolean)value.get(STR_UDT);
//			if(isUDT){
//				udts.add(((EClass)value.get(STR_ENTITY)).getName());
//			}else{
//				entitiesName.add(((EClass)value.get(STR_ENTITY)).getName());
//			}
//		});
//		
//		String fileName = "installGeneration.sh";
//		Utils.generateTemplate(cfg, values, getOutputDir(), cqlTemplate, fileName);
	}

	@Override
	protected void setNameAndVersion() {
		setName("InstallScriptGenerator");
		setVersion("0.0.1");
	}
}
