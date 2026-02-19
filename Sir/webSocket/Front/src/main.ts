import './polyfills'; 
import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';
import { provideRouter, Routes } from '@angular/router';
import { importProvidersFrom } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ChatComponent } from './app/components/chat/chat.component';


bootstrapApplication(AppComponent, appConfig)
  .catch((err) => console.error(err));
