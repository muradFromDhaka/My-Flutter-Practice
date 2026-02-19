import { ApplicationConfig, importProvidersFrom } from '@angular/core';
import { provideRouter } from '@angular/router';

import { routes } from './app.routes';
import { HttpClientModule, provideHttpClient } from '@angular/common/http';
import { FormsModule } from '@angular/forms';
(window as any).global = window;

export const appConfig: ApplicationConfig = {

  providers: [
    provideHttpClient(),
    importProvidersFrom(FormsModule, HttpClientModule), provideRouter(routes)]
};
