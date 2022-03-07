import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';
import { ${entity.name}SearchCriteria } from '../../../../models/${entity.name?lower_case}.model';
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import { ${attribute.type?cap_first} } from '../../../../models/${attribute.type?lower_case}.enum';
</#if>
</#list>

@Component({
  selector: 'app-${entity.name?lower_case}-search',
  templateUrl: './${entity.name?lower_case}-search.component.html'
})
export class ${entity.name}SearchComponent implements OnInit {

  @Output()
  criteria: EventEmitter<${entity.name}SearchCriteria> = new EventEmitter<${entity.name}SearchCriteria>();
  @Output()
  clear: EventEmitter<${entity.name}SearchCriteria> = new EventEmitter();
  form: FormGroup;
  searchCriteria: ${entity.name}SearchCriteria = new ${entity.name}SearchCriteria();
  <#list entity.attributes as attribute>
  <#if attribute.enumerate> 
  public ${attribute.name}Values: any[] = [
    <#list attribute.litterals as litteral>
    {
        label: '${litteral}',
        value: ${attribute.type}.${litteral},
    },
    </#list>
    ];
  </#if>
  </#list>

  constructor(private formBuilder: FormBuilder) { }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      <#list searchableAttributes as attribute>
        <#if attribute.type = "Date">
         ${attribute.name}: new FormControl(''),
         ${attribute.name}_from: new FormControl(''),
         ${attribute.name}_to: new FormControl('')<#sep>,</#sep>
        <#else>
         ${attribute.name}: new FormControl('')<#sep>,</#sep>
        </#if>
      </#list>
    });
  }

  onSearch(){
    this.searchCriteria = this.form.value;
    this.criteria.emit(this.searchCriteria);
  }

  onClear(){
    this.form.reset();
    this.clear.emit(new ${entity.name}SearchCriteria());
  }

}
