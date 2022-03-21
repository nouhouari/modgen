import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { filter, map, Observable, startWith } from 'rxjs';
import { Venue, VenueSearchCriteria } from 'src/app/generated/shared/models/venue.model';
import { VenueService } from 'src/app/generated/shared/modules/venue/services/venue.service';

@Component({
  selector: 'venue-select',
  templateUrl: './venue-select.component.html',
  styleUrls: ['./venue-select.component.scss']
})
export class VenueSelectComponent implements OnInit, OnChanges {

  venueQuickSearchQuery: VenueSearchCriteria = new VenueSearchCriteria();
  filteredOptions: Observable<Venue[]>;
  venueControl = new FormControl();
  @Output()
  selected: EventEmitter<Venue> = new EventEmitter<Venue>();
  @Input()
  venue: Venue;

  constructor(private venueService: VenueService) { }

  ngOnInit(): void {
    
    if(this.venue){
      this.venueControl = new FormControl(this.venue);
    }

    this.filteredOptions = this.venueService.find(this.venueQuickSearchQuery).pipe(
      map(page => page.content)
    );

    this.venueControl.valueChanges.pipe(
      startWith(''),
      filter(value => value instanceof String),
      map((value: string) => this._filter(value)
      )).subscribe();

    this.venueQuickSearchQuery.size = 20;
  }

  ngOnChanges(changes: SimpleChanges): void {
   this.venue = changes.venue.currentValue;
  }

  getPath(fileName: string) {
    return 'api/file?fileName=' + fileName;
  }
  
  displayFn(venue: Venue): string {
    if (venue == null) {
      return;
    }
    return venue.name;
  }

  onSelected(sectedEvent: MatAutocompleteSelectedEvent){
    this.selected.emit(sectedEvent.option.value);
  }

  private _filter(value: string) {
    const filterValue = value.toLowerCase();
    this.venueQuickSearchQuery.quickSearchQuery = value;
    this.filteredOptions = this.venueService.quickSearch(this.venueQuickSearchQuery).pipe(
      map(page => page.content)
    );
  }
}
