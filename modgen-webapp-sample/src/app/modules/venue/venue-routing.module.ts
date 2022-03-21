import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MyVenueCreateComponent } from './venue-create/venue-create.component';
import { MyVenueUpdateComponent } from './venue-update/venue-update.component';
import { MyVenueComponent } from './venue/venue.component';


const routes: Routes = [
  { path: '',   redirectTo: 'list', pathMatch: 'full' },
  {
    path: 'list',
    data: { breadcrumb: 'List' },
    children: [{ path: '', component: MyVenueComponent }]
  },
  {
    path: 'new',
    /* TODO update the breadcrumb */
    data: { breadcrumb: 'New' },
    children: [{ path: '', component: MyVenueCreateComponent }]
  },
  {
    path: 'update/:id',
    /* TODO update the breadcrumb */
    data: { breadcrumb: 'Update' },
    children: [{ path: '', component: MyVenueUpdateComponent }]
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MyVenueRoutingModule { }
