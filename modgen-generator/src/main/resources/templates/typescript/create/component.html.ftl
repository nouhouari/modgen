<page-header pagetitle="'${entity.name} > Create' | translate" breadcrumbs="$ctrl.breadcrumb">
</page-header>


<div class="row">
  <has-messages id="e2e-messages"></has-messages>
</div>

<div class="row">
  <div class="col-sm-6">
    <form class="box-vertical" id="${entity.name?uncap_first}Form" name="$ctrl.${entity.name?uncap_first}Form" no-validate>
      <div>
        <i class="box-highlight" translate> ${entity.name} create</i>
        <#list entity.attributes as attribute>
        <#if !attribute.reference>
        <!-- ${attribute.name} ${attribute.type} ${attribute.enumerate?string('yes','no')} -->
        <#if (attribute.hasAnnotation("PK") && !attribute.hasAnnotation("AUTO")) || !attribute.hasAnnotation("PK")>
        <#if attribute.enumerate>
         <div class="form-group">
          <label class="full">${attribute.name?cap_first}</label>
          <ui-select ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" theme="selectize" sicpa-ui-select>
            <ui-select-match>{{$ctrl.${entity.name?uncap_first}.${attribute.name}}}</ui-select-match>
            <ui-select-choices repeat="option in $ctrl.${attribute.name}Values">
              <span ng-bind="option"></span>
            </ui-select-choices>
          </ui-select>
        <#elseif attribute.type = "boolean">
         <div class="mt-25">
          <input type="checkbox" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" id="${attribute.name}"/>
          <label for="${attribute.name}" translate><span></span>${attribute.name}</label>
        <#elseif attribute.type = "number"> 
        <div class="form-group">
          <input type="number" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" />
          <label for="${attribute.name}" translate>${attribute.name}</label>
        <#elseif attribute.type = "Date">
        <div class="form-group flex--group" datepicker min-date="today" date-format="YYYY-MM-DD">
            <div class="flex--input">
                <input type="text" class="form-control datepicker-field" readonly id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}"/>
                <label translate>${attribute.name}</label>
            </div>
            <div class="flex--info">
                <button type="button" class="btn-default datepicker-trigger">
                    <i class="fa fa-calendar" aria-hidden="true"></i>
                </button>
            </div>
        <#else> 
        <div class="form-group">
          <input type="text" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" />
          <label for="${attribute.name}" translate>${attribute.name}</label>
        </#if>
        <#if attribute.hasValidations()>
        <#list attribute.getAnnotationGroups()["VALIDATIONS"] as va>
          <small class="help-block e2e-${entity.name?uncap_first}-${attribute.name}-${va.getDetails()['message']?replace(".", "-")}" ng-if="$ctrl.packagingUnitErrors['${attribute.name}'].message ===  '${va.getDetails()['message']}' ">{{:: '${va.getDetails()['message']}' | translate}}</small>
        </#list>
        </#if>
        </div>
        </#if>
        </#if>
        </#list>
        <#if entity.hasAnnotation("EXTENDABLE")>
        <!-- Extension fields -->
        <div class="form-group">
          <schema-field 
            type="field.displayType" context="form" 
            field="field" data="$ctrl.extensions.values"
            form="form[field.name]" editing="true"
            input-width="12" ng-repeat="field in $ctrl.flatSchema">
          </schema-field>
        </div>
        </#if>
      </div>  
      <div class="mt-25 ta-c">
      <button type="button" class="btn-default" ng-click="$ctrl.back()" translate>Cancel</button>
      <button type="submit" class="btn-primary" ng-click="$ctrl.save($ctrl.${entity.name?uncap_first})" ng-disabled="${entity.name?uncap_first}Form.$invalid" translate>Create</button>
      </div>
    </form>
  </div>
</div>