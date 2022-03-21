import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { OrganizerSearchCriteria, Organizer } from 'src/app/generated/shared/models/organizer.model';
import { Page } from 'src/app/generated/shared/models/page.model';
import { State } from 'src/app/generated/shared/modules/shared/util/app.constant';
import { Utils } from '../../../utils/utils';

@Component({
  selector: 'organizer',
  templateUrl: './organizer.component.html',
  styleUrls: ['./organizer.component.scss']
})
export class MyOrganizerComponent implements OnInit {

  page: Page<Organizer>;
  dataSource: Organizer[];
  searchCriteria: OrganizerSearchCriteria = new OrganizerSearchCriteria();
  state = State.VIEW;

  constructor(private router: Router,
    private route: ActivatedRoute) {
  }

  ngOnInit(): void { }

  onClear($organizer: OrganizerSearchCriteria) {
    this.onSearch($organizer);
  }

  onSearch($organizer: any) {
    console.log($organizer);
    this.searchCriteria = $organizer;
  }

  onDataSource($organizer: Organizer[]) {
    this.dataSource = $organizer;
  }

  onSelectRecord($organizer: Organizer[]) {
  }

  onEditRecord($organizer: Organizer) {
    this.router.navigate([Utils.paths.ORGANIZER.EDIT, $organizer.id], {
      relativeTo: this.route,
      state: { data: { breadcrumb: 'Update', record: $organizer } }
    })
  }

  onView($organizer: string) {
    this.router.navigate([Utils.paths.ORGANIZER.DETAILS, $organizer], { relativeTo: this.route });
  }
}
