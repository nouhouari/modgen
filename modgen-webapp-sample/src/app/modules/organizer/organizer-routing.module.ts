import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { MyOrganizerCreateComponent } from './organizer-create/organizer-create.component';
import { MyOrganizerDetailsComponent } from './organizer-details/organizer-details.component';
import { MyOrganizerUpdateComponent } from './organizer-update/organizer-update.component';
import { MyOrganizerComponent } from './organizer/organizer.component';

const routes: Routes = [
  { path: '',   redirectTo: 'list', pathMatch: 'full' },
  {
    path: 'list',
    data: { breadcrumb: 'List' },
    children: [{ path: '', component: MyOrganizerComponent }]
  },
  {
    path: 'new',
    data: { breadcrumb: 'New' },
    children: [{ path: '', component: MyOrganizerCreateComponent }]
  },
  {
    path: 'update/:id',
    data: { breadcrumb: 'Update' },
    children: [{ path: '', component: MyOrganizerUpdateComponent }]
  },
  {
    path: 'details/:id',
    data: { breadcrumb: 'Details' },
    children: [{ path: '', component: MyOrganizerDetailsComponent }]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class OrganizerRoutingModule { }
