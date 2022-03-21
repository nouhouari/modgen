import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Venue, VenueSearchCriteria } from 'src/app/generated/shared/models/venue.model';
import { VenueService } from 'src/app/generated/shared/modules/venue/services/venue.service';
import { Utils } from 'src/app/utils/utils';

@Component({
  selector: 'hz-venue',
  templateUrl: './venue.component.html',
  styleUrls: ['./venue.component.scss']
})
export class MyVenueComponent implements OnInit {

  venueSearchCriteria: VenueSearchCriteria = new VenueSearchCriteria();
  venues: Venue[];

  constructor(
    private venueService: VenueService, 
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.venueService.find(this.venueSearchCriteria).subscribe(
      venuePage => this.venues = venuePage.content
    )
  }

  onUpdate($event: Venue){

    this.router.navigate([Utils.paths.VENUE.EDIT, $event.id], {
      relativeTo: this.route,
      state: { data: { breadcrumb: 'Update', record: $event } }
    })
  }

}
