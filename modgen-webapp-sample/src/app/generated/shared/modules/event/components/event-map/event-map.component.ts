import { Component, AfterViewInit, Input, Output, OnChanges, SimpleChanges, EventEmitter } from '@angular/core';
import * as L from 'leaflet';
import * as geojson from 'geojson';
import { Event } from '../../../../models/event.model';
import { NgxPermissionsService } from 'ngx-permissions';
import { State } from '../../../shared/util/app.constant';

@Component({
  selector: 'app-event-map',
  templateUrl: './event-map.component.html',
  styleUrls: ['./event-map.component.scss'],
})
export class EventMapComponent implements AfterViewInit, OnChanges {

  @Input()
  mapMode:State=State.NEW;
  @Input()
  events: Event[];
  @Input()
  height: string;
  map: L.Map;
  markers: L.GeoJSON[] = [];
  @Output()
  clickOnMap: EventEmitter<geojson.Point> = new EventEmitter<geojson.Point>();

  constructor(private ngxPermissionService: NgxPermissionsService) {
    this.height = this.height || '500px';
    }

  ngAfterViewInit(): void {
    this.map = L.map('event-map', {
      zoom: 10,
      center: L.latLng(2.922580414309976, 101.661309704216)
    });
    var openStreetLayer = new L.TileLayer(
      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      {
        minZoom: 3,
        maxZoom: 18,
        attribution:
          '<a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> ',
      }
    );
    openStreetLayer.addTo(this.map);
    
    if (this.mapMode == State.NEW || this.mapMode == State.EDIT) {
      // fire event on click
      this.map.on('click', (e: any) => {
        this.removeMarker();
        const p: geojson.Point = {
          type: "Point",
          coordinates: [e.latlng.lng, e.latlng.lat]
        };
        this.addMarker(p);
        this.clickOnMap.emit(p);
      });
    }
  }

  ngOnChanges(changes: SimpleChanges): void {    
    this.ngxPermissionService
      .hasPermission(['READ_EVENT', 'LIST_EVENT'])
      .then((authorized) => {
        if (authorized) {
          if (changes.events) {
            this.events = changes.events.currentValue;
            this.removeMarker();
            this.addGeoJSonMarker();
          }
        }
      });
  }

  /**
   * Add a list of event in the map.
   */
  addGeoJSonMarker() {
    if (this.events){
      this.events.forEach(
        event => {
          var geojsonPoint: geojson.Point = event.location;
          this.addMarker(geojsonPoint);
        }
      )
    }
  }

  addMarker(geojsonPoint: geojson.Point) {
    if (!geojsonPoint || !geojsonPoint.coordinates)
      return;
    const marker = L.geoJSON(geojsonPoint);
    marker.addTo(this.map);
    this.map.panTo(L.latLng(geojsonPoint.coordinates[1], geojsonPoint.coordinates[0]));
    this.markers.push(marker);
  }
  
  /**
   * Remove all marker from the map.
   */
  removeMarker(){
    if (this.markers){
      this.markers.forEach(
        m => m.removeFrom(this.map)
      )
    }
  }
}
