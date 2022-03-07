/*
 * 
 * Nourreddine HOUARI CONFIDENTIAL
 * 
 * All information contained herein is, and remains
 * the property of Nourreddine HOUARI and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Nourreddine HOUARI
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Nourreddine HOUARI.
 * 
 * [2017] Nourreddine HOUARI SA
 * All Rights Reserved.
 */

package ${package};

import com.google.protobuf.Empty;
import com.google.protobuf.Int64Value;
import java.util.Date;

import ${protoPackage}.${entity.name?cap_first};
import ${protoPackage}.${entity.name?cap_first}SaveResult;
import ${protoPackage}.${entity.name?cap_first}Request;
import ${protoPackage}.${entity.name?cap_first}QuickSearchRequest;
import ${protoPackage}.${entity.name?cap_first}Query;
import ${protoPackage}.${entity.name?cap_first}QuickSearchQuery;
import ${protoPackage}.api.rpc.Page;

import ${rootPackage}.api.server.rest.ResultPage;
import ${rootPackage}.api.client.grpc.${entity.name?cap_first}GrpcClient;
import ${rootPackage}.mapper.${entity.name?cap_first}DTOProtoMapperImpl;
import ${dtoPackage}.${entity.name?cap_first}DTO;
import ${dtoPackage}.${entity.name?cap_first}DTOSaveResult;
import ${dtoPackage}.SaveStatus;
<#list entity.attributes as attribute>
<#if attribute.enumerate>
import ${dtoPackage}.${attribute.type};
<#elseif attribute.reference>
import ${protoPackage}.Link${entity.name?cap_first}To${attribute.name?cap_first}Request;
</#if>
</#list>
<#list entity.relations as relation>
import ${protoPackage}.${entity.name?cap_first}By${relation.model.name?cap_first}${relation.relationName?cap_first}Request;
</#list>
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import rx.Observable;

<#list primaryAttributes as attribute>
    <#if attribute.type == "Integer">
      <#assign primaryKey="com.google.protobuf.Int32Value">
    <#elseif attribute.type == "Long">
      <#assign primaryKey="com.google.protobuf.Int64Value">
     <#elseif attribute.type == "String">
      <#assign primaryKey="com.google.protobuf.StringValue">  
    </#if>  
</#list>

/**
 * @author nhouari
 *
 */
@Service
public class ${entity.name?cap_first}Service {

  /**
   * Logger.
   */
  private static Logger LOGGER = LoggerFactory.getLogger(${entity.name?cap_first}Service.class);
  
  /**
   * Mapper dto/proto
   */
  private ${entity.name?cap_first}DTOProtoMapperImpl mapper;

  /**
   * GRPC client stub
   */
  private ${entity.name?cap_first}GrpcClient client;

  @Autowired 
  public ${entity.name?cap_first}Service(${entity.name?cap_first}DTOProtoMapperImpl mapper, ${entity.name?cap_first}GrpcClient client) {
    this.mapper = mapper;
    this.client = client;
  }
  
  /**
   * Get an ${entity.name?cap_first} by its primary key.
   * @param id Primary key
   * @return Observable on ${entity.name?cap_first}DTO
   */
  public Observable<${entity.name?cap_first}DTO> getByPrimaryKey(<#list primaryAttributes as attribute>${attribute.type} id<#sep>,</#sep></#list>){
    return this.client.getByPrimaryKey( ${primaryKey}.newBuilder().setValue(id).build() )
        .onErrorResumeNext(this::onError)
        .map(proto -> {
          ${entity.name?cap_first}DTO dto  = new ${entity.name?cap_first}DTO();
          mapper.transformProtoToDto(proto, dto);
          return dto;
        });
  }
  
