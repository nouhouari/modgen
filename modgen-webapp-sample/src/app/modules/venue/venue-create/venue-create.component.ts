import { Component } from '@angular/core';
import { Point } from 'geojson';
import { Venue } from 'src/app/generated/shared/models/venue.model';
import { VenueCreateComponent } from 'src/app/generated/shared/modules/venue/components/venue-create/venue-create.component';
import { VenueService } from 'src/app/generated/shared/modules/venue/services/venue.service';
import { NominatimService, Place } from 'src/app/shared/services/nominatim.service';


@Component({
  selector: 'venue-create',
  templateUrl: './venue-create.component.html',
  styleUrls: ['./venue-create.component.scss']
})
export class MyVenueCreateComponent extends VenueCreateComponent {

  location: string;
  mapVenue: Venue[];
  venueLocation: Point;
  venue: Venue = new Venue();

  constructor(private nominatimService: NominatimService, protected venueService: VenueService){
    super(venueService);
  }

  onMapClicked(point: Point){
    this.mapVenue = [new Venue()];
    this.mapVenue[0].location = point;
    console.log(point);
    this.venueLocation = point;
    this.venue.location = point;
  }

  search(query){
    this.nominatimService.findPlace(query).subscribe(
      (locations: Place[]) => {
        if (locations && locations.length>0){
          var place:Place = locations[0];
          var p:Point = {type:'Point', coordinates: [place.lon, place.lat]};
          this.onMapClicked(p);
        }
      }
    )
  }

}
