import { FormBuilder, FormControl, FormGroup } from '@angular/forms';

<#--<#list entity.attributes as attribute>-->
<#--<#if attribute.enumerate>-->
<#--import { ${attribute.type?cap_first} } from '../../models/${attribute.type?lower_case}.enum';-->
<#--</#if>-->
<#--</#list>-->

export class ${entity.name}Form {
  private _form: FormGroup;

  constructor(formBuilder: FormBuilder) {
    this._form = formBuilder.group({
      <#list entity.attributes as attribute>
      <#if !attribute.reference>
      // ${attribute.name} field
      ${attribute.name}: new FormControl('')<#sep>,</#sep>
      </#if>
      </#list>
    });
  }

  public get form() {
    return this._form;
  }
}
