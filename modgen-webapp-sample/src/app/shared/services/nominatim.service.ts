import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class NominatimService {

  constructor(private httpClient: HttpClient) { }

  public findPlace(query: string): Observable<Place[]> {
    let params = new HttpParams();
    params = params.append('format', 'json');
    if (query)
    params = params.append('q', query);
    return this.httpClient.get<Place[]>('https://nominatim.openstreetmap.org/search',{params});
  }

}

export interface Place {
  place_id: number;
  licence: string;
  osm_type: string;
  osm_id: any;
  boundingbox: number[];
  lat: number;
  lon: number;
  display_name: string;
  class: string;
  type: string;
  importance: number;
  icon: string;
}
