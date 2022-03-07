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
<#list entity.attributes as attribute>
<#if attribute.reference>
import { ${attribute.type?cap_first} } from './${attribute.type?lower_case}.model';
</#if>
<#if attribute.enumerate>
import { ${attribute.type?cap_first} } from './${attribute.type?lower_case}.enum';
</#if>
</#list>
import { HttpParams } from '@angular/common/http';
<#list entity.attributes as attribute>
<#if attribute.hasAnnotation("LOCATION")>
import * as geojson from 'geojson';
<#break>
</#if>
</#list>


<#if entity.type == "CLASS">
/**
 * ${entity.name} model.
 */
export class ${entity.name} {

  <#list entity.attributes as attribute>
  <#if attribute.reference>
  <#if attribute.multiplicity==-1>
   // ${attribute.name?cap_first} field
   public ${attribute.name}: ${attribute.type}[] = [];
  <#elseif attribute.multiplicity==1 && attribute.oppositeMultiplicity==1>
   // ${attribute.name?cap_first} field
   public ${attribute.name}: ${attribute.type};
  <#elseif attribute.multiplicity==1 && attribute.oppositeMultiplicity==-1>
   // ${attribute.name?cap_first} field
   public ${attribute.name}: ${attribute.type};
  </#if>
  <#elseif attribute.hasAnnotation("LOCATION")>
  public ${attribute.name}: geojson.Point;
  <#else>
   // ${attribute.name?cap_first} field
   public ${attribute.name}: ${attribute.type};
  </#if>
  </#list>
  <#list entity.relations as relation>
  <#if relation.multiplicity=1>
  <#elseif relation.oppositeMultiplicity=1>
   //public ${relation.model.name?uncap_first}_${relation.relationName?uncap_first}: ${relation.model.name};

  <#else>
   //public ${relation.model.name?uncap_first}_${relation.relationName?uncap_first}: ${relation.model.name}[] = [];
  </#if>
  </#list>
  <#if entity.hasAnnotation("AUDIT_AWARE")>
   // Create by user
    public createdBy: string;
   // Created date
   public createdDate: Date;
    // Last modification user
   public modifiedBy: string;
   // Last modification date
   public modifiedDate: Date;
   </#if>
   // Version
   public version: number;
   <#if entity.hasAnnotation("EXTENDABLE")>
   // Extension
   public extension: any;
   </#if>
 }

 /**
  * ${entity.name} search parameters.
  */
 export class ${entity.name}SearchCriteria {

  public page: number;
  public size: number;
  public sort: string[];
  public quickSearchQuery: string;
  <#if entity.hasAnnotation("AUDIT_AWARE")>
  // Create by user
  public createdBy: string;
  // Created date
  public createdDate: Date;
  public fromCreatedDate: Date;
  public toCreatedDate: Date;
  // Last modification user
  public modifiedBy: string;
  // Last modification date
  public modifiedDate: Date;
  public fromModifiedDate: Date;
  public toModifiedDate: Date;
  </#if>
  <#list entity.attributes as attribute>
  <#if attribute.reference>
  public ${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first}: ${attribute.model.primaryAttribute.type};
  </#if>
  </#list>

  <#list entity.getAttributesByAnnotation("QUERY") as attribute>
  <#if attribute.type=="number" || attribute.type=="Date">
  public from${attribute.name?cap_first}: ${attribute.type};
  public to${attribute.name?cap_first}: ${attribute.type};
  <#elseif attribute.type = "String" && attribute.location>
  public ${attribute.name?lower_case}Distance: ${attribute.type};
  </#if>
  public ${attribute.name}: ${attribute.type};
  </#list>

  public clear(): void {
  <#if entity.getAttributesByAnnotation("QUERY")?size=0>
    /* tslint:disable:no-empty */
  </#if>
  <#list entity.getAttributesByAnnotation("QUERY") as attribute>
   <#if attribute.type="number" || attribute.type="Date">
    this.from${attribute.name?cap_first} = null;
    this.to${attribute.name?cap_first} = null;
   </#if>
    this.${attribute.name} = null;
   </#list> 
  }
  
  /**
   * Convert criteria to HTTP params
   */
  public static toParams(criteria: ${entity.name}SearchCriteria): HttpParams {
    let params:HttpParams = new HttpParams();
    if (criteria.page){
      params = params.append('page', criteria.page.toString());
    }
    if (criteria.size){
      params = params.append('size', criteria.size.toString());
    }
    if (criteria.quickSearchQuery){
      params = params.set('quickSearchQuery', criteria.quickSearchQuery);
    }
    if (criteria.sort?.length > 0){
      params = params.set('sort', criteria.sort?.reduce((a,b)=> a+ "," + b));
    }
    <#list entity.getAttributesByAnnotation("QUERY") as attribute>
    // ${attribute.name} search field
    <#if attribute.type=="number" || attribute.type=="Date">
    if (criteria.from${attribute.name?cap_first}){
      params = params.set('from${attribute.name?cap_first}', criteria.from${attribute.name?cap_first}?.toString());
    }
    if (criteria.to${attribute.name?cap_first}){
	  params = params.set('to${attribute.name?cap_first}', criteria.to${attribute.name?cap_first}?.toString());
    }
    if (criteria.${attribute.name}){
      params = params.set('${attribute.name}', criteria.${attribute.name}?.toString());
    }
    <#elseif attribute.type= "boolean">
    if (criteria.${attribute.name}){
      params = params.set('${attribute.name}', String(criteria.${attribute.name}));
    }
    <#elseif attribute.type = "String" && attribute.location>
    if (criteria.${attribute.name?lower_case}Distance){
      params = params.set('${attribute.name?lower_case}Distance','');
    }
    <#elseif attribute.enumerate>
    if (criteria.${attribute.name}){
      params = params.set('${attribute.name}', criteria.${attribute.name}.toString());
    }
    <#else>
    if (criteria.${attribute.name}){
      params = params.set('${attribute.name}', criteria.${attribute.name});
    }  
    </#if>
      
    </#list>
    <#list entity.attributes as attribute>
    <#if attribute.reference>
    if (criteria.${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first}){
      params = params.set('${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first}', criteria.${attribute.model.name?uncap_first}${attribute.model.primaryAttribute.name?cap_first});
    }
    </#if>
    </#list>
    return params;
  }
}
</#if>
