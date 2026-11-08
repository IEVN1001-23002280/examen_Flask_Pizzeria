import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { App } from './app';
import PizzeriaComponent from './pizzas/pizzeria.component';

@NgModule({
  declarations: [
    App // <--- Aquí solo va el componente raíz tradicional (App)
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    PizzeriaComponent // <--- Aquí van los componentes standalone
  ],
  providers: [],
  bootstrap: [App]
})
export class AppModule { }