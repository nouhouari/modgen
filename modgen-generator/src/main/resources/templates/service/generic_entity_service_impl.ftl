<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	GenericEntityServiceImpl.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
package ${package};

import java.util.Properties;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

import javax.annotation.Resource;
import javax.validation.Validator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.data.jpa.repository.JpaRepository;

//import com.sicpa.gssd.metis.support.validation.ValidationUtil;
//import com.sicpa.gssd.metis.support.CommonsUtil;
import ${package}.GenericEntityService;
import ${transformerPackage}.GenericEntityDTOTransformer;

/**
 * THIS FILE IS AUTOMATICALLY GENERATED
 *     >> DO NOT EDIT MANUALLY <<
 * <br><br>
 * Generated by : ${generator}<br>
 * Version      : ${version}<br>
 * Date         : ${aDate?string.medium}<br>
 * <br>
 * Base class to provide hooks for generic CRUD operations.
 * <p>
 * This abstract class lookup the spring context for Entity & DTO transformer spring bean 
 * based on the supplied bean name.<br>
 * <br>
 * A default implementation is loaded unless otherwise a service name supplied via properties file.<br>
 * bean property key name must follow <code>entityname.transformer</code><br>
 * Every implementation of this class must implement {@link #getDefaultTransformerBeanName()} to supply the default transformer service name.<br>
 * </p> 
 *
 * @param <DTO>
 * @param <T>
 * 
 * @author Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 * @author Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com>
 * 
 */
public abstract class GenericEntityServiceImpl<DTO, T> 
		implements GenericEntityService<DTO, T>, ApplicationListener<ContextRefreshedEvent> { 
	
	@Resource
	private ApplicationContext applicationContext;

	@Resource
	private Properties appProps;
	
	private AtomicBoolean serviceFlag = new AtomicBoolean();	
	private String managedTransformerServiceName;
	private GenericEntityDTOTransformer transformerService;
	
	/**
	 * {@inhertiDoc}
	 */
	 @Override
	 public Map<String, String> create(DTO dto){
	 	
	 	onBeforeDTOValidation(dto);
	 	
	 	//Map<String, String> errors = ValidationUtil.validateDTO(dto, validator);
	 	
	 	//if(!CommonsUtil.isEmpty(errors)) {
	 	//	return errors;
	 	//}
	 	 
		onBeforeDTOTransformation(dto);
		T entity = getNewEntityInstance();		
		getEntityConvertedFromDTO(dto, entity);
		
		onBeforeSave(dto, entity);
		
		getRepository().save(entity);
		
		onSave(dto, entity);
		
		return null;
	}
	
	/**
	 * {@inhertiDoc}
	 */
	@Override
	public long count(){
		return getRepository().count();
	}
	
	/**
	 * {@inheritDoc}
	 */
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (!serviceFlag.get()) {

			if (appProps.containsKey(getTransformerBeanPropertyKey())) {
				managedTransformerServiceName = appProps.getProperty(getTransformerBeanPropertyKey());
			} else {
				managedTransformerServiceName = getDefaultTransformerBeanName();
			}

			transformerService = event.getApplicationContext().getBean(managedTransformerServiceName, GenericEntityDTOTransformer.class);
			serviceFlag.set(true);
		}
	}
	
	/**
	 * @return transformer service managed via context lookup.
	 */
	public GenericEntityDTOTransformer<DTO, T> getTransformerService() {
		return transformerService;
	}
	
	/**
	 * Returns the actual repository at runtime
	 */
	protected abstract JpaRepository getRepository();
	
	/**
	 * converts Entity from DTO;
	 * 
	 * @param dto
	 * @param entity
	 */
	protected abstract void getEntityConvertedFromDTO(DTO dto, T entity);
	
	/**
	 * converts DTO from Entity;
	 * 
	 * @param entity
	 * @param dto
	 */
	protected abstract void getDTOConvertedFromEntity(T entity, DTO dto);
	
	/**
	 * to return the class type of the entity class 
	 */
	protected abstract T getNewEntityInstance();
	
	/**
	 * to return the trasnformer bean name
	 */
	protected abstract String getDefaultTransformerBeanName();
	
	/**
	 * to return the entity name
	 */
	protected abstract String getEntityName();
	
	/**
	 * This will be invoked before the DTO validaitons by the {#link create(DTO dto)} method. <br>
	 * Override this method if needed to perform any custom validation (e.g. custom validations and etc).
	 * Any custome validation need to be atatched to the thread local error context.
	 * 
	 * @param dto 
	 * @see com.sicpa.gssd.metis.support.threadlocals.ThreadLocalErrorContext
	 * @see com.sicpa.gssd.metis.support.validation.ValidaitonUtil
	 */
	protected void onBeforeDTOValidation(DTO dto) {
	}
	
	/**
	 * This will be invoked before the DTO transformation to entity by the {#link create(DTO dto)} method. <br>
	 * Override this method if needed to perform any custom logics (e.g. custom validations and etc).
	 * 
	 * @param dto 
	 */
	protected void onBeforeDTOTransformation(DTO dto) {
	}
	
	/**
	 * This will be invoked before the DTO transformation to entity by the {#link create(DTO dto)} method.
	 * Override this method if needed to perform any custom logics (e.g. workflow triggers and etc).
	 * 
	 * @param dto
	 * @param entity 
	 */
	protected void onBeforeSave(DTO dto, T entity) {
	}
	
	/**
	 * This will be invoked after the entity has been persisted to datastore by the {#link create(DTO dto)} method.
	 * Override this method if needed to perform any custom logics (e.g. workflow triggers and etc).
	 * 
	 * @param dto
	 * @param entity
	 */
	protected void onSave(DTO dto, T entity) {
	}
	
	/**
	 *
	 */
	private String getTransformerBeanPropertyKey() {
		return getEntityName() + ".transformer";
	}
}