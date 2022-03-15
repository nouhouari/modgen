import { Component, EventEmitter, OnInit, Output, Input, OnChanges, SimpleChanges } from '@angular/core';
import { Action } from '../../../../models/action.model';
import { Event, EventSearchCriteria } from '../../../../models/event.model';
import { Page } from '../../../../models/page.model';
import { MatDialog } from '@angular/material/dialog';
import { EventService } from '../../services/event.service';
import { DialogComponent } from '../../../shared/components/dialog/dialog.component';

@Component({
  selector: 'app-event-list',
  templateUrl: './event.component.html',
  styleUrls: ['./event.component.scss']
})
export class EventListComponent implements OnInit, OnChanges {

  page: Page<Event>;
  dataSource : Event[]=[];
  @Output()
  loading: EventEmitter<boolean> = new EventEmitter<boolean>();
  @Input()
  searchCriteria: EventSearchCriteria = new EventSearchCriteria();
  @Input()
  actions: Action[];
  @Output()
  select: EventEmitter<Event[]> = new EventEmitter<Event[]>();
  @Output()
  update: EventEmitter<Event> = new EventEmitter<Event>();
  @Output()
  view: EventEmitter<string> = new EventEmitter<string>();
  @Output()
  data: EventEmitter<Event[]> = new EventEmitter<Event[]>();
  displayedColumns: string[] = [ 'name','description','startDate','organizer','endDate','type','timeZone','format','active','action'];
  pageSizeOptions:any[]=[5, 10, 20, 30, 50];
  private currentPageSize: number;

  constructor(
    protected eventService: EventService,
    public dialog: MatDialog) {
      this.searchCriteria.page = 0;
      this.currentPageSize = this.pageSizeOptions[0];
    }

  ngOnInit(): void { }
  
  /**
   * Listner on the data input
   */
  ngOnChanges(changes: SimpleChanges): void {
  	this.searchCriteria = changes.searchCriteria.currentValue;
  	this.load();
  }
  
  /**
   * Load the data using the search criteria
   */
  public load() {
    this.loading.emit(true);
    this.searchCriteria.size = this.currentPageSize;
    this.eventService.quickSearch(this.searchCriteria).subscribe(
      page => {
        this.page = page;
        this.dataSource = this.page.content;
        this.loading.emit(false);
        this.data.emit(page.content);
      },
      () =>{
        this.loading.emit(false);
      }
    );
  }

  /**
   * Go to next page.
   */
  next(){
    if (this.searchCriteria.page < this.page.totalPages - 1){
      this.searchCriteria.page = this.searchCriteria.page+1;
      this.load();
    }
  }

  /**
   * Go to previous page.
   */
  previous(){
    if (this.searchCriteria.page>0){
      this.searchCriteria.page = this.searchCriteria.page-1;
      this.load();
    }
  }

  /**
   * Sort the table.
   */
  sort(column, order){
    this.searchCriteria.sort = [column, order];
    this.load();
  }

  /**
   * Delete an item
   */
  delete(id){
    this.loading.emit(true);
    this.eventService.deleteEventById(id).subscribe(
      () => this.load(),
      () =>{
        this.loading.emit(false);
      }
    );
  }
  
  /**
   * Emit an event when we select an item.
   * @param e Selected item
   */
  onSelect(e){
    this.select.emit(e);
  }

  /**
   * Send update event.
   * @param e Campaign to update
   */
  onUpdate(e){
    this.update.emit(e);
  }
  
  /**
   * Handle paginator event.
   */
  onChangePage($event){
    this.currentPageSize = +$event.pageSize; // get the pageSize
    this.searchCriteria.page = +$event.pageIndex; // get the current page
    this.load();
  }
  
  /**
   * Confirm the deletion of a Event
   */
  confirmRemoval(id): void {
    const dialogRef = this.dialog.open(DialogComponent, {
      maxWidth: 350,
      data: {
        title: 'Confirm',
        content: 'Are you sure you want to delete this event?'
      }
    });
    dialogRef.afterClosed().subscribe((result: boolean) => {
      if (result) {
        this.delete(id);
      }
    });
  }

  onView(element) {
    this.view.emit(element.id);
  }
}
