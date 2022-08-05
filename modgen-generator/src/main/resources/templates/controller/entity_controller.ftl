<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   : Nourreddine HOUARI <nourreddine.houari@>
 *     Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     :  ${aDate?string.medium} 
 * 
 * File     :  ${entity.name?cap_first}Controller.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
package ${package};

<#function convertJavaToObjectType type>
 <#if type == "String">
   <#return "String">
 <#elseif type == "long" || type == "Long">
    <#return "Long">
 <#elseif type == "int" || type == "Integer">
    <#return "Integer">
 <#elseif type == "double" || type == "Double">
    <#return "Double">      
 </#if>
 <#return type>
</#function> 

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import com.google.common.util.concurrent.ThreadFactoryBuilder;
import org.springframework.format.annotation.DateTimeFormat;

import ${dtoPackage}.${entity.name?cap_first}${dto_suffix};
import ${dtoPackage}.${entity.name?cap_first}${dto_suffix}SaveResult;
<#list entity.relations as relation>
import ${dtoPackage}.${relation.model.name}${dto_suffix};
</#list>
<#assign myHash = { }>
<#list entity.attributes as attribute>
<#if  !myHash[attribute.type]??>
<#if attribute.reference>
import ${dtoPackage}.${attribute.type}${dto_suffix};
<#elseif attribute.enumerate>
import ${entityPackage}.${attribute.type};
</#if>
<#assign myHash=myHash + { attribute.type: 0 }>
</#if>
</#list>      
import ${servicePackage}.${entity.name?cap_first}Service;
import ${servicePackage}.exceptions.NotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RestController
@RequestMapping("/${entity.name?lower_case}")
@CrossOrigin(value={"*"})
public class ${entity.name?cap_first}Controller {
  
  @Autowired
  private ${entity.name?cap_first}Service service;
 
 //PUBLIC METHODS
  
