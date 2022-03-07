<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	${entity.name?cap_first}Service.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 package ${package};

import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;

import ${entityPackage}.${entity.name?cap_first}${entity_suffix};
<#list entity.relations as relation>
import ${dtoPackage}.${relation.model.name}${dto_suffix};
</#list>
<#list entity.attributes as attribute>
<#if attribute.reference>
import ${dtoPackage}.${attribute.type}${dto_suffix};
<#elseif attribute.enumerate>
import ${entityPackage}.${attribute.type?cap_first};
</#if>
</#list>      
import ${dtoPackage}.${entity.name?cap_first}${dto_suffix};
import ${transformerPackage}.GenericEntityDTOTransformer;
import ${package}.GenericEntityService;

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
public interface ${entity.name?cap_first}Service extends GenericEntityService<${entity.name?cap_first}${dto_suffix}, ${entity.name?cap_first}${entity_suffix}> { 
	
	/**
	 * Get one ${entity.name?cap_first} using the primary key(s) as param.
	<#if primaryAttributes?size gt 1>
	 * @param keys Primary keys.
	<#else> 
    <#list primaryAttributes as attribute>
	 * @param ${attribute.name?lower_case}
	</#list>
    </#if>
	 */
	 ${entity.name?cap_first}${dto_suffix} getByPrimaryKey(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);

	/**
     * Get all ${entity.name} entities. 
     * @Return list of ${entity.name} entities
     */  
    public List<${entity.name?cap_first}${dto_suffix}> get${entity.name?cap_first}ByIds(List<${entity.primaryAttribute.type}> ${entity.primaryAttribute.name}s);

    /**
	 * Get one entity ${entity.name?cap_first} using the primary key(s) as param.
	<#if primaryAttributes?size gt 1>
	 * @param keys Primary keys.
	<#else> 
    <#list primaryAttributes as attribute>
	 * @param ${attribute.name?lower_case}
	</#list>
    </#if>
	 */
	 ${entity.name?cap_first}${entity_suffix} getEntityByPrimaryKey(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);

    /**
    * Find one entity.
    * @param ${entity.name?uncap_first}${dto_suffix} dto.
    */
    public ${entity.name?cap_first}${entity_suffix} findOne(${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first}${dto_suffix});
	 
	/**
	 * Delete one ${entity.name?cap_first}${entity_suffix} using the primary key(s) as param.
	 <#if primaryAttributes?size gt 1>
	 * @param keys Primary keys.
	<#else> 
    <#list primaryAttributes as attribute>
	 * @param ${attribute.name?lower_case}
	</#list>
    </#if>
	 */
	 void delete(<#if primaryAttributes?size gt 1>Object[] keys<#else><#list primaryAttributes as attribute>${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list></#if>);
	
	/**
	 * 
	   <#list primaryAttributes as attribute>
	 *  @param ${attribute.name?lower_case}
	 	</#list>
	 */
	Page<${entity.name?cap_first}${dto_suffix}> queryResult(
			Integer page,
			Integer size<#if entity.hasAnnotation("AUDIT_AWARE")>, String createdBy, Date createdDate, Date fromCreatedDate, Date toCreatedDate, String modifiedBy, Date modifiedDate, Date fromModifiedDate, Date toModifiedDate</#if>
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
   // Relation with ${primaryAttribute.name}
   ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
   </#list>
   </#list-->
   <#list entity.attributes as attribute>
   <#if attribute.reference>
   <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
   // Query from ${primaryAttribute.type} ${attribute.name} reference.
   ,${convertJavaToObjectType(primaryAttribute.type)} ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
   </#list>
   </#if>
   </#list>);
	
	/**
	 * 
	 * @param query
	 */
	List<${entity.name?cap_first}${entity_suffix}> execute(String query);
	
	<#assign myHash = { }>
    <#list entity.relations as relation>
    <#if !myHash[relation.model.name]??>
    <#assign myHash=myHash + { relation.model.name: 0 }>
	<#if relation.multiplicity == 1>
   /**
	* Find ${entity.name}${dto_suffix} knowing the ${relation.model.name}.
	*/
	public ${entity.name}${dto_suffix} findBy${relation.model.name}(${relation.model.name}${dto_suffix} ${relation.model.name?lower_case});
	<#else>
    /**
	* Find ${entity.name}${dto_suffix} knowing the ${relation.model.name}.
	*/
	public Page<${entity.name}${dto_suffix}> findBy${relation.model.name}(${relation.model.name}${dto_suffix} ${relation.model.name?lower_case}, int page, int size);
	</#if>
    </#if>
    	
    </#list>
   <#list entity.attributes as attribute>
      <#if attribute.reference>
 		<#if attribute.multiplicity == 1>
   /**
 	* Set relation with ${attribute.name?cap_first} instance.
 	* @param dto
 	* @param ${attribute.name?lower_case}${dto_suffix}
 	*/
 	public void set${attribute.name?cap_first}Relation(
 	    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
        ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
        </#list>
        <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
        ${primaryAttribute.type} ${attribute.name}${primaryAttribute.name?cap_first}${attribute.model.name}<#sep>,</#sep>
        </#list>);
 		<#elseif attribute.multiplicity == -1>
 		
   /**
    * Add relation with ${attribute.type?cap_first} instance.
    */      
    public void add${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep>
     </#list>);
	
   /**
    * Remove relation with ${attribute.type?cap_first} instance.
    */     
    public void remove${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name}${entity.name},
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name}${attribute.model.name}<#sep>,</#sep>
     </#list>);
        <#else>
        // UNKOWN attribute (${attribute.name}) multiplicity = ${attribute.multiplicity}
        </#if>
     </#if>
     </#list>

   /**
    * Get all ${entity.name} entities. 
    * @Return list of ${entity.name} entities
    */  
   public List<${entity.name?cap_first}${dto_suffix}> getAll${entity.name?cap_first}s();
   
  /**
   * Quick search ${entity.name?cap_first}
   * @param ident
   */
   Page<${entity.name?cap_first}${dto_suffix}> quickSearch(String quickSearchQuery, Integer offset, Integer size, String sort
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
   </#list>
   );

   /**
    * Save ${entity.name} instance. 
    * @Return saved ${entity.name} instance.
    */ 
   public ${entity.name?cap_first}${dto_suffix} save(${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first});
   
   /**
    * Save ${entity.name} instance.
    * @Return saved ${entity.name} instance.
    */ 
   public ${entity.name?cap_first}${entity_suffix} save(${entity.name?cap_first}${entity_suffix} ${entity.name?uncap_first});

   /**
	* Return the ${dto_suffix}/Entity transformer.
	*/
   public GenericEntityDTOTransformer<${entity.name?cap_first}${dto_suffix}, ${entity.name?cap_first}${entity_suffix}> getTransformerService();
   <#if entity.hasOneOfAnnotation(["SYNCH_SERVER"])>
   /**
    * Get latest update date.
    */
   public Date getLastestUpdateDate();
   /**
    * Get latest update date.
    */
   public List<${entity.name}DTO> get${entity.name}FromLastUpdateDate(Date date);
   </#if>
}