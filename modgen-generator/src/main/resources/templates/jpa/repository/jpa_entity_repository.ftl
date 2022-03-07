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
 * Author : Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 *          Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com> 
 *
 * Date     :  ${aDate?string.medium} 
 * 
 * File     :  ${entity.name?cap_first}.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */

package ${package};

import ${entity_package}.${entity.name}${entity_suffix};
<#list entity.attributes as attribute>
<#if attribute.reference>
import ${entity_package}.${attribute.model.name}${entity_suffix};
</#if>
</#list>
<#list entity.relations as relation>
import ${entity_package}.${relation.model.name}${entity_suffix};
</#list>
<#list searchableAttributes as attribute>
<#if attribute.enumerate>
import  ${entity_package}.${attribute.type?cap_first};
</#if>
</#list>

import java.util.Date;
import java.util.List;
import javax.transaction.Transactional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * THIS FILE IS AUTOMATICALLY GENERATED
 *     >> DO NOT EDIT MANUALLY <<
 * <br><br>
 * Generated by : ${generator}<br>
 * Version      : ${version}<br>
 * Date         : ${aDate?string.medium}<br>
 * <br>
 * @author Nourreddine HOUARI nourreddine.houari@sicpa.com
 * @author Koneru, Venkaiah Chowdary VenkaiahChowdary.Koneru@sicpa.com
 *
 */
 <#list entity.attributes as attribute>
 <#if attribute.hasAnnotation("PK")>
 <#assign primaryType = attribute.type>
 </#if>
 </#list>
public interface ${entity.name}${entity_repository_suffix} extends JpaRepository<${entity.name}${entity_suffix}, ${primaryType}>, JpaSpecificationExecutor<${entity.name}${entity_suffix}> {

 <#list entity.attributes as attribute>
 <#if attribute.reference>
  /**
   * Find by  ${attribute.name?cap_first}.
   */
  List<${entity.name}${entity_suffix}> findBy${attribute.name?cap_first}(${attribute.type}${entity_suffix} ${attribute.name?uncap_first});
  
 </#if>
 </#list> 
 <#list searchableAttributes as attribute>
 <#if attribute.type != 'boolean' &&  attribute.type != 'Integer'>
  /**
   * Find by ${attribute.name?cap_first}.
   * @param ${attribute.name?uncap_first} search parameter.
   */ 
  List<${entity.name}${entity_suffix}> findBy${attribute.name?cap_first}(${attribute.type} ${attribute.name?uncap_first});
 </#if>
 </#list>
   <#assign myHash = { }>
   <#list entity.relations as relation>
     <#if !myHash[relation.model.name]??>
     <#if relation.multiplicity == 1>

  /**
   * Find ${entity.name}${entity_suffix} knowing the ${relation.model.name}.
   */
  @Query("select ${entity.name?lower_case} from ${relation.model.name}${entity_suffix} p inner join p.${relation.relationName} ${entity.name?lower_case} where p = :${relation.model.name?lower_case}")
  public ${entity.name}${entity_suffix} findBy${relation.model.name}${relation.relationName?cap_first}(@Param("${relation.model.name?lower_case}") ${relation.model.name}${entity_suffix} ${relation.model.name?lower_case});
     <#else>

  /**
   * Find ${entity.name}${entity_suffix} knowing the ${relation.model.name}.
   */
  @Query("select ${entity.name?lower_case} from ${relation.model.name}${entity_suffix} p inner join p.${relation.relationName} ${entity.name?lower_case} where p = :${relation.model.name?lower_case}")
  public Page<${entity.name}${entity_suffix}> findBy${relation.model.name}${relation.relationName?cap_first}(@Param("${relation.model.name?lower_case}") ${relation.model.name}${entity_suffix} ${relation.model.name?lower_case}, Pageable pageable);
     </#if>
    
     </#if>
   </#list>
   
  <#if entity.hasAnnotation("PUBLISH")> 
  /**
   * Should it return a page ???
   * Find  ${entity.name?lower_case} by publish flag.
   */
  List<${entity.name}${entity_suffix}> findByPublished(boolean published);

  /**
   * Set the publish flag.
   * @param published boolean value
   * @param name primary key of ${entity.name}${entity_suffix}
   * @return
   */
  @Transactional
  @Modifying
  @Query("update ${entity.name}${entity_suffix} e set e.published = ?1 where <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>e.${primaryAttribute.name} = ?${primaryAttribute?index+2}<#sep>,</#sep></#list>")
  int setFixedPublishedFor(boolean published, <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.type} ${primaryAttribute.name?uncap_first}<#sep>,</#sep></#list>);
  </#if>
  <#if entity.hasOneOfAnnotation(["SYNCH_SERVER"])>
  /**
   * Get the latest modified.
   */
  ${entity.name}Entity findFirstByOrderByModifiedDateDesc();
  
  /**
   * Get all the ${entity.name}Entity that has been updated after a date
   * @param date
   * @return
   */
  List<${entity.name}Entity> findByModifiedDateGreaterThan(Date date);
  
  </#if>
    
}