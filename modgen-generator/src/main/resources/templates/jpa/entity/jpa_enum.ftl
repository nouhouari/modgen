<#macro underlinesToCamelCase inString><#local strArray = inString?split("_")><#list strArray as item><#if item?index == 0>${item}<#else>${item?cap_first}</#if></#list></#macro>
<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@sicpa.com> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	${entity.name?cap_first}.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
package ${package};

public enum ${entity.name} {
    <#list entity.attributes as attribute>
    ${attribute.name}<#if attribute_has_next>,<#else>;</#if>
    </#list>
}