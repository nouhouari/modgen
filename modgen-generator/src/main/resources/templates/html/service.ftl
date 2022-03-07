/*
 * @author Nourreddine HOUARI <nourreddine.houari@sicpa.com>
 * @author Venkaiah Chowdary Koneru <VenkaiahChowdary.Koneru@sicpa.com>
 * Generated by : ${generator}
 * Version      : ${version}
 * Date         : ${today}
 */

'use strict';

/**
 * @ngdoc function
 * @name ${angularModule}.controller:${entity.name?cap_first}Ctrl
 * @description
 * # ${entity.name?cap_first}Service
 * Service of the ${angularModule}
 */
angular.module('${angularModule}')
  .service('${entity.name?cap_first}Service', function ($http, ajaxService, APPCONSTANTS) {
  
    $http.defaults.headers.common['Access-Control-Allow-Origin'] = '*';
    
	//Query the service with search parameters
    this.fetchAllByQuery = function(pageNumber, pageSize, sentQuery, successResultCallback, errorResultCallback) { 
        //Send the get query to fetch the result
        ajaxService.ajaxGet('/${entity.name?lower_case}/search?size='+pageSize+'&page=' + pageNumber + sentQuery, 
        		function(result, status) {
                	successResultCallback(result, status);
             	},
             	function(result) {
             		errorResultCallback(result);
             	});
    };
    
    //Delete ${entity.name?cap_first}
    this.delete${entity.name?cap_first} = function(${entity.name?lower_case}Obj, resultCallback){
        $http.delete(APPCONSTANTS.CONTEXT_PATH + '/${entity.name?lower_case}'<#list primaryAttributes as attribute>+'/'+encodeURIComponent(${entity.name?lower_case}Obj.${attribute.name?uncap_first})</#list>)
    		.then(function(result){
                resultCallback(result);   
            });
    };
    
    //Save ${entity.name?cap_first}
    this.save${entity.name?cap_first} = function(${entity.name?lower_case}Obj, successResultCallback, errorResultCallback){
    	ajaxService.ajaxPost(${entity.name?lower_case}Obj, '/${entity.name?lower_case}/', 
    			function(result, status){
    				successResultCallback(result, status);
    			},
    			function(result){
    				errorResultCallback(result);
    			});
    };
    
    //Save list of ${entity.name?cap_first}
    this.save${entity.name?cap_first}Bulk = function(${entity.name?lower_case}Obj, successResultCallback, errorResultCallback, blockUIMessage){
    	ajaxService.ajaxPost(${entity.name?lower_case}Obj, '/${entity.name?lower_case}/bulk', 
    			function(response){
    				successResultCallback(response);
    			},
    			function(){
    				errorResultCallback();
    			}, blockUIMessage);
    };
    
    //Load ${entity.name?cap_first}
    this.findByPrimaryKey = function(<#list primaryAttributes as attribute>${attribute.name?uncap_first}<#sep>, </#sep></#list>, successResultCallback, errorResultCallback){
    	 ajaxService.ajaxGet('/${entity.name?lower_case}'<#list primaryAttributes as attribute>+'/'+encodeURIComponent(${attribute.name?uncap_first})</#list>, 
    	 		function(result, status){
    	 			successResultCallback(result, status);
    	 		},
    	 		function(result) {
    	 			errorResultCallback(result, status);
    	 		});
    };
    
    <#list entity.relations as relation>
    //Find by ${relation.model.name}
    this.fetchBy${relation.model.name} = function(${relation.model.name?lower_case}Obj, pageNumber, pageSize, sentQuery, successResultCallback, errorResultCallback) { 
        //Send the get query to fetch the result
        ajaxService.ajaxPost(${relation.model.name?lower_case}Obj,'/${entity.name?lower_case}/${relation.model.name?lower_case}?size='+pageSize+'&page=' + pageNumber + sentQuery, 
        		function(result, status) {
                	successResultCallback(result, status);
             	},
             	function(result) {
             		errorResultCallback(result);
             	},
                "Loading ${entity.name}...");
    };
    </#list>
    
  });