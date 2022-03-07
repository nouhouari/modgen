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

import { ${entity.name}, ${entity.name}Service } from './${entity.name?lower_case}.service';

/* @ngInject */
export class ${entity.name}s {
  public templateUrl: string = '${entity.name?lower_case}-table.html';
  public controller: string  = '${entity.name?lower_case}ListController';
}

/* @ngInject */
export class ${entity.name}ListController {

  public ${entity.name?lower_case}s: any = [];

  constructor(
    private $log: angular.ILogService,
    private ${entity.name?uncap_first}Service: ${entity.name}Service) {
  }

  public $onInit(): void {
    this.findAll();
  }

  public findAll(): void {
    this.$log.info('Find all ${entity.name}');
    this.${entity.name?uncap_first}Service.find().then(
      page => this.${entity.name?lower_case}s = page.list,
      error => this.$log.error(error),
      );
  }
  
  /**
   * View ${entity.name} details
   * @param e 
   */
  public view${entity.name}(e: ${entity.name}): void {
    this.$log.info('Details : ' + e);
  }

  /**
   * Edit ${entity.name}
   * @param e 
   */
  public editEntityC(e: ${entity.name}): void {
    this.$log.info('Edit : ' + e);
  }

  /**
   * Delete ${entity.name}
   */
  public delete${entity.name}(e: ${entity.name}): void {
    this.$log.info('Delete : ' + e);
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
}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}s', new ${entity.name}s())
  .controller('${entity.name?lower_case}ListController', ${entity.name}ListController);
