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
export class ${entity.name}s {
  public templateUrl: string = 'generated/${entity.name?lower_case}s/${entity.name?lower_case}.component.html';
  public controller: string  = '${entity.name?uncap_first}Controller';
}

/* @ngInject */
export class ${entity.name}Routes {
   constructor($stateProvider: ng.ui.IStateProvider) {
    $stateProvider
      .state('${entity.name?lower_case}', {
        template: '<${entity.name?lower_case}></${entity.name?lower_case}>'})
      .state('${entity.name?lower_case}.main', {
        template: '<${entity.name?lower_case}-main></${entity.name?lower_case}-main>',
        url: '/${entity.name?lower_case}'})
      .state('${entity.name?lower_case}.list', {
        template: '<${entity.name?lower_case}-list></${entity.name?lower_case}-list>',
        url: '/${entity.name?lower_case}/list'})
      .state('${entity.name?lower_case}.details', {
        template: '<${entity.name?lower_case}-details></${entity.name?lower_case}-details>',
        url: '/${entity.name?lower_case}/{id}'})
      .state('${entity.name?lower_case}.create', {
        template: '<${entity.name?lower_case}-create></${entity.name?lower_case}-create>',
        url: '/new/${entity.name?lower_case}'})
      .state('${entity.name?lower_case}.edit', {
        template: '<${entity.name?lower_case}-edit></${entity.name?lower_case}-edit>' ,
        url: '/${entity.name?lower_case}/{id}/edit'});
  }
}

/* @ngInject */
export class ${entity.name}Controller {

}

// Remove on Angular 2
require('./${entity.name?lower_case}.module')
  .component('${entity.name?lower_case}', new ${entity.name}s())
  .controller('${entity.name?uncap_first}Controller', ${entity.name}Controller)
  .config(${entity.name}Routes)
  .constant('paginationProperties', {defaultItemsPerPage: 10, maximumItemsPerPage: 50});
