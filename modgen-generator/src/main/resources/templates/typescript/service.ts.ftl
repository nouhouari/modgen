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
    ${entity.name}SaveResult,
    ${entity.name}SearchCriteria,
    ${entity.name}PageResult } from './${entity.name?lower_case}.model';
import { ApiService } from '../../../shared/api/api.service';
<#if entity.hasAnnotation("EXTENDABLE")>
import { Schema, Field, Translation, AvailableValue } from 'sicpa-extension-schema';
import * as _ from 'lodash';
import { IDeferred } from 'angular';
</#if>

/**
 * ${entity.name} service interface.
 */
export interface I${entity.name}Service {

  /**
   * Get the ${entity.name} by its key.
   */
  get${entity.name}ById(id: any): angular.IPromise<${entity.name}>;

  /**
   * Save new${entity.name}.
   */
  save(new${entity.name}: ${entity.name}): angular.IPromise<${entity.name}SaveResult>;

  /**
   * Save new${entity.name} list.
   */
  saveBulk(new${entity.name}s: ${entity.name}[]): angular.IPromise<{}>;

  /**
   * Find ${entity.name} with search criteria.
   * @return a paginated result of ${entity.name}.
   */
  find(criteria?: ${entity.name}SearchCriteria, page?: number, size?: number): angular.IPromise<${entity.name}PageResult>;

  /**
   * Delete ${entity.name}.
   */
  delete${entity.name}ById(id: any): angular.IPromise<${entity.name}>;
  <#if entity.hasAnnotation("EXTENDABLE")>
  /**
   * Get ${entity.name} schema.
   */
   getSchema(): angular.IPromise<Schema>;
   </#if>
}

/* @ngInject */
export class ${entity.name}Service implements I${entity.name}Service {

  <#if entity.hasAnnotation("EXTENDABLE")>
  private schemaCache: Schema = null;
  </#if>

  /**
   * Build new ${entity.name}Service.
   * @constructor
   * @param q
   * @param log
   * @param apiService
   */
  constructor(private $q: angular.IQService,
  			  <#if entity.hasAnnotation("EXTENDABLE")>
              private gettextCatalog: angular.gettext.gettextCatalog,
              </#if>
              private $log: angular.ILogService,
              private apiService: ApiService) {}

