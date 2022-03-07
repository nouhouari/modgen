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

import { ${entity.name}Service } from './../shared/${entity.name?lower_case}.service';
import { ${entity.name} } from './../shared/${entity.name?lower_case}.model';
import { IStateParamsService } from 'angular-ui-router';
import * as _ from 'lodash';
import { AggregatorService } from 'sicpa-web-aggregation';

import { IBreadcrumb, IHasMessagesService } from 'sicpa-styleguide-angular';
<#assign myHash = { }>
<#list entity.attributes as attribute>
<#if !myHash[attribute.type]??>
<#if attribute.enumerate>
import { ${attribute.type} } from '../../shared/${attribute.type?lower_case}.model';
<#elseif attribute.reference>
import {
${attribute.type},
${attribute.type}SearchCriteria,
${attribute.type}PageResult,
} from '../../${attribute.type?lower_case}s/shared/${attribute.type?lower_case}.model';
import { ${attribute.type}Service } from '../../${attribute.type?lower_case}s/shared/${attribute.type?lower_case}.service';
</#if>
<#assign myHash=myHash + { attribute.type: 0 }>
</#if>
</#list>
<#if entity.hasAnnotation("EXTENDABLE")>
import { Schema, Field } from 'sicpa-extension-schema';
</#if>

/* @ngInject */
export class ${entity.name}Edit {
  public templateUrl: string = 'generated/${entity.name?lower_case}s/${entity.name?lower_case}-edit/${entity.name?lower_case}-edit.component.html';
  public controller: string  = '${entity.name?uncap_first}EditController';
}

/**
 * Aggregation service URL.
 */
declare const env: {
  aggregationRegistryUrl: string;
};

/* @ngInject */
export class ${entity.name}EditController {

  public breadcrumb: IBreadcrumb[];
  public ${entity.name?lower_case}Id: string;
  public ${entity.name?uncap_first}: ${entity.name};
  <#list entity.attributes as attribute>
<#if attribute.enumerate> 
  public ${attribute.name}Values: ${attribute.type}[] = [
    <#list attribute.litterals as litteral>
    ${attribute.type}.${litteral},
    </#list>
    ];
</#if>
</#list>
  <#if entity.hasAnnotation("EXTENDABLE")>
  public schema: Schema;
  public flatSchema: Field[];
  </#if>

  constructor(
    <#assign myHash = { }>
    <#list entity.attributes as attribute>
    <#if !myHash[attribute.type]??>
    <#if attribute.reference>
    protected ${attribute.type?uncap_first}Service: ${attribute.type}Service,
    <#assign myHash=myHash + { attribute.type: 0 }>
    </#if>
    </#if>
    </#list>
    protected $log: angular.ILogService,
    protected hasMessagesService: IHasMessagesService,
    protected ${entity.name?uncap_first}Service: ${entity.name}Service,
    protected $state: ng.ui.IStateService,
    protected $stateParams: IStateParamsService,
    protected $window: Window,
    private aggregatorService: AggregatorService) {
  }

  public $onInit(): void {
    this.${entity.name?lower_case}Id = _.get(this.$stateParams, 'id', '');
    this.$log.info('Get by id : ' + this.${entity.name?lower_case}Id);
    this.${entity.name?uncap_first}Service.get${entity.name}ById(this.${entity.name?lower_case}Id).then(
      e => {
            this.${entity.name?uncap_first} = e;
            <#if entity.hasAnnotation("EXTENDABLE")>
            // Get entity schema for this instance
            this.${entity.name?uncap_first}Service.getSchema(e.schemaFullyQualifiedName.toString()).then(
              schema => {
                  this.schema = schema;
                  this.flatSchema = schema.flatten();
                },
              error => {
                this.$log.debug(error);
                this.hasMessagesService.addError('Error retrieving ${entity.name} schema : e.schemaFullyQualifiedName.toString()');
              },
            );
            </#if>
           });
    this.breadcrumb = [
      { displayName: '${entity.name}', state: '${entity.name?lower_case}.main' },
      { displayName: 'Edit', state: '${entity.name?lower_case}.edit' },
    ];
    // Load menu from aggregation service
    this.aggregatorService.loadMenu(env.aggregationRegistryUrl + `/api/v1/menu`);
  }

  /**
   * Go back to the previous page.
   */
  public back(): void {
    this.$log.info('back');
    this.$window.history.back();
  }

  <#list entity.attributes as attribute>
  <#if attribute.reference>
  /**
   * Load relation
   */
  public load${attribute.name?cap_first}(c: ${attribute.type}SearchCriteria): ng.IPromise<${attribute.type}PageResult> {
    <#list entity.getAttributesByAnnotation("PK") as p>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    c.${entity.name?uncap_first}${attribute.name?cap_first}${p.name?cap_first} = this.${entity.name?lower_case}Id;
    </#list>
    </#list>
    return this.${attribute.type?uncap_first}Service.find(c);
  }
  <#if attribute.multiplicity=1>
  /**
   * On ${attribute.name} selected from the list.
   */
  public on${attribute.name?cap_first}Selected(${attribute.name}: ${attribute.type}): void {
    this.${entity.name?uncap_first}Service.set${attribute.name?cap_first}Relation(
    <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${entity.name?uncap_first}.${primaryAttribute.name},
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ${attribute.name}.${primaryAttribute.name},
    </#list>
    ).then(p => this.${entity.name?uncap_first} = p);
  }
  <#elseif attribute.multiplicity=-1>
  /**
   * On ${attribute.name} selected from the list.
   */
  public on${attribute.name?cap_first}Selected(${attribute.name}: ${attribute.type}, checked: boolean): void {
   this.$log.info(JSON.stringify(${attribute.name}));
   if (checked) {
    this.${entity.name?uncap_first}Service.add${attribute.name?cap_first}Relation(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${entity.name?uncap_first}.${primaryAttribute.name},
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ${attribute.name}.${primaryAttribute.name},
    </#list>
    ).then(p => this.$log.debug(p));
   } else {
    this.${entity.name?uncap_first}Service.remove${attribute.name?cap_first}Relation(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    this.${entity.name?uncap_first}.${primaryAttribute.name},
    </#list>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ${attribute.name}.${primaryAttribute.name},
    </#list>
    ).then(p => this.$log.debug(p));
   }
  }
  </#if>
  </#if>
  </#list>

  /**
   * Save the edited ${entity.name?lower_case}.
   * @param e ${entity.name?uncap_first} to save.
   */
  public save(e: ${entity.name}): void {
    <#list entity.attributes as attribute>
    <#if attribute.type  = "Date">
    // Convert date ${attribute.name}
    if (e.${attribute.name} !== undefined && e.${attribute.name} !== null) {
      e.${attribute.name} = this.parse(e.${attribute.name}.toString());
    }
    </#if>
    </#list>
    this.$log.info(<#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list>);
    this.${entity.name?uncap_first}Service.save(e).then(p => {
      this.${entity.name?uncap_first} = p.entity;
      this.$state.go('${entity.name?lower_case}.main', {});
    });
  }

  /**
   * Convert a string to a Date.
   * @param dateStr String representation of the date the following format DD/MM/YYYY
   */
  public parse(dateStr: string): Date {
    const y = parseInt(dateStr.substr(6, 4), 10),
          m = parseInt(dateStr.substr(4, 2), 10),
          d = parseInt(dateStr.substr(0, 2), 10);
    return new Date(y, m, d);
  }

}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}Edit', new ${entity.name}Edit())
  .controller('${entity.name?uncap_first}EditController', ${entity.name}EditController);
