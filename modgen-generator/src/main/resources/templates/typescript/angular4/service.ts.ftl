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

import {
    ${entity.name},
    ${entity.name}SearchCriteria} from '../../../models/${entity.name?lower_case}.model';

import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Page } from '../../../models/page.model';


@Injectable()
export class ${entity.name}Service {

  /**
   * Build new ${entity.name}Service.
   * @constructor
   */
  constructor(private http: HttpClient) {}

  /**
   * Get the ${entity.name} by its key.
   */
  public get${entity.name}ById(id: any): Observable<${entity.name}> {
    return this.http.get<${entity.name}>('api/${entity.name?lower_case}/' + id);
  }

  /**
   * Save ${entity.name}.
   */
  public save(new${entity.name}: ${entity.name}): Observable<${entity.name}> {
    return this.http.post<${entity.name}>('api/${entity.name?lower_case}/', new${entity.name});
  }

  /**
   * Save ${entity.name} list.
   */
  public saveBulk(new${entity.name}s: ${entity.name}[]): Observable<${entity.name}[]> {
    return this.http.post<${entity.name}[]>('api/${entity.name?lower_case}/saveBulk', new${entity.name}s);
  }

  /**
   * Find ${entity.name} with search criteria.
   * @return a paginated result of ${entity.name}.
   */
  public find(criteria?: ${entity.name}SearchCriteria): Observable<Page<${entity.name}>> {
   return this.http.get<Page<${entity.name}>>('api/${entity.name?lower_case}/search', {params: ${entity.name}SearchCriteria.toParams(criteria)});
  }

  /**
   * QuickSearch ${entity.name} with search criteria.
   * @return a paginated result of ${entity.name}.
   */
  public quickSearch(criteria?: ${entity.name}SearchCriteria): Observable<Page<${entity.name}>> {
   return this.http.get<Page<${entity.name}>>('api/${entity.name?lower_case}/quicksearch', {params: ${entity.name}SearchCriteria.toParams(criteria)});
  }

  /**
   * Delete ${entity.name}.
   */
  public delete${entity.name}ById(id: any): Observable<void> {
    return this.http.delete<void>('api/${entity.name?lower_case}/' + id);
  }

  <#list entity.attributes as attribute>
   <#if attribute.reference> 
    <#if attribute.multiplicity=1> 
  /**
   * Set OneToOne relation with ${attribute.name}
   * @param name
   * @param mainCarId
   */
  public set${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}: ${primaryAttribute.type},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): Observable<${entity.name}> {
    return this.http.post<any>('api/${entity.name?lower_case}/${attribute.name?lower_case}/set', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>});
  }
   <#elseif attribute.multiplicity=-1>
  /**
   * Add relation with ${attribute.name}
   */
  public add${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}: ${primaryAttribute.type},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): Observable<string> {
    return this.http.post<any>('/${entity.name?lower_case}/${attribute.name?lower_case}/add', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>});
  }

  /**
   * Remove relation with ${attribute.name}
   */
  public remove${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}: ${primaryAttribute.type},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): Observable<string> {
    return this.http.post<any>('/${entity.name?lower_case}/${attribute.name?lower_case}/remove', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>});
  }
    </#if>
   </#if>
  </#list>
}
