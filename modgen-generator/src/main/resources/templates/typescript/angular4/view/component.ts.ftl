import { Component, EventEmitter, Input, OnChanges, OnInit, Output, SimpleChanges<#if entity.hasAnnotation("EXTENDABLE")>, ViewChild</#if> } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ${entity.name} } from '../../../../models/${entity.name?lower_case}.model';
import { ${entity.name}Form } from '../${entity.name?lower_case}-form/${entity.name?lower_case}.form';
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import { ${attribute.type?cap_first} } from '../../../../models/${attribute.type?lower_case}.enum';
</#if>
</#list>
<#if entity.hasAnnotation("EXTENDABLE")>
import { JsonSchemaFormComponent } from '@ajsf/core';
</#if>

@Component({
  selector: 'app-${entity.name?lower_case}-view',
  templateUrl: './${entity.name?lower_case}-view.component.html'
})
export class ${entity.name}ViewComponent implements OnInit, OnChanges {

  public form: FormGroup;
  @Input()
  public data: ${entity.name};
  @Output()
  public save: EventEmitter<${entity.name}> = new EventEmitter<${entity.name}>();
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
  <#if entity.hasAnnotation("EXTENDABLE")>
  @Input()
  public schema: any;
  // JSON extension configuration
  @ViewChild(JsonSchemaFormComponent, {static: true})
  public extensionForm: JsonSchemaFormComponent;
  public extensionValid: boolean;
  options = {addSubmit: false};
  </#if>

  constructor(protected formBuilder: FormBuilder) { }

  ngOnChanges(changes: SimpleChanges): void {
    if (this.form){
      this.form.patchValue(changes.data.currentValue);
      <#if entity.hasAnnotation("EXTENDABLE")>
      this.extensionForm.setFormValues(changes.data.currentValue.extension.extension);
      </#if>
    }
  }

  ngOnInit(): void {
    this.form = new ${entity.name}Form(this.formBuilder).form;
      if (this.data) {
        this.form.patchValue(this.data);
      }
  }

  <#if entity.hasAnnotation("EXTENDABLE")>
  
  public isExtensionValid(isValid: boolean){
    this.extensionValid = isValid;
  }
  </#if>
}
