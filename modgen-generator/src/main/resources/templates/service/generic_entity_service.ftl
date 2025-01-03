<#assign aDateTime = .now>
<#assign aDate = aDateTime?date>
/*
 * Author   :	Nourreddine HOUARI <nourreddine.houari@>
 * 				Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@> 
 *
 * Date     : 	${aDate?string.medium} 
 * 
 * File     : 	GenericEntityService.java 
 * 
 * Copyright (c) ${aDate?string.yyyy} houari_nourreddine Sdn Bhd, All rights reserved.                   
 */
 package ${package};

import java.util.Map;

/**
 * THIS FILE IS AUTOMATICALLY GENERATED
 *     >> DO NOT EDIT MANUALLY <<
 * <br><br>
 * Generated by : ${generator}<br>
 * Version      : ${version}<br>
 * Date         : ${aDate?string.medium}<br>
 * <br>
 * @author Nourreddine HOUARI <nourreddine.houari@>
 * @author Koneru, Venkaiah Chowdary <VenkaiahChowdary.Koneru@>
 *
 */
public interface GenericEntityService<DTO, T> { 
	
	/**
	 * persists one entity instance.
	 */
	 Map<String, String> create(DTO dto);
	
    /**
	 * Count the number of records in the repository.
	 * @return
	 */
	long count();
}