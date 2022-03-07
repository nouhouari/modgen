<page-header pagetitle="'${entity.name} > Details' | translate" breadcrumbs="$ctrl.breadcrumb">
</page-header>
<div class="row">
  <div class="col-sm-3">
    <form class="box-vertical">
      <div>
        <i class="box-highlight"> ${entity.name} details</i>
        <#list entity.attributes as attribute>
        <#if attribute.hasAnnotation("PK")>
        <i>{{ $ctrl.${entity.name?uncap_first}.${attribute.name} }}</i>
        </#if>
        </#list>
        <#list entity.attributes as attribute>
        <#if !attribute.hasAnnotation("PK")>
        <div class="form-group">
          <input type="text" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" disabled />
          <label for="${attribute.name}">${attribute.name}</label>
        </div>
        </#if>
        </#list>
      </div>  
      <div class="mt-25 ta-c">
      <button type="button" class="btn-default" ng-click="$ctrl.back()">Cancel</button>
      </div>
    </form>
  </div>
</div>