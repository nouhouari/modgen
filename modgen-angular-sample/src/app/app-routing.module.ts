import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EventCreateComponent } from './generated/shared/modules/event/components/event-create/event-create.component';
import { EventListComponent } from './generated/shared/modules/event/components/event-list/event.component';


const routes: Routes = [
  { path: '', redirectTo: 'campaigns', pathMatch: 'full' },
  { path: 'event', component: EventListComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
