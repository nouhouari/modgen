import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ${entity.name}SearchCriteria } from '../../../../models/${entity.name?lower_case}.model';


@Component({
  selector: 'app-${entity.name?lower_case}-quicksearch',
  templateUrl: './${entity.name?lower_case}-quicksearch.component.html'
})
export class ${entity.name}QuickSearchComponent implements OnInit {

  @Input()
  title: string;
  @Output()
  criteria: EventEmitter<${entity.name}SearchCriteria> = new EventEmitter<${entity.name}SearchCriteria>();
  @Output()
  clear: EventEmitter<any> = new EventEmitter();
  form: FormGroup;
  searchCriteria: ${entity.name}SearchCriteria = new ${entity.name}SearchCriteria();
  
  constructor(private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      quickSearchQuery: new FormControl('')
    });
  }

  onSearch(){
    this.searchCriteria = this.form.value;
    this.criteria.emit(this.searchCriteria);
  }

  onClear(){
    this.form.reset();
    this.clear.emit();
  }

}
