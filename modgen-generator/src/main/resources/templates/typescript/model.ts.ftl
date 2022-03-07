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

<#assign myHash = { }>
<#list entity.attributes as attribute>
<#if !myHash[attribute.type]??>
<#if attribute.enumerate>
import { ${attribute.type} } from '../../shared/${attribute.type?lower_case}.model';
<#elseif attribute.reference && (attribute.multiplicity=-1 || (attribute.multiplicity==1 && attribute.oppositeMultiplicity==1) || (attribute.multiplicity==1 && attribute.oppositeMultiplicity==-1))>
import { ${attribute.type} } from '../../${attribute.type?lower_case}s/shared/${attribute.type?lower_case}.model';
</#if>
<#assign myHash=myHash + { attribute.type: 0 }>
</#if>
</#list>
<#if entity.hasAnnotation("EXTENDABLE")>
</#if>
import { Error } from '../../shared/error.model';

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
   <#else>
  // ${attribute.name?cap_first} field
  public ${attribute.name}: ${attribute.type};
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
  <#if entity.hasAnnotation("VERSIONABLE")>
  // Version
  public version: number;
  </#if>
  <#if entity.hasAnnotation("EXTENDABLE")>
  // Extension fields
  public extensions: any;
  // Extension schema
  public schemaFullyQualifiedName: String;
  </#if>

  /**
   * ${entity.name} model constructor.
   */
  constructor(data: any= {}) {
    if (data) {
      <#list entity.attributes as attribute>
      <#if attribute.reference>
      <#if attribute.multiplicity==1 && attribute.oppositeMultiplicity==1>
      this.${attribute.name} = new ${attribute.type?cap_first}(data.${attribute.name});
      <#elseif attribute.multiplicity==1 && attribute.oppositeMultiplicity==-1>
      this.${attribute.name} = new ${attribute.type?cap_first}(data.${attribute.name});
      <#elseif attribute.multiplicity==-1>
      if (data.${attribute.name}) {
        data.${attribute.name}.forEach((element: any) => {
          this.${attribute.name}.push(new ${attribute.type?cap_first}(element));
       });
      }
      </#if>
      <#else>
      <#if attribute.type="Date">
      this.${attribute.name} = data.${attribute.name} ? new Date(data.${attribute.name}) : null;
      <#elseif attribute.reference>
      this.${attribute.name} = data.${attribute.name} ? new ${attribute.type?cap_first}(data.${attribute.name}) : null;
      <#else>
      this.${attribute.name} = data.${attribute.name} ? data.${attribute.name} : '';
      </#if>
      </#if>
      </#list>
      <#if entity.hasAnnotation("AUDIT_AWARE")>
      // Create by user
      this.createdBy = data.createdBy ? data.createdBy  : null;
      // Created date
      this.createdDate = data.createdDate ? new Date(data.createdDate) : null;
      // Last modification user
      this.modifiedBy = data.modifiedBy ? data.modifiedBy : null;
      // Last modification date
      this.modifiedDate = data.modifiedDate ? new Date(data.modifiedDate) : null;
      </#if>
      <#if entity.hasAnnotation("VERSIONABLE")>
      // Object version
      this.version = data.version ? data.version : '';
      </#if>
      <#if entity.hasAnnotation("EXTENDABLE")>
      // Extension
      this.schemaFullyQualifiedName = data.schemaFullyQualifiedName ? data.schemaFullyQualifiedName : '';
      // Schema name
      this.extensions = data.extensions ? data.extensions : '';
     </#if>
   }
  }
}

/**
 * ${entity.name} page result.
 */
export class ${entity.name}PageResult {
  /**
   * Total amount of elements.
   */
  public totalElements: number;
  /**
   * Number of current page.
   */
  public number: number;
  /**
   * Number of element in the current page.
   */
  public numberOfElements: number;
  /**
   * Page size.
   */
  public size: number;
  /**
   * Total number of pages.
   */
  public totalPages: number;
  /**
   * List of item in the current page.
   */
  public list: ${entity.name}[] = [];

