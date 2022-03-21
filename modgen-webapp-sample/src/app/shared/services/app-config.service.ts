import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

import merge from 'lodash-es/merge';
import { environment } from 'src/environments/environment';

@Injectable()
export class AppConfigService {

  private appConfig;

  constructor(private $http: HttpClient) {
  }

  loadAppConfig() {
    const appConfig = this.$http.get('./assets/config/app-config.json').toPromise();
    const appScreenConfig = this.$http.get(`./assets/screen-app-config/${environment.clientName}-screen-app-config.json`).toPromise();

    return Promise.all([appConfig, appScreenConfig])
      .then((data) => {
        const conf = data[0];
        const screenConfig = data[1];
        this.appConfig = merge(conf, screenConfig);
      })
      .catch((error) => {
        throw error;
      });
  }

  get config() {
    return this.appConfig;
  }
}
