import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PizzeriaService } from './pizzeria.service';

@Component({
  selector: 'app-consultas-ventas',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './consultas-ventas.component.html'
})
export class ConsultasVentasComponent {
  diaSeleccionado: string = 'lunes';
  mesSeleccionado: string = 'enero';

  resultadoDia: any = null;
  resultadoMes: any = null;
  detalleVenta: any = null;
  idpedidoSeleccionado: number | null = null;

  constructor(private pizzeriaService: PizzeriaService) {}

  buscarPorDia() {
    this.pizzeriaService.getVentasPorDiaSemana(this.diaSeleccionado).subscribe({
      next: (res) => { this.resultadoDia = res; },
      error: (err) => { console.error(err); alert('Error al consultar ventas por día'); }
    });
  }

  buscarPorMes() {
    this.pizzeriaService.getVentasPorMes(this.mesSeleccionado).subscribe({
      next: (res) => { this.resultadoMes = res; },
      error: (err) => { console.error(err); alert('Error al consultar ventas por mes'); }
    });
  }

  verDetalle(idpedido: number) {
    this.idpedidoSeleccionado = idpedido;
    this.pizzeriaService.getDetalleVenta(idpedido).subscribe({
      next: (res) => { this.detalleVenta = res; },
      error: (err) => { console.error(err); alert('Error al obtener el detalle'); }
    });
  }
}