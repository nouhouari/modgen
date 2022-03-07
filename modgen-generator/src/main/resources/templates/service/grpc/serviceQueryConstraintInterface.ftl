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

import ${entityPackage}.${entity.name}Entity;

import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

/**
 * @author nhouari
 *
 */
public interface ${entity.name}QueryConstraintListener {
  
   /**
   * Add User defined constraint on the query service 
   * @param root
   * @param query
   * @param builder
   * @param predicates
   */
  public void addConstraint(Root<${entity.name}Entity> root, CriteriaQuery<?> query, CriteriaBuilder builder, List<Predicate> predicates);
}
