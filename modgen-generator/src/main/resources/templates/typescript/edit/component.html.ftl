	<page-header pagetitle="'${entity.name} > Edit' | translate" breadcrumbs="$ctrl.breadcrumb">
</page-header>

<div class="row">
  <has-messages id="e2e-messages"></has-messages>
</div>

<div class="row">
  <div class="col-md-10">
    <form>
      <div>
        <i class="box-highlight"> ${entity.name} edit</i>
        <#list entity.attributes as attribute>
        <#if attribute.hasAnnotation("PK")>
        <i>{{ $ctrl.${entity.name?uncap_first}.${attribute.name} }}</i>
        </#if>
        </#list>
      </div>
      <div>
        <#list entity.attributes as attribute>
        <div class="row form-group">
        <#if attribute.reference>
            <#if attribute.multiplicity=1>
            <span><button class="accordion" onclick="this.classList.toggle('active'); var panel = document.getElementById('${attribute.name}'); if (panel.style.display === 'block') {
          panel.style.display = 'none';
        } else {
          panel.style.display = 'block';
        }"><#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
            <span><i class="fa fa-plus"> </i> ${attribute.name} : {{ $ctrl.${entity.name?uncap_first}.${attribute.name}.${primaryAttribute.name} }}</span>
            </#list></button></span>
            <div class="row col-md-12 panel" id="${attribute.name}">
                <${attribute.type?lower_case}-search class="col-md-3"></${attribute.type?lower_case}-search>
                <${attribute.type?lower_case}-list group="${attribute.name}" selected="{{$ctrl.${entity.name?uncap_first}.${attribute.name}.<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}</#list>}}" class="col-md-9" hide-details="true" hide-edit="true" hide-delete="true" hide-select="false"  hide-select-multi="true" callback="$ctrl.on${attribute.name?cap_first}Selected(${attribute.type?lower_case})"></${attribute.type?lower_case}-list>
            </div>
            <#elseif attribute.multiplicity=-1>
           <div>  
             <span><button class="accordion" onclick="this.classList.toggle('active'); var panel = document.getElementById('${attribute.name}'); if (panel.style.display === 'block') {
                panel.style.display = 'none';
              } else {
               panel.style.display = 'block';
              }"><#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
             <span><i class="fa fa-plus"> </i> ${attribute.name} : {{ $ctrl.${entity.name?uncap_first}.${attribute.name}.${primaryAttribute.name} }}</span>
             </#list></button></span>
             <div class="row col-md-12 panel" id="${attribute.name}">
                <${attribute.type?lower_case}-search class="col-md-3"></${attribute.type?lower_case}-search>
                <${attribute.type?lower_case}-list  group="${attribute.name}" selected="{{$ctrl.${entity.name?uncap_first}.${attribute.name}.<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}</#list>}}" class="col-md-9" hide-details="true" hide-edit="true" hide-delete="true" hide-select="true" hide-select-multi="false" callback="$ctrl.on${attribute.name?cap_first}Selected(${attribute.type?lower_case}, checked)"></${attribute.type?lower_case}-list>
                <${attribute.type?lower_case}-list  group="${attribute.name}" selected="{{$ctrl.${entity.name?uncap_first}.${attribute.name}.<#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>${primaryAttribute.name}</#list>}}" class="col-md-9" hide-details="true" hide-edit="true" hide-delete="true" hide-select="true" hide-select-multi="true" loader="$ctrl.load${attribute.name?cap_first}(c)" use-loader="true"></${attribute.type?lower_case}-list>
             </div>
           </div>
            </#if>
        <#else>
        <#if !attribute.hasAnnotation("PK")>
        <#if attribute.enumerate>
        <div class="form-group">
          <label class="full">${attribute.name?cap_first}</label>
          <ui-select ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" theme="selectize" hin-ui-select>
            <ui-select-match>{{$ctrl.${entity.name?uncap_first}.${attribute.name}}}</ui-select-match>
            <ui-select-choices repeat="option in $ctrl.${attribute.name}Values">
              <span ng-bind="option"></span>
            </ui-select-choices>
          </ui-select>
        </div>  
        <#elseif attribute.type = "boolean">
         <div class="form-group">
          <input type="checkbox" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" id="${attribute.name}"/>
          <label for="${attribute.name}"><span></span>${attribute.name}</label>
         </div>
        <#elseif attribute.type = "number"> 
        <div class="form-group">
          <input type="number" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" />
          <label for="${attribute.name}">${attribute.name}</label>
        </div>
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
		</div>
            
        <#else>
        <div class="form-group">
          <input type="text" class="form-control" id="${attribute.name}" ng-model="$ctrl.${entity.name?uncap_first}.${attribute.name}" />
          <label for="${attribute.name}">${attribute.name}</label>
        </div>
        </#if>
        </#if>
        </#if>
        </div>
        </#list>
        <#if entity.hasAnnotation("EXTENDABLE")>
        <div class="row form-group">
          <schema-field 
            type="field.displayType" context="form" 
            field="field" data="$ctrl.${entity.name?uncap_first}.extensions"
            form="form[field.name]" editing="true"
            input-width="12" ng-repeat="field in $ctrl.flatSchema">
          </schema-field>
        </div>
        </#if>
      </div>  
      <div class="mt-25 ta-c">
      <button type="button" class="btn-default" ng-click="$ctrl.back()">Cancel</button>
      <button type="submit" class="btn-primary" ng-click="$ctrl.save($ctrl.${entity.name?uncap_first})">Update</button>
      </div>
    </form>
  </div>
</div>
