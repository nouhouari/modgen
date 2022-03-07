<page-header pagetitle="'${entity.name}'|translate" breadcrumbs="$ctrl.breadcrumb">
  <page-header-toolbar></page-header-toolbar>
</page-header>

<div class="row">
  <has-messages id="e2e-messages"></has-messages>
</div>

<div class="row pt-5 pr-20 pb-20 pl-15">
  <div class="row advance-search" ng-class="{'show-form':$ctrl.showAdvanedSearch}">
    <div id="adv-search-canvas">
     <${entity.name?lower_case}-search></${entity.name?lower_case}-search>
     <div class="adv-search-container">
      <button ng-click="$ctrl.toggle()" class="btn btn-default advsearch-expand" ng-class="{'collapsed': $ctrl.showAdvanedSearch}"></button>
     </div>
     <div class="content-container">
      <div id="das-activation-container" style="padding-left:15px"> 
        <div class="row">
          <${entity.name?lower_case}-list hide-select="true" hide-select-multi="true"></${entity.name?lower_case}-list>
        </div>
       </div>
      </div> 
     </div>
   </div>
</div>