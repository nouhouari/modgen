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


/* @ngInject */
export class ${entity.name}QuickSearch {
  public templateUrl: string =
  'generated/${entity.name?lower_case}s/${entity.name?lower_case}-quicksearch/${entity.name?lower_case}-quicksearch.component.html';
  public controller: string  =
  '${entity.name?lower_case}QuickSearchController';
}

/* @ngInject */
export class ${entity.name}QuickSearchController {

  public quickSearch: string = '';

  constructor(
    private $location: angular.ILocationService) {}

  /**
   * Update the search query.
   */
  public search(): void {
    if (this.quickSearch != null) {
      this.$location.search({quickSearchQuery: this.quickSearch});
    }
  }
}

// Remove on Angular 2
require('../${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}QuickSearch', new ${entity.name}QuickSearch())
  .controller('${entity.name?lower_case}QuickSearchController', ${entity.name}QuickSearchController);
