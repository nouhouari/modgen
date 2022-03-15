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
import { EventType } from './eventtype.enum';
import { EventFormat } from './eventformat.enum';
import { Media } from './media.model';
import { HttpParams } from '@angular/common/http';


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
   // StartDate field
   public startDate: Date;
   // Organizer field
   public organizer: string;
   // EndDate field
   public endDate: Date;
   // Type field
   public type: EventType;
   // TimeZone field
   public timeZone: string;
   // Format field
   public format: EventFormat;
   // Active field
   public active: boolean;
   // Media field
   public media: Media[] = [];
   //public category_event: Category[] = [];
   //public venue_event: Venue[] = [];
   //public organizer_event: Organizer[] = [];
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
  public mediaId: string;

  public name: string;
  public type: EventType;
  public format: EventFormat;
  public active: boolean;

  public clear(): void {
    this.name = null;
    this.type = null;
    this.format = null;
    this.active = null;
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
      
    // type search field
    if (criteria.type){
      params = params.set('type', criteria.type.toString());
    }
      
    // format search field
    if (criteria.format){
      params = params.set('format', criteria.format.toString());
    }
      
    // active search field
    if (criteria.active){
      params = params.set('active', String(criteria.active));
    }
      
    if (criteria.mediaId){
      params = params.set('mediaId', criteria.mediaId);
    }
    return params;
  }
}
