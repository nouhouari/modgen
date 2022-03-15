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
import { EventCreateComponent } from './components/event-create/event-create.component';
import { EventEditComponent } from './components/event-edit/event-edit.component';
import { EventViewComponent } from './components/event-view/event-view.component';
import { EventListComponent } from './components/event-list/event.component';
import { EventQuickSearchComponent } from './components/event-quicksearch/event-quicksearch.component';
import { EventSearchComponent } from './components/event-search/event-search.component';
import { EventUpdateComponent } from './components/event-update/event-update.component';
import { GeneratedEventRoutingModule } from './event-routing.module';
import { EventService } from './services/event.service';
import { GeneratedSharedModule } from '../shared/shared.module';


@NgModule({
declarations: [
	EventCreateComponent,
	EventEditComponent,
	EventListComponent,
	EventViewComponent,
	EventQuickSearchComponent,
	EventSearchComponent,
	EventUpdateComponent,
],
imports: [
	CommonModule,
	GeneratedSharedModule,
	// GeneratedEventRoutingModule
],
exports: [
  EventCreateComponent,
  EventEditComponent,
  EventListComponent,
  EventViewComponent,
  EventQuickSearchComponent,
  EventSearchComponent,
  EventUpdateComponent,
],
providers: [
	EventService
]
})
export class GeneratedEventModule { }