 /**
  * Create/Update an entity.
  * @param ${entity.name?uncap_first} instance to save/update
  */
  @PostMapping(
    path = "", 
    produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<${entity.name?cap_first}${dto_suffix}> create(@RequestBody ${entity.name?cap_first}${dto_suffix} ${entity.name?uncap_first}DTO) {
    ${entity.name?cap_first}${dto_suffix} result = service.save(${entity.name?uncap_first}DTO);
    return new ResponseEntity<${entity.name?cap_first}${dto_suffix}>(result, HttpStatus.OK);
  }
  
  /**
   * returns the number of records on the persistence layer.
   */
  @GetMapping(
      path = "/count", 
      produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Long> count() {
    return new ResponseEntity<Long>( service.count(),HttpStatus.OK);
  }
 
  @RequestMapping(
      path = "", 
      produces = MediaType.APPLICATION_JSON_VALUE, 
      method = RequestMethod.GET)
  @ResponseBody
  public ResponseEntity<List<${entity.name?cap_first}DTO>> getAll() {
    List<${entity.name?cap_first}DTO> list = service.getAll${entity.name?cap_first}s();
    return new ResponseEntity<List<${entity.name?cap_first}DTO>>(list, HttpStatus.OK);
  }
 
  /**
   * Get one ${entity.name?cap_first}${entity_suffix} using the primary key.
     <#list primaryAttributes as attribute>
   * @param {${attribute.name?lower_case}}
     </#list>
   */
  @GetMapping(
   value="<#list primaryAttributes as attribute>/{${attribute.name?lower_case}}</#list>",
   produces=MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<${entity.name?cap_first}${dto_suffix}> getByPrimaryKey(
    <#list primaryAttributes as attribute>
    @PathVariable 
    ${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if>
    </#list>
    ){
     ${entity.name?cap_first}${dto_suffix} result = service.getByPrimaryKey(<#list primaryAttributes as attribute>${attribute.name?lower_case}<#if attribute?has_next>,</#if></#list>);
     return new ResponseEntity<${entity.name?cap_first}DTO>(result, HttpStatus.OK);
  }
 
  /**
   * Delete one ${entity.name?cap_first} using the primary key.
    <#list primaryAttributes as attribute>
   * @param {${attribute.name?lower_case}}
   </#list>
   */
  @DeleteMapping(
    value="<#list primaryAttributes as attribute>/{${attribute.name?lower_case}}</#list>")
  @ResponseBody
  public ResponseEntity<Void> delete(
   <#list primaryAttributes as attribute>
   @PathVariable 
   ${attribute.type} ${attribute.name?lower_case}<#if attribute?has_next>,</#if>
      </#list>
   ){
  <#if primaryAttributes?size gt 1>
    Object [] keys = {<#list primaryAttributes as attribute>${attribute.name?lower_case}<#sep>,</#sep></#list>};
  </#if> 
    service.delete(<#if primaryAttributes?size gt 1>keys<#else><#list primaryAttributes as attribute>${attribute.name?lower_case}<#sep>,</#sep></#list></#if>);
    return new ResponseEntity<Void>(HttpStatus.OK);
  }
 
  /**
   * Quick search ${entity.name?cap_first} service.
   * @param page
   * @param size
   * @param quickSearchQuery
   * @param sort
   * @return
   */
  @GetMapping(
   path = "/quicksearch", 
   produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Page<${entity.name?cap_first}DTO>> quickSearch(
    @RequestParam(required=false, defaultValue="0") Integer page,
    @RequestParam(required=false, defaultValue="10") Integer size,
    @RequestParam(required=false) String quickSearchQuery,
    @RequestParam(required=false) String sort
    <#if searchableAttributes?size gt 0>,</#if>
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double">
    @RequestParam(required=false) ${attribute.type} from${attribute.name?cap_first},
    @RequestParam(required=false) ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "Date">
    @RequestParam(required=false) @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss.SSS") ${attribute.type} from${attribute.name?cap_first},
    @RequestParam(required=false) @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss.SSS") ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "String" && attribute.location>
    @RequestParam(required=false) Double ${attribute.name?lower_case}Distance, 
    </#if>
    @RequestParam(required=false) ${attribute.type} ${attribute.name?uncap_first}<#if attribute?has_next>, </#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ,@RequestParam(required=false) ${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
    </#list>
    </#list>
    ){
    
    Page<${entity.name?cap_first}DTO> result = this.service.quickSearch(quickSearchQuery, page, size, sort
        <#if searchableAttributes?size gt 0>,</#if>
     <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    from${attribute.name?cap_first},
    to${attribute.name?cap_first},
    <#elseif attribute.type = "String" && attribute.location>
    ${attribute.name?lower_case}Distance, 
    </#if>
    ${attribute.name?uncap_first}<#if attribute?has_next>, </#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ,${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
    </#list>
    </#list>);
    return new ResponseEntity<Page<${entity.name?cap_first}DTO>>(result, HttpStatus.OK);
  }
 
  /**
   * Quick search ${entity.name?cap_first} service.
   * @param page
   * @param size
   * @param quickSearchQuery
   * @param sort
   * @return
   */
  @GetMapping(
   path = "/search", 
   produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Page<${entity.name?cap_first}DTO>> search(
    @RequestParam(required=false, defaultValue="0") Integer page,
    @RequestParam(required=false, defaultValue="10") Integer size,
    @RequestParam(required=false) String sort<#if entity.hasAnnotation("AUDIT_AWARE")>,
    @RequestParam(required=false) String createdBy, 
    @RequestParam(required=false) Date createdDate, 
    @RequestParam(required=false) Date fromCreatedDate, 
    @RequestParam(required=false) Date toCreatedDate, 
    @RequestParam(required=false) String modifiedBy, 
    @RequestParam(required=false) Date modifiedDate, 
    @RequestParam(required=false) Date fromModifiedDate, 
    @RequestParam(required=false) Date toModifiedDate</#if>
    <#if searchableAttributes?size gt 0>,</#if>
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double">
    @RequestParam(required=false) ${attribute.type} from${attribute.name?cap_first},
    @RequestParam(required=false) ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "Date">
    @RequestParam(required=false) @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss.SSS") ${attribute.type} from${attribute.name?cap_first},
    @RequestParam(required=false) @DateTimeFormat(pattern="yyyy-MM-dd'T'HH:mm:ss.SSS") ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "String" && attribute.location>
    @RequestParam(required=false) Double ${attribute.name?lower_case}Distance, 
    </#if>
    @RequestParam(required=false) ${attribute.type} ${attribute.name?uncap_first}<#if attribute?has_next>, </#if>
    </#list>
    
    <#list entity.referenceAttributes as attribute>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     // Query from ${primaryAttribute.type} ${attribute.name} reference.
     ,@RequestParam(required=false) ${convertJavaToObjectType(primaryAttribute.type)} ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
     </#list>
   </#list>
    ){
    
    Page<${entity.name?cap_first}DTO> result = this.service.queryResult( page, size, sort <#if entity.hasAnnotation("AUDIT_AWARE")>,
      createdBy, 
      createdDate, 
      fromCreatedDate, 
      toCreatedDate, 
      modifiedBy, 
      modifiedDate, 
      fromModifiedDate, 
      toModifiedDate</#if>
      <#if searchableAttributes?size gt 0>,</#if>
       <#list searchableAttributes as attribute>
      <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
      from${attribute.name?cap_first},
      to${attribute.name?cap_first},
      <#elseif attribute.type = "String" && attribute.location>
      ${attribute.name?lower_case}Distance, 
      </#if>
      ${attribute.name?uncap_first}<#if attribute?has_next>, </#if>
      </#list>
      <#list entity.referenceAttributes as attribute>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     // Query from ${primaryAttribute.type} ${attribute.name} reference.
     ,${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
     </#list>
   </#list>
   );
    return new ResponseEntity<Page<${entity.name?cap_first}DTO>>(result, HttpStatus.OK);

  }	
 
 
  <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#if attribute.multiplicity == 1>
  // Simple reference
  @PostMapping(path = "/${attribute.name?lower_case}/set", produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Void> set${attribute.name?cap_first}Relation(
     @RequestBody Map<String,String> request) {
    
    service.set${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    <#if primaryAttribute.type="String">
    request.get("${primaryAttribute.name}"),
    <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
    Integer.parseInt(request.get("${primaryAttribute.name}")),
    <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
    Long.parseLong(request.get("${primaryAttribute.name}")),
    </#if>
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    <#if primaryAttribute.type="String">
    request.get("${attribute.name}${primaryAttribute.name?cap_first}")<#sep>,</#sep>
    <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
    Integer.parseInt(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
    <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
    Long.parseLong(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
    </#if>
    </#list>);
     return new ResponseEntity<Void>(HttpStatus.OK);
  }

   <#elseif attribute.multiplicity == -1>
  // Multiple references
  @PostMapping(path = "/${attribute.name?lower_case}", produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Void> add${attribute.name?cap_first}Relation(@RequestBody Map<String,String> request) {
    service.add${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     <#if primaryAttribute.type="String">
     request.get("${primaryAttribute.name}"),
     <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
     Integer.parseInt(request.get("${primaryAttribute.name}")),
     <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
     Long.parseLong(request.get("${primaryAttribute.name}")),
     </#if>
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     <#if primaryAttribute.type="String">
     request.get("${attribute.name}${primaryAttribute.name?cap_first}")<#sep>,</#sep>
     <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
     Integer.parseInt(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
     <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
     Long.parseLong(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
     </#if>
     </#list>);
    return new ResponseEntity<Void>(HttpStatus.OK);
  }
               
  @DeleteMapping(path = "/${attribute.name?lower_case}", produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<Void> remove${attribute.name?cap_first}Relation(@RequestBody Map<String,String> request) {
    service.remove${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    <#if primaryAttribute.type="String">
     request.get("${primaryAttribute.name}"),
    <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
     Integer.parseInt(request.get("${primaryAttribute.name}")),
     <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
     Long.parseLong(request.get("${primaryAttribute.name}")),
     </#if>
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     <#if primaryAttribute.type="String">
     request.get("${attribute.name}${primaryAttribute.name?cap_first}")<#sep>,</#sep>
    <#elseif primaryAttribute.type="int" || primaryAttribute.type="Integer">
     Integer.parseInt(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
     <#elseif primaryAttribute.type="long" || primaryAttribute.type="Long">
     Long.parseLong(request.get("${attribute.name}${primaryAttribute.name?cap_first}"))<#sep>,</#sep>
     </#if>
     </#list>);
    return new ResponseEntity<Void>(HttpStatus.OK);
  }
        <#else>
        // UNKOWN attribute (${attribute.name}) multiplicity = ${attribute.multiplicity}
        </#if>
   </#if>
 </#list>
 
  <#if entity.hasOneOfAnnotation(["SYNCH_SERVER"])>
  /**
   * Returns the latest update date.
   * @return
   */
  @GetMapping(path = "latest") 
  public ResponseEntity<Date> getLastUpdateDate(){
	  Date latest = this.service.getLastestUpdateDate();
	  if (latest != null) {
		  return new ResponseEntity<Date>(latest, HttpStatus.OK);
	  }
	  throw new NotFoundException("Latest ${entity.name}");
  }
  /**
   * Returns the latest update ${entity.name} from a date.
   * @return
   */
  @GetMapping(path = "update", params = "latestDate") 
  public ResponseEntity<List<${entity.name}DTO>> getLast${entity.name}FromUpdateDate(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS") Date latestDate){
	 return new ResponseEntity(this.service.get${entity.name}FromLastUpdateDate(latestDate), HttpStatus.OK);
  }
  </#if>
  
}