/**
 * 
 */
package fr.hin.modelgenerator.generator;

import static fr.hin.modelgenerator.GeneratorConstants.STR_ENTITY;
import static fr.hin.modelgenerator.GeneratorConstants.STR_GENERATOR;
import static fr.hin.modelgenerator.GeneratorConstants.STR_VERSION;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EClassifier;
import fr.hin.modelgenerator.ecore.EEnum;
import fr.hin.modelgenerator.ecore.EEnumLiteral;
import fr.hin.modelgenerator.ecore.EPackage;
import fr.hin.modelgenerator.ecore.EReference;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Annotation;
import fr.hin.modelgenerator.model.Attribute;
import fr.hin.modelgenerator.model.ClassifierType;
import fr.hin.modelgenerator.model.ObjectMetaModel;
import fr.hin.modelgenerator.model.ObjectRelationModel;
import freemarker.template.Configuration;
import freemarker.template.TemplateException;

/**
 * @author nourredine
 *
 */
public abstract class AbstractGenerator implements IGenerator {

	private static final Logger LOGGER = LoggerFactory.getLogger(AbstractGenerator.class);

	private String name;
	private String version;
	protected Configuration cfg;
	protected String template;
	private String outputDir;
	//private Map<String, Map<String, Object>> entities = new HashMap<String, Map<String, Object>>();
	private Map<String, ObjectMetaModel> metaModels = new HashMap<>();

	public AbstractGenerator(String outputDir) {
		this.outputDir = outputDir;
		setNameAndVersion();
		init();
	}

	public void setTemplateRootPath(String path) {
		this.template = path;
	}

	public void init() {
		cfg = new Configuration(Configuration.VERSION_2_3_0);
		cfg.setClassForTemplateLoading(this.getClass(), "/templates/");
	}

	protected abstract void setNameAndVersion();

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the version
	 */
	public String getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(String version) {
		this.version = version;
	}

	/**
	 * @return the cfg
	 */
	public Configuration getCfg() {
		return cfg;
	}

	/**
	 * @param cfg
	 *            the cfg to set
	 */
	public void setCfg(Configuration cfg) {
		this.cfg = cfg;
	}

	/**
	 * 
	 * @param packache
	 * @param configuration
	 */
	public void generateModel(EPackage packache, Settings settings) {
		LOGGER.info("\tStarting {} generator {}", getName(), getVersion());

		Utils.checkDirectoryOrCreate(outputDir);
		onCreateDirectories();

		List<EClassifier> eClassifiers = packache.getEClassifiers();

		Map<String, Object> input = new HashMap<String, Object>();
		input.put(STR_GENERATOR, getName());
		input.put(STR_VERSION, getVersion());
		// Add child inputs
		addInputs(input);

		for (EClassifier eClassifier : eClassifiers) {
			onEachEntityStart();

			try {
				if (eClassifier instanceof EClass) {
					parseClass(input, eClassifier);
				} else if (eClassifier instanceof EEnum) {
					parseEnum(input, eClassifier);
				}
			} catch (IOException | TemplateException e) {
				LOGGER.error("Exception", e);
			}
		}

		// Build relation between reference and type.
		buildRelations();

		generateFiles(input);

		LOGGER.info("\t{} generation finished.", getName());
	}

	/**
	 * Build the objects tree and link attributes with their MetaModel.
	 */
	private void buildRelations() {
		// Loop on all objects and attributes
		for (ObjectMetaModel model : metaModels.values()) {
			for (Attribute attribute : model.getAttributes()) {
				//Test if attribute is reference
				if (attribute.isReference()) {
					String type = attribute.getType();
					ObjectMetaModel relation = metaModels.get(type);
					
					if (attribute.getMultiplicity() == 1 || attribute.getMultiplicity() == -1) {
						
						ObjectRelationModel relationModel = new ObjectRelationModel();
						relationModel.setRelationName(attribute.getName());
						relationModel.setModel(model);
						relationModel.setContainment(attribute.isContainment());
						relationModel.setMultiplicity(attribute.getMultiplicity());
						relationModel.setOppositeMultiplicity(attribute.getOppositeMultiplicity());
						
						relation.getRelations().add(relationModel);
					}

					attribute.setModel(metaModels.get(type));
				} else if (attribute.hasAnnotation("PK")) {
					model.setPrimaryAttribute(attribute);
				}
				
				ObjectMetaModel objectMetaModel = metaModels.get(attribute.getType());
				if(objectMetaModel != null){
					boolean enumerate = objectMetaModel.getType() == ClassifierType.ENUM;
					attribute.setEnumerate(enumerate);
					if(enumerate){
						objectMetaModel.getAttributes().forEach((a)->attribute.getLitterals().add(a.getName()));
					}
				}
			}
		}
	}

	/**
	 * Triggered when
	 */
	protected abstract void onEachEntityStart();

	protected abstract void onCreateDirectories();

