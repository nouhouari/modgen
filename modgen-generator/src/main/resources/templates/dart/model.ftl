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
<#function convertJavaToDartype type>
   <#if type == "String">
    <#return "String">
   <#elseif type == "Date">
    <#return "DateTime">
   <#elseif type == "Byte">
    <#return "int">
   <#elseif type == "Short">
    <#return "int">
   <#elseif type == "Integer">
    <#return "int">
   <#elseif type == "Long">
    <#return "int">
   <#elseif type == "Float">
    <#return "double">
   <#elseif type == "Double">
    <#return "double">
   <#elseif type == "Boolean" || type == "boolean">
    <#return "bool">
   <#elseif type == "Character">
    <#return "String">
   <#else>
    <#return type> 
   </#if>
  <#return "">
</#function> 

import 'package:enum_to_string/enum_to_string.dart'; 
<#if entity.hasAnnotation("EXTENDABLE")>
import 'common/extension.dart';
</#if>
<#list entity.attributes as attribute>
<#if attribute.reference || attribute.enumerate>
import '${attribute.type?lower_case}.dart';
</#if>
</#list>

class ${entity.name} {
  <#list entity.attributes as attribute>
  <#if attribute.multiplicity==-1>
  List<${convertJavaToDartype(attribute.type)}>? ${attribute.name};
  <#elseif attribute.type == 'String' && attribute.hasAnnotation('LOCATION')>
  Map<String, dynamic>?  ${attribute.name};
  <#else>
  ${convertJavaToDartype(attribute.type)}? ${attribute.name};
  </#if>
  </#list>	
  <#if entity.hasAnnotation("EXTENDABLE")>
  Extension? extension;
  </#if>
  <#if entity.hasOneOfAnnotation(["SYNCH_SERVER", "SYNCH_CLIENT"])>
  int? modifiedDate; 
  </#if>
  

  ${entity.name}(
      {
      <#if entity.hasOneOfAnnotation(["SYNCH_SERVER", "SYNCH_CLIENT"])>
      this.modifiedDate,
      </#if>
      <#list entity.attributes as attribute>
      this.${attribute.name}<#sep>,</#sep>
      </#list>
      <#if entity.hasAnnotation("EXTENDABLE")>
      ,this.extension
      </#if>
      });

  ${entity.name}.fromJson(Map<String, dynamic> json) {
    <#list entity.attributes as attribute>
     <#if attribute.reference>
       <#if attribute.multiplicity == -1>
      this.${attribute.name} = json["${attribute.name}"] == null
        ? null
        : (json["${attribute.name}"] as List)
            .map((e) => ${attribute.type}.fromJson(e))
            .toList();
       <#elseif attribute.oppositeMultiplicity==1>
      if (json["${attribute.name}"] != null) {
        this.${attribute.name} = ${attribute.type}.fromJson(json["${attribute.name}"]);
      }
      </#if>
      <#elseif attribute.type == 'Date'>
      if (json["${attribute.name}"] != null){
        this.${attribute.name} = DateTime.parse(json["${attribute.name}"]);
      }
      <#elseif attribute.enumerate>
      if (json["${attribute.name}"] != null) {
        this.${attribute.name} = EnumToString.fromString(${attribute.type}.values, json["${attribute.name}"]);  
      }  
      <#else>
      this.${attribute.name} = json["${attribute.name}"];
      </#if>
      </#list>
      <#if entity.hasAnnotation("EXTENDABLE")>
      this.extension = json["extension"] == null
        ? null
        : Extension.fromJson(json["extension"]);
      </#if>
      <#if entity.hasOneOfAnnotation(["SYNCH_SERVER", "SYNCH_CLIENT"])>
      this.modifiedDate = DateTime.parse(json["modifiedDate"]).millisecondsSinceEpoch;
      </#if>
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    <#list entity.attributes as attribute>
    <#if attribute.reference>
     <#if attribute.multiplicity == -1>
     if (this.${attribute.name} != null){
      data["${attribute.name}"] = this.${attribute.name}?.map((e) => e.toJson()).toList();
     }
     <#elseif attribute.oppositeMultiplicity == 1>
     data["${attribute.name}"] = this.${attribute.name}?.toJson();
     </#if> 
     <#elseif attribute.type == 'Date'>
     if (this.${attribute.name} != null){
       data["${attribute.name}"] = ${attribute.name}?.toIso8601String();
     } 
     <#elseif attribute.enumerate>
     if (this.${attribute.name} != null){
       data["${attribute.name}"] = EnumToString.convertToString(this.${attribute.name});
     }  
     <#else>
     data["${attribute.name}"] = this.${attribute.name};
     </#if>
    </#list>
    <#if entity.hasAnnotation("EXTENDABLE")>
     if (this.extension != null) data["extension"] = this.extension?.toJson();
    </#if>
    <#if entity.hasOneOfAnnotation(["SYNCH_SERVER"])>
     data["modifiedDate"] = this.modifiedDate;
    </#if>
    
    return data;
  }
  
  @override
  String toString() =>
      '${entity.name}{<#list entity.attributes as attribute>${r"$"}{' ${attribute.name}: ${r"$"}${attribute.name},'}</#list>}';
  
}