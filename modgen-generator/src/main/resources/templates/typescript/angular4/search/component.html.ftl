<div *ngxPermissionsOnly="['SEARCH_${entity.name?upper_case}']">
  <h4>Search ${entity.name}</h4>
  <form [formGroup]="form">
      <#list searchableAttributes as attribute>
  	    <#if attribute.type = "number">
  	    <mat-form-field appearance="standard">
          <mat-label>${attribute.name?cap_first}</mat-label>
          <input matInput type="number" placeholder="${attribute.name?cap_first}" id="${attribute.name}" formControlName="${attribute.name}" />
        </mat-form-field>
        <#elseif attribute.type = "boolean">
        <mat-checkbox id="${attribute.name}" formControlName="${attribute.name}">${attribute.name?cap_first}</mat-checkbox>
        <#elseif attribute.type = "Date">
        <mat-form-field>
          <input matInput id="${entity.name?lower_case}_${attribute.name}" [matDatepicker]="${attribute.name?cap_first}_picker" placeholder="Choose a ${attribute.name?cap_first}" formControlName="${attribute.name}">
          <mat-datepicker-toggle matSuffix [for]="${attribute.name?cap_first}_picker"></mat-datepicker-toggle>
          <mat-datepicker #${attribute.name?cap_first}_picker></mat-datepicker>
        </mat-form-field>
        <mat-form-field>
          <input matInput id="${entity.name?lower_case}_${attribute.name}_from" [matDatepicker]="${attribute.name?cap_first}_picker_from" placeholder="Choose a from ${attribute.name?cap_first}" formControlName="${attribute.name}_from">
          <mat-datepicker-toggle matSuffix [for]="${attribute.name?cap_first}_picker_from"></mat-datepicker-toggle>
          <mat-datepicker #${attribute.name?cap_first}_picker_from></mat-datepicker>
        </mat-form-field>
        <mat-form-field>
          <input matInput id="${entity.name?lower_case}_${attribute.name}_to" [matDatepicker]="${attribute.name?cap_first}_picker_to" placeholder="Choose a to ${attribute.name?cap_first}" formControlName="${attribute.name}_to">
          <mat-datepicker-toggle matSuffix [for]="${attribute.name?cap_first}_picker_to"></mat-datepicker-toggle>
          <mat-datepicker #${attribute.name?cap_first}_picker_to></mat-datepicker>
        </mat-form-field>
        <#elseif attribute.enumerate>
        <mat-form-field appearance="standard" id="${attribute.name}">
          <mat-label>Select ${attribute.name}</mat-label>
          <mat-select formControlName="${attribute.name}">
            <mat-option *ngFor="let option of ${attribute.name}Values" [value]="option.value">{{option.label}}</mat-option>
          </mat-select>
        </mat-form-field>
        <#else>
        <mat-form-field appearance="standard">
          <mat-label>${attribute.name?cap_first}</mat-label>
          <input matInput placeholder="${attribute.name?cap_first}" id="${attribute.name}" formControlName="${attribute.name}" />
        </mat-form-field>
        </#if>
      </#list>
      <button mat-flat-button color="primary" id="${entity.name?lower_case}_clear_button" (click)="onClear()">Clear</button>&nbsp;<button  mat-flat-button color="primary" id="${entity.name?lower_case}_search_button" (click)="onSearch()">Search</button> 
  </form>
</div>
