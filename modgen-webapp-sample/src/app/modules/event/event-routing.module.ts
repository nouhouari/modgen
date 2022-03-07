import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { EventCreateComponent } from './event-create/event-create.component';
import { EventDetailsComponent } from './event-details/event-details.component';
import { EventEditComponent } from './event-edit/event-edit.component';
import { EventComponent } from './event/event.component';

const routes: Routes = [
  { path: '',   redirectTo: 'list', pathMatch: 'full' },
  {
    path: 'list',
    data: { breadcrumb: 'List' },
    children: [{ path: '', component: EventComponent }]
  },
  {
    path: 'new',
    /* TODO update the breadcrumb */
    data: { breadcrumb: 'New' },
    children: [{ path: '', component: EventCreateComponent }]
  },
  {
    path: 'edit/:id',
    /* TODO update the breadcrumb */
    data: { breadcrumb: 'Edit' },
    children: [{ path: '', component: EventEditComponent }]
  },
  {
    path: 'details/:id',
    /* TODO update the breadcrumb */
    data: { breadcrumb: 'Details' },
    children: [{ path: '', component: EventDetailsComponent }]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EventRoutingModule { }
