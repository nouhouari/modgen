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
import { HttpParams } from '@angular/common/http';
import * as geojson from 'geojson';


/**
 * Event model.
 */
export class Event {

   // Id field
   public id: string;
   // Name field
   public name: string;
   // Description field
   public description: string;
  public location: geojson.Point;
   // StartDate field
   public startDate: Date;
   // Organizer field
   public organizer: string;
   // EndDate field
   public endDate: Date;
   // Version
   public version: number;
   // Extension
   public extension: any;
 }

 /**
  * Event search parameters.
  */
 export class EventSearchCriteria {

  public page: number;
  public size: number;
  public sort: string[];
  public quickSearchQuery: string;

  public name: string;

  public clear(): void {
    this.name = null;
  }
  
  /**
   * Convert criteria to HTTP params
   */
  public static toParams(criteria: EventSearchCriteria): HttpParams {
    let params:HttpParams = new HttpParams();
    if (criteria.page){
      params = params.append('page', criteria.page.toString());
    }
    if (criteria.size){
      params = params.append('size', criteria.size.toString());
    }
    if (criteria.quickSearchQuery){
      params = params.set('quickSearchQuery', criteria.quickSearchQuery);
    }
    if (criteria.sort?.length > 0){
      params = params.set('sort', criteria.sort?.reduce((a,b)=> a+ "," + b));
    }
    // name search field
    if (criteria.name){
      params = params.set('name', criteria.name);
    }  
      
    return params;
  }
}
