import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';


const routes: Routes = [
  { path: '',   redirectTo: '/event/list', pathMatch: 'full' },
  {
    path: 'event',
    loadChildren: () => import('./modules/event/event.module').then(m => m.EventModule),
    data: { breadcrumb: 'Event' }
  },
  {
    path: 'venue',
    loadChildren: () => import('./modules/venue/venue.module').then(m => m.MyVenueModule),
    data: { breadcrumb: 'Venue' }
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
