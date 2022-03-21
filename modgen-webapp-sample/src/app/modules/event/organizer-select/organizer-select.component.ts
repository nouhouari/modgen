import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges } from '@angular/core';
import { FormControl } from '@angular/forms';
import { MatAutocompleteSelectedEvent } from '@angular/material/autocomplete';
import { filter, map, Observable, startWith } from 'rxjs';
import { Organizer, OrganizerSearchCriteria } from 'src/app/generated/shared/models/organizer.model';
import { OrganizerService } from 'src/app/generated/shared/modules/organizer/services/organizer.service';

@Component({
  selector: 'organizer-select',
  templateUrl: './organizer-select.component.html',
  styleUrls: ['./organizer-select.component.scss']
})
export class OrganizerSelectComponent implements OnInit, OnChanges {

  organizerQuickSearchQuery: OrganizerSearchCriteria = new OrganizerSearchCriteria();
  filteredOptions: Observable<Organizer[]>;
  organizerControl = new FormControl();
  @Output()
  selected: EventEmitter<Organizer> = new EventEmitter<Organizer>();
  @Input()
  organizer: Organizer;

  constructor(private organizerService: OrganizerService) { }

  ngOnInit(): void {
    
    if(this.organizer){
      this.organizerControl = new FormControl(this.organizer);
    }

    this.filteredOptions = this.organizerService.find(this.organizerQuickSearchQuery).pipe(
      map(page => page.content)
    );

    this.organizerControl.valueChanges.pipe(
      startWith(''),
      filter(value => value instanceof String),
      map((value: string) => this._filter(value)
      )).subscribe();

    this.organizerQuickSearchQuery.size = 20;
  }

  ngOnChanges(changes: SimpleChanges): void {
   this.organizer = changes.organizer.currentValue;
  }

  getPath(fileName: string) {
    return 'api/file?fileName=' + fileName;
  }
  
  displayFn(organizer: Organizer): string {
    if (organizer == null) {
      return;
    }
    return organizer.firstName + ' ' + organizer.lastName;
  }

  onSelected(sectedEvent: MatAutocompleteSelectedEvent){
    this.selected.emit(sectedEvent.option.value);
  }

  private _filter(value: string) {
    const filterValue = value.toLowerCase();
    this.organizerQuickSearchQuery.quickSearchQuery = value;
    this.filteredOptions = this.organizerService.quickSearch(this.organizerQuickSearchQuery).pipe(
      map(page => page.content)
    );
  }
}
