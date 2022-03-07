<div id="side-form" class="advance-menu">
      <form class="form pt-5 pr-20 pb-20 pl-20" id="${entity.name?uncap_first}SeachForm" name="${entity.name?uncap_first}SeachForm">
        <h3>Advanced Search</h3>
        <#list searchableAttributes as attribute>
        <#if attribute.type = "number">
        <div class="form-group mt-25">
          <input type="number" class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.from${attribute.name?cap_first}" />
          <label>from${attribute.name?cap_first}</label>
        </div>
        <div class="form-group mt-25">
          <input type="number" class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.to${attribute.name?cap_first}" />
          <label>to${attribute.name?cap_first}</label>
        </div>
        <div class="form-group mt-25">
          <input type="number" class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.${attribute.name}" />
          <label>${attribute.name}</label>
        </div>
        <#elseif attribute.type = "boolean">
        <div class="mt-25">
          <input type="checkbox" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.${attribute.name}" />
          <label for="${attribute.name}"><span></span>${attribute.name}</label>
        </div>
        <#elseif attribute.type = "Date">
        <div class="form-group mt-25">
          <input type="text" datepicker class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.from${attribute.name?cap_first}" />
          <label>from${attribute.name?cap_first}</label>
        </div>
        <div class="form-group mt-25">
          <input type="text" datepicker class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.to${attribute.name?cap_first}" />
          <label>to${attribute.name?cap_first}</label>
        </div>
        <div class="form-group mt-25">
          <input type="text" datepicker class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.${attribute.name}" />
          <label>${attribute.name}</label>
        </div>
        <#elseif attribute.enumerate>
        <div class="form-group mt-25">
          <select ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.${attribute.name}" id="${attribute.name}">
            <option></option>
            <option ng-repeat="option in $ctrl.${attribute.name}Values" value="{{option.value}}">{{option.label}}</option>
          </select>
         </div>
        <#else>
        <div class="form-group mt-25">
          <input type="text" class="form-control" ng-model="$ctrl.${entity.name?lower_case}SearchCriteria.${attribute.name}" />
          <label>${attribute.name}</label>
        </div>
        </#if>
        </#list>
        <div class="mt-25 ta-c pull-right">
          <button type="button" class="btn-default" ng-click="$ctrl.clear()">Cancel</button>
          <button type="submit" class="btn-primary" ng-click="$ctrl.search()" ng-disabled="${entity.name?uncap_first}SeachForm.$invalid">Validate</button>
        </div>
      </form>
  </div>