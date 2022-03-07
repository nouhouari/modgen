<!-- 
 @author Nourreddine HOUARI (nourreddine.houari@)
 @author Venkaiah Chowdary Koneru <VenkaiahChowdary.Koneru@>
 Generated by : ${generator}
 Version      : ${version}
 Date         : ${today}
-->

<section class="content-header">
<div>
  <div class="panel panel-default">
    <!-- Panel Heading -->
    <div class="panel-heading">
        <div class="pull-right">
            <span class="glyphicon glyphicon-pencil" data-toggle="tooltip" title="Edit this" ng-click="edit${entity.name}(${entity.name?lower_case}Obj)"></span>
            <span class="glyphicon glyphicon-trash" data-toggle="tooltip" title="Remove this" ng-click="delete${entity.name}(${entity.name?lower_case}Obj)"></span>
        </div>
        <div class="clearfix"></div>
	</div> 
	
	<!-- Panel Body -->
    <div class="panel-body">
<#list entity.attributes as attribute>
 <#if !attribute.reference>
	<div class="form-group">
	 <!-- ${attribute.type} -->
      <label for="${attribute.name?uncap_first}">${attribute.name?cap_first}</label><br>      
      <#if attribute.type== "Date">
      <p name="${attribute.name?uncap_first}" ng-bind="convertDate(${entity.name?lower_case}Obj.${attribute.name?uncap_first})"/>
      <#elseif attribute.type == "Boolean">
      <input type="checkbox" disabled name="${attribute.name?uncap_first}" ng-model="${entity.name?lower_case}Obj.${attribute.name?uncap_first}"/> 
	  <#elseif attribute.enumerate>
      <!-- ENUM -->
      <select ng-model="${entity.name?lower_case}Obj.${attribute.name?uncap_first}" disabled>
    		<option ng-selected="{{${attribute.name}.value == ${entity.name?lower_case}Obj.${attribute.name?uncap_first}}}"
            ng-repeat="${attribute.name} in ${attribute.name}_items"
            value="{{${attribute.name}.label}}">
      {{${attribute.name}.label}}
    		</option>
		</select>
      <#else>
      <#if attribute.hasAnnotation("LINK")>
	  <a ng-href="{{ ${entity.name?lower_case}Obj.${attribute.name?uncap_first} }}">{{ ${entity.name?lower_case}Obj.${attribute.name?uncap_first} }}</a>	
      <#else>
      <p ng-bind="${entity.name?lower_case}Obj.${attribute.name?uncap_first}"></p> 
      </#if>
      </#if>
    </div>
  </#if>
</#list>
 <div ng-cloak>
   <md-content>
      <md-tabs md-dynamic-height md-border-bottom>
<#list entity.attributes as attribute>
  <#if attribute.reference>
       <md-tab label="${attribute.name?cap_first}">		
        <md-content class="md-padding">
      <#if attribute.model.hasAnnotation("UDT")>
      <div class="panel panel-default">
      	<div class="panel-heading">${attribute.name?cap_first}</div>
      	<div class="panel-body">
       <#list attribute.model.attributes as udtAttribute>
         <#if attribute.type== "Date">
       <label name="${udtAttribute.name?uncap_first}" ng-bind="convertDate(${entity.name?lower_case}Obj.${attribute.name?uncap_first}DTO.${udtAttribute.name?uncap_first})"/><br>
         <#else>   
       <label name="${udtAttribute.name?uncap_first}" ng-bind="${entity.name?lower_case}Obj.${attribute.name?uncap_first}DTO.${udtAttribute.name?uncap_first}"/><br>
         </#if>
	   </#list>
      	</div>
      </div>
      <#else>
      <#if attribute.multiplicity == -1>
      <div ng-include="'views/generated/${attribute.model.name?lower_case}-table.html'" ng-controller="${attribute.model.name}Ctrl"></div>
      <#else>
      <div ng-include="'views/generated/${attribute.model.name?lower_case}-details.html'" ng-controller="${attribute.model.name}Ctrl"></div>
	  </#if>		
      </#if>
       </md-content>
     </md-tab> 
  </#if>
</#list>
 </md-tabs>
   </md-content>
  </div>

      <button type="button" class="btn btn-primary pull-right" onClick="history.back()" ng-hide="embedded${entity.name}">Back</button>
    </div> 
  </div>
</div>
</section>