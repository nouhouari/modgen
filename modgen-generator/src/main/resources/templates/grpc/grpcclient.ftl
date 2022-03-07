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
/**
 *
 */

package ${package};

<#list primaryAttributes as attribute>
    <#if attribute.type == "Integer">
      <#assign primaryKey="com.google.protobuf.Int32Value">
    <#elseif attribute.type == "Long">
      <#assign primaryKey="com.google.protobuf.Int64Value">
     <#elseif attribute.type == "String">
      <#assign primaryKey="com.google.protobuf.StringValue">  
    </#if>  
</#list>
import com.google.protobuf.Empty;
import com.google.protobuf.Int64Value;

import ${protoPackage}.${entity.name?cap_first};
import ${protoPackage}.${entity.name?cap_first}SaveResult;
import ${protoPackage}.${entity.name?cap_first}List;
import ${protoPackage}.${entity.name?cap_first}CRUDServicesGrpc;
import ${protoPackage}.${entity.name?cap_first}QuickSearchRequest;
import ${protoPackage}.${entity.name?cap_first}Request;
import ${protoPackage}.${entity.name?cap_first}ResultPage;
<#list entity.attributes as attribute>
 <#if attribute.reference>
import ${protoPackage}.Link${entity.name}To${attribute.name?cap_first}Request;
 </#if>
</#list>
<#list entity.relations as relation>
import ${protoPackage}.${entity.name?cap_first}By${relation.model.name?cap_first}${relation.relationName?cap_first}Request;
</#list>   
import com.sicpa.ptf.grpc.support.GrpcRxClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import rx.Observable;

/**
 * @author nhouari
 *
 */
@Service
public class ${entity.name?cap_first}GrpcClient {
  
  /**
   * Logger
   */
  private static Logger LOGGER = LoggerFactory.getLogger(${entity.name?cap_first}GrpcClient.class);

  /**
   * Client stub
   */
  private ${entity.name?cap_first}CRUDServicesGrpc.${entity.name?cap_first}CRUDServicesStub stub;
  
  /**
   * Build a new ${entity.name?cap_first} service.
   * @param stub
   */
  @Autowired 
  public ${entity.name?cap_first}GrpcClient(${entity.name?cap_first}CRUDServicesGrpc.${entity.name?cap_first}CRUDServicesStub stub) {
    this.stub = stub;
  }
  
  /**
   * Wrapper of the gRPC ${entity.name?cap_first} service.
   * @return Observable ${entity.name?cap_first}.
   */
  public Observable<${entity.name?cap_first}> getByPrimaryKey(${primaryKey} id) {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("getByPrimaryKey : " + id.getValue());
    }
    // Call the gRPC client
    return GrpcRxClient.serverSideStreaming(id, stub::read${entity.name?cap_first});
  }
  
  /**
   * Wrapper of the gRPC ${entity.name?cap_first} service.
   * @return Observable ${entity.name?cap_first}.
   */
  public Observable<${entity.name?cap_first}List> getAll${entity.name?cap_first}s() {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("getAll ${entity.name?cap_first} list");
    }
    // Call the gRPC client
    return GrpcRxClient.serverSideStreaming(Empty.newBuilder().build(), stub::getAll${entity.name?cap_first}s);
  }
  
  /**
   * Quick search ${entity.name?cap_first} entities that satisfy the request.
   * @param request
   * @return
   */
  public Observable<${entity.name?cap_first}ResultPage> quickSearch${entity.name?cap_first}(${entity.name?cap_first}QuickSearchRequest  request) {
    return GrpcRxClient.serverSideStreaming(request, stub::quickSearch${entity.name?cap_first});
  }
  
  /**
   * Create/update a ${entity.name?cap_first}.
   * @return new created/updated ${entity.name?cap_first}
   */
  public Observable<${entity.name?cap_first}SaveResult> save(${entity.name?cap_first} ${entity.name?uncap_first}){
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("create new ${entity.name?cap_first}.");
    }
    // Call the gRPC client
    return GrpcRxClient.serverSideStreaming(${entity.name?uncap_first}, stub::save${entity.name?cap_first});
  }
  
  /**
   * Delete ${entity.name?cap_first}.
   * @return Observable Empty.
   */
  public Observable<Empty> delete(${primaryKey} id) {
    if (LOGGER.isDebugEnabled()) {
      LOGGER.debug("delete : " + id.getValue());
    }
    // Call the gRPC client
    return GrpcRxClient.serverSideStreaming(id, stub::delete${entity.name?cap_first});
  }
  
  /**
   * Count the number of ${entity.name?cap_first}.
   * @return count number.
   */
  public Observable<Int64Value> count(Empty e) {
    if (LOGGER.isInfoEnabled()) {
      LOGGER.info("Count ${entity.name?cap_first}");
    }
    return GrpcRxClient.serverSideStreaming(e, stub::count${entity.name?cap_first});
  }
  
  /**
   * Get all ${entity.name?cap_first} entities that satisfy the request.
   * @param request
   * @return
   */
  public Observable<${entity.name?cap_first}ResultPage> getAll${entity.name?cap_first}(${entity.name?cap_first}Request request) {
    return GrpcRxClient.serverSideStreaming(request, stub::getAll${entity.name?cap_first});
  }
  
  <#list entity.attributes as attribute>
   <#if attribute.reference && attribute.multiplicity=1>
  /**
   * Link ${entity.name?cap_first} and ${attribute.name?cap_first}
   * @param request
   * @return
   */
  public Observable<${entity.name?cap_first}> set${attribute.name?cap_first}Relation(Link${entity.name}To${attribute.name?cap_first}Request request) {
    return GrpcRxClient.serverSideStreaming(request, stub::link${attribute.name?cap_first});
  }
  
   <#elseif attribute.reference && attribute.multiplicity=-1>
  /**
   * Link ${entity.name?cap_first} and ${attribute.name?cap_first}
   * @param request
   * @return
   */
  public Observable<${entity.name?cap_first}SaveResult> add${attribute.name?cap_first}Relation(Link${entity.name}To${attribute.name?cap_first}Request request) {
    return GrpcRxClient.serverSideStreaming(request, stub::add${attribute.name?cap_first});
  }
  
  /**
   * Link ${entity.name?cap_first} and ${attribute.name?cap_first}
   * @param request
   * @return
   */
  public Observable<${entity.name?cap_first}SaveResult> remove${attribute.name?cap_first}Relation(Link${entity.name}To${attribute.name?cap_first}Request request) {
    return GrpcRxClient.serverSideStreaming(request, stub::remove${attribute.name?cap_first});
  } 
   
   </#if> 
  </#list>

}
