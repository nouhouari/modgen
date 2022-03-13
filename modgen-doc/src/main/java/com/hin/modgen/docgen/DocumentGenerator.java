package com.hin.modgen.docgen;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGenerator;
import fr.hin.modelgenerator.generator.utils.Utils;
import fr.hin.modelgenerator.model.Attribute;
import fr.opensagres.xdocreport.core.XDocReportException;
import fr.opensagres.xdocreport.document.IXDocReport;
import fr.opensagres.xdocreport.document.registry.XDocReportRegistry;
import fr.opensagres.xdocreport.template.IContext;
import fr.opensagres.xdocreport.template.TemplateEngineKind;

/**
 * This class generate a ODT/Word document from the model.
 * @author nourreddine
 *
 */
public class DocumentGenerator extends AbstractGenerator {

	private static Logger LOGGER = LoggerFactory.getLogger(DocumentGenerator.class);
	
	public DocumentGenerator(String outputDir) {
		super(outputDir);
	}

	/*
	 * (non-Javadoc)
	 * @see fr.hin.modelgenerator.generator.IGenerator#getName()
	 */
	public String getName() {
		return "Document Generator";
	}

	/*
	 * (non-Javadoc)
	 * @see fr.hin.modelgenerator.generator.IGenerator#getVersion()
	 */
	public String getVersion() {
		return "0.1";
	}

	@Override
	protected void setNameAndVersion() {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void onEachEntityStart() {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void onCreateDirectories() {
		Utils.checkDirectoryOrCreate(getOutputDir());
	}

	@Override
	protected void onAttributesAdded(Map<String, Object> input) {
		
	}

	@Override
	protected void addInputs(Map<String, Object> input) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void onEnumAttributeAdded(Attribute e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	protected void onAttributeAdded(ArrayList<Attribute> attributes, EStructuralFeature feature, Attribute attribute) {
		attributes.add(attribute);
	}

	@Override
	protected void generateFiles(Map<String, Object> input) {
		try {
			FileInputStream is = new FileInputStream("src/main/resources/PackageTemplate.odt");
			IXDocReport report = XDocReportRegistry.getRegistry().loadReport(is, TemplateEngineKind.Freemarker);
			
			IContext context = report.createContext();
			context.put("version", "1.0");
			context.put("package", "Nourreddine");
			context.put("purpose", "purpose");
			context.put("entities",getMetaModels().values().toArray());
			
			report.createFieldsMetadata();
			//metadata.load( "entities", ObjectMetaModel.class, true );
			
			FileOutputStream fos = new FileOutputStream(getOutputDir() + File.separatorChar + "Result.odt");
			report.process(context, fos);
			if(LOGGER.isInfoEnabled()){
				LOGGER.info(getOutputDir() + File.separatorChar + "Result.odt generated.");
			}
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (XDocReportException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	

}
