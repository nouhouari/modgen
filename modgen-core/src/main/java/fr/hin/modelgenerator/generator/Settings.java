package fr.hin.modelgenerator.generator;

/**
 * @author nourredine
 */
public class Settings {

  // Input parameters
  private String modelFilePath;
  private String projectsOutputDir;
  private boolean owner;
  private String apiOutputDir;
  private String serviceOutputDir;
  private String bffOutputDir;
  private String frontendOutputDir;
  private String frontendAngular4OutputDir;
  private String componentOutputDir;
  private String javaOutputSourceDir;
  private String javaOutputTestDir;
  private String typeScriptOutputSourceDir;
  private String protoOutputSourceDir;
  private String modelPath;
  private String dartOutputDir;

  private final String entitySuffix = "Entity";
  private final String entityRepositorySuffix = "Reposit";
  private final String dtoSuffix = "DTO";

  // Computed parameters
  private String rootPackage = "com.sicpa.modgen.test";
  private String protoBufPackage = rootPackage + ".proto";
  private String entityPackage = rootPackage + ".entity";
  private String repositoryPackage = rootPackage + ".repository";
  private String dtoPackage = rootPackage + ".dto";
  private String rolePackage = rootPackage + ".role";
  private String dtoEntityTransformerPackage = rootPackage + ".transformers";
  private String dtoProtoTransformerPackage = rootPackage + ".transformers";
  private String transformerPackage = rootPackage + ".transformers";
  private String servicePackage = rootPackage + ".service";
  private String grpcServerPackage = rootPackage + ".grpc.server";
  private String grpcClientPackage = rootPackage + ".grpc.client";
  private String controllerPackage = rootPackage + ".controller";
  private String validationPackage = rootPackage + ".validation";
  private String component;

  public Settings(
      String rootPackage,
      String modelFilePath,
      String projectsOutputDir,
      String apiOutputDir,
      String serviceOutputDir,
      String bffOutputDir,
      String frontendOutputDir,
      String frontendAngular4OutputDir,
      String componentOutputDir,
      String javaOutputSourceDir,
      String javaOutputTestDir,
      String typeScriptOutputSourceDir,
      String protoOutputSourceDir,
      String model_ecore_path,
      String component,
      String dartOutputDir) {

    // Input attributes
    this.rootPackage = rootPackage;
    this.modelFilePath = modelFilePath;
    this.projectsOutputDir = projectsOutputDir;
    this.apiOutputDir = apiOutputDir;
    this.serviceOutputDir = serviceOutputDir;
    this.bffOutputDir = bffOutputDir;
    this.frontendOutputDir = frontendOutputDir;
    this.frontendAngular4OutputDir = frontendAngular4OutputDir;
    this.componentOutputDir = componentOutputDir;
    this.javaOutputSourceDir = javaOutputSourceDir;
    this.javaOutputTestDir = javaOutputTestDir;
    this.typeScriptOutputSourceDir = typeScriptOutputSourceDir;
    this.protoOutputSourceDir = protoOutputSourceDir;
    this.modelPath = model_ecore_path;
    this.component = component;
    this.dartOutputDir = dartOutputDir;

    // Computed attributes
    this.protoBufPackage = rootPackage;
    this.entityPackage = rootPackage + ".model";
    this.repositoryPackage = rootPackage + ".dao";
    this.dtoPackage = rootPackage + ".dto";
    this.rolePackage = rootPackage + ".roles";
    this.dtoEntityTransformerPackage = rootPackage + ".mapper";
    this.dtoProtoTransformerPackage = rootPackage + ".mapper";
    this.transformerPackage = rootPackage + ".mapper";
    this.servicePackage = rootPackage + ".service";
    this.grpcServerPackage = rootPackage + ".api.server";
    this.grpcClientPackage = rootPackage + ".api.client.grpc";
    this.controllerPackage = rootPackage + ".api.server.rest";
    this.validationPackage = rootPackage + ".support.validation";
  }

  /**
   * @return the rootPackage
   */
  public String getRootPackage() {
    return rootPackage;
  }

  /**
   * @param rootPackage the rootPackage to set
   */
  public void setRootPackage(String rootPackage) {
    this.rootPackage = rootPackage;
  }

  /**
   * @return the modelFilePath
   */
  public String getModelFilePath() {
    return modelFilePath;
  }

  /**
   * @param modelFilePath the modelFilePath to set
   */
  public void setModelFilePath(String modelFilePath) {
    this.modelFilePath = modelFilePath;
  }

  /**
   * @return the projectsOutputDir
   */
  public String getProjectsOutputDir() {
    return projectsOutputDir;
  }

