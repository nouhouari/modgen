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
 * [2021] Nourreddine HOUARI SA
 * All Rights Reserved.
 */

/**
 * Table action list model.
 */
export class Action {

  id: string;
  icon: string;
  color: string;
  callBack: Function;
  permissions: string[];

  constructor(id: string, icon: string, callback: Function, permissions: string[], color?: string) {
    this.id = id;
    this.icon = icon;
    this.callBack = callback;
    this.permissions = permissions;
    this.color = color || 'default';
  }
}
