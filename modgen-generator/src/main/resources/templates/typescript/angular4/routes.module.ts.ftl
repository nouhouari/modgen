import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ${entity.name}CreateComponent } from './components/${entity.name?lower_case}-create/${entity.name?lower_case}-create.component';
import { ${entity.name}ViewComponent } from './components/${entity.name?lower_case}-view/${entity.name?lower_case}-view.component';
import { ${entity.name}EditComponent } from './components/${entity.name?lower_case}-edit/${entity.name?lower_case}-edit.component';
import { ${entity.name}ListComponent } from './components/${entity.name?lower_case}-list/${entity.name?lower_case}.component';

const routes: Routes = [
  { path: '',   redirectTo: 'list', pathMatch: 'full' },
  {
    path: 'list',
    data: { breadcrumb: 'List' },
    children: [{ path: '', component: ${entity.name}ListComponent}]
  },
  {
    path: 'create',
    data: { breadcrumb: 'Create' },
    children: [{ path: '', component: ${entity.name}CreateComponent }]
  },
  {
    path: 'edit/:id',
    data: { breadcrumb: 'Edit' },
    children: [{ path: '', component: ${entity.name}EditComponent }]
  },
  {
    path: 'view/:id',
    data: { breadcrumb: 'View' },
    children: [{ path: '', component: ${entity.name}ViewComponent }]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class Generated${entity.name?cap_first}RoutingModule { }
