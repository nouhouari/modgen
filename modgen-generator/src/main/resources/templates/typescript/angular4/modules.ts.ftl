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
<#list entities as entity>
import { ${entity.name}CreateComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-create/${entity.name?lower_case}-create.component';
import { ${entity.name}EditComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-edit/${entity.name?lower_case}-edit.component';
import { ${entity.name}FormComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-form/${entity.name?lower_case}-form.component';
import { ${entity.name}ListComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-list/${entity.name?lower_case}-list.component';
import { ${entity.name}MapComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-map/${entity.name?lower_case}-map.component';
import { ${entity.name}MapComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-map/${entity.name?lower_case}-map.component';
import { ${entity.name}QuickSearchComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-quicksearch/${entity.name?lower_case}-quicksearch.component';
import { ${entity.name}SearchComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-search/${entity.name?lower_case}-search.component';
import { ${entity.name}UpdateComponent } from './${entity.name?lower_case}/components/${entity.name?lower_case}-update/${entity.name?lower_case}-update.component';
</#list>


@NgModule({
declarations: [
<#list entities as entity>
	${entity.name}CreateComponent,
	${entity.name}EditComponent,
	${entity.name}FormComponent,
	${entity.name}ListComponent,

	${entity.name}MapComponent,

	${entity.name}MapComponent,
	${entity.name}QuickSearchComponent,
	${entity.name}SearchComponent,
	${entity.name}UpdateComponent,
</#list>
],
imports: [
	CommonModule
]
})
export class GeneratedModule { }
