import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { MyVenueComponent } from './venue/venue.component';


const routes: Routes = [
  { path: '',   redirectTo: 'list', pathMatch: 'full' },
  {
    path: 'list',
    data: { breadcrumb: 'List' },
    children: [{ path: '', component: MyVenueComponent }]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class MyVenueRoutingModule { }
