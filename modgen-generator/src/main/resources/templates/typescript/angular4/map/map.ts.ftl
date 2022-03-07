import { Component, AfterViewInit, Input, Output, OnChanges, SimpleChanges, EventEmitter } from '@angular/core';
import * as L from 'leaflet';
import * as geojson from 'geojson';
import { ${entity.name} } from '../../../../models/${entity.name?lower_case}.model';
import { NgxPermissionsService } from 'ngx-permissions';
import { State } from '../../../shared/util/app.constant';

<#list entity.attributes as attribute>
<#if attribute.hasAnnotation("LOCATION")>
 <#assign locationField = attribute.name>
</#if>
</#list>
@Component({
  selector: 'app-${entity.name?lower_case}-map',
  templateUrl: './${entity.name?lower_case}-map.component.html',
  styleUrls: ['./${entity.name?lower_case}-map.component.scss'],
})
export class ${entity.name}MapComponent implements AfterViewInit, OnChanges {

  @Input()
  mapMode:State=State.NEW;
  @Input()
  ${entity.name?lower_case}s: ${entity.name}[];
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
    this.map = L.map('${entity.name?lower_case}-map', {
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
    // fire event on click
    this.map.on('click', (e:any)=>{
      this.removeMarker();
      const p: geojson.Point = {
        type: "Point",
        coordinates: [e.latlng.lng, e.latlng.lat]
      };
      this.addMarker(p);
      this.clickOnMap.emit(p);
    });
  }

  ngOnChanges(changes: SimpleChanges): void {    
    this.ngxPermissionService
      .hasPermission(['READ_${entity.name?upper_case}', 'LIST_${entity.name?upper_case}'])
      .then((authorized) => {
        if (authorized) {
          if (changes.${entity.name?lower_case}s) {
            this.${entity.name?lower_case}s = changes.${entity.name?lower_case}s.currentValue;
            this.removeMarker();
            this.addGeoJSonMarker();
          }
        }
      });
  }

  /**
   * Add a list of ${entity.name?lower_case} in the map.
   */
  addGeoJSonMarker() {
    if (this.${entity.name?lower_case}s){
      this.${entity.name?lower_case}s.forEach(
        ${entity.name?lower_case} => {
          var geojsonPoint: geojson.Point = ${entity.name?lower_case}.${locationField};
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
