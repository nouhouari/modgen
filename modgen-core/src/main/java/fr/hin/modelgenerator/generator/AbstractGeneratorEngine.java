package fr.hin.modelgenerator.generator;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.hin.modelgenerator.ecore.EPackage;

public abstract class AbstractGeneratorEngine {

	private static final Logger LOGGER = LoggerFactory.getLogger(AbstractGeneratorEngine.class);

	/**
	 * Unmarshall the Ecore model into a java object. <br>
	 * Call generatePackage() methods with deserialized model.
	 */
	public void start(String modelPath) {

		EPackage ePackage = readECoreModel(modelPath);
		generatePackage(ePackage);
	}

	/**
	 * Read ecore model from XML file.
	 * 
	 * @param modelPath
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static EPackage readECoreModel(String modelPath) {
		// Check if file exists
		File f = new File(modelPath);
		if (!f.exists()) {
			LOGGER.error("Model [" + modelPath + "] not found !");
			return null;
		} else {
			LOGGER.info("Using model : " + modelPath);
		}

		JAXBContext context = null;
		try {
			context = JAXBContext.newInstance("fr.hin.modelgenerator.ecore");
		} catch (JAXBException e2) {
			e2.printStackTrace();
		}
		
		// LOGGER.info("Context " + context);
		
		Unmarshaller unmarshaller = null;
		try {
			unmarshaller = context.createUnmarshaller();
		} catch (JAXBException e1) {
			e1.printStackTrace();
		}

		JAXBElement<fr.hin.modelgenerator.ecore.EPackage> unmarshal = null;
		try {
			unmarshal = (JAXBElement<EPackage>) unmarshaller.unmarshal(new FileInputStream(new File(modelPath)));
			return unmarshal.getValue();
		} catch (JAXBException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		// XStream
//
////		EPackage ePackage = unmarshal.getValue();
//		XStream xs = new XStream();
//		
//		xs.alias("ecore:EPackage", EPackage.class);
////		xs.alias("eClassifiers", EClass.class);
////		xs.aliasType("eClassifiers", EClassifier.class);
//		//xs.alias("eStructuralFeatures", EAttribute.class);
//		//xs.addImplicitCollection(EPackage.class, "eClassifiers");
////		xs.addImplicitCollection(EClass.class, "eAnnotations");
//		
////		xs.addImplicitCollection(EClassifier.class, "eStructuralFeatures");
//		//xs.addImplicitCollection(EStructuralFeature.class, "eAnnotations");
//		
//		try {
//			EPackage epackage = (EPackage) xs.fromXML(new FileInputStream(new File(modelPath)));
//			return epackage;
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		}
		
		// Jackson
		
//		try {
//			JacksonXmlModule module = new JacksonXmlModule();
//			module.setDefaultUseWrapper(false);
//			XmlMapper xmlMapper = new XmlMapper(module);
//			
//			AnnotationIntrospector introspector = new JacksonXmlAnnotationIntrospector();
//			// if ONLY using JAXB annotations:
//			xmlMapper.setAnnotationIntrospector(introspector);
//			xmlMapper.registerModule(new JaxbAnnotationModule());
//			
//			// if using BOTH JAXB annotations AND Jackson annotations:
//			//xmlMapper.setAnnotationIntrospector(new AnnotationIntrospector.Pair(introspector, secondary);
//			
////			mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
////			mapper.setPropertyNamingStrategy(PropertyNamingStrategy.LOWER_CAMEL_CASE);
//			xmlMapper.configure(MapperFeature.ACCEPT_CASE_INSENSITIVE_PROPERTIES, true);
//			xmlMapper.enableDefaultTyping();
//
//			EPackage epackage = xmlMapper.readValue(new File(modelPath), EPackage.class);
//			return epackage;
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

		

		return null;
	}

	/**
	 * 
	 * @param ePackage
	 */
	public abstract void generatePackage(EPackage ePackage);
}