	/**
	 * Parse enum classifier and add it to the list of classifiers.
	 * @param input
	 * @param eClassifier
	 * @throws IOException
	 * @throws TemplateException
	 */
	private void parseEnum(Map<String, Object> input, EClassifier eClassifier)
			throws IOException, TemplateException {

		EEnum eenum = (EEnum) eClassifier;
		
		ObjectMetaModel enumerated = new ObjectMetaModel();
		enumerated.setName(eenum.getName());
		enumerated.setType(ClassifierType.ENUM);
		
		// create list of enum values
		List<Attribute> attributes = new ArrayList<Attribute>();
		List<EEnumLiteral> eLiterals = eenum.getELiterals();
		for (EEnumLiteral eEnumLiteral : eLiterals) {
			Attribute e = new Attribute(eEnumLiteral.getName(), false, null, false, 1, 1);
			attributes.add(e);
			enumerated.getAttributes().add(e);
			onEnumAttributeAdded(e);
		}
		
		//Add the enumerated to the list of classifiers
		if(!metaModels.containsKey(enumerated.getName())){
			metaModels.put(enumerated.getName(), enumerated);
		}
		//input.put(STR_ENTITY, enumerated);
		//entities.put(enumerated.getName(), input);
	}

	private void parseClass(Map<String, Object> input, EClassifier eClassifier)
			throws IOException, TemplateException {

		EClass entity = (EClass) eClassifier;

		//Create meta model for this class
		ObjectMetaModel metaModel = new ObjectMetaModel();
		metaModel.setName(entity.getName());
		metaModel.setType(ClassifierType.CLASS);
		
		input.put(STR_ENTITY, metaModel);
		
		// Add Object annotation
		entity.getEAnnotations().forEach(a -> {
		  Annotation annotation = new Annotation(a.getSource());
		  // Add annoation details
		  a.getDetails().forEach(det -> {
        annotation.getDetails().put(det.getKey(), det.getValue());
      });
      metaModel.getAnnotations().add(annotation);
		}
    );
		
		ArrayList<Attribute> attributes = new ArrayList<Attribute>();

		List<EStructuralFeature> features = entity.getEStructuralFeatures();
		for (EStructuralFeature feature : features) {
			if (feature.getEType() == null) {
				LOGGER.error("{} is null for type {}", feature.getName(), entity.getName());
				continue;
			}
			int multiplicity = 1;
			boolean containment = false;
			if (feature instanceof EReference) {
				EReference reference = (EReference) feature;
				String upperBound = reference.getUpperBound();
				if (upperBound != null) {
					if ("*".equalsIgnoreCase(upperBound)) {
						multiplicity = -1;
					} else {
						try {
							multiplicity = Integer.parseInt(upperBound);
						} catch (NumberFormatException e) {
							LOGGER.error("Error in reference multiplicity : {} for class {}", reference.getName(),
									eClassifier.getName());
						}
					}
				}
				containment = Boolean.valueOf(reference.getContainment());
			}

			int oppositeMultiplicity = 1;
			if ("1".equals(feature.getLowerBound()) && "-1".equals(feature.getUpperBound())) {
				oppositeMultiplicity = 1;
			} else if("-1".equals(feature.getUpperBound())){
			 oppositeMultiplicity = -1;
			}
			
			Attribute attribute = new Attribute(
					feature.getName(), 
					true, 
					Utils.convertToJavaType(feature.getEType()),
					feature instanceof EReference, 
					multiplicity, 
					oppositeMultiplicity);
			
			attribute.setContainment(containment);
			
			feature.getEAnnotations().forEach(e -> {
				String annotationString = e.getSource();
				// Check if can add the annotation
				if(this.canAddAttributeAnnotation(annotationString)) {
				  Annotation annotation = new Annotation(annotationString);
				  e.getDetails().forEach(det -> {
				    annotation.getDetails().put(det.getKey(), det.getValue());
				  });
				  
				  attribute.getAnnotations().add(annotation);				  
				}
			});
			onAttributeAdded(attributes, feature, attribute);
		}

		metaModel.getAttributes().addAll(attributes);
		
		if(!metaModels.containsKey(metaModel.getName())){
			metaModels.put(metaModel.getName(), metaModel);
		}
	}

	/**
	 * Check if the annotation on a attribute can be added.
	 * @param annotation annotation string value.
	 * @return true by default
	 */
  protected boolean canAddAttributeAnnotation(String annotation) {
    return true;
  }

	/**
	 * Generate all the files using the input String,Object map.
	 * @param input
	 */
  protected abstract void generateFiles(Map<String, Object> input);

  /**
   * Trigger on new attribute added.
   * @param input
   */
	protected abstract void onAttributesAdded(Map<String, Object> input);

	/**
	 * Add inputs to Template hashmap model.
	 * 
	 * @param input
	 */
	protected abstract void addInputs(Map<String, Object> input);

	/**
	 * Called on each enum attribute.
	 * 
	 * @param e
	 */
	protected abstract void onEnumAttributeAdded(Attribute e);

	/**
	 * Called on each attribute added.
	 * 
	 * @param attributes
	 * @param feature
	 * @param attribute
	 */
	protected abstract void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature,
			Attribute attribute);

	/**
	 * @return the outputDir
	 */
	public String getOutputDir() {
		return outputDir;
	}

	/**
	 * @param outputDir
	 *            the outputDir to set
	 */
	public void setOutputDir(String outputDir) {
		this.outputDir = outputDir;
	}

	/**
	 * 
	 * @return
	 */
	protected Map<String, ObjectMetaModel> getMetaModels() {
		return metaModels;
	}

	/**
	 * 
	 * @return
	 */
	protected static Logger getLogger() {
		return LOGGER;
	}
}
