import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Point } from 'geojson';
import { Event } from 'src/app/generated/shared/models/event.model';
import { EventService } from 'src/app/generated/shared/modules/event/services/event.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'event-create',
  templateUrl: './event-create.component.html',
  styleUrls: ['./event-create.component.scss']
})
export class EventCreateComponent implements OnInit {

  event: Event;
  isUpdate: boolean;
  location: Point;

  constructor(private router: Router,
              private eventService: EventService) { }

  ngOnInit(): void {
    this.isUpdate = !!history.state.data?.record;
    if (this.isUpdate) {
      this.event = history.state.data.record;
    } else {
      this.event = new Event();
    }
  }

  onSave(event: Event) {
    // event.location = this.location;
    event.id = null;
    this.eventService.save(event).subscribe((event) => {
      this.router.navigate([Utils.paths.EVENT.LIST]);
    });
  }

  onClickMap($event: Point) {
    this.location = $event;
  }
}
