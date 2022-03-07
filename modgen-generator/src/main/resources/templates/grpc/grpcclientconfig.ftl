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

<#list entities as entity>
import ${package}.${entity.name?cap_first}CRUDServicesGrpc.${entity.name?cap_first}CRUDServicesStub;
</#list>

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.grpc.Channel;

/**
 * @author nhouari
 *
 */
@Configuration
public class ${componentClassNamePrefix}GrpcClientConfig {

  @Autowired
  private Channel channel;
  
  <#list entities as entity>
  @Bean
  public ${entity.name?cap_first}CRUDServicesStub ${entity.name?uncap_first}Stub() {
    return ${entity.name?cap_first}CRUDServicesGrpc.newStub(channel);
  }
  
  </#list>
  
}
