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
import ${servicePackage}.${entity.name?cap_first}Service;
import ${package}.api.server.${entity.name?cap_first}GrpcServiceImpl;
</#list>


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import rx.subjects.PublishSubject;
<#list entities as entity>
  <#if entity.hasAnnotation("PUBLISH") || entity.hasAnnotation("SUBSCRIBE")>
import rx.Subscription;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import com.google.protobuf.Any;
import com.hin.ptf.common.messages.Audit;
import com.hin.ptf.common.messages.Envelope;
import com.google.protobuf.InvalidProtocolBufferException;
  <#break>
  </#if>
</#list>
<#list entities as entity>
  <#if entity.hasAnnotation("SUBSCRIBE")>
import org.apache.kafka.clients.consumer.OffsetResetStrategy;  
import rx.Observable;
import com.hin.ptf.common.messages.Envelope;
import org.apache.kafka.clients.consumer.ConsumerRecord;
  <#break>
  </#if>
</#list>
import lombok.extern.slf4j.Slf4j;
import com.hin.ptf.kafka.support.consumer.KafkaReader;
import com.hin.ptf.kafka.support.producer.KafkaWriter;
import com.hin.ptf.kafka.support.consumer.KafkaConsumerFactory;
import com.hin.ptf.multitenancy.MultiTenancyProperties;

import io.grpc.BindableService;
<#list entities as entity>
<#if entity.hasAnnotation("PUBLISH")>
import com.hin.ptf.kafka.entitypublisher.EntityPublisher;
import com.hin.ptf.kafka.entitypublisher.EntityPublisherDaemon;
import com.hin.ptf.kafka.entitypublisher.PublishableEntityRepository;
import com.hin.ptf.audit.trail.Auditor;
import com.hin.ptf.audit.trail.AuditorHolder;
<#break>
</#if>
</#list>
<#list entities as entity>
<#if entity.hasAnnotation("PUBLISH")>
import ${entityPackage}.${entity.name?cap_first}${entity_suffix};
import ${transformerPackage}.${entity.name?cap_first}${entity_suffix}ProtoMapperImpl; 
import ${repositoryPackage}.${entity.name}Reposit;
import ${servicePackage}.${entity.name}ServiceImpl;
</#if>
<#if entity.hasAnnotation("SUBSCRIBE")>
import ${servicePackage}.${entity.name}Service;
</#if>
</#list>

/**
 * @author nhouari
 *
 */
@Configuration
@Slf4j
public class ${componentClassNamePrefix}GrpcServerConfig {

  <#list entities as entity>
  @Autowired
  private ${entity.name?cap_first}Service ${entity.name?uncap_first}Service;

  @Autowired
  private ${entity.name?cap_first}GrpcServiceImpl ${entity.name?uncap_first}GrpcServiceImpl;
  </#list>
  <#list entities as entity>
  <#if entity.hasAnnotation("PUBLISH") || entity.hasAnnotation("SUBSCRIBE")>
  @Autowired
  private ${componentClassNamePrefix}KafkaProperties kafkaProperties;
  <#break>
  </#if>
  </#list>
  @Autowired
  private MultiTenancyProperties multiTenancyProperties;

  <#list entities as entity>
  @Bean
  public BindableService grpc${entity.name?cap_first}Server() {
    return ${entity.name?cap_first}GrpcServiceImpl.bind(${entity.name?uncap_first}GrpcServiceImpl);
  }  
  
   <#list entity.attributes as attribute>
   <#if attribute.reference>
   /**
    * Create a AddLink${entity.name}To${attribute.name}Request observable to be use to publish the relation.
    * @return the subscription.
    */
   @Bean
   public PublishSubject<AddLink${entity.name}To${attribute.name?cap_first}Request> create${entity.name}To${attribute.name?cap_first}RequestObservable() {
     //Create subject
     PublishSubject<AddLink${entity.name}To${attribute.name?cap_first}Request> linkSubject = PublishSubject.create();
     return linkSubject;
   }
   </#if>
   </#list>
  
