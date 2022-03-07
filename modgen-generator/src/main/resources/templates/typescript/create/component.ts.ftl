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
import { ${entity.name}, ${entity.name}SaveResult } from './../shared/${entity.name?lower_case}.model';
import { IStateParamsService } from 'angular-ui-router';
import { IBreadcrumb, IHasMessagesService } from 'sicpa-styleguide-angular';
import { AggregatorService } from 'sicpa-web-aggregation';
<#if entity.hasAnnotation("EXTENDABLE")>
import { Field, Schema } from 'sicpa-extension-schema';
import { Extensions } from '../../shared/extension.model';
</#if>
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import { ${attribute.type} } from '../../shared/${attribute.type?lower_case}.model';
</#if>
</#list>

/* @ngInject */
export class ${entity.name}Create {
  public templateUrl: string =
  'generated/${entity.name?lower_case}s/${entity.name?lower_case}-create/${entity.name?lower_case}-create.component.html';
  public controller: string  =
  '${entity.name?uncap_first}CreateController';
}

/**
 * Aggregation service URL.
 */
declare const env: {
  aggregationRegistryUrl: string;
};

/* @ngInject */
export class ${entity.name}CreateController {

  public breadcrumb: IBreadcrumb[];
  public ${entity.name?uncap_first}Form: angular.IFormController;
  public packagingUnitErrors: any = [];
  <#if entity.hasAnnotation("EXTENDABLE")>
  public schema: Schema;
  public flatSchema: Field[];
  public extensions: Extensions;
  </#if>
  // Create instance
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

  // Constructor
  constructor(
    protected $log: angular.ILogService,
    protected ${entity.name?uncap_first}Service: ${entity.name}Service,
    protected $state: ng.ui.IStateService,
    protected hasMessagesService: IHasMessagesService,
    protected $stateParams: IStateParamsService,
    protected $window: Window,
    private aggregatorService: AggregatorService) {

    <#if entity.hasAnnotation("EXTENDABLE")>
    // Get entity schema
    this.${entity.name?uncap_first}Service.getSchema('${package}.extension.v0.${entity.name?lower_case}').then(
        schema => {
          this.schema = schema;
          this.flatSchema = schema.flatten();
          this.extensions = new Extensions({}, this.schema);
        },
        error => {
          this.$log.debug(error);
          this.hasMessagesService.addError('Error retrieving ${entity.name} schema : ${package}.extension.v0.${entity.name?lower_case}.');
        },
      );
    </#if>  
  }

  public $onInit(): void {
    this.$log.debug('On Init : Create');
    this.breadcrumb = [
      { displayName: '${entity.name}', state: '${entity.name?lower_case}.main' },
      { displayName: 'Create', state: '${entity.name?lower_case}.create' },
    ];
    // Load menu from aggregation service
    this.aggregatorService.loadMenu(env.aggregationRegistryUrl + `/api/v1/menu`);
  }
  /**
   * Go back to the previous page.
   */
  public back(): void {
    this.$window.history.back();
  }

  /**
   * Save the edited ${entity.name?lower_case}.
   * @param e ${entity.name?uncap_first} to save.
   */
  public save(e: ${entity.name}): void {
    // Saving empty entity
    if (e === undefined) {
      e = new ${entity.name}();
    }
    <#if entity.hasAnnotation("EXTENDABLE")>
    // Set schema
    e.schemaFullyQualifiedName = this.schema.fullyQualifiedName;
    // Set extensions values
    e.extensions = this.extensions.values;
    </#if>
    <#list entity.attributes as attribute>
    <#if attribute.type  = "Date">
    // Convert date ${attribute.name}
    if (e.${attribute.name} !== undefined && e.${attribute.name} !== null) {
      e.${attribute.name} = this.parse(e.${attribute.name}.toString());
    }
    </#if>
    </#list>
    this.${entity.name?uncap_first}Service.save(e).then(
      (p: ${entity.name}SaveResult) => {
        this.${entity.name?uncap_first} = p.entity;
        if (p.status !== 'SUCCESS') {
            for (let error of p.errors) {
              this.packagingUnitErrors[error.property] = { message: error.message };
            }
        } else {
        this.${entity.name?uncap_first}.<#list primaryAttributes as attribute>${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list> = null;
        this.$state.go('${entity.name?lower_case}.main', {});
        }
      },
      err => this.$log.error('Error saving.' + err));
  }

  /**
   * Convert a string to a Date.
   * @param dateStr String representation of the date the following format DD/MM/YYYY
   */
  public parse(dateStr: string): Date {
    const y = parseInt(dateStr.substr(6, 4), 10),
          m = parseInt(dateStr.substr(4, 2), 10),
          d = parseInt(dateStr.substr(0, 2), 10);

    this.$log.info('d=' + d + ', m=' + m + ', y=' + y);
    return new Date(y, m, d);
  }

}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}Create', new ${entity.name}Create())
  .controller('${entity.name?uncap_first}CreateController', ${entity.name}CreateController);
