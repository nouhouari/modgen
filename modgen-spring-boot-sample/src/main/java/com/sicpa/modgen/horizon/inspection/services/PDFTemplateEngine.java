package com.sicpa.modgen.horizon.inspection.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.lowagie.text.DocumentException;

@Service
public class PDFTemplateEngine {

	private static final String PDF_RESOURCES = "templates/";
	
	@Autowired
	private TemplateEngine templateEngine;
	
	/**
	 * Generate PDF file using the template name and the contextual data.
	 * @param templateName
	 * @param context
	 * @return PDF file
	 * @throws IOException
	 * @throws DocumentException
	 */
	public File generatePdf(String templateName, Context context) throws IOException, DocumentException {
        String html = loadAndFillTemplate(templateName,context);
        return renderPdf(html);
    }

	/**
	 * Merge the template and the contextual and produces an output string
	 * @param templateName Template name
	 * @param context Contextual data.
	 * @return Merged string
	 */
    public String loadAndFillTemplate(String templateName, Context context) {
        return templateEngine.process(templateName, context);
    }

    /**
     * Render HTML into a PDF file.
     * @param html HTML input
     * @return PDF file
     * @throws IOException
     * @throws DocumentException
     */
    private File renderPdf(String html) throws IOException, DocumentException {
    	File file = File.createTempFile("report", ".pdf");
    	OutputStream outputStream = new FileOutputStream(file);
    	ITextRenderer renderer = new ITextRenderer(20f * 4f / 3f, 20);
    	renderer.setDocumentFromString(html, new ClassPathResource(PDF_RESOURCES).getURL().toExternalForm());
    	renderer.layout();
    	renderer.createPDF(outputStream);
    	outputStream.close();
    	file.deleteOnExit();
    	return file;
    }
}
