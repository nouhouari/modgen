package fr.hin.modelgenerator.generator.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class Utils {

	private static final Logger LOGGER = LoggerFactory.getLogger(Utils.class);

	public static void checkDirectoryOrCreate(String directoryPath) {
		File directory = new File(directoryPath);
		if (!directory.exists()) {
			directory.mkdirs();
			LOGGER.info("\t\tCreating directory : {}", directory);
		}
	}

	public static boolean copyFile(String source, String dest) {
		File fileSource = new File(source);
		File fileDest = new File(dest);

		return copyFile(fileSource, fileDest);
	}

	public static boolean copyFile(File source, File dest) {
		try {
			// Declaration et ouverture des flux
			java.io.FileInputStream sourceFile = new java.io.FileInputStream(source);

			try {
				java.io.FileOutputStream destinationFile = null;

				try {
					destinationFile = new FileOutputStream(dest);

					// Lecture par segment de 0.5Mo
					byte buffer[] = new byte[512 * 1024];
					int nbLecture;

					while ((nbLecture = sourceFile.read(buffer)) != -1) {
						destinationFile.write(buffer, 0, nbLecture);
					}
				} finally {
					destinationFile.close();
				}
			} finally {
				sourceFile.close();
			}
		} catch (IOException e) {
			LOGGER.error("IOException", e);
			return false; // Erreur
		}

		return true;
	}

	// public static void generateTemplateWithConfirmation(Configuration cfg,
	// Map<String,
	// Object> model, String outputDir, String templateName, String fileName) {
	//
	// if(Configuration.confirmationEnable) {
	// Confirmation confirm = new Confirmation();
	//
	// if(confirm.isFileExists(outputDir+fileName)){
	// if(Configuration.overwriteAll){
	// Utils.generateTemplate(cfg, model, outputDir, templateName, fileName);
	// }
	// else
	// {
	// Response response = confirm.readInput(fileName);
	// if(response == Response.YES){
	// Utils.generateTemplate(cfg, model, outputDir, templateName, fileName);
	// }else if(response == Response.ALL){
	// Utils.generateTemplate(cfg, model, outputDir, templateName, fileName);
	// Configuration.overwriteAll = true;
	// }
	// }
	//
	// }else{
	// Utils.generateTemplate(cfg, model, outputDir, templateName, fileName);
	// }
	// }
	// else {
	// if(Configuration.overwriteAll) {
	// Utils.generateTemplate(cfg, model, outputDir, templateName, fileName);
	// }
	// }
	// }

	public static void generateTemplate(Configuration cfg, Map<String, Object> model, String outputDir,
			String templateName, String fileName) {

		try {
			Writer outputWriter = null;
			Template template = cfg.getTemplate(templateName);
			File file = new File(outputDir + "/" + fileName);
			outputWriter = new FileWriter(file);
			template.process(model, outputWriter);
			outputWriter.flush();

			LOGGER.info("\t\tGenerating file : {}", file.getAbsolutePath());
		} catch (IOException e) {
			LOGGER.error("IOException", e);
		} catch (TemplateException e) {
			LOGGER.error("TemplateException", e);
		}
	}

	// public static List<Method> addMethods(EClass eclass,List<Method> methods)
	// {
	// List<EOperation> eAllOperations = eclass.getEOperations();
	// for (EOperation operation : eAllOperations) {
	// methods.add(new Method(operation.getName()));
	// }
	// return methods;
	// }

	// public static void addSupperMethods(List<Method> methods,
	// List<String> eSuperTypes, HashMap<String, EClassifier> eclasses) {
	//
	// for (String string : eSuperTypes) {
	// String type = string.replace("#//", "");
	// EClassifier superClass = eclasses.get(type);
	//// System.out.println("super : " +type +" -> "+ superClass);
	// if(superClass instanceof EClass){
	// EClass eclass = (EClass) superClass;
	// List<EOperation> eAllOperations = eclass.getEOperations();
	// for (EOperation operation : eAllOperations) {
	// methods.add(new Method(operation.getName()));
	// }
	// addSupperMethods(methods, eclass.getESuperTypes(), eclasses);
	// }
	// }
	// }
	//
	// public static List<Attribute> createListAttributes(EClass eclass,
	// HashMap<String, EClassifier> eclasses){
	//
	// List<Attribute> attributes = new ArrayList<Attribute>();
	//
	// List<EStructuralFeature> eStructuralFeatures =
	// eclass.getEStructuralFeatures();
	// for (EStructuralFeature eStructuralFeature : eStructuralFeatures) {
	// eStructuralFeature.getName();
	// boolean changeable = false;
	// if(eStructuralFeature.getChangeable() != null){
	// changeable = Boolean.parseBoolean(eStructuralFeature.getChangeable());
	// }
	//
	// String eType = eStructuralFeature.getEType();
	// System.out.println("\t-" + eStructuralFeature.getName() + " type:" +
	// eType);
	// if(eType == null){
	// System.err.println("Bad parameter type : " +
	// eStructuralFeature.getName());
	// }else{
	//
	// String eTypeStr = convertToJavaType(eType);
	//
	// Attribute newAttribute = new
	// Attribute(eStructuralFeature.getName(),changeable,eTypeStr, false, 1, 1);
	// attributes.add(newAttribute);
	//
	//
	//// if(eType.contains("EInt")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"int", false, 1));
	//// }else if(eType.contains("ELong")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"long", false, 1));
	//// }else if(eType.contains("EDouble")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"double", false, 1));
	//// }else if(eType.contains("EByte")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"byte", false, 1));
	//// }else if(eType.contains("EShort")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"short", false, 1));
	//// }else if(eType.contains("EFloat")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"float", false, 1));
	//// } else if(eType.contains("EBoolean")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"boolean", false, 1));
	//// }else if(eType.contains("EString")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"String", false, 1));
	//// }else if(eType.contains("EDate")){
	//// attributes.add(new
	// Attribute(eStructuralFeature.getName(),changeable,"Date", false, 1));
	//// }else{
	//
	//
	// if(eTypeStr.equals("unknown")) {
	// String type = eStructuralFeature.getEType().replace("#//", "");
	// EClassifier eClassifier = eclasses.get(type);
	// newAttribute = new
	// Attribute(eStructuralFeature.getName(),changeable,type, false, 1, 1);
	//
	// if(eClassifier instanceof EEnum){
	// newAttribute.setEnumerate(true);
	// EEnum eenum = (EEnum) eClassifier;
	// List<EEnumLiteral> eLiterals = eenum.getELiterals();
	// for (EEnumLiteral eEnumLiteral : eLiterals) {
	// newAttribute.getLitterals().add(eEnumLiteral.getName());
	// }
	// }
	// }
	//
	// //Check for enum
	// EClassifier classifier = null;
	// if((classifier=eclasses.get(eTypeStr)) != null && classifier instanceof
	// EEnum){
	// newAttribute.setEnumerate(true);
	// }
	// }
	// }
	// return attributes;
	// }
	//
	//
	// public static List<Attribute> createListAttributesWithMultiplicity(EClass
	// entity, List<String> enums){
	// ArrayList<Attribute> attributes = new ArrayList<>();
	// List<EStructuralFeature> features = entity.getEStructuralFeatures();
	// for (EStructuralFeature feature : features) {
	// if(feature.getEType() == null){
	// System.err.println(feature.getName()+" is null for type " +
	// entity.getName());
	// continue;
	// }
	// int multiplicity = 1;
	// if(feature instanceof EReference){
	// EReference reference = (EReference) feature;
	// String upperBound = reference.getUpperBound();
	// if(upperBound != null){
	// if("*".equalsIgnoreCase(upperBound)){
	// multiplicity = -1;
	// }else{
	// try {
	// multiplicity = Integer.parseInt(upperBound);
	// } catch (Exception e) {
	// System.err.println("Error in reference multiplicity : " +
	// reference.getName() + " for class " + entity.getName());
	// }
	// }
	// }
	// }
	// Attribute attribute = new Attribute(feature.getName(), true,
	// Utils.convertToJavaType(feature.getEType()),feature instanceof
	// EReference, multiplicity, 1);
	// if(enums.contains(feature.getEType())){
	// attribute.setEnumerate(true);
	// }
	// attributes.add(attribute);
	// }
	//
	// return attributes;
	// }
	//
	public static String convertToJavaType(String eType) {
		String result = "unknown";
		if (eType.contains("EInt")) {
			result = "int";
		} else if (eType.contains("ELong")) {
			result = "long";
		} else if (eType.contains("EDouble")) {
			result = "double";
		} else if (eType.contains("EByte")) {
			result = "byte";
		} else if (eType.contains("EShort")) {
			result = "short";
		} else if (eType.contains("EFloat")) {
			result = "float";
		} else if (eType.contains("EBoolean")) {
			result = "boolean";
		} else if (eType.contains("EString")) {
			result = "String";
		} else if (eType.contains("EDate")) {
			result = "Date";
		} else {
			result = eType.replace("#//", "");
		}
		return result;
	}

	public static String convertToJavaObjectType(String eType) {
		String result = "unknown";
		if (eType.contains("EInt")) {
			result = "Integer";
		} else if (eType.contains("ELong")) {
			result = "Long";
		} else if (eType.contains("EDouble")) {
			result = "Double";
		} else if (eType.contains("EByte")) {
			result = "Byte";
		} else if (eType.contains("EShort")) {
			result = "Short";
		} else if (eType.contains("EFloat")) {
			result = "Float";
		} else if (eType.contains("EBoolean")) {
			result = "Boolean";
		} else if (eType.contains("EString")) {
			result = "String";
		} else if (eType.contains("EDate")) {
			result = "Date";
		} else {
			result = eType.replace("#//", "");
		}
		return result;
	}
}
