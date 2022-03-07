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

import { ${entity.name}SearchCriteria } from '../shared/${entity.name?lower_case}.model';
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import { ${attribute.type} } from '../../shared/${attribute.type?lower_case}.model';
</#if>
</#list>

/* @ngInject */
export class ${entity.name}Search {
  public templateUrl: string =
  'generated/${entity.name?lower_case}s/${entity.name?lower_case}-search/${entity.name?lower_case}-search.component.html';
  public controller: string  =
  '${entity.name?lower_case}SearchController';
}

/* @ngInject */
export class ${entity.name}SearchController {

  public ${entity.name?lower_case}SearchCriteria: ${entity.name}SearchCriteria;
<#list entity.attributes as attribute>
<#if attribute.enumerate> 
  public ${attribute.name}Values: any[] = [
    <#list attribute.litterals as litteral>
    {
        label: '${litteral}',
        value: ${attribute.type}.${litteral},
    },
    </#list>
    ];
</#if>
</#list>

  constructor(
    protected $log: angular.ILogService,
    protected $location: angular.ILocationService) {}

  /**
   * Read the search parameters from path.
   */
  public $onInit(): void {
    // Read the path parameter to reload
    if (this.${entity.name?lower_case}SearchCriteria != null) {
      this.${entity.name?lower_case}SearchCriteria.read(this.$location.search());
    }
  }

  /**
   * Clear search query parameters and path.
   */
  public clear(): void {
    if (typeof this.${entity.name?lower_case}SearchCriteria !== 'undefined') {
      this.${entity.name?lower_case}SearchCriteria = null;
    }
    this.$location.search({});
  }

  /**
   * Update the search query.
   */
  public search(): void {
    if (this.${entity.name?lower_case}SearchCriteria != null) {
      this.$location.search(this.${entity.name?lower_case}SearchCriteria);
    }
  }

}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}Search', new ${entity.name}Search())
  .controller('${entity.name?lower_case}SearchController', ${entity.name}SearchController);
