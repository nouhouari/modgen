<#macro underlinesToCamelCase inString><#local strArray = inString?split("_")><#list strArray as item><#if item?index == 0>${item}<#else>${item?cap_first}</#if></#list></#macro>
<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	${entity.name?cap_first}ServiceImpl.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 package ${package};

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import ${package}.exceptions.NotFoundException;
import ${entityPackage}.${entity.name?cap_first}${entity_suffix};
<#list entity.relations as relation>
import ${dtoPackage}.${relation.model.name}${dto_suffix};
import ${transformerPackage}.${relation.model.name?cap_first}${entity_suffix}${dto_suffix}TransformerImpl;
import ${entityPackage}.${relation.model.name}${entity_suffix};
</#list>
<#assign myHash = { }>
<#list entity.attributes as attribute>
// ${attribute.name} ${attribute.enumerate?string}
<#if attribute.enumerate>
//Import enum
import ${entityPackage}.${attribute.type?cap_first};
</#if>
<#if attribute.reference>
<#if !myHash[attribute.type]??>
import ${dtoPackage}.${attribute.type}${dto_suffix};
import ${entityPackage}.${attribute.type}${entity_suffix};
</#if>
<#assign myHash=myHash + { attribute.type: 0 }>
</#if>
</#list> 
import ${dtoPackage}.${entity.name?cap_first}${dto_suffix};
import ${repositoryPackage}.${entity.name?cap_first}${entity_repository_suffix};
import ${repositoryPackage}.${entity.name?cap_first}Specification;
import ${package}.${entity.name?cap_first}Service;
import ${package}.GenericEntityServiceImpl;
import ${repositoryPackage}.${entity.name?cap_first}QuickSearchSpecification;

<#function convertJavaToObjectType type>
 <#if type == "String">
   <#return "String">
 <#elseif type == "long" || type== "Long">
    <#return "Long">
 <#elseif type == "int" || type== "Integer">
    <#return "Integer">   
 </#if>
</#function> 

/**
 * THIS FILE IS AUTOMATICALLY GENERATED
 *     >> DO NOT EDIT MANUALLY <<
 * <br><br>
 * Generated by : ${generator}<br>
 * Version      : ${version}<br>
 * Date         : ${aDate?string.medium}<br>
 * <br>
 * @author Nourreddine HOUARI <nourreddine.houari@>
 * @author Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 */
@Service
public class ${entity.name?cap_first}ServiceImpl extends GenericEntityServiceImpl<${entity.name?cap_first}${dto_suffix}, ${entity.name?cap_first}${entity_suffix}> implements ${entity.name?cap_first}Service {
	
	//PRIVATE MEMBERS
	@Autowired(required = false)
	private ${entity.name?cap_first}QueryConstraintListener ${entity.name?uncap_first}QueryConstraintListener;
	@Autowired
	private ${entity.name?cap_first}${entity_repository_suffix} repository;
	<#assign myHash = { }>
    <#list entity.attributes as attribute>
    <#if attribute.reference>
   	<#if !myHash[attribute.model.name]??>
   	<#assign myHash=myHash + { attribute.model.name: 0 }>
	@Autowired
	private ${attribute.type?cap_first}Service ${attribute.type?uncap_first}Service;
	</#if>
    </#if>
	</#list>
	<#assign myHash = { }>
	<#list entity.relations as relation>
	<#if !myHash[relation.model.name]??>
	<#assign myHash=myHash + { relation.model.name: 0 }>
	@Autowired
	${relation.model.name?cap_first}${entity_suffix}${dto_suffix}TransformerImpl ${relation.model.name?uncap_first}${entity_suffix}${dto_suffix}Transformer;
	@Autowired
	private ${relation.model.name?cap_first}Service ${relation.model.name?uncap_first}Service;
	</#if>
    </#list>

