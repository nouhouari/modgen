import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { EventSearchCriteria, Event } from 'src/app/generated/shared/models/event.model';
import { Page } from 'src/app/generated/shared/models/page.model';
import { State } from 'src/app/generated/shared/modules/shared/util/app.constant';
import { Utils } from '../../../utils/utils';

@Component({
  selector: 'hz-event',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.scss']
})
export class EventComponent implements OnInit {

  page: Page<Event>;
  dataSource: Event[];
  searchCriteria: EventSearchCriteria = new EventSearchCriteria();
  state = State.VIEW;

  constructor(private router: Router,
    private route: ActivatedRoute) {
  }

  ngOnInit(): void { }

  onClear($event: EventSearchCriteria) {
    this.onSearch($event);
  }

  onSearch($event: any) {
    console.log($event);
    
    this.searchCriteria = $event;
  }

  onDataSource($event: Event[]) {
    this.dataSource = $event;
  }

  onSelectRecord($event: Event[]) {
  }

  onEditRecord($event: Event) {
    this.router.navigate([Utils.paths.EVENT.EDIT, $event.id], {
      relativeTo: this.route,
      state: { data: { breadcrumb: 'Edit', record: $event } }
    })
  }

  onView($event: string) {
    this.router.navigate([Utils.paths.EVENT.DETAILS, $event], { relativeTo: this.route });
  }
}
