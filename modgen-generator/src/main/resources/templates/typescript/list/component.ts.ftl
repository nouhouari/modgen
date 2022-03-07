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

import { IHasMessagesService } from 'sicpa-styleguide-angular';
import { ${entity.name}Service } from './../shared/${entity.name?lower_case}.service';
import {
${entity.name},
${entity.name}PageResult,
${entity.name}SearchCriteria } from './../shared/${entity.name?lower_case}.model';
import { AggregatorService } from 'sicpa-web-aggregation';
<#if entity.hasAnnotation("EXTENDABLE")>
import { Schema, Field } from 'sicpa-extension-schema';
import { Extensions } from '../../shared/extension.model';
</#if>
/* @ngInject */
export class ${entity.name}List {
  public templateUrl: string =
  'generated/${entity.name?lower_case}s/${entity.name?lower_case}-list/${entity.name?lower_case}-list.component.html';
  public controller: string =
  '${entity.name?lower_case}ListController';
  public bindings: {[index: string]: string} = {
    hideDetails: '<',
    hideDelete: '<',
    hideEdit: '<',
    hideSelect: '<',
    hideSelectMulti: '<',
    selected: '@',
    group: '@',
    callback: '&',
    loader: '&',
    useLoader: '<',
  };
}

/**
 * Aggregation service URL.
 */
declare const env: {
  aggregationRegistryUrl: string;
};

/**
 * Sort column.
 */
class SortColumn {
  public name: string;
  public dir: boolean;

  constructor(name: string) {
    this.name = name;
    this.dir = false;
  }
}

/* @ngInject */
export class ${entity.name}ListController {

  public ${entity.name?lower_case}PageResult: ${entity.name}PageResult;
  public ${entity.name?uncap_first}SearchCriteria: ${entity.name}SearchCriteria = new ${entity.name}SearchCriteria();
  public options: number[] = [1, 5, 10, 20, 50];
  public cleanup: any;
  public sortByField: Array<SortColumn> = new Array<SortColumn>();
  public sortByFieldNames: Array<SortColumn> = new Array<SortColumn>();
  public error: boolean = false;
  public callback: (t: any) => ng.IPromise<void>;
  public loader: (c: any) => ng.IPromise<${entity.name}PageResult>;
  public useLoader: boolean;
  <#if entity.hasAnnotation("EXTENDABLE")>
  // Extension schema
  public schema: Schema;
  public flatSchema: Field[];
  public extensions: Extensions;
  </#if>

  constructor(
    protected $log: angular.ILogService,
    protected $rootScope: ng.IRootScopeService,
    protected ${entity.name?uncap_first}Service: ${entity.name}Service,
    protected hasMessagesService: IHasMessagesService,
    protected paginationProperties: any,
    protected $state: ng.ui.IStateService,
    protected $location: angular.ILocationService,
    private aggregatorService: AggregatorService) {

    <#if entity.hasAnnotation("EXTENDABLE")>
    // Get entity schema
    this.entityDService.getSchema('${package}.extension.v0.${entity.name?lower_case}').then(
      schema => {
        this.schema = schema;
        this.flatSchema = schema.flatten();
        this.extensions = new Extensions({}, this.schema);
      },
      error => {
        this.$log.debug(error);
        this.hasMessagesService.addError('Error retrieving ${entity.name} schema : ${package}.extension.v0.${entity.name?lower_case}');
      },
    );
    </#if>
  }

  public $onInit(): void {
    this.cleanup = this.$rootScope.$on('$locationChangeSuccess', () => {
      this.$log.info('Location changed.');
      this.${entity.name?uncap_first}SearchCriteria.read(this.$location.search());
      this.reloadUrl(this.$location.search());
    });
    this.reloadUrl(this.$location.search());
    // Load the menu from the aggregation service
    this.aggregatorService.loadMenu(env.aggregationRegistryUrl + `/api/v1/menu`);
  }

  /**
   * Unregister the listener on locationChangeSuccess.
   */
  public $onDestroy(): void {
   this.cleanup();
  }

