<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	Extensions.java
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */

package ${package};

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;

import com.fasterxml.jackson.databind.JsonNode;
import com.vladmihalcea.hibernate.type.json.JsonBinaryType;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Embeddable
@TypeDef(name = "jsonb", typeClass = JsonBinaryType.class)
@NoArgsConstructor
@SuperBuilder
@Data
public class Extension implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4992262872080500403L;
	@Type(type = "jsonb")
	@Column(columnDefinition = "jsonb")
	private JsonNode extension;
}