package fr.hin.modgen.core;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;

import fr.hin.modelgenerator.ecore.EAttribute;
import fr.hin.modelgenerator.ecore.EClass;
import fr.hin.modelgenerator.ecore.EClassifier;
import fr.hin.modelgenerator.ecore.EPackage;
import fr.hin.modelgenerator.ecore.EStructuralFeature;
import fr.hin.modelgenerator.generator.AbstractGeneratorEngine;

public class ReadEcoreTest {

	
	
	@Test
	public void test() {
		//fail("Not yet implemented");
		EPackage ecoreModel = AbstractGeneratorEngine.readECoreModel("src/test/resources/test.ecore");
		assertNotNull(ecoreModel);
		
		List<EClassifier> eClassifiers = ecoreModel.getEClassifiers();
		assertEquals(1, eClassifiers.size());
		
		EClassifier eClass = eClassifiers.get(0);
		assertEquals(EClass.class, eClass.getClass());
		
		// Test class name
		assertEquals("Activation", eClass.getName());
		
		// Test Attributes
		EClass eClassImpl = (EClass)eClass;
		List<EStructuralFeature> attributes = eClassImpl.getEStructuralFeatures();
		assertEquals(2,attributes.size());
		
		EAttribute idAttribute = (EAttribute)attributes.get(0);
		assertEquals("id", idAttribute.getName());
		
		assertEquals(2, idAttribute.getEAnnotations().size());
	}

}
