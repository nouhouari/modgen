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

import ${protoPackage}.${entity.name?cap_first};
import ${protoPackage}.${entity.name?cap_first}.Builder;
import ${dtoPackage}.${entity.name?cap_first}DTO;

<#list entity.attributes as attribute>
  <#if attribute.reference && attribute.multiplicity=-1>
import ${protoPackage}.${attribute.model.name?cap_first};
  </#if>
</#list>

import ${package}.GenericProtoDTOTransformer;
<#list entity.attributes as attribute>
<#if attribute.reference>
<#if attribute.multiplicity==1>
import ${dtoPackage}.${attribute.type}DTO;
import ${protoPackage}.${attribute.type};
</#if>
</#if>
</#list>
<#list entity.relations as relation>
import ${dtoPackage}.${relation.model.name?cap_first}DTO;
import ${protoPackage}.${relation.model.name?cap_first};
</#list>
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
<#if hasGeometry>
import com.vividsolutions.jts.io.ParseException;
import com.vividsolutions.jts.io.WKTReader;
</#if>
<#if isExtendable>
import com.sicpa.ptf.extension.schema.support.common.ExtensionSchemaCache;
import com.sicpa.ptf.extension.schema.support.common.ExtensionsParser;
import com.google.protobuf.Any;
</#if>

@Component("${entity.name?cap_first}ProtoMapper")
public class ${entity.name?cap_first}DTOProtoMapperImpl implements GenericProtoDTOTransformer<${entity.name?cap_first}DTO, ${entity.name?cap_first}> {
 
  <#assign myHash = { }>
  <#list entity.attributes as attribute>
  <#if attribute.reference>
  <#if !myHash[attribute.model.name]??>
    <#assign myHash=myHash + { attribute.model.name: 0 }>
  @Autowired
  private ${attribute.model.name?cap_first}DTOProtoMapperImpl ${attribute.model.name?uncap_first}ProtoMapper;
  
  </#if>
  </#if>
  </#list>
  <#assign myHash = { }>
  <#list entity.relations as relation>
  <#if !myHash[relation.model.name]??>
    <#assign myHash=myHash + { relation.model.name: 0 }>
  @Autowired
  private ${relation.model.name?cap_first}DTOProtoMapperImpl ${relation.model.name?uncap_first}ProtoMapper;
  </#if>
  </#list>
  <#if hasGeometry>
 
  private WKTReader wkt = new WKTReader();
  </#if>

  <#if isExtendable>
  @Autowired
  private ExtensionSchemaCache extensionSchemaCache;
  </#if>

  @Override
  public void transformProtoToDto(${entity.name?cap_first} proto, ${entity.name?cap_first}DTO dto) {
    if (dto == null || proto == null) {
      return;
    }
  
    <#list entity.attributes as attribute>
    <#if attribute.type=="String" && attribute.hasAnnotation("GEOMETRY")>
    try {
      dto.set${attribute.name?cap_first}(wkt.read(proto.get${attribute.name?cap_first}()));
    } catch (ParseException e) {
      e.printStackTrace();
    }
    <#elseif attribute.reference>
    <#if attribute.multiplicity==1>
  
    // One2One or Many2One (${attribute.name})
    if (proto.has${attribute.name?cap_first}()) {
      if (dto.get${attribute.name?cap_first}() == null){
        dto.set${attribute.name?cap_first}(new ${attribute.type?cap_first}DTO());
      } 
      ${attribute.model.name?uncap_first}ProtoMapper.transformProtoToDto(proto.get${attribute.name?cap_first}(),dto.get${attribute.name?cap_first}());
    }
  <#else>
  
    // One2Many of Many2Many (${attribute.name})
    //NOTHING TO DO
  </#if>
    <#elseif attribute.enumerate>
    dto.set${attribute.name?cap_first}(${dtoPackage}.${attribute.type}.valueOf(proto.get${attribute.name?cap_first}().toString()));
    <#elseif attribute.type=="Date">
    dto.set${attribute.name?cap_first}(new Date(proto.get${attribute.name?cap_first}()));
    <#else>
    dto.set${attribute.name?cap_first}(proto.get${attribute.name?cap_first}());
    </#if> 
    </#list>

    <#list entity.relations as relation>
    <#if relation.multiplicity=1>
    <#elseif relation.oppositeMultiplicity=1>
    if (proto.has${relation.model.name?cap_first}${relation.relationName?cap_first}()) {
      ${relation.model.name?cap_first}DTO ${relation.model.name?uncap_first}DTO = new ${relation.model.name?cap_first}DTO();
      ${relation.model.name?uncap_first}ProtoMapper.transformProtoToDto(proto.get${relation.model.name?cap_first}${relation.relationName?cap_first}(), ${relation.model.name?uncap_first}DTO);
      dto.set${relation.model.name?cap_first}_${relation.relationName?uncap_first}(${relation.model.name?uncap_first}DTO);
    }

    <#else>
    
     // IGNORE *toMany relations
     // if(proto.get${relation.model.name?cap_first}${relation.relationName?cap_first}Count() > 0) {
     //   List<${relation.model.name}DTO> list = new ArrayList<>();
     //   proto.get${relation.model.name?cap_first}${relation.relationName?cap_first}List().forEach(p -> {
     //   ${relation.model.name}DTO ${relation.model.name?uncap_first}_${relation.relationName?uncap_first} = new ${relation.model.name}DTO();
     //     ${relation.model.name?uncap_first}ProtoMapper.transformProtoToDto(p, ${relation.model.name?uncap_first}_${relation.relationName?uncap_first});
     //     list.add(${relation.model.name?uncap_first}_${relation.relationName?uncap_first});
     //   });
     //   dto.set${relation.model.name?cap_first}_${relation.relationName?uncap_first}(list);
     // }
    </#if>
    </#list>

    <#if entity.hasAnnotation("AUDIT_AWARE")>
    // Creation user
    dto.setCreatedBy(proto.getCreatedBy());
    // Creation date
    dto.setCreatedDate(new Date(proto.getCreatedDate()));
    // Last modification user
    dto.setModifiedBy(proto.getModifiedBy());
    // Last modification date
    dto.setModifiedDate(new Date(proto.getModifiedDate()));
    </#if>
    <#if isExtendable>
    // Extension schema name
    dto.setSchemaFullyQualifiedName(proto.getSchemaFullyQualifiedName());
    // Extension data
    Map<String, Object> extensions = ExtensionsParser.mapProtoToExtensions(proto.getExtensionFields(),
          extensionSchemaCache.getOrThrow(proto.getSchemaFullyQualifiedName()), proto.getSchemaFullyQualifiedName());
    dto.setExtensions(extensions);
	</#if>
	<#if entity.hasAnnotation("VERSIONABLE")>
    // Set the version
    dto.setVersion(proto.getVersion());
    </#if>
  }
 
