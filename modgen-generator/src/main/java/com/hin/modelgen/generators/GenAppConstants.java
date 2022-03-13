/**
 * 
 */
package com.hin.modelgen.generators;

/**
 * @author VKoneru
 *
 */
public final class GenAppConstants {

	/**
	 * private to prevent un-necessary instantiation
	 */
	private GenAppConstants() {
	}

	// Package Constants
	public static final String STR_ENTITY_PACKAGE = "entityPackage";
	public static final String STR_ENTITY_SUFFIX = "entity_suffix";
	public static final String STR_ENTITY_REPOSITORY_SUFFIX = "entity_repository_suffix";
	public static final String STR_DTO_PACKAGE = "dtoPackage";
	public static final String STR_DTO_SUFFIX = "dtoSuffix";
	public static final String STR_REPO_PACKAGE = "repositoryPackage";
	public static final String STR_SERVICE_PACKAGE = "servicePackage";
	public static final String STR_TRANSF_PACKAGE = "transformerPackage";
	public static final String STR_PROTO_PACKAGE = "protoPackage";
	public static final String STR_ROOT_PACKAGE = "rootPackage";
	public static final String STR_COMPONENT_CLASS_NAME_PREFIX = "componentClassNamePrefix";
  
	
	public static final String STR_TODAY = "today";
	
	// Attributes Constants
	public static final String STR_PRIMARY_ATTRIBUTES = "primaryAttributes";
	public static final String STR_SEARCHABLE_ATTRIBUTES = "searchableAttributes";
	public static final String STR_CLUSTERING_ATTRIBUTES = "clusteringAttributes";
	
	// API Constants
	public static final String STR_CONTEXT_PATH = "contextRoot";
	public static final String STR_REST_PREFIX = "restPath";
	public static final String STR_SERVER_ADDRESS = "serverHost";
	public static final String STR_SERVER_PORT = "serverPort";
	public static final String STR_APP_MODULE = "angularModule";
}
