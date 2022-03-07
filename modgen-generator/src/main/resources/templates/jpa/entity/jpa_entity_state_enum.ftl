<#macro underlinesToCamelCase inString><#local strArray = inString?split("_")><#list strArray as item><#if item?index == 0>${item}<#else>${item?cap_first}</#if></#list></#macro>
<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	EntityState.java
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
package ${package};

public enum EntityState {
    ANONYMOUS, NEW, UPDATE
}