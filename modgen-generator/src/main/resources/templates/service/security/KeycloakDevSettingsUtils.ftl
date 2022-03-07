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

<#list entities as entity>
import ${rolePackage}.${entity.name}Roles;
</#list>

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import javax.ws.rs.ClientErrorException;
import javax.ws.rs.core.Response;

import org.apache.http.HttpStatus;
import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.keycloak.admin.client.resource.ClientsResource;
import org.keycloak.admin.client.resource.RealmResource;
import org.keycloak.admin.client.resource.RolesResource;
import org.keycloak.admin.client.resource.UsersResource;
import org.keycloak.representations.idm.ClientRepresentation;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.RealmRepresentation;
import org.keycloak.representations.idm.UserRepresentation;

import lombok.extern.slf4j.Slf4j;

/**
 * This class injects the clients and users setting for 
 * a local settings.<br>
 * It need a user (idm) with realm-admin role to run.<br>
 * <br>
 * <b>Clients :</b>
 * <ul>
 * <li>${component}-service</li>
 * <li>${component}-web-bff</li>
 * </ul>
 * 
 * <b>Roles :</b>
 * <ul>
<#list entities as entity>
 *  <li>save-${entity.name?lower_case}</li> 
 *  <li>read-${entity.name?lower_case}</li>
 *  <li>count-${entity.name?lower_case}</li>
 *  <li>delete-${entity.name?lower_case}</li>
 *  <li>list-${entity.name?lower_case}</li>
 *  <li>search-${entity.name?lower_case}</li>
</#list>
 * </ul>
 * 
 * <b>User :</b>
 * <ul>
 * <li>user01/password</li>
 * </ul>
 * 
 * @author nhouari
 *
 */
@Slf4j
public class KeycloakDevSettingsUtils {

