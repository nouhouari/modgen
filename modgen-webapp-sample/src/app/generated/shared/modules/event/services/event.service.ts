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

import {
    Event,
    EventSearchCriteria} from '../../../models/event.model';

import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Page } from '../../../models/page.model';


@Injectable()
export class EventService {

  /**
   * Build new EventService.
   * @constructor
   */
  constructor(private http: HttpClient) {}

  /**
   * Get the Event by its key.
   */
  public getEventById(id: any): Observable<Event> {
    return this.http.get<Event>('api/event/' + id);
  }

  /**
   * Save Event.
   */
  public save(newEvent: Event): Observable<Event> {
    return this.http.post<Event>('api/event/', newEvent);
  }

  /**
   * Save Event list.
   */
  public saveBulk(newEvents: Event[]): Observable<Event[]> {
    return this.http.post<Event[]>('api/event/saveBulk', newEvents);
  }

  /**
   * Find Event with search criteria.
   * @return a paginated result of Event.
   */
  public find(criteria?: EventSearchCriteria): Observable<Page<Event>> {
   return this.http.get<Page<Event>>('api/event/search', {params: EventSearchCriteria.toParams(criteria)});
  }

  /**
   * QuickSearch Event with search criteria.
   * @return a paginated result of Event.
   */
  public quickSearch(criteria?: EventSearchCriteria): Observable<Page<Event>> {
   return this.http.get<Page<Event>>('api/event/quicksearch', {params: EventSearchCriteria.toParams(criteria)});
  }

  /**
   * Delete Event.
   */
  public deleteEventById(id: any): Observable<void> {
    return this.http.delete<void>('api/event/' + id);
  }

  /**
   * Add relation with media
   */
  public addMediaRelation(
    id: string,
    mediaId: string): Observable<string> {
    return this.http.post<any>('/event/media/add', {
    'id': id,
    'mediaId': mediaId});
  }

  /**
   * Remove relation with media
   */
  public removeMediaRelation(
    id: string,
    mediaId: string): Observable<string> {
    return this.http.post<any>('/event/media/remove', {
    'id': id,
    'mediaId': mediaId});
  }
}