  /**
   * ${entity.name} page constructor.
   */
  constructor(data: any) {
    this.totalElements = data.totalElements ? data.totalElements : 0;
    this.number = data.number ? data.number : 0;
    this.numberOfElements = data.numberOfElements ? data.numberOfElements : 0;
    this.size = data.size ? data.size : 0;
    this.totalPages = data.totalPages ? data.totalPages : 0;

    if (data.list) {
      for (let s of data.list) {
        this.list.push(new ${entity.name}(s));
      }
    }
  }
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
  <#list entity.relations as relation>
  <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
  public ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}: string;
  </#list>
  </#list>

  <#list searchableAttributes as attribute>
  <#if attribute.type=="number" || attribute.type=="Date">
  public from${attribute.name?cap_first}: ${attribute.type};
  public to${attribute.name?cap_first}: ${attribute.type};
  <#elseif attribute.type = "String" && attribute.location>
  public ${attribute.name?lower_case}Distance: ${attribute.type};
  </#if>
  public ${attribute.name}: ${attribute.type};
  </#list>
  <#list entity.attributes as attribute>
  <#if attribute.reference>
  <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
  public ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}: ${primaryAttribute.type};
  </#list>
  </#if>
  </#list>


   public read(data: any): void {
    this.page = data.page ? data.page : this.page;
    this.size = data.size ? data.size : this.size;
    this.sort = data.sort ? data.sort : [];
    this.quickSearchQuery = data.quickSearchQuery ? data.quickSearchQuery : null;
    <#if entity.hasAnnotation("AUDIT_AWARE")>
    // Create by user
    this.createdBy = data.createdBy ? data.createdBy : null;
    // Created date
    this.createdDate = data.createdDate ? data.createdDate : null;
    this.fromCreatedDate = data.fromCreatedDate ? data.fromCreatedDate : null;
    this.toCreatedDate = data.toCreatedDate ? data.toCreatedDate : null;
    // Last modification user
    this.modifiedBy = data.modifiedBy ? data.modifiedBy : null;
    // Last modification date
    this.modifiedDate = data.modifiedDate ? data.modifiedDate : null;
    this.fromModifiedDate = data.fromModifiedDate ? data.fromModifiedDate : null;
    this.toModifiedDate = data.toModifiedDate ? data.toModifiedDate : null;
    </#if> 
    <#list searchableAttributes as attribute>
    <#if attribute.type="number">
    this.from${attribute.name?cap_first} = data.from${attribute.name?cap_first} ? data.from${attribute.name?cap_first} : null;
    this.to${attribute.name?cap_first} = data.to${attribute.name?cap_first} ? data.to${attribute.name?cap_first} : null;
    <#elseif attribute.type="Date">
    this.from${attribute.name?cap_first} = data.from${attribute.name?cap_first} ? new Date(data.from${attribute.name?cap_first}) : null;
    this.to${attribute.name?cap_first} = data.to${attribute.name?cap_first} ? new Date(data.to${attribute.name?cap_first}) : null;
    </#if>
    <#if attribute.type="Date">
    this.${attribute.name} = data.${attribute.name} ? new Date(data.${attribute.name}) : null;
    <#else>
    this.${attribute.name} = data.${attribute.name} ? data.${attribute.name} : null;
    </#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} = data.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} ? data.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} : null;
    </#list>
    </#list>
    <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${attribute.name?uncap_first}${primaryAttribute.name?cap_first} = data.${attribute.name?uncap_first}${primaryAttribute.name?cap_first} ? data.${attribute.name?uncap_first}${primaryAttribute.name?cap_first} : null;
    </#list>
    </#if>
    </#list>
  }

  public clear(): void {
  <#if searchableAttributes?size=0>
    /* tslint:disable:no-empty */
  </#if>
  <#list searchableAttributes as attribute>
   <#if attribute.type="number" || attribute.type="Date">
    this.from${attribute.name?cap_first} = null;
    this.to${attribute.name?cap_first} = null;
   </#if>
    this.${attribute.name} = null;
   </#list>
   <#list entity.relations as relation>
   <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} = null;
   </#list>
   </#list> 
  }
}

/**
 * ${entity.name}SaveResult model.
 */
export class ${entity.name}SaveResult {
    public status: string;
    public entity: ${entity.name};
    public errors: Error[] = [];

    /**
     * ${entity.name}SaveResult page constructor.
     */
    constructor(data: any) {
      this.status = data.status ? data.status : 'SUCCESS';
      this.entity = data.dto ? data.dto : null;

      if (data.errors && data.status !== 'SUCCESS') {
        Object.keys(data.errors).forEach(key => {
            this.errors.push(new Error(key, data.errors[key]));
        });
      }
    }
}
