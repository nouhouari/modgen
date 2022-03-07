<#macro underlinesToCamelCase inString><#local strArray = inString?split("_")><#list strArray as item><#if item?index == 0>${item}<#else>${item?cap_first}</#if></#list></#macro>
<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
<#assign hasGeometry=false>
<#list entity.attributes as attribute>
 <#if attribute.type=="String" && attribute.hasAnnotation("GEOMETRY")>
  <#assign hasGeometry=true>
  <#break>
 </#if>
</#list>
<#assign isExtendable=false>
<#if entity.hasAnnotation("EXTENDABLE")>
 <#assign isExtendable=true>
</#if>

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
 * Author   : Nourreddine HOUARI nourreddine.houari@
 *     Koneru, Venkaiah Chowdary VenkaiahChowdary.Koneru@ 
 *
 * Date     :  ${aDate?string.medium} 
 * 
 * File     :  ${entity.name?cap_first}EntityMapperImpl.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 
package ${package};

<#assign imports = [
"import java.util.ArrayList;",
"import java.util.Date;", 
"import java.util.List;",
"import org.springframework.beans.factory.annotation.Autowired;",
"import org.springframework.stereotype.Component;"]>

import ${protoPackage}.${entity.name?cap_first};
import ${protoPackage}.${entity.name?cap_first}.Builder;
import ${entityPackage}.${entity.name?cap_first}${entity_suffix};
<#list entity.relations as relation>
<#if relation.multiplicity=1>
<#elseif relation.oppositeMultiplicity=1>
import ${entityPackage}.${relation.model.name?cap_first}${entity_suffix};
<#else>
</#if>
</#list>
<#assign myHash = { }>
<#list entity.attributes as attribute>
  <#if attribute.reference && !myHash[attribute.type]??>
import ${entityPackage}.${attribute.model.name?cap_first}${entity_suffix};
<#assign myHash=myHash + { attribute.type: 0 }>
  </#if>
</#list>

import ${package}.GenericEntityProtoMapper;
<#assign myHash = { }>
<#list entity.attributes as attribute>
  <#if !myHash[attribute.type]??>
    <#if attribute.enumerate>
// ${attribute.name}  
import  ${entityPackage}.${attribute.type};
    </#if>
    <#if attribute.reference>
import ${protoPackage}.${attribute.type};
    </#if>
    <#assign myHash=myHash + { attribute.type: 0 }>
  </#if>
</#list>
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
<#if hasGeometry>
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
</#if>
<#if isExtendable>
import com.sicpa.ptf.extension.schema.support.common.ExtensionSchemaCache;
import com.sicpa.ptf.extension.schema.support.common.ExtensionsParser;
import java.util.Map;
import com.google.protobuf.Any;
import ${entityPackage}.Extensions;
</#if>

@Component("${entity.name?cap_first}EntityMapper")
public class ${entity.name?cap_first}EntityProtoMapperImpl implements GenericEntityProtoMapper<${entity.name?cap_first}, ${entity.name?cap_first}${entity_suffix}> {
 
  <#assign myHash = { }>
  <#list entity.relations as relation>
  <#if relation.multiplicity=1>
  <#elseif relation.oppositeMultiplicity=1>
  @Autowired
  private ${relation.model.name?cap_first}EntityProtoMapperImpl ${relation.model.name?uncap_first}EntityProtoMapper;

  <#else>
  </#if>
  </#list>

  <#if isExtendable>
  @Autowired
  private ExtensionSchemaCache extensionSchemaCache;
  </#if>

  <#list entity.attributes as attribute>
  <#if attribute.reference>
  <#if !myHash[attribute.model.name]??>
    <#assign myHash=myHash + { attribute.model.name: 0 }>
  @Autowired
  private ${attribute.model.name?cap_first}EntityProtoMapperImpl ${attribute.model.name?uncap_first}EntityMapper;
  
  /**
   * Get the ${attribute.model.name?uncap_first} transformer.
   * @return the ${attribute.model.name?uncap_first} mapper.
   */
  public ${attribute.model.name?cap_first}EntityProtoMapperImpl get${attribute.model.name?cap_first}EntityProtoMapper(){
    return ${attribute.model.name?uncap_first}EntityMapper;
  }
  </#if>
  </#if>
  </#list>
  <#if hasGeometry>
  private WKTReader wkt = new WKTReader();
  </#if>