  <#if entity.hasAnnotation("PUBLISH")>
  /**
   * ${entity.name?cap_first} Publisher daemon.
   * @param mapper Transform an entity to proto
   * @param repository ${entity.name?cap_first} repository
   * @param service ${entity.name?cap_first} service
   * @param kafkaWriter Kafka publisher
   * @return publisher daemon
   */
  @Bean
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.publish", matchIfMissing = false)
  public EntityPublisherDaemon<${entity.name?cap_first}${entity_suffix}> ${entity.name?uncap_first}PublisherDaemon(
  ${entity.name?cap_first}${entity_suffix}ProtoMapperImpl mapper, 
  ${entity.name}Reposit repository, 
  ${entity.name}ServiceImpl service,
  KafkaWriter<String, Envelope> kafkaWriter) {
    if(log.isInfoEnabled()) {
      log.info("Creating Kafka writer for ${entity.name}.");
    }
    // Create a publisher
    EntityPublisher<${entity.name?cap_first}${entity_suffix}> publisher = new EntityPublisher<${entity.name?cap_first}${entity_suffix}>(
        kafkaWriter, 
        kafkaProperties.get${entity.name}TopicName(),
         
        (${entity.name?uncap_first}) -> {
        return <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
        <#if primaryAttribute.type == 'String'>
        ${entity.name?uncap_first}.get${primaryAttribute.name?cap_first}();
        <#else>
        Long.toString(${entity.name?uncap_first}.get${primaryAttribute.name?cap_first}());
        </#if>
        },
        </#list>	
        
        (${entity.name?uncap_first}, headersBldr) -> {
         try {
            Audit audit = Audit.parseFrom(${entity.name?uncap_first}.getAudit());
            headersBldr
            .setCorrelationId(<#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
                              <#if primaryAttribute.type == 'String'>
            ${entity.name?uncap_first}.get${primaryAttribute.name?cap_first}()
        	<#else>
        	Long.toString(${entity.name?uncap_first}.get${primaryAttribute.name?cap_first}())
        	</#if>
        	</#list>)
            .setAudit(Any.pack(audit));  
          } catch (InvalidProtocolBufferException e) {
            e.printStackTrace();
          }
        },
        mapper::transformEntityToProto);
    
    // Load unpublished entities and make published ones
    PublishableEntityRepository<${entity.name?cap_first}${entity_suffix}> loader = new PublishableEntityRepository<>(
        () -> repository.findByPublished(false),
        (${entity.name?uncap_first}) -> repository.setFixedPublishedFor(true, ${entity.name?uncap_first}<#list entity.getAttributesByAnnotation("PK") as attribute>.get${attribute.name?cap_first}()</#list>),
        multiTenancyProperties.getTenantList());
    
    // Return the daemon
    return new EntityPublisherDaemon<>(publisher, loader, service.getObservable(), "publisher-${entity.name?uncap_first}-");
  }
  
  <#list entity.attributes as attribute>
   <#if attribute.reference>
  /**
   * Subscribe to the relation observable and publish to Kafka the relation.
   * @param kafkaWriter Kafka writer
   * @param observable Relation observable
   * @return the Subscription.
   */
  @Bean
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.publish", matchIfMissing = false)
  public Subscription ${entity.name?uncap_first}${attribute.name?cap_first}RelationPublisher(KafkaWriter<String, byte[]> kafkaWriter, PublishSubject<AddLink${entity.name}To${attribute.name?cap_first}Request> observable) {
    
    // Subscribe to observable and publish to Kafka
    return observable.doOnNext( message -> {
      // Wrap the message in a Envelope
      Envelope envelope = Envelope.newBuilder()
      .setBody(Any.pack(message))
      .build();
      
      // Publish record to Kafka
      kafkaWriter
      .sendRecord(
          kafkaProperties.get${entity.name}To${attribute.name?cap_first}TopicName(), 
          kafkaProperties.get${entity.name}To${attribute.name?cap_first}Partition(), 
          envelope.toByteArray());
      
    })
    .doOnError(e -> {
      if(log.isErrorEnabled()){
        log.error("Error while writing AddLink${entity.name}To${attribute.name?cap_first}Request relation to topic {}", kafkaProperties.get${entity.name}To${attribute.name?cap_first}TopicName(), e);
      }
    })
    .retry()
    .subscribe();
  }
   </#if>
  </#list>
  
  </#if>
  <#if entity.hasAnnotation("SUBSCRIBE")>
  <#list entity.attributes as attribute>
   <#if attribute.reference>
  /**
   * Kafka reader for ${entity.name} to ${attribute.name} relation.
   */ 
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.subscribe", matchIfMissing = false)
  @Bean
  public KafkaReader<String, byte[]> AddLink${entity.name}To${attribute.name?cap_first}RequestKafkaReader() {
    return KafkaReader
        .from(kafkaConsumerFactory(kafkaProperties.get${entity.name}To${attribute.name?cap_first}ConsumerGroup()))
        .subscribe(kafkaProperties.get${entity.name}To${attribute.name?cap_first}TopicName());
  }
  
  /**
   * This bean will subscribe to Kafka and save automatically the relation between ${entity.name} and ${attribute.name} of type ${attribute.type}.
   * @return Subscription
   */
  @Bean 
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.subscribe.auto", matchIfMissing = false)
  public Subscription save${entity.name}To${attribute.name?cap_first}Subscriber() {
    return AddLink${entity.name}To${attribute.name?cap_first}RequestKafkaReader()
    .observe()
    .map(ConsumerRecord::value)
    .map(stream -> {
      Envelope envelope;
      try {
        // Decode the envelop
        envelope = Envelope.parseFrom(stream);
        // Decode Site proto message
        AddLink${entity.name}To${attribute.name?cap_first}Request proto = envelope.getBody().unpack(AddLink${entity.name}To${attribute.name?cap_first}Request.class);
        return proto;
      } catch (InvalidProtocolBufferException e) {
        e.printStackTrace();
      }
        return null;
      })
    .doOnNext(link -> {
      if(link.getLink()) {
        // Add relation
        ${entity.name?uncap_first}Service.add${attribute.name?cap_first}Relation(
        <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
        link.get${primaryAttribute.name?cap_first}(), 
        </#list>
        <#list attribute.model.getAttributesByAnnotation("PK") as linkedPrimaryAttribute>
        link.get${attribute.name?cap_first}${linkedPrimaryAttribute.name?cap_first}()<#sep>,</#sep>
        </#list>
        );
      } else {
        // Remove relation
       ${entity.name?uncap_first}Service.remove${attribute.name?cap_first}Relation(
        <#list entity.getAttributesByAnnotation("PK") as primaryAttribute>
        link.get${primaryAttribute.name?cap_first}(), 
        </#list>
        <#list attribute.model.getAttributesByAnnotation("PK") as linkedPrimaryAttribute>
        link.get${attribute.name?cap_first}${linkedPrimaryAttribute.name?cap_first}()<#sep>,</#sep>
        </#list>
        );
      }
    })
    .doOnError(ex -> {
      if(log.isErrorEnabled()){
        log.error("Error linking ${entity.name} and ${attribute.name} of type ${attribute.type} : " + ex.getMessage());
      }  
    })
    .retry() // retry if error
    .subscribe();
  }
  
   </#if>
  </#list> 
  
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.subscribe", matchIfMissing = false)
  @Bean
  public KafkaReader<String, byte[]> ${entity.name?uncap_first}KafkaReader() {
    return KafkaReader
        .from(kafkaConsumerFactory(kafkaProperties.get${entity.name}ConsumerGroup()))
        .subscribe(kafkaProperties.get${entity.name}TopicName());
  }
  
  /**
   * Adaptation from Kafka to rx.java Observable.
   * This bean will read from Kafka and push to the observable.
   * @return rx.java Observable of ${entity.name} 
   */
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.subscribe", matchIfMissing = false) 
  @Bean(name="kafka${entity.name}Observable")
  public Observable<${entity.name}> ${entity.name?uncap_first}Observable() {
  
    if(log.isInfoEnabled()) {
      log.info("Creating rx.java Observable for ${entity.name}.");
    }
    
    // Create subject
    PublishSubject<${entity.name}> ${entity.name?uncap_first}Subject = PublishSubject.create();
    Observable<${entity.name}> ${entity.name?uncap_first}Observable = ${entity.name?uncap_first}Subject.share();
    
    // Transform Kafka byte stream to ${entity.name} stream.  
    Observable<ConsumerRecord<String, byte[]>> observable = ${entity.name?uncap_first}KafkaReader().observe();
    observable
      .map(ConsumerRecord::value)
      .map(stream -> {
        Envelope envelope;
        try {
          // Decode the envelop
          envelope = Envelope.parseFrom(stream);
          // Decode ${entity.name} proto message
          ${entity.name} proto = envelope.getBody().unpack(${entity.name}.class);
          return proto;
        } catch (InvalidProtocolBufferException e) {
          e.printStackTrace();
        }
          return null;
        })
      .doOnNext(${entity.name?uncap_first} -> {
        // Push to stream
        ${entity.name?uncap_first}Subject.onNext(${entity.name?uncap_first});
        })
      .doOnError(ex -> {
        if(log.isErrorEnabled()) {
          log.error("Error: " + ex.getMessage());
        }
      })
      .retry() // retry if error
      .subscribe();
 
    // Return observable    
    return ${entity.name?uncap_first}Observable;
  }
  
  /**
   * Subscriber to Kafka observable that store the message locally.
   * @param observable ${entity.name} Observable
   * @param ${entity.name?uncap_first}Service service used to saved new message.
   * @return rx.java Subscription 
   */
  @Bean
  @ConditionalOnProperty( name = "${entity.name?lower_case}.kafka.subscribe.auto", matchIfMissing = false)
  public Subscription ${entity.name?uncap_first}Subscriber(Observable<${entity.name}> observable, ${entity.name}Service ${entity.name?uncap_first}Service){
    if(log.isInfoEnabled()) {
      log.info("Creating rx.java automatic subscriber for ${entity.name}.");
    }
    return observable
      .doOnNext(${entity.name?uncap_first} -> {
        if(log.isDebugEnabled()) {
          log.debug(" Received >>>> " + ${entity.name?uncap_first});
        }  
        // Create an audit context 
        AuditorHolder.newContext(Auditor.systemOperation("${entity.name?lower_case}")).attach();
        // Save locally
        ${entity.name?uncap_first}Service.save(${entity.name?uncap_first});
       }) 
      .subscribe();
  } 
  
  </#if>
  </#list>
  
  <#list entities as entity>
  <#if entity.hasAnnotation("SUBSCRIBE")>
  /**
   * Create Kafka consumer
   * @param groupName Kafka consumer group name.
   * @return Kafka consumer factory
   */
  public KafkaConsumerFactory<String, byte[]> kafkaConsumerFactory(String groupName) {
    return KafkaConsumerFactory.of(kafkaProperties.getAddress(), this.getClass().getPackage().getName() + '.' + groupName)
        .autoOffsetReset(OffsetResetStrategy.EARLIEST)
        .metadataMaxAgeMs(Long.valueOf(kafkaProperties.getMetadataMaxAgeMs()))
        .build();
  }
  <#break>
  </#if>
  </#list>
}
