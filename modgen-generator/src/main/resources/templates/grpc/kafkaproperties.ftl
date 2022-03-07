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

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
public class ${componentClassNamePrefix}KafkaProperties {
 
  // Common Kafka settings
  @Value("${r"${"}kafka.metadataMaxAgeMs:300000}")
  private String metadataMaxAgeMs;
  @Value("${r"${"}kafka.address}")
  private String address;
  <#list entities as entity>
  <#if entity.hasAnnotation("SUBSCRIBE") || entity.hasAnnotation("PUBLISH") >
  
  // ${entity.name} pub/sub parameters
  @Value("${r"${"}kafka.${entity.name?uncap_first}TopicName:${entity.name?uncap_first}TopicName}")
  private String ${entity.name?uncap_first}TopicName;
  @Value("${r"${"}kafka.${entity.name?uncap_first}Partition:${entity.name?uncap_first}Partition}")
  private String ${entity.name?uncap_first}Partition;
  @Value("${r"${"}kafka.${entity.name?uncap_first}ConsumerGroup:${entity.name?uncap_first}ConsumerGroup}")
  private String ${entity.name?uncap_first}ConsumerGroup;
  <#list entity.attributes as attribute>
   <#if attribute.reference>
  
  // Relation between ${entity.name} and ${attribute.name}
  @Value("${r"${"}kafka.${entity.name?lower_case}.${attribute.name?lower_case}.topic:${entity.name?lower_case}To${attribute.name?lower_case}TopicName}")
  private String ${entity.name?uncap_first}To${attribute.name?cap_first}TopicName;
  @Value("${r"${"}kafka.${entity.name?lower_case}.${attribute.name?lower_case}.partition:${entity.name?lower_case}To${attribute.name?lower_case}Partition}")
  private String ${entity.name?uncap_first}To${attribute.name?cap_first}Partition;
  @Value("${r"${"}kafka.${entity.name?lower_case}.${attribute.name?lower_case}.ConsumerGroup:${entity.name?lower_case}To${attribute.name?lower_case}ConsumerGroup}")
  private String ${entity.name?uncap_first}To${attribute.name?cap_first}ConsumerGroup;   
   </#if>
  </#list>
  </#if>
  </#list>
}