  /**
   * @param projectsOutputDir the projectsOutputDir to set
   */
  public void setProjectsOutputDir(String projectsOutputDir) {
    this.projectsOutputDir = projectsOutputDir;
  }

  /**
   * @return the apiOutputDir
   */
  public String getApiOutputDir() {
    return apiOutputDir;
  }

  /**
   * @param apiOutputDir the apiOutputDir to set
   */
  public void setApiOutputDir(String apiOutputDir) {
    this.apiOutputDir = apiOutputDir;
  }

  /**
   * @return the serviceOutputDir
   */
  public String getServiceOutputDir() {
    return serviceOutputDir;
  }

  /**
   * @param serviceOutputDir the serviceOutputDir to set
   */
  public void setServiceOutputDir(String serviceOutputDir) {
    this.serviceOutputDir = serviceOutputDir;
  }

  /**
   * @return the bffOutputDir
   */
  public String getBffOutputDir() {
    return bffOutputDir;
  }

  /**
   * @param bffOutputDir the bffOutputDir to set
   */
  public void setBffOutputDir(String bffOutputDir) {
    this.bffOutputDir = bffOutputDir;
  }

  /**
   * @return the frontendOutputDir
   */
  public String getFrontendOutputDir() {
    return frontendOutputDir;
  }

  /**
   * @param frontendOutputDir the frontendOutputDir to set
   */
  public void setFrontendOutputDir(String frontendOutputDir) {
    this.frontendOutputDir = frontendOutputDir;
  }

  /**
   * @return the frontendAngular4OutputDir
   */
  public String getFrontendAngular4OutputDir() {
    return frontendAngular4OutputDir;
  }

  /**
   * @param frontendAngular4OutputDir the frontendAngular4OutputDir to set
   */
  public void setFrontendAngular4OutputDir(String frontendAngular4OutputDir) {
    this.frontendAngular4OutputDir = frontendAngular4OutputDir;
  }

  /**
   * @return the componentOutputDir
   */
  public String getComponentOutputDir() {
    return componentOutputDir;
  }

  /**
   * @param componentOutputDir the componentOutputDir to set
   */
  public void setComponentOutputDir(String componentOutputDir) {
    this.componentOutputDir = componentOutputDir;
  }

  /**
   * @return the javaOutputSourceDir
   */
  public String getJavaOutputSourceDir() {
    return javaOutputSourceDir;
  }

  /**
   * @param javaOutputSourceDir the javaOutputSourceDir to set
   */
  public void setJavaOutputSourceDir(String javaOutputSourceDir) {
    this.javaOutputSourceDir = javaOutputSourceDir;
  }

  /**
   * @return the javaOutputTestDir
   */
  public String getJavaOutputTestDir() {
    return javaOutputTestDir;
  }

  /**
   * @param javaOutputTestDir the javaOutputTestDir to set
   */
  public void setJavaOutputTestDir(String javaOutputTestDir) {
    this.javaOutputTestDir = javaOutputTestDir;
  }

  /**
   * @return the typeScriptOutputSourceDir
   */
  public String getTypeScriptOutputSourceDir() {
    return typeScriptOutputSourceDir;
  }

  /**
   * @param typeScriptOutputSourceDir the typeScriptOutputSourceDir to set
   */
  public void setTypeScriptOutputSourceDir(String typeScriptOutputSourceDir) {
    this.typeScriptOutputSourceDir = typeScriptOutputSourceDir;
  }

  /**
   * @return the model_ecore_path
   */
  public String getModelPath() {
    return modelPath;
  }

  /**
   * @param model_ecore_path the model_ecore_path to set
   */
  public void setModel_ecore_path(String model_ecore_path) {
    this.modelPath = model_ecore_path;
  }

  /**
   * @return the protoBufPackage
   */
  public String getProtoBufPackage() {
    return protoBufPackage;
  }

  /**
   * @param protoBufPackage the protoBufPackage to set
   */
  public void setProtoBufPackage(String protoBufPackage) {
    this.protoBufPackage = protoBufPackage;
  }

  /**
   * @return the entityPackage
   */
  public String getEntityPackage() {
    return entityPackage;
  }

  /**
   * @param entityPackage the entityPackage to set
   */
  public void setEntityPackage(String entityPackage) {
    this.entityPackage = entityPackage;
  }

  /**
   * @return the repositoryPackage
   */
  public String getRepositoryPackage() {
    return repositoryPackage;
  }

  /**
   * @param repositoryPackage the repositoryPackage to set
   */
  public void setRepositoryPackage(String repositoryPackage) {
    this.repositoryPackage = repositoryPackage;
  }