   /**
   * Delete an ${entity.name?cap_first} by its primary key.
   * @param id Primary key
   * @return Observable on ${entity.name?cap_first}DTO
   */
  public Observable<Empty> delete(<#list primaryAttributes as attribute>${attribute.type} id<#sep>,</#sep></#list>){
    return this.client.delete(${primaryKey}.newBuilder().setValue(id).build())
           .map(proto -> Empty.newBuilder().build());
  }
  
  /**
   * Count the number of ${entity.name?cap_first}.
   * @return
   */
  public Observable<Int64Value> count(){
    return this.client.count(Empty.newBuilder().build());
  }
  
  /**
   * Get all ${entity.name?cap_first}.
   * @return Observable on ${entity.name?cap_first}DTO
   */
  public Observable<List<${entity.name?cap_first}DTO>> getAll${entity.name?cap_first}s(){
    return this.client.getAll${entity.name?cap_first}s()
//        .onErrorResumeNext(this::onError)
        .map(list -> {
            List<${entity.name?cap_first}DTO> result = new ArrayList<${entity.name?cap_first}DTO>();
            list.getEntitiesList().forEach(proto -> {
              ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
              mapper.transformProtoToDto(proto, dto);
              result.add(dto);
            });
            return result;
        });
  }
  
  /**
   * Save ${entity.name?cap_first}
   * @param dto instance to save.
   * @return saved ${entity.name?cap_first}
   */
  public Observable<${entity.name?cap_first}DTOSaveResult> save(${entity.name?cap_first}DTO dto){
    return this.client.save(this.mapper.transformDtoToProto(dto))
        .map(proto -> {
            mapper.transformProtoToDto(proto.getEntityProto(), dto);
            ${entity.name?cap_first}DTOSaveResult.${entity.name?cap_first}DTOSaveResultBuilder resultBuilder = ${entity.name?cap_first}DTOSaveResult
                                .builder();

            resultBuilder.dto(dto);
            resultBuilder.status(SaveStatus.valueOf(proto.getStatus().getValueDescriptor().getName()));
            resultBuilder.errors(proto.getErrorsMap());
          return resultBuilder.build();
        });
  }
  
