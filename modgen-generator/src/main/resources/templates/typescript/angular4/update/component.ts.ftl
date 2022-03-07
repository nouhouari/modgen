import { Component, Input, OnInit } from '@angular/core';
import { ${entity.name} } from '../../../../models/${entity.name?lower_case}.model';
import { ${entity.name}Service } from '../../services/${entity.name?lower_case}.service';

@Component({
  selector: 'app-${entity.name?lower_case}-update',
  templateUrl: './${entity.name?lower_case}-update.component.html'
})
export class ${entity.name}UpdateComponent implements OnInit {

  @Input()
  data: ${entity.name};
  <#if entity.hasAnnotation("EXTENDABLE")>
  @Input()
  public schema: any;
  </#if>

  constructor(private ${entity.name?lower_case}Service: ${entity.name}Service) { }
  
  ngOnInit(): void { }
  
  onSave(${entity.name?lower_case}: ${entity.name}){
    this.${entity.name?lower_case}Service.save(${entity.name?lower_case}).subscribe(
      console.log
    );
  }

}