  /**
   * @return the dtoPackage
   */
  public String getDtoPackage() {
    return dtoPackage;
  }

  /**
   * @param dtoPackage the dtoPackage to set
   */
  public void setDtoPackage(String dtoPackage) {
    this.dtoPackage = dtoPackage;
  }

  /**
   * @return the rolePackage
   */
  public String getRolePackage() {
    return rolePackage;
  }

  /**
   * @param rolePackage the rolePackage to set
   */
  public void setRolePackage(String rolePackage) {
    this.rolePackage = rolePackage;
  }

  /**
   * @return the dtoEntityTransformerPackage
   */
  public String getDtoEntityTransformerPackage() {
    return dtoEntityTransformerPackage;
  }

  /**
   * @param dtoEntityTransformerPackage the dtoEntityTransformerPackage to set
   */
  public void setDtoEntityTransformerPackage(String dtoEntityTransformerPackage) {
    this.dtoEntityTransformerPackage = dtoEntityTransformerPackage;
  }

  /**
   * @return the dtoProtoTransformerPackage
   */
  public String getDtoProtoTransformerPackage() {
    return dtoProtoTransformerPackage;
  }

  /**
   * @param dtoProtoTransformerPackage the dtoProtoTransformerPackage to set
   */
  public void setDtoProtoTransformerPackage(String dtoProtoTransformerPackage) {
    this.dtoProtoTransformerPackage = dtoProtoTransformerPackage;
  }

  /**
   * @return the transformerPackage
   */
  public String getTransformerPackage() {
    return transformerPackage;
  }

  /**
   * @param transformerPackage the transformerPackage to set
   */
  public void setTransformerPackage(String transformerPackage) {
    this.transformerPackage = transformerPackage;
  }

  /**
   * @return the servicePackage
   */
  public String getServicePackage() {
    return servicePackage;
  }

  /**
   * @param servicePackage the servicePackage to set
   */
  public void setServicePackage(String servicePackage) {
    this.servicePackage = servicePackage;
  }

  /**
   * @return the grpcServerPackage
   */
  public String getGrpcServerPackage() {
    return grpcServerPackage;
  }

  /**
   * @param grpcServerPackage the grpcServerPackage to set
   */
  public void setGrpcServerPackage(String grpcServerPackage) {
    this.grpcServerPackage = grpcServerPackage;
  }

  /**
   * @return the grpcClientPackage
   */
  public String getGrpcClientPackage() {
    return grpcClientPackage;
  }

  /**
   * @param grpcClientPackage the grpcClientPackage to set
   */
  public void setGrpcClientPackage(String grpcClientPackage) {
    this.grpcClientPackage = grpcClientPackage;
  }

  /**
   * @return the controllerPackage
   */
  public String getControllerPackage() {
    return controllerPackage;
  }

  /**
   * @param controllerPackage the controllerPackage to set
   */
  public void setControllerPackage(String controllerPackage) {
    this.controllerPackage = controllerPackage;
  }

  /**
   * @return the validationPackage
   */
  public String getValidationPackage() {
    return validationPackage;
  }

  /**
   * @param validationPackage the validationPackage to set
   */
  public void setValidationPackage(String validationPackage) {
    this.validationPackage = validationPackage;
  }

  /**
   * @return the entitysuffix
   */
  public String getEntitySuffix() {
    return entitySuffix;
  }

  /**
   * @return the entityrepositorysuffix
   */
  public String getEntityrepositorysuffix() {
    return entityRepositorySuffix;
  }

  /**
   * @return the dtosuffix
   */
  public String getDtoSuffix() {
    return dtoSuffix;
  }

  /**
   * @return the protoOutputSourceDir
   */
  public String getProtoOutputSourceDir() {
    return protoOutputSourceDir;
  }

  /**
   * @param protoOutputSourceDir the protoOutputSourceDir to set
   */
  public void setProtoOutputSourceDir(String protoOutputSourceDir) {
    this.protoOutputSourceDir = protoOutputSourceDir;
  }

  /**
   * @return the component
   */
  public String getComponent() {
    return component;
  }

  /**
   * @param component the component to set
   */
  public void setComponent(String component) {
    this.component = component;
  }

  /**
   * @return the owner
   */
  public boolean isOwner() {
    return owner;
  }

  /**
   * @param owner the owner to set
   */
  public void setOwner(boolean owner) {
    this.owner = owner;
  }
  
  /**
   * Get DART output directory
   * @return
   */
  public String getDartOutputDir() {
	return dartOutputDir;
  }
}