  @Override
  public ${entity.name?cap_first} transformDtoToProto(${entity.name?cap_first}DTO dto) {
  
    Builder builder = ${entity.name?cap_first}.newBuilder();
  <#list entity.attributes as attribute>
  <#if attribute.type == "boolean">
    builder.set${attribute.name?cap_first}(dto.is${attribute.name?cap_first}());

  <#elseif attribute.type == "String" && attribute.hasAnnotation("GEOMETRY")>
    builder.set${attribute.name?cap_first}(dto.get${attribute.name?cap_first}().toText());

  <#elseif attribute.type=="Date">
    if (dto.get${attribute.name?cap_first}() != null) {
      builder.set${attribute.name?cap_first}(dto.get${attribute.name?cap_first}().getTime());
    }

  <#elseif attribute.reference>
    <#if attribute.multiplicity == 1>
    //One to One  
    if(dto.get${attribute.name?cap_first}() != null){
      ${attribute.type} ${attribute.name} = ${attribute.model.name?uncap_first}ProtoMapper.transformDtoToProto(dto.get${attribute.name?cap_first}());
      builder.set${attribute.name?cap_first}(${attribute.name});
    }

    <#else>
    //One to Many (${attribute.name?lower_case})
     if (dto.get${attribute.name?cap_first}() != null){
      dto.get${attribute.name?cap_first}().forEach(p -> {
        ${attribute.model.name} ${attribute.model.name?uncap_first} = this.${attribute.model.name?uncap_first}ProtoMapper.transformDtoToProto(p);
        builder.add${attribute.name?cap_first}(${attribute.model.name?uncap_first});
      });
    }

    </#if>
     <#elseif attribute.enumerate>
    if (dto.get${attribute.name?cap_first}() != null){ 
      builder.set${attribute.name?cap_first}(${protoPackage}.${attribute.type}.valueOf(dto.get${attribute.name?cap_first}().toString()));
    }

     <#elseif attribute.type == "String">
    if(dto.get${attribute.name?cap_first}() != null) {
      builder.set${attribute.name?cap_first}(dto.get${attribute.name?cap_first}());
    }

     <#else>
    builder.set${attribute.name?cap_first}(dto.get${attribute.name?cap_first}());

  </#if>
  </#list>

    <#list entity.relations as relation>
    <#if relation.multiplicity=1>
    <#elseif relation.oppositeMultiplicity=1>
    if(dto.get${relation.model.name?cap_first}_${relation.relationName?uncap_first}() != null) {
        builder.set${relation.model.name?cap_first}${relation.relationName?cap_first}(this.${relation.model.name?uncap_first}ProtoMapper.transformDtoToProto(dto.get${relation.model.name?cap_first}_${relation.relationName?uncap_first}()));
    }

    <#else>
    // NOT HANDLING MANY TO MANY HERE
    </#if>
    </#list>
    <#if isExtendable>
    // Schema extension name
    builder.setSchemaFullyQualifiedName(dto.getSchemaFullyQualifiedName());
    // Extension values
    Any extensions = ExtensionsParser.mapExtensionsToProto(
        dto.getExtensions(),
        extensionSchemaCache.getOrThrow(dto.getSchemaFullyQualifiedName()),
        dto.getSchemaFullyQualifiedName());

    System.out.println("Extension dto : " + dto.getExtensions());
    System.out.println("Values : " + extensions);
    builder.setExtensionFields(extensions);

    </#if>
    <#if entity.hasAnnotation("VERSIONABLE")>
    //Set the version
    builder.setVersion(dto.getVersion());
    </#if>

    ${entity.name?cap_first} ${entity.name?lower_case} = builder.build();
    return ${entity.name?lower_case};
  }
}