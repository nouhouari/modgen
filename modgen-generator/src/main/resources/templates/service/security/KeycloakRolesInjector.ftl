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

import ${rolePackage}.${entity.name}Roles;
import com.sicpa.ptf.keycloak.test.support.setup.KeycloakSetup;

import lombok.extern.slf4j.Slf4j;

/**
 * Generated on ${today}
 */

@Slf4j
public class Keycloak${entity.name?cap_first}RolesInjector {
  
  /**
   * Create the Keycloak roles on the client.
   * @param realm Realm id.
   * @param clientName Client id.
   * @param setup Keycloak setup.
   */
  public static void createRolesForClient(String realm, String clientName, KeycloakSetup setup){
  
    log.info("Create ${entity.name?cap_first} roles for Keycloak client {} ", clientName);
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.COUNT_${entity.name?upper_case});
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.DELETE_${entity.name?upper_case});
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.LIST_${entity.name?upper_case});
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.READ_${entity.name?upper_case});
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.SAVE_${entity.name?upper_case});
    setup.createClientRole(realm, clientName, ${entity.name?cap_first}Roles.SEARCH_${entity.name?upper_case});
  }

  /**
   * Create the Keycloak roles on the realm.
   *
   * @param realm Realm id.
   * @param setup Keycloak setup.
   */
  public static void createRolesForRealm(String realm, KeycloakSetup setup){

     log.info("Create ${entity.name?cap_first} roles for Keycloak realm {} ", realm);
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.COUNT_${entity.name?upper_case});
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.DELETE_${entity.name?upper_case});
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.LIST_${entity.name?upper_case});
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.READ_${entity.name?upper_case});
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.SAVE_${entity.name?upper_case});
     setup.createRealmRole(realm, ${entity.name?cap_first}Roles.SEARCH_${entity.name?upper_case});
  }

  /**
    * Link realm role to client.
    *
    * @param realmName  the realm name
    * @param clientName the client name
    * @param setup      the setup
    */
  public static void linkRealmRoleToClient(String realmName, String clientName, KeycloakSetup setup) {

     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.COUNT_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.COUNT_${entity.name?upper_case});
     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.DELETE_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.DELETE_${entity.name?upper_case});
     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.LIST_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.LIST_${entity.name?upper_case});
     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.READ_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.READ_${entity.name?upper_case});
     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.SAVE_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.SAVE_${entity.name?upper_case});
     setup.linkClientRolesToRealmRole(realmName, ${entity.name?cap_first}Roles.SEARCH_${entity.name?upper_case},
              clientName, ${entity.name?cap_first}Roles.SEARCH_${entity.name?upper_case});

  }


  /**
    * Assing user to roles.
    *
    * @param username the username
    * @param setup    the setup
    */
    public static void assingUserToRoles(String realm, String username, KeycloakSetup setup) {
     setup.assignRealmRolesToUser(realm,username,new String[]{
         ${entity.name?cap_first}Roles.COUNT_${entity.name?upper_case},
         ${entity.name?cap_first}Roles.DELETE_${entity.name?upper_case},
         ${entity.name?cap_first}Roles.LIST_${entity.name?upper_case},
         ${entity.name?cap_first}Roles.READ_${entity.name?upper_case},
         ${entity.name?cap_first}Roles.SAVE_${entity.name?upper_case},
         ${entity.name?cap_first}Roles.SEARCH_${entity.name?upper_case}
     });
    }

  
}
