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
 
 export interface Page<T> {
    content: T[];
    empty: boolean;
    first: boolean;
    last: boolean;
    number: number;
    numberOfElements: number;
    pageable: Pageable;
    size: number;
    sort: Sort;
    totalElements: number;
    totalPages: number;
  }
  
 export interface Pageable {
    offset: number;
    pageNumber: number;
    pageSize: number;
    paged: boolean;
    sort: Sort;
    unpaged: boolean;
 }
  
 export interface Sort {
    empty: boolean;
    sorted: boolean;
    unsorted: boolean;
 }