<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
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
 
/*
 * Author   : 
 *     Nourreddine HOUARI <nourreddine.houari@>
 *     Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     :  ${aDate?string.medium} 
 * 
 * File     :  GenericEntityProtoTransformer.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 
package ${package};

public interface GenericEntityProtoMapper<Proto, T> {
 
  /**
   * Copies the data from {@link Proto} object to {@link T} object.
   *  
   * @param proto The protobuf message to copy the data from.
   * @param entity The JPA entity to copy the data to.
   */
  void transformProtoToEntity(Proto proto, T entity);
 
  /**
   * Copies the data from {@link T} object to {@link Proto} object.
   *  
   * @param entity The JPA entity to copy the data from.
   * @return proto The Protobuf message to copy the data to.
   */
  Proto transformEntityToProto(T entity);
}