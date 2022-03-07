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

import { IBreadcrumb } from 'sicpa-styleguide-angular';

/* @ngInject */
export class ${entity.name}Main {
  public templateUrl: string = 'generated/${entity.name?lower_case}s/${entity.name?lower_case}-main/${entity.name?lower_case}-main.component.html';
  public controller: string  = '${entity.name?uncap_first}MainController';
}

/* @ngInject */
export class ${entity.name}MainController {

  public showAdvanedSearch: boolean;
  protected breadcrumb: IBreadcrumb[];

  constructor(
    protected $window: angular.IWindowService,
    protected $log: angular.ILogService,
    protected $state: ng.ui.IStateService) {
  }

  public $onInit(): void {
    this.$log.debug('On Init : Main');
    this.breadcrumb = [
      { displayName: '${entity.name}', state: '${entity.name?lower_case}.main' },
    ];
  }

  // To toggle advance search from to either to show or hide
  public toggle(): void {
    this.showAdvanedSearch = !this.showAdvanedSearch;
    let widthOriginal = this.$window.innerWidth - 200; // Calculate original browser width
    let resize = widthOriginal - 500; // Calculate content width when opening menu

    if (this.showAdvanedSearch) {
      document.getElementById('das-activation-container').style.width = resize + 'px';
    } else {
      document.getElementById('das-activation-container').style.width = widthOriginal + 'px';
    }
  }

}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}Main', new ${entity.name}Main())
  .controller('${entity.name?uncap_first}MainController', ${entity.name}MainController);
