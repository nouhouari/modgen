import { Component, EventEmitter, OnInit, Output, Input, OnChanges, SimpleChanges } from '@angular/core';
import { Action } from '../../../../models/action.model';
import { ${entity.name}, ${entity.name}SearchCriteria } from '../../../../models/${entity.name?lower_case}.model';
import { Page } from '../../../../models/page.model';
import { MatDialog } from '@angular/material/dialog';
import { ${entity.name}Service } from '../../services/${entity.name?lower_case}.service';
import { DialogComponent } from '../../../shared/components/dialog/dialog.component';

@Component({
  selector: 'app-${entity.name?lower_case}-list',
  templateUrl: './${entity.name?lower_case}.component.html',
  styleUrls: ['./${entity.name?lower_case}.component.scss']
})
export class ${entity.name}ListComponent implements OnInit, OnChanges {

  page: Page<${entity.name}>;
  dataSource : ${entity.name}[]=[];
  @Output()
  loading: EventEmitter<boolean> = new EventEmitter<boolean>();
  @Input()
  searchCriteria: ${entity.name}SearchCriteria = new ${entity.name}SearchCriteria();
  @Input()
  actions: Action[];
  @Output()
  select: EventEmitter<${entity.name}[]> = new EventEmitter<${entity.name}[]>();
  @Output()
  update: EventEmitter<${entity.name}> = new EventEmitter<${entity.name}>();
  @Output()
  view: EventEmitter<string> = new EventEmitter<string>();
  @Output()
  data: EventEmitter<${entity.name}[]> = new EventEmitter<${entity.name}[]>();
  displayedColumns: string[] = [ <#list entity.attributes as attribute><#if !attribute.reference && !attribute.hasAnnotation('ListHide')&& !attribute.hasAnnotation("PK")>'${attribute.name}',</#if></#list>'action'];
  @Input()
  pageSizeOptions:any[]=[5, 10, 20, 30, 50];
  private currentPageSize: number;

  constructor(
    protected ${entity.name?uncap_first}Service: ${entity.name}Service,
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
  	this.searchCriteria.size = this.pageSizeOptions[0];
    this.currentPageSize = this.pageSizeOptions[0];
  	this.load();
  }
  
  /**
   * Load the data using the search criteria
   */
  public load() {
    this.loading.emit(true);
    this.searchCriteria.size = this.currentPageSize;
    this.${entity.name?uncap_first}Service.quickSearch(this.searchCriteria).subscribe(
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
    this.${entity.name?uncap_first}Service.delete${entity.name}ById(id).subscribe(
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
   * Confirm the deletion of a ${entity.name}
   */
  confirmRemoval(id): void {
    const dialogRef = this.dialog.open(DialogComponent, {
      maxWidth: 350,
      data: {
        title: 'Confirm',
        content: 'Are you sure you want to delete this ${entity.name?lower_case}?'
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