    /**
	 * {@inheritDoc}
	 */
	 @Override
	 public ${entity.name?cap_first}${entity_suffix} findOne( ${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first}${dto_suffix}){
		return repository.getById(<#if primaryAttributes?size gt 1>keys<#else><#list primaryAttributes as attribute>${entity.name?uncap_first}${dto_suffix}.get${attribute.name?cap_first}()<#if attribute?has_next>,</#if></#list></#if>);
	 }

	/**
	 * {@inheritDoc}
	 */
	 @Override
	 public ${entity.name?cap_first}${dto_suffix} getByPrimaryKey(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>){
		Optional<${entity.name?cap_first}${entity_suffix}> ${entity.name?uncap_first}${entity_suffix}Opts  = repository.findById(<#if primaryAttributes?size gt 1>keys<#else><#list primaryAttributes as attribute>${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);
		if(${entity.name?uncap_first}${entity_suffix}Opts.isEmpty()){
			// Not found
			throw new NotFoundException("${entity.name?cap_first}");
		}
		${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first}${dto_suffix} = new ${entity.name?cap_first}${dto_suffix}();
		getTransformerService().transformEntityToDto(${entity.name?uncap_first}${entity_suffix}Opts.get(), ${entity.name?uncap_first}${dto_suffix});
		return ${entity.name?uncap_first}${dto_suffix};
	}
	
	/**
	 * {@inheritDoc}
	 */
	 @Override
	 public ${entity.name?cap_first}${entity_suffix} getEntityByPrimaryKey(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>){
		Optional<${entity.name?cap_first}${entity_suffix}> ${entity.name?uncap_first}${entity_suffix}Opts  = repository.findById(<#if primaryAttributes?size gt 1>keys<#else><#list primaryAttributes as attribute>${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);
		if(${entity.name?uncap_first}${entity_suffix}Opts.isEmpty()){
			// Not found
			throw new NotFoundException("${entity.name?cap_first}");
		}
		return ${entity.name?uncap_first}${entity_suffix}Opts.get();
	}
	
	/**
	 * {@inheritDoc}
	 */
	 @Override
	 public void delete(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>){
		repository.deleteById(<#if primaryAttributes?size gt 1>keys<#else><#list primaryAttributes as attribute>${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);
	}
	
	/**
	 * {@inhertiDoc}
	 */
	 @Override
	public Page<${entity.name?cap_first}${dto_suffix}> queryResult(
			Integer page,
			Integer size, 
			String sort
			<#if entity.hasAnnotation("AUDIT_AWARE")>,
			String createdBy, 
			Date createdDate, 
			Date fromCreatedDate, 
			Date toCreatedDate, 
			String modifiedBy, 
			Date modifiedDate, 
			Date fromModifiedDate, 
			Date toModifiedDate
			</#if>
   <#if searchableAttributes?size gt 0>,</#if>
   <#list searchableAttributes as attribute>
   <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
${attribute.type} from${attribute.name?cap_first},
   ${attribute.type} to${attribute.name?cap_first},
   <#elseif attribute.type = "String" && attribute.location>
   Double ${attribute.name?lower_case}Distance, 
   </#if>
   ${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>, </#if>
   </#list>
   
   <#-- list entity.relations as relation>
   <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
   ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
   </#list>
   </#list-->
   
   <#list entity.referenceAttributes as attribute>
  
   <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
   // Query from ${primaryAttribute.type} ${attribute.name} reference.
   ,${convertJavaToObjectType(primaryAttribute.type)} ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
   </#list>

   </#list>){
   
			${entity.name?cap_first}Specification spec = new ${entity.name?cap_first}Specification(<#assign relationAdded = false>
		    <#list entity.referenceAttributes as attribute>
		     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
		     // Query from ${primaryAttribute.type} ${attribute.name} reference.
		     ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
		      </#list>
		      <#sep>,</#sep>
		    </#list>
		     
		   <#--  <#list entity.relations as relation>
		    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
		    ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
		    <#assign relationAdded = true>
		    </#list>
		    <#sep>,</#sep>
		    </#list>
		     -->
		    <#if entity.referenceAttributes?size gt 0 && searchableAttributes?size gt 0>
		    ,
		    </#if>
		    <#list searchableAttributes as attribute>
		    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
		    from${attribute.name?cap_first},
		    to${attribute.name?cap_first},
		    <#elseif attribute.type = "String" && attribute.location>
		    ${attribute.name?lower_case}Distance, 
		    </#if>
		    ${attribute.name?lower_case}<#if attribute?has_next>, </#if>
		    </#list>);
		    if (${entity.name?uncap_first}QueryConstraintListener != null){
		    	spec.setQueryListener(${entity.name?uncap_first}QueryConstraintListener);
		    }
		    PageRequest pageRequest = null;
            // Check the sort parameters
            if (sort != null) {
              Sort s = buildSort(sort);
              pageRequest = PageRequest.of(page, size, s);
            } else {
              // without sorting
              pageRequest = PageRequest.of(page, size);
            }
		    Page<${entity.name?cap_first}${entity_suffix}> entityPage = repository.findAll(spec,
		    pageRequest);
		    
		    
		    return entityPage.map((entity) -> {
			  ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
			  getTransformerService().transformEntityToDto(entity, dto);
			  return dto;
		    });
	}
	
	@Override
    public Page<${entity.name?cap_first}DTO> quickSearch(String quickSearchQuery, Integer page, Integer size, String sort
    <#list searchableAttributes as attribute>
   <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
   ,${attribute.type} from${attribute.name?cap_first}
   ,${attribute.type} to${attribute.name?cap_first}
   <#elseif attribute.type = "String" && attribute.location>
   ,Double ${attribute.name?lower_case}Distance
   </#if>
   ,${attribute.type} ${attribute.name?lower_case}
   </#list>
   <#list entity.relations as relation>
   <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
   ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
   </#list>
   </#list>) {
    
      ${entity.name?cap_first}QuickSearchSpecification quickSearchSpec = new ${entity.name?cap_first}QuickSearchSpecification(quickSearchQuery
    
    <#assign relationAdded = false>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ,${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
    <#assign relationAdded = true>
    </#list>
    </#list>
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    ,from${attribute.name?cap_first}
    ,to${attribute.name?cap_first}
    <#elseif attribute.type = "String" && attribute.location>
    ,${attribute.name?lower_case}Distance 
    </#if>
    ,${attribute.name?lower_case}
    </#list>);
    
      // Inject custom constraints
      //if (this.queryConstraintListener != null){
      //  quickSearchSpec.setQueryListener(this.queryConstraintListener);
      //}
    
      PageRequest pageRequest = null;
      // Check the sort parameters
      if (sort != null) {
        Sort s = buildSort(sort);
        pageRequest = PageRequest.of(page, size, s);
      } else {
        // without sorting
        pageRequest = PageRequest.of(page, size);
      }
      return repository.findAll(quickSearchSpec, pageRequest)
        .map((entity) -> {
			  ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
			  getTransformerService().transformEntityToDto(entity, dto);
			  return dto;
		    });
    }
    
    @Override
    public List<${entity.name?cap_first}${dto_suffix}> get${entity.name?cap_first}ByIds(List<${entity.primaryAttribute.type}> ${entity.primaryAttribute.name}s) {
    	return this.repository.findAllById(${entity.primaryAttribute.name}s).stream().map(entity -> {
          ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
 		  getTransformerService().transformEntityToDto(entity, dto);
 		  return dto;
    	}).collect(Collectors.toList());
    } 
    
    @Override
    public List<${entity.name?cap_first}DTO> getAll${entity.name?cap_first}s() {
    	return this.repository.findAll().stream().map(entity -> {
          ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
 		  getTransformerService().transformEntityToDto(entity, dto);
 		  return dto;
    	}).collect(Collectors.toList());
    }     
	
	
	/**
	 * {@inhertiDoc}
	 */
	 @Override
	public List<${entity.name?cap_first}${entity_suffix}> execute(String query){
		//TODO return repository.execute(query);
		return null;
	} 
	
    <#list entity.attributes as attribute>
    <#if attribute.hasAnnotation("PK")>
    <#assign primaryType = attribute.type>
    </#if>
    </#list>
    /**
     * {@inhertiDoc}
     */
    @Override
    protected JpaRepository<${entity.name?cap_first}${entity_suffix},${primaryType}> getRepository() {
    	return repository;
    }
    
    /**
     * {@inheritDoc} 
     */
    @Override
    protected void getEntityConvertedFrom${dto_suffix}(${entity.name?cap_first}${dto_suffix} dto, ${entity.name?cap_first}${entity_suffix} entity) {
    	getTransformerService().transformDtoToEntity(dto, entity);
    }
    
    /**
     * {@inheritDoc} 
     */
    @Override
    protected void getDTOConvertedFromEntity(${entity.name?cap_first}${entity_suffix} entity, ${entity.name?cap_first}${dto_suffix} dto) {
    	getTransformerService().transformEntityToDto(entity, dto);
    }
    
    /**
     * {@inheritDoc} 
     */
    @Override
    protected ${entity.name?cap_first}${entity_suffix} getNewEntityInstance() {
    	return new ${entity.name?cap_first}${entity_suffix}();
    }
    
    /**
	 * {@inheritDoc}
	 */
	@Override
	protected String getDefaultTransformerBeanName() {
		return "${entity.name?cap_first}Entity${dto_suffix}Mapper";
	}
	
	/**
	 * {@inheritDoc}
	 */
	@Override
	protected String getEntityName() {
		return "${entity.name?lower_case}";
	}
		
	/**
	 * {@inheritDoc}
	 */
	@Override
	protected void onBeforeSave(${entity.name?cap_first}${dto_suffix} dto, ${entity.name?cap_first}${entity_suffix} entity) {
		<#list entity.attributes as attribute>
		<#if attribute.hasAnnotation("PK")>
		<#if attribute.type == "String">
		//if(!StringUtils.hasText(entity.get<@underlinesToCamelCase attribute.name?cap_first/>())) {
		//	dto.setEntityState(EntityState.NEW);
		//} else {
		//	dto.setEntityState(EntityState.UPDATE);
		//}
		<#elseif (attribute.type == "Integer" || attribute.type == "Long")>
		//if(entity.get<@underlinesToCamelCase attribute.name?cap_first/>() == 0) {
		//	dto.setEntityState(EntityState.NEW);
		//} else {
		//	dto.setEntityState(EntityState.UPDATE);
		//}
		</#if>
		</#if>
		</#list>
	}
	
	/**
	 * {@inheritDoc}
	 */
	@Override
	protected void onSave(${entity.name?cap_first}${dto_suffix} dto, ${entity.name?cap_first}${entity_suffix} entity) {
		//if(dto.getEntityState().equals(EntityState.NEW)){
		  <#list entity.attributes as attribute>
		  	<#if attribute.hasAnnotation("PK")>
		  	//dto.set<@underlinesToCamelCase attribute.name?cap_first/>(entity.get<@underlinesToCamelCase attribute.name?cap_first/>());
		  	</#if>
		  </#list>
		//}
		//asyncEventBus.post(dto);
	}
	
	
	<#assign myHash = { }>
    <#list entity.relations as relation>
    <#if !myHash[relation.model.name]??>
    <#assign myHash=myHash + { relation.model.name: 0 }>
    <#if relation.multiplicity == 1>
   /**
	* Find ${entity.name}${dto_suffix} knowing the ${relation.model.name}.
	* @param ${relation.model.name?lower_case} dto.
	*/
	public ${entity.name}${dto_suffix} findBy${relation.model.name}(${relation.model.name}${dto_suffix} ${relation.model.name?lower_case}){
		${relation.model.name}${entity_suffix} ${relation.model.name?uncap_first}${entity_suffix} = ${relation.model.name?uncap_first}Service.findOne(${relation.model.name?lower_case});
		${entity.name}${entity_suffix} entity = repository.findBy${relation.model.name}${entity.name}(${relation.model.name?uncap_first}${entity_suffix});
		${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
 		getTransformerService().transformEntityToDto(entity, dto);
 		return dto;
	}
	<#else>
   /**
	* Find ${entity.name}${entity_suffix} knowing the ${relation.model.name}.
	* @param ${relation.model.name?lower_case}
	* @param page Page number
	* @size page Page size
	* @return paged result of ${entity.name}${entity_suffix}
	*/
	public Page<${entity.name}${dto_suffix}> findBy${relation.model.name}(${relation.model.name}${dto_suffix} ${relation.model.name?lower_case}${dto_suffix}, int page, int size){
		
		${relation.model.name}${entity_suffix} ${relation.model.name?lower_case} = new ${relation.model.name}${entity_suffix}();
		${relation.model.name?uncap_first}${entity_suffix}${dto_suffix}Transformer.transformDtoToEntity( ${relation.model.name?lower_case}${dto_suffix}, ${relation.model.name?lower_case});
		
		Page<${entity.name?cap_first}${dto_suffix}> pageResult = repository.findBy${relation.model.name}${entity.name}(${relation.model.name?lower_case}, PageRequest.of(page, size))
		.map(entity -> {
          ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
 		  getTransformerService().transformEntityToDto(entity, dto);
 		  return dto;
    	});
		return pageResult;
	}
	</#if>
    </#if>
    </#list>

    <#list entity.attributes as attribute>
      <#if attribute.reference>
 		<#if attribute.multiplicity == 1>
   /**
 	* {@inhertiDoc}
 	*/
 	public void set${attribute.name?cap_first}Relation(
      <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
        ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
        </#list>
        <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
        ${primaryAttribute.type} ${attribute.name}${primaryAttribute.name?cap_first}${attribute.model.name}<#sep>,</#sep>
        </#list>){
        
      // Find entities
      ${entity.name}${entity_suffix} ${entity.name?uncap_first}${entity_suffix} = repository.getById(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}${entity.name}<#sep>,</#sep></#list>);
      ${attribute.type}${entity_suffix} ${attribute.type?uncap_first}${entity_suffix} = ${attribute.type?uncap_first}Service.getEntityByPrimaryKey(<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}${attribute.model.name}<#sep>,</#sep></#list>);
      // Set relation
      ${entity.name?uncap_first}${entity_suffix}.set${attribute.name?cap_first}(${attribute.type?uncap_first}${entity_suffix});
      // Save entity
      ${entity.name?cap_first}${entity_suffix} saved = (${entity.name?cap_first}${entity_suffix}) getRepository().save(${entity.name?uncap_first}${entity_suffix});
    }
 		<#elseif attribute.multiplicity == -1>
   /**
 	* {@inhertiDoc}
 	*/      
    public void add${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ${primaryAttribute.type} ${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep>
    </#list>){
		${entity.name?cap_first}${entity_suffix} ${entity.name?uncap_first}${entity_suffix}  = repository.getById(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}${entity.name}<#sep>,</#sep></#list>);
    	${attribute.type?cap_first}${entity_suffix} ${attribute.type?uncap_first}${entity_suffix} = ${attribute.type?uncap_first}Service.getEntityByPrimaryKey(<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep></#list>);
    	${entity.name?uncap_first}${entity_suffix}.get${attribute.name?cap_first}().add(${attribute.type?uncap_first}${entity_suffix});
    	<#if attribute.oppositeMultiplicity == 1>
    	// To one relation type
    	${attribute.type?uncap_first}${entity_suffix}.set${entity.name?cap_first}_${attribute.name?uncap_first}(${entity.name?uncap_first}${entity_suffix});
    	<#else>
    	// To many relation type
    	${attribute.type?uncap_first}${entity_suffix}.get${entity.name?cap_first}_${attribute.name?uncap_first}().add(${entity.name?uncap_first}${entity_suffix});
    	</#if>
    	getRepository().save(${entity.name?uncap_first}${entity_suffix});
    }
   /**
 	* {@inhertiDoc}
 	*/     
    public void remove${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ${primaryAttribute.type} ${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep>
    </#list>){
		${entity.name?cap_first}${entity_suffix} ${entity.name?uncap_first}${entity_suffix}  = repository.getById(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}${entity.name}<#sep>,</#sep></#list>);
    	${attribute.type?cap_first}${entity_suffix} ${attribute.type?uncap_first}${entity_suffix} = ${attribute.type?uncap_first}Service.getEntityByPrimaryKey(<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep></#list>);
    	${entity.name?uncap_first}${entity_suffix}.get${attribute.name?cap_first}().remove(${attribute.type?uncap_first}${entity_suffix});
    	<#if attribute.oppositeMultiplicity == 1>
    	// To one relation type
    	${attribute.type?uncap_first}${entity_suffix}.set${entity.name?cap_first}_${attribute.name?uncap_first}(null);
    	<#else>
    	// To many relation type
    	${attribute.type?uncap_first}${entity_suffix}.get${entity.name?cap_first}_${attribute.name?uncap_first}().remove(${entity.name?uncap_first}${entity_suffix});
    	</#if>
    	getRepository().save(${entity.name?uncap_first}${entity_suffix});
    }	
        <#else>
        // UNKOWN attribute (${attribute.name}) multiplicity = ${attribute.multiplicity}
        </#if>
	  </#if>
	</#list>
	
   /** {@inheritDoc}
    *  Save ${entity.name} instance.
    *  @Override 
    *  @Return saved ${entity.name} instance.
    */
   //@Transactional(readOnly=false)   
   public ${entity.name?cap_first}${dto_suffix} save(${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first}) {
      ${entity.name?cap_first}${entity_suffix} entity = new ${entity.name?cap_first}Entity();
      getTransformerService().transformDtoToEntity(${entity.name?uncap_first}, entity);
	  <#if entity.hasAnnotation("EXTENDABLE")>
	  // TODO check schema
      
      </#if>
      // Save entity
      ${entity.name?cap_first}${entity_suffix} savedEntity = repository.save(entity);
      // Transform entity to DTO
      getTransformerService().transformEntityToDto(savedEntity,${entity.name?uncap_first});
      return ${entity.name?uncap_first};
    }
    
    <#if entity.hasOneOfAnnotation(["SYNCH_SERVER"])>
   /**
    * Get latest update date.
    */
   public Date getLastestUpdateDate(){
     ${entity.name?cap_first}${entity_suffix} latest = repository.findFirstByOrderByModifiedDateDesc();
     if (latest != null){
       return latest.getModifiedDate();
     } else {
     	return null;
     }
   }
   /**
    * Get latest record from update date.
    */
   public List<${entity.name}DTO> get${entity.name}FromLastUpdateDate(Date date){
   	return repository.findByModifiedDateGreaterThan(date).stream().map(entity -> {
          ${entity.name}${dto_suffix} dto = new ${entity.name}${dto_suffix}();
 		  getTransformerService().transformEntityToDto(entity, dto);
 		  return dto;
    	}).collect(Collectors.toList());
   }
   </#if>
	
	/**
    * Save ${entity.name} instance.
    * @Return saved ${entity.name} instance.
    */ 
    public ${entity.name?cap_first}${entity_suffix} save(${entity.name?cap_first}${entity_suffix} ${entity.name?uncap_first}){
      return repository.save(${entity.name?uncap_first});
    }
	
   /**
    * Parse the params string and return a Sort object that 
    * contains all the sort parameters.
    */
    private Sort buildSort(String sort) {
      List<Order> orders = new ArrayList<>();
      String[] values = sort.split(",");
      for(int i=0; i< values.length-1; i=i+2){
        String column = values[i];
        String direction = values[i+1];
        Order columnSort = new Order(Direction.fromString(direction), column);
        orders.add(columnSort);
      }
      return Sort.by(orders);
    }	
}