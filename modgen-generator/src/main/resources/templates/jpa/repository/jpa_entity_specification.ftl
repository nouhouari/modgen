<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * 
 * Nourreddine HOUARI CONFIDENTIAL
 * 
 * All information contained herein is, and remains
 * the property of Nourreddine HOUARI and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Nourreddine HOUARI
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 * 
 * [2017] Nourreddine HOUARI SA
 * All Rights Reserved.
 */
 
/*
 * Author   : 
 *     Nourreddine HOUARI <nourreddine.houari@>
 *     Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     :  ${aDate?string.medium} 
 * 
 * File     :  ${entity.name?cap_first}.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 
package ${package};

import ${entity_package}.${entity.name}${entity_suffix};
import ${servicePackage}.${entity.name}QueryConstraintListener;

<#list searchableAttributes as attribute>
<#if attribute.enumerate>
import  ${entity_package}.${attribute.type?cap_first};
</#if>
</#list>
<#assign myHash = { }>
<#list entity.relations as relation>
<#if !myHash[relation.model.name]??>
import ${entity_package}.${relation.model.name}${entity_suffix};
<#assign myHash=myHash + { relation.model.name: 0 }>
</#if>
</#list>
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.JoinType;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.data.jpa.domain.Specification;
import lombok.Setter;

<#function convertJavaToObjectType type>
 <#if type == "String">
   <#return "String">
 <#elseif type == "long" || type == "Long">
    <#return "Long">
 <#elseif type == "int" || type== "Integer">
    <#return "Integer">   
 </#if>
</#function> 

@Setter
public class ${entity.name}Specification implements Specification<${entity.name}${entity_suffix}> {

  <#-- 
  <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
  private ${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first};  
    </#list>
  </#list>
   -->
  
  <#list entity.attributes as attribute>
  <#if attribute.reference>
  <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
  // Query from ${primaryAttribute.type} ${attribute.name} reference.
  private ${convertJavaToObjectType(primaryAttribute.type)} ${attribute.name?uncap_first}${primaryAttribute.name?cap_first};
  </#list>
  </#if>
  </#list>
   
  <#list searchableAttributes as attribute>
  <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
  private ${attribute.type} from${attribute.name?cap_first};
  private ${attribute.type} to${attribute.name?cap_first};
  <#elseif attribute.type = "String" && attribute.location>
  private Double ${attribute.name?uncap_first}Distance;
  </#if>
  private ${attribute.type} ${attribute.name?uncap_first};
  </#list>
  private ${entity.name?cap_first}QueryConstraintListener queryListener;
  <#if entity.hasAnnotation("AUDIT_AWARE")>
  // Creation date
  private Date createdDate;
  private Date fromCreatedDate;
  private Date toCreatedDate;
  // Modification date
  private Date modifiedDate;
  private Date fromModifiedDate;
  private Date toModifiedDate;
  // Creation user
  private String createdBy;
  // Last modification user
  private String modifiedBy;
  </#if>
 
  public ${entity.name}Specification(
   <#list entity.referenceAttributes as attribute>
     ${attribute.model.primaryAttribute.type} ${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first}
      <#sep>,</#sep>
    </#list>
   <#if searchableAttributes?size gt 0 && entity.referenceAttributes?size gt 0>
   ,
   </#if>
   <#list searchableAttributes as attribute>
      <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
      ${attribute.type} from${attribute.name?cap_first},
      ${attribute.type} to${attribute.name?cap_first},
      <#elseif attribute.type = "String" && attribute.location>
      Double ${attribute.name?lower_case}Distance, 
      </#if>
      ${attribute.type} ${attribute.name?uncap_first}<#sep>,</#sep>
  </#list>
  
   ) {
 <#--    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} = ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first};  
    </#list>
    </#list>  
     --> 
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    this.from${attribute.name?cap_first} = from${attribute.name?cap_first};
    this.to${attribute.name?cap_first} = to${attribute.name?cap_first};
    <#elseif attribute.type = "String" && attribute.location>
    this.${attribute.name?lower_case}Distance = ${attribute.name?lower_case}Distance;
    </#if>
    this.${attribute.name?uncap_first} = ${attribute.name?uncap_first};
    </#list>
    
    <#list entity.attributes as attribute>
     <#if attribute.reference>
     this.${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first} = ${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first};
     </#if>
    </#list>
  }

  @Override
  public Predicate toPredicate(Root<${entity.name}${entity_suffix}> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
    List<Predicate> predicates = new ArrayList<Predicate>();
  
    <#-- 
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Relation with ${relation.model.name?uncap_first}
    if (this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} != null) {
      Join join = root.join("${relation.model.name?uncap_first}_${relation.relationName}", JoinType.LEFT);
      predicates.add(join.get("${primaryAttribute.name}").in(this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}));
    }

    </#list>
    </#list>
     -->
    
    <#list searchableAttributes as attribute>
    // QUERY attribute ${attribute.name}
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    if (from${attribute.name?cap_first} != null) {
      predicates.add(builder.greaterThanOrEqualTo(root.get("${attribute.name?uncap_first}"), from${attribute.name?cap_first}));
    }
    if (to${attribute.name?cap_first} != null) {
      predicates.add(builder.lessThanOrEqualTo(root.get("${attribute.name?uncap_first}"), to${attribute.name?cap_first}));
    }
    </#if>  
    <#if attribute.type = "String">
    if (${attribute.name?uncap_first} != null) {
      ${attribute.wildcard?then(
        'predicates.add(builder.like(root.get("${attribute.name?uncap_first}"), "%" + ${attribute.name?uncap_first} + "%"));'
        ,'predicates.add(builder.equal(root.get("${attribute.name?uncap_first}"), ${attribute.name?uncap_first}));'
      )}
    }
    <#else>
    if (${attribute.name?uncap_first} != null) {
      predicates.add(builder.equal(root.get("${attribute.name?uncap_first}"), ${attribute.name?uncap_first}));
    }
    </#if>
    </#list>
    
    <#if entity.hasAnnotation("AUDIT_AWARE")>
    // Creation date
    if (this.createdDate != null) {
      predicates.add(builder.equal(root.get("createdDate"), this.createdDate));
    }
    if (fromCreatedDate != null) {
      predicates.add(builder.greaterThanOrEqualTo(root.get("fromCreatedDate"), fromCreatedDate));
    }
    if (toCreatedDate != null) {
      predicates.add(builder.lessThanOrEqualTo(root.get("toCreatedDate"), toCreatedDate));
    }
 
    // Modification date
    if (this.modifiedDate != null) {
      predicates.add(builder.equal(root.get("modifiedDate"), this.modifiedDate));
    }
    if (fromModifiedDate != null) {
      predicates.add(builder.greaterThanOrEqualTo(root.get("fromModifiedDate"), fromModifiedDate));
    }
    if (toModifiedDate != null) {
      predicates.add(builder.lessThanOrEqualTo(root.get("toModifiedDate"), toModifiedDate));
    }
    
    // Creation user
    if (createdBy != null) {
      predicates.add(builder.equal(root.get("createdBy"), createdBy));
    }
    // Last modification user
    if (modifiedBy != null) {
      predicates.add(builder.equal(root.get("modifiedBy"), modifiedBy));
    }
    </#if>
   
    <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Query from ${attribute.name} reference primary key.
    if (${attribute.name?uncap_first}${primaryAttribute.name?cap_first} != null) {
      // Add child primary key clause.
      predicates.add(builder.equal(root.join("${attribute.name}").get("${primaryAttribute.name}"), ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}));
    }
    </#list>
    </#if>
    </#list>
    
    // Custom constraints listener
    if (queryListener != null){
      queryListener.addConstraint(root, query, builder, predicates);
    }
    
    return builder.and(predicates.toArray(new Predicate[] {} ));
  }
 
}