  public static void main(String[] args) {
    
    //Keycloak settings
    String serverUrl = "http://localhost:18080/auth";
    // Realm name
    String realm = "sample";
    String clientId = "admin-cli";
    // User with realm-admin role
    String idmRealm = "master";
    String idmUser = "keycloak";
    String idmPassword = "keycloak";
    // Client names
    String bffClientName = "${component}-web-bff";
    String webClientUrl  = "http://localhost:3000"; 
    String serviceClientName = "${component}-service";
    
    // Create a keycloak admin client instance
    Keycloak keycloak = KeycloakBuilder.builder() 
      .serverUrl(serverUrl) 
      .realm(idmRealm)
      .grantType(OAuth2Constants.PASSWORD) 
      .clientId(clientId) 
      .username(idmUser)
      .password(idmPassword)
      .build();
    log.info("Token : " + keycloak.tokenManager().getAccessTokenString());

    // Create realm
    RealmRepresentation realmRepresentation = new RealmRepresentation();
    realmRepresentation.setRealm(realm);
    realmRepresentation.setEnabled(true);
    try {
      keycloak.realms().create(realmRepresentation);
    } catch (ClientErrorException e) {
      if (e.getResponse().getStatus() == HttpStatus.SC_CONFLICT) {
        log.info("Realm {} already exists", realm);
      } else {
        throw e;
      }
    }

    // Get realm
    RealmResource realmResource = keycloak.realm(realm);
    UsersResource userResource = realmResource.users();
   
    // Get the clients resources
    ClientsResource clientResource = realmResource.clients();
   
    // Create Bff client
    // Check if client exists
    List<ClientRepresentation> bffs = clientResource.findByClientId(bffClientName);
    if(bffs.size() == 0) {
      // Create the client
      ClientRepresentation bffClient = new ClientRepresentation();
      bffClient.setClientId(bffClientName);
      bffClient.setName(bffClientName);
      bffClient.setDescription(bffClientName + " description");
      ArrayList<String> bffRoles = new ArrayList<>();
      <#list entities as entity>
      bffRoles.addAll(Arrays.asList(${entity.name?cap_first}Roles.roles));
      </#list>
      bffClient.setDefaultRoles(bffRoles.toArray(new String[bffRoles.size()]));
      bffClient.setPublicClient(true);
      bffClient.setRedirectUris(Arrays.asList(webClientUrl + "/*"));
      bffClient.setWebOrigins(Arrays.asList(webClientUrl));
      bffClient.setEnabled(true);
      bffClient.setDirectAccessGrantsEnabled(true);
      bffClient.setStandardFlowEnabled(true);
      Response response = clientResource.create(bffClient);
      log.info("BFF client creation response : " + response.getStatusInfo());
    } else {
      log.info("BFF client {}  already exist", bffClientName);
    }
    
    // Create service client
     // Check if client exists
    List<ClientRepresentation> services = clientResource.findByClientId(serviceClientName);
    if(services.size() == 0) {
      ClientRepresentation serviceClient = new ClientRepresentation();
      serviceClient.setClientId(serviceClientName);
      serviceClient.setName(serviceClientName);
      serviceClient.setDescription(serviceClientName + " description");
      ArrayList<String> serviceRoles = new ArrayList<>();
      <#list entities as entity>
      serviceRoles.addAll(Arrays.asList(${entity.name?cap_first}Roles.roles));
      </#list>
      serviceClient.setDefaultRoles(serviceRoles.toArray(new String[serviceRoles.size()]));
      serviceClient.setBearerOnly(true);
      serviceClient.setEnabled(true);
      serviceClient.setDirectAccessGrantsEnabled(true);
      serviceClient.setStandardFlowEnabled(true);
      Response response = clientResource.create(serviceClient);
      log.info("Service client creation response : " + response.getStatusInfo());
    } else {
      log.info("Service client {}  already exist", serviceClientName);
    }

    String userId = null;
    // Create the user01
    UserRepresentation user = new UserRepresentation();
    user.setUsername("user01");
    // Create user (requires manage-users role)
    List<UserRepresentation> search = userResource.search(user.getUsername(), 0, 1);
    if (search.size() > 0) {
      // User already existing
      userId = search.get(0).getId();
      log.info("User {} already exist with id {}", user.getUsername(), userId);
    } else {
      // Create user
      log.info("Creating user {} ...", user.getUsername());
      user.setEnabled(true);
      user.setFirstName("user01");
      user.setLastName("user01");
      user.setEmail("user01@sicpa-dev.com");
      user.setEmailVerified(true);
      List<CredentialRepresentation> credentials = new ArrayList<>();
      CredentialRepresentation e = new CredentialRepresentation();
      e.setTemporary(false);
      e.setType(OAuth2Constants.PASSWORD);
      e.setValue("password");
      credentials.add(e);
      user.setCredentials(credentials);
      user.setAttributes(Collections.singletonMap("origin", Arrays.asList(realm)));

      Response response = userResource.create(user);
      
      log.info("Repsonse: " + response.getStatusInfo());
      log.info("Location: " + response.getLocation());
      if (response.getLocation() != null) {
        userId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");
        log.info("User created with userId: %s%n", userId);
      }
    }
    
    if(userId == null) {
      log.error("User id cannot be null!");
      System.exit(1);
    }
    
    log.info("Assigning roles to user {} ", userId);
      
    // Get BFF client
    ClientRepresentation client = clientResource .findByClientId(bffClientName).get(0);
      
    // Get BFF client level role (requires view-clients role)
    RolesResource userClientRole = clientResource.get(client.getId()).roles();
      
    // Assign BFF client level roles to user
    userResource.get(userId).roles() .clientLevel(client.getId()).add(userClientRole.list());
    log.info("BFF roles assigned");
      
    // Get client
    client = clientResource .findByClientId(serviceClientName).get(0);
      
    // Get client level role (requires view-clients role)
    userClientRole = clientResource.get(client.getId()).roles();
      
    // Assign service client level roles to user
    userResource.get(userId).roles() .clientLevel(client.getId()).add(userClientRole.list());
    log.info("Service roles assigned"); 
  }
}
