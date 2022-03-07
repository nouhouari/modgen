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
 *     Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 *     Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com> 
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

@Setter
public class ${entity.name?cap_first}QuickSearchSpecification implements Specification<${entity.name?cap_first}Entity>{

  private String quickSearchString; 
  
  <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
  private ${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first};  
    </#list>
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
  
  public ${entity.name?cap_first}QuickSearchSpecification(String quickSearchString
  
   <#assign relationAdded = false>
   <#list entity.relations as relation>
     <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}  
     <#assign relationAdded = true>
     </#list>
   </#list>
   <#list searchableAttributes as attribute>
      <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
      ,${attribute.type} from${attribute.name?cap_first}
      ,${attribute.type} to${attribute.name?cap_first}
      <#elseif attribute.type = "String" && attribute.location>
      ,Double ${attribute.name?lower_case}Distance 
      </#if>
      ,${attribute.type} ${attribute.name?uncap_first}
  </#list>) {
   this.quickSearchString = quickSearchString;
   <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} = ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first};  
    </#list>
    </#list>   
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    this.from${attribute.name?cap_first} = from${attribute.name?cap_first};
    this.to${attribute.name?cap_first} = to${attribute.name?cap_first};
    <#elseif attribute.type = "String" && attribute.location>
    this.${attribute.name?lower_case}Distance = ${attribute.name?lower_case}Distance;
    </#if>
    this.${attribute.name?uncap_first} = ${attribute.name?uncap_first};
    </#list>
  }

  @Override
  public Predicate toPredicate(Root<${entity.name?cap_first}Entity> root, CriteriaQuery<?> query, CriteriaBuilder builder) {
    List<Predicate> quickSearchPredicate = new ArrayList<Predicate>();
    List<Predicate> advanceSearchPredicate = new ArrayList<Predicate>();
    
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte">
    if (isByte(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Byte.parseByte(quickSearchString)));
    }
    <#elseif attribute.type=="Short">
    if (isShort(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Short.parseShort(quickSearchString)));
    }
    <#elseif attribute.type=="Integer">
    if (isInt(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Integer.parseInt(quickSearchString)));
    }
    <#elseif attribute.type=="Long">
    if (isLong(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Long.parseLong(quickSearchString)));
    }
    <#elseif attribute.type=="Float">
    if (isFloat(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Float.parseFloat(quickSearchString)));
    }
    <#elseif attribute.type=="Double">
    if (isDouble(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Double.parseDouble(quickSearchString)));
    }
    <#elseif attribute.type=="Boolean">
    if (isBoolean(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Boolean.parseBoolean(quickSearchString)));
    }
    <#elseif attribute.type=="Date">
    if (isByte(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), Byte.parseByte(quickSearchString)));
    }
    <#elseif attribute.type=="String">
    if (quickSearchString != null){
      quickSearchPredicate.add(builder.like(root.get("${attribute.name?uncap_first}"), "%" + quickSearchString + "%"));
    }
    <#elseif attribute.enumerate>
    if (is${attribute.type}(quickSearchString)){
      quickSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), ${attribute.type}.valueOf(quickSearchString)));
    }
    </#if>
    </#list>


    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Relation with ${relation.model.name?uncap_first}
    if (this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} != null) {
      Join join = root.join("${relation.model.name?uncap_first}_${relation.relationName}", JoinType.LEFT);
      quickSearchPredicate.add(join.get("${primaryAttribute.name}").in(this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}));
    }
    
    //System.out.println("Quick search predicate :: " + quickSearchPredicate.toArray().toString());
    
    // To add normal search specification.
    </#list>
    </#list>
    <#list searchableAttributes as attribute>
    // QUERY attribute ${attribute.name}
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    if (from${attribute.name?cap_first} != null) {
      advanceSearchPredicate.add(builder.greaterThanOrEqualTo(root.get("${attribute.name?uncap_first}"), from${attribute.name?cap_first}));
    }
    if (to${attribute.name?cap_first} != null) {
      advanceSearchPredicate.add(builder.lessThanOrEqualTo(root.get("${attribute.name?uncap_first}"), to${attribute.name?cap_first}));
    }
    </#if>  
    <#if attribute.type = "String">
    if (${attribute.name?uncap_first} != null) {
      ${attribute.wildcard?then(
        'advanceSearchPredicate.add(builder.like(root.get("${attribute.name?uncap_first}"), "%" + ${attribute.name?uncap_first} + "%"));'
        ,'advanceSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), ${attribute.name?uncap_first}));'
      )}
    }
    <#else>
    if (${attribute.name?uncap_first} != null) {
      advanceSearchPredicate.add(builder.equal(root.get("${attribute.name?uncap_first}"), ${attribute.name?uncap_first}));
    }
    </#if>
    </#list>

    // Custom constraints listener
    if (queryListener != null){
      // do a AND with the custom constraints 
      // (custom) AND (q1 OR q2 OR...)
      List<Predicate> constraints = new ArrayList<Predicate>();
      queryListener.addConstraint(root, query, builder, constraints);
      Predicate customPredicate = builder.and(constraints.toArray(new Predicate[] {} ));
      Predicate advanceSearchPredicates = builder.and(advanceSearchPredicate.toArray(new Predicate[] {} ));
      Predicate quickSearchPredicates = builder.and(customPredicate, builder.or(quickSearchPredicate.toArray(new Predicate[] {})));
      return builder.and(advanceSearchPredicates, quickSearchPredicates);
    }else{
      // do a OR with the default query parameters
      // (q1 OR q2 OR...)
      Predicate advanceSearchPredicates = builder.and(advanceSearchPredicate.toArray(new Predicate[] {} ));
      if (quickSearchPredicate.size() > 0) {
    	  Predicate quickSearchPredicates = builder.or(quickSearchPredicate.toArray(new Predicate[] {}));
    	  return builder.and(advanceSearchPredicates, quickSearchPredicates);      	  
      } else {
    	  return advanceSearchPredicates;
      }
    }
  }
  
  private boolean isByte(String value) {
    try {
      Byte.parseByte(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isShort(String value) {
    try {
      Short.parseShort(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isInt(String value) {
    try {
      Integer.parseInt(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isLong(String value) {
    try {
      Long.parseLong(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isFloat(String value) {
    try {
      Float.parseFloat(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isDouble(String value) {
    try {
      Double.parseDouble(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  
  private boolean isBoolean(String value) {
    if (value !=null && (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false"))){
      return true;
    }
    return false;
  }
  
  <#list searchableAttributes as attribute>
  <#if attribute.enumerate>
   private boolean is${attribute.type}(String value) {
    try {
      ${attribute.type}.valueOf(value);
      return true;
    } catch (Exception e) {
      return false;
    }
  }
  </#if>
  </#list> 
}
