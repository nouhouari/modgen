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
* [2021] Nourreddine HOUARI SA
* All Rights Reserved.
*/

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ${entity.name}CreateComponent } from './components/${entity.name?lower_case}-create/${entity.name?lower_case}-create.component';
import { ${entity.name}EditComponent } from './components/${entity.name?lower_case}-edit/${entity.name?lower_case}-edit.component';
import { ${entity.name}ViewComponent } from './components/${entity.name?lower_case}-view/${entity.name?lower_case}-view.component';
import { ${entity.name}ListComponent } from './components/${entity.name?lower_case}-list/${entity.name?lower_case}.component';
import { ${entity.name}MapComponent } from './components/${entity.name?lower_case}-map/${entity.name?lower_case}-map.component';
import { ${entity.name}QuickSearchComponent } from './components/${entity.name?lower_case}-quicksearch/${entity.name?lower_case}-quicksearch.component';
import { ${entity.name}SearchComponent } from './components/${entity.name?lower_case}-search/${entity.name?lower_case}-search.component';
import { ${entity.name}UpdateComponent } from './components/${entity.name?lower_case}-update/${entity.name?lower_case}-update.component';
import { GeneratedSharedModule } from '../shared/shared.module';


@NgModule({
declarations: [
	${entity.name}CreateComponent,
	${entity.name}EditComponent,
	${entity.name}ListComponent,
	${entity.name}ViewComponent,
	${entity.name}MapComponent,
	${entity.name}QuickSearchComponent,
	${entity.name}SearchComponent,
	${entity.name}UpdateComponent,
],
imports: [
	CommonModule,
	GeneratedSharedModule
],
exports: [
  ${entity.name}CreateComponent,
  ${entity.name}EditComponent,
  ${entity.name}ListComponent,
  ${entity.name}ViewComponent,
  ${entity.name}MapComponent,
  ${entity.name}QuickSearchComponent,
  ${entity.name}SearchComponent,
  ${entity.name}UpdateComponent,
]
})
export class Generated${entity.name?cap_first}Module { }