  /**
   * 
   * @return
   */
  public Observable<ResultPage<${entity.name?cap_first}DTO>> search(
    String sort,            
    Integer page,
    Integer size
    <#if entity.hasAnnotation("AUDIT_AWARE")>
    , String createdBy, 
    Date createdDate, 
    Date fromCreatedDate, 
    Date toCreatedDate, 
    String modifiedBy, 
    Date modifiedDate, 
    Date fromModifiedDate, 
    Date toModifiedDate
    </#if>
    <#if searchableAttributes?size gt 0>,</#if>
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    ${attribute.type} from${attribute.name?cap_first},
    ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "String" && attribute.location>
    Double ${attribute.name?lower_case}Distance,
    </#if>
    ${attribute.type} ${attribute.name?uncap_first}<#if attribute?has_next>,</#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
    </#list>
    </#list>
    <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Query from ${primaryAttribute.type} ${attribute.name} reference.
    ,${primaryAttribute.type} ${attribute.name?uncap_first}${primaryAttribute.name?cap_first}
    </#list>
    </#if>
    </#list>
    ){
    
    // Pagination
    Page pageRequest = Page.newBuilder()
      .setPage(page)
      .setSize(size)
      .build();
    
    // Query parameters
    ${entity.name?cap_first}Query.Builder builder = ${entity.name?cap_first}Query.newBuilder();
    // Sort parameters
    if(sort !=null) { builder.setSortParams(sort); }
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double">
    if(from${attribute.name?cap_first} != null) { builder.setFrom${attribute.name?cap_first}(from${attribute.name?cap_first}); }
    if(to${attribute.name?cap_first} != null) { builder.setTo${attribute.name?cap_first}(to${attribute.name?cap_first}); }
    <#elseif attribute.type == "Date">
    if(from${attribute.name?cap_first} != null) { builder.setFrom${attribute.name?cap_first}(from${attribute.name?cap_first}.getTime()); }
    if(to${attribute.name?cap_first} != null) { builder.setTo${attribute.name?cap_first}(to${attribute.name?cap_first}.getTime()); }
    <#elseif attribute.type = "String" && attribute.location>
    if(${attribute.name?cap_first}Distance != null) { builder.set${attribute.name?cap_first}Distance(${attribute.name?cap_first}Distance); }
    </#if>
    <#if attribute.enumerate>
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${protoPackage}.${attribute.type}.valueOf(${attribute.name?uncap_first}.toString()));}
    <#else>
    <#if attribute.type == "Date">
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${attribute.name?uncap_first}.getTime()); }
    <#else>
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${attribute.name?uncap_first}); }
    </#if>
    </#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Relation query
    if(${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} != null){
      builder.set${relation.model.name?cap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}(${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first});
    }
    </#list>
    </#list>

    <#list entity.attributes as attribute>
    <#if attribute.reference>
    <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Query from ${attribute.name} reference primary key.
    if (${attribute.name?uncap_first}${primaryAttribute.name?cap_first} != null) {
      // Add child primary key clause.
      builder.set${attribute.name?cap_first}${primaryAttribute.name?cap_first}(${attribute.name?uncap_first}${primaryAttribute.name?cap_first});
    }
    </#list>
    </#if>
    </#list>
    
    <#if entity.hasAnnotation("AUDIT_AWARE")>
    if (createdBy != null){
      builder.setCreatedBy(createdBy);
    }
    if(createdDate != null) {
      builder.setCreatedDate(createdDate.getTime());
    }
    if(fromCreatedDate != null) {
      builder.setFromCreatedDate(fromCreatedDate.getTime());
    }
    if(modifiedBy != null) {
      builder.setModifiedBy(modifiedBy);
    }
    if(modifiedDate != null) {
      builder.setModifiedDate(modifiedDate.getTime());
    }
    if(fromModifiedDate != null) {
      builder.setFromModifiedDate(fromModifiedDate.getTime());
    }
    if(toModifiedDate != null) {
      builder.setToModifiedDate(toModifiedDate.getTime());
    }
    </#if>
    ${entity.name?cap_first}Query query = builder.build();   
    
     // Call client     
    return this.client.getAll${entity.name?cap_first}(${entity.name?cap_first}Request.newBuilder()
        .setPage(pageRequest)
        .setQuery(query)
        .build())
    .map(list -> {
          ResultPage<${entity.name?cap_first}DTO> resultPage = new ResultPage<${entity.name?cap_first}DTO>();
          List<${entity.name?cap_first}DTO> result = new ArrayList<${entity.name?cap_first}DTO>();
          list.getEntitiesList().forEach(proto -> {
            ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
            mapper.transformProtoToDto(proto, dto);
            result.add(dto);
          });
          
          resultPage.setTotalElements(list.getTotalElements());
          resultPage.setNumber(list.getNumber());
          resultPage.setNumberOfElements(list.getNumberOfElements());
          resultPage.setSize(list.getSize());
          resultPage.setTotalPages(list.getTotalPages());
          resultPage.setList(result);
          return resultPage;
      });
  }
   /**
   *
   * @return
   */
  public Observable<ResultPage<${entity.name?cap_first}DTO>> quickSearch(
    Integer page,
    Integer size,
    String quickSearchQuery,
    String sort
    <#if searchableAttributes?size gt 0>,</#if>
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double"|| attribute.type=="Date">
    ${attribute.type} from${attribute.name?cap_first},
    ${attribute.type} to${attribute.name?cap_first},
    <#elseif attribute.type = "String" && attribute.location>
    Double ${attribute.name?lower_case}Distance,
    </#if>
    ${attribute.type} ${attribute.name?uncap_first}<#if attribute?has_next>,</#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    ,${primaryAttribute.type} ${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}
    </#list>
    </#list>){

    // Pagination
    Page pageRequest = Page.newBuilder()
      .setPage(page)
      .setSize(size)
      .build();
      
      // Query parameters
    ${entity.name?cap_first}QuickSearchQuery.Builder builder = ${entity.name?cap_first}QuickSearchQuery.newBuilder();
    // Sort parameters
    if(sort !=null) { builder.setSortParams(sort); }
    <#list searchableAttributes as attribute>
    <#if attribute.type=="Byte" || attribute.type=="Short"|| attribute.type=="Integer"|| attribute.type=="Long"|| attribute.type=="Float"|| attribute.type=="Double">
    if(from${attribute.name?cap_first} != null) { builder.setFrom${attribute.name?cap_first}(from${attribute.name?cap_first}); }
    if(to${attribute.name?cap_first} != null) { builder.setTo${attribute.name?cap_first}(to${attribute.name?cap_first}); }
    <#elseif attribute.type == "Date">
    if(from${attribute.name?cap_first} != null) { builder.setFrom${attribute.name?cap_first}(from${attribute.name?cap_first}.getTime()); }
    if(to${attribute.name?cap_first} != null) { builder.setTo${attribute.name?cap_first}(to${attribute.name?cap_first}.getTime()); }
    <#elseif attribute.type = "String" && attribute.location>
    if(${attribute.name?cap_first}Distance != null) { builder.set${attribute.name?cap_first}Distance(${attribute.name?cap_first}Distance); }
    </#if>
    <#if attribute.enumerate>
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${protoPackage}.${attribute.type}.valueOf(${attribute.name?uncap_first}.toString()));}
    <#else>
    <#if attribute.type == "Date">
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${attribute.name?uncap_first}.getTime()); }
    <#else>
    if(${attribute.name?uncap_first} != null) { builder.set${attribute.name?cap_first}(${attribute.name?uncap_first}); }
    </#if>
    </#if>
    </#list>
    <#list entity.relations as relation>
    <#list relation.model.getAttributesByAnnotation("PK") as primaryAttribute>
    // Relation query
    if(${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first} != null){
      builder.set${relation.model.name?cap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first}(${relation.model.name?uncap_first}${relation.relationName?cap_first}${primaryAttribute.name?cap_first});
    }
    </#list>
    </#list>

    // Query
    ${entity.name?cap_first}QuickSearchQuery query = builder
        .setQuickSearchQuery(quickSearchQuery)
        .build();

    // Request
    ${entity.name?cap_first}QuickSearchRequest request = ${entity.name?cap_first}QuickSearchRequest
        .newBuilder()
        .setPage(pageRequest)
        .setQuery(query)
        .build();

    // Call gRPC client
    return this.client.quickSearch${entity.name?cap_first}(request)
        .map(list -> {
              ResultPage<${entity.name?cap_first}DTO> resultPage = new ResultPage<${entity.name?cap_first}DTO>();
              List<${entity.name?cap_first}DTO> result = new ArrayList<${entity.name?cap_first}DTO>();
              list.getEntitiesList().forEach(proto -> {
                ${entity.name?cap_first}DTO dto = new ${entity.name?cap_first}DTO();
                mapper.transformProtoToDto(proto, dto);
                result.add(dto);
              });

              resultPage.setTotalElements(list.getTotalElements());
              resultPage.setNumber(list.getNumber());
              resultPage.setNumberOfElements(list.getNumberOfElements());
              resultPage.setSize(list.getSize());
              resultPage.setTotalPages(list.getTotalPages());
              resultPage.setList(result);
              return resultPage;
        });
  }
  
   <#list entity.attributes as attribute>
     <#if attribute.reference && attribute.multiplicity=1>
   /**
    * Set the relation between ${entity.name?cap_first} and ${attribute.name?cap_first}
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${primaryAttribute.name} 
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${attribute.name}${primaryAttribute.name?cap_first}
     </#list>
    * @return Observable on ${entity.name?cap_first}DTO
    */
   public Observable<${entity.name?cap_first}DTO> set${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name},
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep>
     </#list>
   ){
     return this.client.set${attribute.name?cap_first}Relation(Link${entity.name?cap_first}To${attribute.name?cap_first}Request
     .newBuilder()
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${primaryAttribute.name?cap_first}(${primaryAttribute.name})
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${attribute.name?cap_first}${primaryAttribute.name?cap_first}(${attribute.name}${primaryAttribute.name?cap_first})
     </#list>
     .build())
       .onErrorResumeNext(this::onError)
       .map(proto -> {
         ${entity.name?cap_first}DTO dto  = new ${entity.name?cap_first}DTO();
         mapper.transformProtoToDto(proto, dto);
         return dto;
      });
   }
   
   <#elseif attribute.reference && attribute.multiplicity=-1>
   
   /**
    * Set the relation between ${entity.name?cap_first} and ${attribute.name?cap_first}
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${primaryAttribute.name} 
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${attribute.name}${primaryAttribute.name?cap_first}
     </#list>
    * @return Observable on Empty
    */
   public Observable<${entity.name?cap_first}DTOSaveResult> add${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name},
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep>
     </#list>
   ){
     return this.client.add${attribute.name?cap_first}Relation(Link${entity.name?cap_first}To${attribute.name?cap_first}Request
     .newBuilder()
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${primaryAttribute.name?cap_first}(${primaryAttribute.name})
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${attribute.name?cap_first}${primaryAttribute.name?cap_first}(${attribute.name}${primaryAttribute.name?cap_first})
     </#list>
     .build())
     .map(proto -> {
            ${entity.name?cap_first}DTOSaveResult.${entity.name?cap_first}DTOSaveResultBuilder resultBuilder = ${entity.name?cap_first}DTOSaveResult
                                .builder();

            resultBuilder.status(SaveStatus.valueOf(proto.getStatus().getValueDescriptor().getName()));
            resultBuilder.errors(proto.getErrorsMap());

          return resultBuilder.build();
        });
   }
   
   /**
    * Set the relation between ${entity.name?cap_first} and ${attribute.name?cap_first}
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${primaryAttribute.name} 
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
    * @param ${attribute.name}${primaryAttribute.name?cap_first}
     </#list>
    * @return Observable on Empty
    */
   public Observable<${entity.name?cap_first}DTOSaveResult> remove${attribute.name?cap_first}Relation(
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${primaryAttribute.name},
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     ${primaryAttribute.type} ${attribute.name}${primaryAttribute.name?cap_first}<#sep>,</#sep>
     </#list>
   ){
     return this.client.remove${attribute.name?cap_first}Relation(Link${entity.name?cap_first}To${attribute.name?cap_first}Request
     .newBuilder()
     <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${primaryAttribute.name?cap_first}(${primaryAttribute.name})
     </#list>
     <#list attribute.model.getAttributesByAnnotation("PK") as primaryAttribute>
     .set${attribute.name?cap_first}${primaryAttribute.name?cap_first}(${attribute.name}${primaryAttribute.name?cap_first})
     </#list>
     .build())
     .map(proto -> {
            ${entity.name?cap_first}DTOSaveResult.${entity.name?cap_first}DTOSaveResultBuilder resultBuilder = ${entity.name?cap_first}DTOSaveResult
                                .builder();

            resultBuilder.status(SaveStatus.valueOf(proto.getStatus().getValueDescriptor().getName()));
            resultBuilder.errors(proto.getErrorsMap());

          return resultBuilder.build();
        });
   }
   
    </#if>
   </#list>
  
  /**
   * Error handler when calling GRPC service.
   * @param throwable
   * @return
   */
  private Observable<${entity.name?cap_first}> onError(Throwable throwable) {
    if (LOGGER.isErrorEnabled()) {
      LOGGER.error("GRPC Error :" + throwable);
    }
    return Observable.error(throwable);
  }

}