  /**
   * Get the ${entity.name} by its key.
   */
  public get${entity.name}ById(id: any): angular.IPromise<${entity.name}> {
    let defer = this.$q.defer<${entity.name}>();
    this.$log.info('Get by id : ' + id);
    this.apiService.get('${entity.name?lower_case}/read/' + id).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}>) => {
                defer.resolve(new ${entity.name}(response.data));
            },
      this.errorCallback(defer),
    );
    return defer.promise;
  }

  /**
   * Save ${entity.name}.
   */
  public save(new${entity.name}: ${entity.name}): angular.IPromise<${entity.name}SaveResult> {
    let defer = this.$q.defer<${entity.name}SaveResult>();
    this.apiService.post('${entity.name?lower_case}/', new${entity.name}).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}SaveResult>) => {
                defer.resolve(new ${entity.name}SaveResult(response.data));
                },
      this.errorCallback(defer),
    );
    return defer.promise;
  }

  /**
   * Save ${entity.name} list.
   */
  public saveBulk(new${entity.name}s: ${entity.name}[]): angular.IPromise<{}> {
    let defer = this.$q.defer();
    // Not Implemented yet.
    return defer.promise;
  }

  /**
   * Find ${entity.name} with search criteria.
   * @return a paginated result of ${entity.name}.
   */
  public find(criteria?: ${entity.name}SearchCriteria): angular.IPromise<${entity.name}PageResult> {
   let defer = this.$q.defer<${entity.name}PageResult>();
   this.apiService.get('${entity.name?lower_case}/search', criteria).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}PageResult>) => {
                defer.resolve(new ${entity.name}PageResult(response.data));
            },
      this.errorCallback(defer),
    );
   return defer.promise;
  }

  /**
   * QuickSearch ${entity.name} with search criteria.
   * @return a paginated result of ${entity.name}.
   */
  public quickSearch(criteria?: ${entity.name}SearchCriteria): angular.IPromise<${entity.name}PageResult> {
   let defer = this.$q.defer<${entity.name}PageResult>();
   this.apiService.get('${entity.name?lower_case}/quicksearch', criteria).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}PageResult>) => {
                defer.resolve(new ${entity.name}PageResult(response.data));
            },
      this.errorCallback(defer),
    );
   return defer.promise;
  }

  /**
   * Delete ${entity.name}.
   */
  public delete${entity.name}ById(id: any): angular.IPromise<${entity.name}> {
    let defer = this.$q.defer<${entity.name}>();
    this.apiService.delete('${entity.name?lower_case}/' + id).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}>) => {
                defer.resolve(new ${entity.name}(response.data));
            },
      this.errorCallback(defer),
    );
    return defer.promise;
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
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): angular.IPromise<${entity.name}> {
    let defer = this.$q.defer<${entity.name}>();
    this.apiService.post('/${entity.name?lower_case}/${attribute.name?lower_case}/set', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>}).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}>) => {
                defer.resolve(new ${entity.name}(response.data));
            },
      this.errorCallback(defer),
    );
    return defer.promise;
  }
    <#elseif attribute.multiplicity=-1>
  /**
   * Add relation with ${attribute.name}
   */
  public add${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}: ${primaryAttribute.type},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): angular.IPromise<${entity.name}SaveResult> {
    let defer = this.$q.defer<${entity.name}SaveResult>();
    this.apiService.post('/${entity.name?lower_case}/${attribute.name?lower_case}/add', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>}).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}SaveResult>) => {
                defer.resolve(new ${entity.name}SaveResult(response.data));
            },
      this.errorCallback(defer),
    );
    return defer.promise;
  }

  /**
   * Remove relation with ${attribute.name}
   */
  public remove${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}: ${primaryAttribute.type},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${attribute.name}${primaryAttribute.name?cap_first}: ${primaryAttribute.type}<#sep>,</#sep></#list>): angular.IPromise<${entity.name}SaveResult> {
    let defer = this.$q.defer<${entity.name}SaveResult>();
    this.apiService.post('/${entity.name?lower_case}/${attribute.name?lower_case}/remove', {
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>'${primaryAttribute.name}': ${primaryAttribute.name},</#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>'${attribute.name}${primaryAttribute.name?cap_first}': ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep></#list>}).then(
      (response: angular.IHttpPromiseCallbackArg<${entity.name}SaveResult>) => {
                defer.resolve(new ${entity.name}SaveResult(response.data));
            },
      this.errorCallback(defer),
    );
    return defer.promise;
  }
    </#if>
   </#if>
  </#list>

  <#if entity.hasAnnotation("EXTENDABLE")>
  /**
   * Get ${entity.name} schema from bff service.
   */
  public getSchema(sfqn?: string): angular.IPromise<Schema> {
    let defer = this.$q.defer<Schema>();

    if (this.schemaCache !== null) {
      defer.resolve(this.schemaCache);
      return defer.promise;
    }

    this.apiService.get('schema', {schemaFullyQualifiedName: sfqn}).then(
      (response: angular.IHttpResponse<Schema>) => {
        this.schemaCache = new Schema(response.data);
        this.addSchemaTranslations(this.schemaCache);
        defer.resolve(this.schemaCache);
      },
      this.handleError(
        defer,
        '${entity.name}Service.getSchema',
        this.$log,
        this.gettextCatalog.getString('An error occurred while accessing the server'),
      ),
    );

    return defer.promise;
  }

  /**
   * Handle errors.
   */
  private handleError<T>(
    defer: IDeferred<T>,
    callerName: string,
    $log: angular.ILogService,
    defaultMsg: string,
    errorField: string = 'userMsg'): (reason: angular.IHttpResponse<any>) => any {
    'use strict';
    return (reason: angular.IHttpResponse<any>) => {
      $log.warn(`${r"${callerName}"} for -> ERROR: ${r"${reason.status}"}`, reason);

      let errorMsg: String = _.get(reason.data, errorField, defaultMsg);

      defer.reject({
        config: reason.config,
        data: reason.data,
        headers: reason.headers,
        msg: errorMsg,
        status: reason.status,
      });
    };
  }

  /**
   * Add schema translation.
   */
  private addSchemaTranslations(schema: Schema): void {
    _.forEach(schema.flatten(), (field: Field) => {
      _.forEach(field.labelTranslations, (translation: Translation) => {
        this.insertTranslation(translation.language, field.label, translation.value);
      });

      _.forEach(field.availableValues, (availableValue: AvailableValue) => {
        _.forEach(availableValue.labelTranslations, (translation: Translation) => {
          this.insertTranslation(translation.language, availableValue.label, translation.value);
        });
      });
    });
  }

  /**
   * Insert translation for all schema fields.
   */
  private insertTranslation(language: string, source: string, translation: string): void {
    let translations: { [key: string]: string } = {};
    translations[source] = translation;
    this.gettextCatalog.setStrings(language, translations);
  }
  </#if>

  // PRIVATE METHODS

  /**
   * Error callback method.
   */
  private errorCallback<T>(defer: angular.IDeferred<T>): (t: T) => void {
        return (response: T) => {
            this.$log.error(response);
            defer.reject(response);
        };
    }
}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .service('${entity.name?uncap_first}Service', ${entity.name}Service);
