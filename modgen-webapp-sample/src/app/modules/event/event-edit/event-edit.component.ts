import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Point } from 'geojson';
import { Event } from 'src/app/generated/shared/models/event.model';
import { EventService } from 'src/app/generated/shared/modules/event/services/event.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'hz-event-edit',
  templateUrl: './event-edit.component.html',
  styleUrls: ['./event-edit.component.scss']
})
export class EventEditComponent implements OnInit {

  location: Point;
  event: Event;

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private eventService: EventService) { }

  ngOnInit(): void {
    let eventId = this.activatedRoute.snapshot.paramMap.get('id');
    this.eventService.getEventById(eventId).subscribe(
      ev => this.event = ev
    )
  }

  onSave(event: Event) {
    if (this.location){
      event.location = this.location;
    }
    console.log(event);
    this.eventService.save(event).subscribe((event) => {
      this.router.navigate([Utils.paths.EVENT.LIST]);
    });
  }

  onClickMap($event: Point) {
    this.location = $event;
    console.log('Selected location', this.location);  
  }

}
