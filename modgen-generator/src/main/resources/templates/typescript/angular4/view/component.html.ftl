<form [formGroup]="form" *ngxPermissionsOnly="['READ_${entity.name?upper_case}']">
  <#list entity.attributes as attribute>
        <#if attribute.hasAnnotation("PK") || attribute.reference>
        <#continue>
        </#if>
        <#if attribute.type = "number">
        <mat-form-field>
          <input readonly type="number" matInput placeholder="${attribute.name?cap_first}" id="${entity.name?lower_case}_${attribute.name?cap_first}" name="${attribute.name?cap_first}" formControlName="${attribute.name}">
        </mat-form-field>
        <br>
  	    <#elseif attribute.type = "boolean">
        <mat-checkbox id="${attribute.name}" formControlName="${attribute.name}">${attribute.name}</mat-checkbox><br>
        <#elseif attribute.type = "Date">
        <mat-form-field>
          <input matInput readonly[matDatepicker]="${attribute.name?cap_first}_picker" placeholder="Choose a ${attribute.name?cap_first}" formControlName="${attribute.name}">
          <mat-datepicker-toggle matSuffix [for]="${attribute.name?cap_first}_picker"></mat-datepicker-toggle>
          <mat-datepicker #${attribute.name?cap_first}_picker></mat-datepicker>
        </mat-form-field><br>
        <#elseif attribute.enumerate>
        <mat-form-field>
          <mat-label>${attribute.name}</mat-label>
          <mat-select id="${attribute.name}" formControlName="${attribute.name}" readonly>
            <mat-option *ngFor="let option of  ${attribute.name}Values" [value]="option.value">
              {{option.label}}
            </mat-option>
          </mat-select>
        </mat-form-field>
        <br>
        <#else>
        <mat-form-field>
          <input readonly matInput placeholder="${attribute.name?cap_first}" id="${entity.name?lower_case}_${attribute.name?cap_first}" name="${attribute.name?cap_first}" formControlName="${attribute.name}">
        </mat-form-field>
        <br>
        </#if>
  </#list>
  <#if entity.hasAnnotation('EXTENDABLE')>
  <!-- Extension -->
  <div *ngIf="schema">
    <label>Extension</label><br>
    <json-schema-form
    #${entity.name?lower_case}_extension
    [loadExternalAssets]=true
    framework="material-design"
    [schema]="schema.schema"
    [layout]="schema.layout"
    [options]="options"
    (isValid)="isExtensionValid($event)"
    >
    </json-schema-form>
  </div>  
  </#if>
</form>
