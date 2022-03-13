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
import { IBreadcrumb } from 'hin-styleguide-angular';
import { AggregatorService } from 'hin-web-aggregation';

/* @ngInject */
export class ${entity.name}Details {
  public templateUrl: string =
  'generated/${entity.name?lower_case}s/${entity.name?lower_case}-details/${entity.name?lower_case}-details.component.html';
  public controller: string  =
  '${entity.name?uncap_first}DetailsController';
}

/**
 * Aggregation service URL.
 */
declare const env: {
  aggregationRegistryUrl: string;
};

/* @ngInject */
export class ${entity.name}DetailsController {

  public ${entity.name?lower_case}Id: string;
  public ${entity.name?uncap_first}: ${entity.name};
  public breadcrumb: IBreadcrumb[];

  constructor(
    protected $log: angular.ILogService,
    protected ${entity.name?uncap_first}Service: ${entity.name}Service,
    protected $stateParams: IStateParamsService,
    protected $window: Window,
    private aggregatorService: AggregatorService) {
  }

  public $onInit(): void {
    this.${entity.name?lower_case}Id = _.get(this.$stateParams, 'id', '');
    this.$log.info('Get by id : ' + this.${entity.name?lower_case}Id);
    this.${entity.name?uncap_first}Service.get${entity.name}ById(this.${entity.name?lower_case}Id).then(
        e => { this.$log.info('Response from the server ' + <#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list>); this.${entity.name?uncap_first} = e; });
    this.breadcrumb = [
      { displayName: '${entity.name}', state: '${entity.name?lower_case}.main' },
      { displayName: 'Details', state: '${entity.name?lower_case}.details' },
    ];
    // Load menu from aggregation service
    this.aggregatorService.loadMenu(env.aggregationRegistryUrl + `/api/v1/menu`);
  }

  public back(): void {
    this.$log.info('back');
    this.$window.history.back();
  }
}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}Details', new ${entity.name}Details())
  .controller('${entity.name?uncap_first}DetailsController', ${entity.name}DetailsController);
