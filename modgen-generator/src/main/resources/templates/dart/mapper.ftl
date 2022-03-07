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
 * [2021] Nourreddine HOUARI SA
 * All Rights Reserved.
 */
import 'package:enum_to_string/enum_to_string.dart';
import '../../model/dao/database.dart' as dao;
import '../../model/${entity.name?uncap_first}.dart' as dto;
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import '../../model/${attribute.type?lower_case}.dart';
</#if>
</#list>

class ${entity.name}Mapper {

  static dto.${entity.name} fromDAOToDto(dao.${entity.name}Data dao) {
    return dto.${entity.name}(
        <#list entity.attributes as attribute>
        <#if attribute.enumerate>
        ${attribute.name}: (dao.${attribute.name} != null)
            ? EnumToString.fromString(${attribute.type}.values, dao.${attribute.name}!)
            : null<#sep>,</#sep>
        <#elseif attribute.reference>
        // ${attribute.name} ${attribute.multiplicity}
        <#else>
        ${attribute.name}: dao.${attribute.name}<#sep>,</#sep>
        </#if>
        </#list>);
  }

  static dao.${entity.name}Data fromDtoToDAO(dto.${entity.name} dto) {
    return dao.${entity.name}Data(
      lastUpdateTimestamp: dto.modifiedDate!,
      <#if entity.hasAnnotation("SYNCH_CLIENT")>
      synchronized: false,
      </#if> 
      <#list entity.attributes as attribute>
        <#if attribute.enumerate>
        ${attribute.name}: (dto.${attribute.name} != null)
            ? EnumToString.convertToString(dto.${attribute.name}!)
            : null<#sep>,</#sep>
        <#elseif attribute.reference>
        // ${attribute.name} ${attribute.multiplicity}
        <#elseif attribute.type == 'Date'>
        ${attribute.name}: dto.${attribute.name}<#sep>,</#sep>
        <#else>
        ${attribute.name}: dto.${attribute.name}<#sep>,</#sep>   
        </#if>
      </#list>
    );
  }
}