  /**
   * {@inheritDoc}
   */
  @Override
  public void transformProtoToEntity(${entity.name?cap_first} proto, ${entity.name?cap_first}${entity_suffix} entity) {
    if (entity == null || proto == null) {
      return;
    }
  
    <#list entity.attributes as attribute>
    // ${attribute.type} ${attribute.name}
    <#if attribute.type=="String" && attribute.hasAnnotation("GEOMETRY")>
    if(proto.hasField(${entity.name?cap_first}.getDescriptor().findFieldByName("${attribute.name}"))){
      try {
        entity.set${attribute.name?cap_first}(wkt.read(proto.get${attribute.name?cap_first}()));
      } catch (ParseException e) {
        e.printStackTrace();
      }
    
    <#elseif attribute.reference>
    <#if attribute.multiplicity==1>
    if(proto.hasField(${entity.name?cap_first}.getDescriptor().findFieldByName("${attribute.name}"))){
    // One2One or Many2One (${attribute.name})
    if (proto.has${attribute.name?cap_first}()) {
      if (entity.get${attribute.name?cap_first}() == null){
        entity.set${attribute.name?cap_first}(new ${attribute.model.name?cap_first}${entity_suffix}());
      } 
      ${attribute.model.name?uncap_first}EntityMapper.transformProtoToEntity(proto.get${attribute.name?cap_first}(),entity.get${attribute.name?cap_first}());
    }
    
  <#else>
    if(proto.get${attribute.name?cap_first}Count() > 0) {
    // One2Many or Many2Many (${attribute.name})
    if (proto.get${attribute.name?cap_first}List() !=null){
      proto.get${attribute.name?cap_first}List().forEach(p -> {
        ${attribute.type}${entity_suffix} ${attribute.type?uncap_first}${entity_suffix} = new ${attribute.type}${entity_suffix}();
        ${attribute.model.name?uncap_first}EntityMapper.transformProtoToEntity(p, ${attribute.type?uncap_first}${entity_suffix});
        entity.add${attribute.name?cap_first}(${attribute.type?uncap_first}${entity_suffix});
      });
    }
 
  </#if>
    <#elseif attribute.enumerate>
    if(proto.hasField(${entity.name?cap_first}.getDescriptor().findFieldByName("${attribute.name}"))){
      entity.set${attribute.name?cap_first}(${attribute.type}.valueOf(proto.get${attribute.name?cap_first}().toString()));
    <#elseif attribute.type=="Date">
    if(proto.hasField(${entity.name?cap_first}.getDescriptor().findFieldByName("${attribute.name}"))){
      entity.set${attribute.name?cap_first}(new Date(proto.get${attribute.name?cap_first}()));
    <#else>
    if(proto.hasField(${entity.name?cap_first}.getDescriptor().findFieldByName("${attribute.name}"))){
      entity.set${attribute.name?cap_first}(proto.get${attribute.name?cap_first}());
    </#if>
    }
    </#list>

    <#list entity.relations as relation>
    <#if relation.multiplicity=1>
    <#elseif relation.oppositeMultiplicity=1>
    if (proto.has${relation.model.name?cap_first}${relation.relationName?cap_first}()) {
      ${relation.model.name?cap_first}${entity_suffix} ${relation.model.name?uncap_first}${entity_suffix} = new ${relation.model.name?cap_first}${entity_suffix}();
      this.${relation.model.name?uncap_first}EntityProtoMapper.transformProtoToEntity(proto.get${relation.model.name?cap_first}${relation.relationName?cap_first}(), ${relation.model.name?uncap_first}${entity_suffix});
      entity.set${relation.model.name?cap_first}_${relation.relationName?uncap_first}(${relation.model.name?uncap_first}${entity_suffix});
    }
    <#else>
    // IGNORING MANY TO MANY
    </#if>
    </#list>
    
    <#if isExtendable>
    // Convert extension fields
    entity.setSchemaFullyQualifiedName(proto.getSchemaFullyQualifiedName());
    Map<String, Object> extensions = ExtensionsParser.mapProtoToExtensions(proto.getExtensionFields(),
          extensionSchemaCache.getOrThrow(proto.getSchemaFullyQualifiedName()), proto.getSchemaFullyQualifiedName());
    entity.setExtensions(new Extensions(extensions));
    </#if>
    <#if entity.hasAnnotation("VERSIONABLE")>
    // Set the version
    entity.setVersion(proto.getVersion());
    </#if>
  }

  /**
   * {@inheritDoc}
   */
  @Override
  public ${entity.name?cap_first} transformEntityToProto(${entity.name?cap_first}${entity_suffix} entity) {
  
    Builder builder = ${entity.name?cap_first}.newBuilder();
  <#list entity.attributes as attribute>
  <#if attribute.type == "boolean">
    builder.set${attribute.name?cap_first}(entity.is${attribute.name?cap_first}());

  <#elseif attribute.type == "String" && attribute.hasAnnotation("GEOMETRY")>
    builder.set${attribute.name?cap_first}(entity.get${attribute.name?cap_first}().toText());

  <#elseif attribute.type=="Date">
    if (entity.get${attribute.name?cap_first}() != null) {
      builder.set${attribute.name?cap_first}(entity.get${attribute.name?cap_first}().getTime());
    }

  <#elseif attribute.reference>
    <#if attribute.multiplicity == 1>
    //One to One  
    if(entity.get${attribute.name?cap_first}() != null){
      ${attribute.model.name?cap_first} ${attribute.name?lower_case}  = ${attribute.model.name?uncap_first}EntityMapper.transformEntityToProto(entity.get${attribute.name?cap_first}());
      builder.set${attribute.name?cap_first}(${attribute.name?lower_case});
    }

    <#else>
    //One to Many (${attribute.name?lower_case})
    //NOTHING TO DO. Not fetching all  the children here  

    </#if>
    <#elseif attribute.enumerate>
    if (entity.get${attribute.name?cap_first}() != null) {
      builder.set${attribute.name?cap_first}(${protoPackage}.${attribute.type}.valueOf(entity.get${attribute.name?cap_first}().toString()));
    }

    <#else>
    <#if attribute.type == 'int' || attribute.type == 'long' || attribute.type == 'float' || attribute.type == 'double'>
    builder.set${attribute.name?cap_first}(entity.get${attribute.name?cap_first}());

    <#else>
    if (entity.get${attribute.name?cap_first}() != null) {
      builder.set${attribute.name?cap_first}(entity.get${attribute.name?cap_first}());
    }

    </#if>
    </#if>
    </#list>
    <#list entity.relations as relation>
    <#if relation.multiplicity=1>
    <#elseif relation.oppositeMultiplicity=1>
    if (entity.get${relation.model.name?cap_first}_${relation.relationName?uncap_first}() != null) {
      builder.set${relation.model.name?cap_first}${relation.relationName?cap_first}(this.${relation.model.name?uncap_first}EntityProtoMapper.transformEntityToProto(entity.get${relation.model.name?cap_first}_${relation.relationName?uncap_first}()));
    }

    <#else>
    </#if>
    </#list>
    <#if entity.hasAnnotation("AUDIT_AWARE")>
    // Audit data
    if (entity.getCreatedBy() != null){
      builder.setCreatedBy(entity.getCreatedBy());
    }

    if (entity.getCreatedDate() != null){
      builder.setCreatedDate(entity.getCreatedDate().getTime());
    }

    if (entity.getModifiedBy() != null){
      builder.setModifiedBy(entity.getModifiedBy());
    }

    if (entity.getModifiedDate() != null){
      builder.setModifiedDate(entity.getModifiedDate().getTime());
    }

    </#if>
    
    <#if isExtendable>
    // Convert extension to protobuf
    Any extensions = ExtensionsParser.mapExtensionsToProto(
    	entity.getExtensions().getValues(),
        extensionSchemaCache.getOrThrow(entity.getSchemaFullyQualifiedName()),
        entity.getSchemaFullyQualifiedName());
    builder.setSchemaFullyQualifiedName(entity.getSchemaFullyQualifiedName());
    builder.setExtensionFields(extensions);   
    </#if>
    <#if entity.hasAnnotation("VERSIONABLE")>
    //Set the version
    builder.setVersion(entity.getVersion());
	</#if>
    return builder.build();
  }
}