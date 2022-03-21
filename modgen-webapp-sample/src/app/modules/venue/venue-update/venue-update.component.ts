import { Component, Input } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Point } from 'geojson';
import { Media, MediaSearchCriteria } from 'src/app/generated/shared/models/media.model';
import { Venue } from 'src/app/generated/shared/models/venue.model';
import { MediaService } from 'src/app/generated/shared/modules/media/services/media.service';
import { VenueUpdateComponent } from 'src/app/generated/shared/modules/venue/components/venue-update/venue-update.component';
import { VenueService } from 'src/app/generated/shared/modules/venue/services/venue.service';
import { NominatimService, Place } from 'src/app/shared/services/nominatim.service';
import { Utils } from 'src/app/utils/utils';


@Component({
  selector: 'venue-update',
  templateUrl: './venue-update.component.html',
  styleUrls: ['./venue-update.component.scss']
})
export class MyVenueUpdateComponent extends VenueUpdateComponent {

  location: string;
  mapVenue: Venue[];
  venueLocation: Point;
  mediaSearchCriteria: MediaSearchCriteria = new MediaSearchCriteria();
  medias: Media[];

  constructor(
    private nominatimService: NominatimService,
    protected venueService: VenueService,
    private mediaService: MediaService,
    private router: Router,
    private activatedRoute: ActivatedRoute) {
    super(venueService);
  }

  ngOnInit(): void {
    let venueId = this.activatedRoute.snapshot.paramMap.get('id');
    this.mediaSearchCriteria.venueId = venueId;
    this.venueService.getVenueById(venueId).subscribe(
      venue => {
        this.data = venue;
        this.mapVenue = [venue];
      }
    )
    this.mediaService.find(this.mediaSearchCriteria).subscribe(
      page => this.medias = page.content
    )
  }

  onMapClicked(point: Point) {
    this.mapVenue = [new Venue()];
    this.mapVenue[0].location = point;
    console.log(point);
    this.venueLocation = point;
    this.data.location = point;
  }

  search(query) {
    this.nominatimService.findPlace(query).subscribe(
      (locations: Place[]) => {
        if (locations && locations.length > 0) {
          var place: Place = locations[0];
          var p: Point = { type: 'Point', coordinates: [place.lon, place.lat] };
          this.onMapClicked(p);
        }
      }
    )
  }

  onSave(updatedVenue: any){
    updatedVenue.id = this.data.id;
    
    if(updatedVenue.media){
      // Saving pictures
      updatedVenue.media.forEach(m =>{
        console.log('Saving...', m)
        this.mediaService.save(m).subscribe(
          m => console.log
        );
      })
    }

    // Saving venue
    this.venueService.save(updatedVenue).subscribe(
      v => {console.log(v), this.router.navigate([Utils.paths.VENUE.LIST]);},
      e => console.error
    )
  }

}