  /**
   * Search.
   */
  public findAll(): void {

    if (!this.useLoader) {
      // Load default
      this.error = false;
      if (this.${entity.name?uncap_first}SearchCriteria !== null &&
          this.${entity.name?uncap_first}SearchCriteria.quickSearchQuery !==  null &&
          this.${entity.name?uncap_first}SearchCriteria.quickSearchQuery !== '') {
        this.${entity.name?uncap_first}Service.quickSearch(this.${entity.name?uncap_first}SearchCriteria).then(
          page => { this.${entity.name?lower_case}PageResult = page; },
          error => { this.$log.error(error); this.error = true; },
        );
      } else {
        this.${entity.name?uncap_first}Service.find(this.${entity.name?uncap_first}SearchCriteria).then(
          page => { this.${entity.name?lower_case}PageResult = page; },
          error => { this.$log.error(error); this.error = true; },
        );
      }
    } else {
      // Load using external loader
      this.$log.info('Loadind data from callback');
      this.loader({c: this.${entity.name?uncap_first}SearchCriteria}).then(
        page => { page.number++; this.${entity.name?lower_case}PageResult = page; },
        error => { this.$log.error(error); this.error = true; },
      );
    }
  }
  /**
   * View Entityc details
   * @param e
   */
  public view${entity.name}(e: ${entity.name}): void {
    this.$state.go('${entity.name?lower_case}.details', { id: <#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list> });
  }

  /**
   * Edit Entityc
   * @param e
   */
  public edit${entity.name}(e: ${entity.name}): void {
    this.$log.info('Edit : ' + <#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list>);
    this.$state.go('${entity.name?lower_case}.edit', { id: <#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list> });
  }

  /**
   * Delete ${entity.name}
   */
  public delete${entity.name}(e: ${entity.name}): void {
    this.$log.info('Delete : ' + <#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list>);
    this.${entity.name?uncap_first}Service.delete${entity.name}ById(<#list primaryAttributes as attribute>e.${attribute.name?uncap_first}<#if attribute?has_next>,</#if></#list>).then((msg) => this.findAll());
  }

  /**
   * Fired when the page change
   */
  public pagechange(start: any): void {
    let pagenumber: number = Math.round((start.start) / this.${entity.name?uncap_first}SearchCriteria.size);
    if ( pagenumber !== this.${entity.name?uncap_first}SearchCriteria.page) {
      this.${entity.name?uncap_first}SearchCriteria.page = pagenumber;
      this.${entity.name?lower_case}PageResult.number = (pagenumber + 1) * this.${entity.name?uncap_first}SearchCriteria.size - 1;
      this.findAll();
    }
  }

  /**
   * Fired when user click on number of item per page.
   * @param n Number of items per page
   */
  public numberPerPageChange(n: number): void {
    this.${entity.name?uncap_first}SearchCriteria.page = 0;
    this.${entity.name?uncap_first}SearchCriteria.size = n;
    this.findAll();
  }

  /**
   *  Convert date to String.
   * @param timestamp
   */
  public convertDate(timestamp: number): string {
    if (timestamp !== undefined) {
      return new Date(timestamp).toLocaleString();
    }
  }

  /**
   * Sort by field name.
   */
  public sortBy(field: any): void {
    let isPresent: boolean = this.sortByFieldNames.some(o => o.name === field);
    if (isPresent) {
      let index: number = this.sortByFieldNames.indexOf(this.sortByField[field]);
      let removed: SortColumn[] = this.sortByFieldNames.filter(o => o.name === field);
      this.sortByFieldNames.splice(index, 1);
      removed[0].dir = !removed[0].dir;
      this.sortByFieldNames.push(removed[0]);
    } else {
       let col: SortColumn = new SortColumn(field);
       this.sortByField[field] = col;
       this.sortByFieldNames.push(col);
    }

    let orderParms: URLSearchParams = new URLSearchParams();
    this.sortByFieldNames.reverse().forEach(o => {
      orderParms.append('sort', o.name + ',' + (o.dir ? 'ASC' : 'DESC'));
    });
    this.$location.search(orderParms.toString());
  }

  /**
   * Return true if the column is used for sorting the array.
   */
  public columnOrder(field: string): boolean {
    let result: boolean = false;
    this.sortByFieldNames.forEach(o => {
      if (o.name === field) {
        result = o.dir;
      }
    });
    return result;
  }

  /**
   * Call the call back function for parent component.
   * @param ${entity.name?lower_case} Selected item.
   */
  public onItemSelected(${entity.name?lower_case}: ${entity.name?cap_first}, checked: boolean): void {
    this.callback({${entity.name?lower_case}: ${entity.name?lower_case}, checked: checked});
  }

  /**
   * Go to create page.
   */
  public goToCreate(): void {
    this.$log.debug('On Init : Main');
    this.$state.go('${entity.name?lower_case}.create', {});
  }

  /**
   * Reload page by reading url parameters.
   */
  private reloadUrl(search: any): void {
      this.${entity.name?uncap_first}SearchCriteria.page = 0;
      this.${entity.name?uncap_first}SearchCriteria.size = this.paginationProperties.defaultItemsPerPage;
      this.${entity.name?uncap_first}SearchCriteria.read(search);
      this.findAll();
  }

}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}List', new ${entity.name}List())
  .controller('${entity.name?lower_case}ListController', ${entity.name}ListController);
