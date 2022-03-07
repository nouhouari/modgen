import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Event } from 'src/app/generated/shared/models/event.model';
import { EventService } from 'src/app/generated/shared/modules/event/services/event.service';
import { State } from 'src/app/generated/shared/modules/shared/util/app.constant';

@Component({
  selector: 'event-details',
  templateUrl: './event-details.component.html',
  styleUrls: ['./event-details.component.scss']
})
export class EventDetailsComponent implements OnInit {

  event: Event;
  mapMode:State=State.VIEW;

  constructor(private route: ActivatedRoute,
              private router: Router,
              private eventService: EventService) {
  }

  ngOnInit(): void {
    let id = this.route.snapshot.paramMap.get('id');
    if (!id) {
      this.router.navigate(['']);
      return;
    }

    this.eventService.getEventById(id).subscribe(e => {
      this.event = e;
    });
  }

}
