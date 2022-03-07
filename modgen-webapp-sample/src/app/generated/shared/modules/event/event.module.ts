import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { NgxPermissionsModule } from 'ngx-permissions';
// import { MaterialModule } from '../../../../../core/material/material-component/material.module';
// import { GeneratedBizModule } from '../biz/generated-biz.module';
// import { GeneratedSharedModule } from '../shared/generated-shared.module';

import { EventService } from './services/event.service';
// import { EventDetailComponent } from './components/inspection-detail/inspection-detail.component';
import { EventEditComponent } from './components/event-edit/event-edit.component';
import { EventListComponent } from './components/event-list/event.component';
import { EventQuickSearchComponent } from './components/event-quicksearch/event-quicksearch.component';
import { EventSearchComponent } from './components/event-search/event-search.component';
import { EventMapComponent } from './components/event-map/event-map.component';
import { MaterialModule } from 'src/app/core/material/material-component/material.module';
import { JsonSchemaFormModule } from '@ajsf/core';
import { GeneratedSharedModule } from '../shared/shared.module';



@NgModule({
  declarations: [
    EventEditComponent,
    EventListComponent,
    EventQuickSearchComponent,
    EventSearchComponent,
    EventMapComponent
    // EventDetailComponent,
  ],
  exports: [
    EventSearchComponent,
    EventQuickSearchComponent,
    EventListComponent,
    EventEditComponent,
    EventMapComponent,
    // EventDetailComponent
  ],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MaterialModule,
    NgxPermissionsModule.forChild(),
    JsonSchemaFormModule,
    GeneratedSharedModule,
    // GeneratedBizModule
  ],
  providers: [
    EventService
  ]
})
export class GeneratedEventModule { }
