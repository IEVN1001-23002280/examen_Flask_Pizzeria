import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ClientePizzaComponent } from './cliente-pizza.component';
import { DetallePedidoComponent } from './detalle-pedido.component';
import { ConsultasVentasComponent } from './consultas-ventas.component';

@Component({
  selector: 'app-pizzeria',
  standalone: true,
  imports: [
    CommonModule,
    ClientePizzaComponent,
    DetallePedidoComponent,
    ConsultasVentasComponent
  ],
  templateUrl: './pizzeria.component.html'
})
export default class PizzeriaComponent {}