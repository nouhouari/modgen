/**
 * 
 */
package com.hin.modelgen.generators.jpa.entity;

import static com.hin.modelgen.generators.GenAppConstants.STR_TODAY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_PACKAGE;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
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
public class JPAEnumGenerator extends AbstractGenerator {

	private String jpaEntityTemplate = "jpa/entity/jpa_enum.ftl";
	private String packageName;
	private ArrayList<Attribute> primaryAttributes = new ArrayList<>();
	private ArrayList<Attribute> clusteringAttributes = new ArrayList<>();

	public JPAEnumGenerator(String outputDir, String packageName) {
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
		setName("JPA Enum");
		setVersion("0.0.1");
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
		
		getMetaModels().values().forEach(m->{
			if(m.getType() == ClassifierType.ENUM){
				input.put(STR_ENTITY, m);
				String fileName = m.getName() + ".java";
				Utils.generateTemplate(cfg, input,
						getOutputDir() + File.separatorChar + packageName.replaceAll("\\.", "\\/"), jpaEntityTemplate, fileName);
			}
		});
	}

}
