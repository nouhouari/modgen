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

export * from './shared/${entity.name?lower_case}.model';
export * from './shared/${entity.name?lower_case}.service';
export * from './${entity.name?lower_case}.component';
export * from './${entity.name?lower_case}-create';
export * from './${entity.name?lower_case}-details';
export * from './${entity.name?lower_case}-edit';
export * from './${entity.name?lower_case}-list';
export * from './${entity.name?lower_case}-search';
export * from './${entity.name?lower_case}-quicksearch';
export * from './${entity.name?lower_case}-main';

export const name = require('./${entity.name?lower_case}.module').name;
