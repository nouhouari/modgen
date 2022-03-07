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

package ${package};

import ${entityPackage}.${entity.name}Entity;
<#list entity.attributes as attribute>
  <#if attribute.reference>
import ${entityPackage}.${attribute.type}Entity;
  </#if>
</#list>  

import java.util.Map;

/**
 * @author nhouari
 *
 */
public interface ${entity.name}ValidationListener {
  
  /**
   * Triggered after JSR_303 validation.
   * @param entity Entity to validate
   * @param errors Map of error to populate
   * @return Map of key and error
   */
  void onAfterValidation(${entity.name}Entity entity, Map<String, String> errors);
  
  <#list entity.attributes as attribute>
  <#if attribute.reference>
  /**
   * Trigger when we add a relation between a ${entity.name} and a ${attribute.name}
   * @param ${entity.name?uncap_first}Entity The ${entity.name?uncap_first}
   * @param ${attribute.type}Entity The ${attribute.name} of type ${attribute.type}
   * @param errors map of errors.
   */
  void onAdd${attribute.name?cap_first}Relation(${entity.name?cap_first}Entity ${entity.name?uncap_first}Entity, ${attribute.type?cap_first}Entity ${attribute.type?uncap_first}Entity, Map<String, String> errors);
  
  /**
   * Trigger when we remove a relation between a ${entity.name} and a ${attribute.name}
   * @param ${entity.name?uncap_first}Entity The ${entity.name?uncap_first}
   * @param ${attribute.type}Entity The  ${attribute.name} of type ${attribute.type}
   * @param errors map of errors.
   */
  void onRemove${attribute.name?cap_first}Relation(${entity.name?cap_first}Entity ${entity.name?uncap_first}Entity, ${attribute.type?cap_first}Entity ${attribute.type?uncap_first}Entity, Map<String, String> errors);
  
  </#if>
  </#list>

}
