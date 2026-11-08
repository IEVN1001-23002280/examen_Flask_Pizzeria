import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { PizzeriaService } from './pizzeria.service';

@Component({
  selector: 'app-detalle-pedido',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './detalle-pedido.component.html'
})
export class DetallePedidoComponent {
  pizzasDetalle: any[] = [];

  constructor(private pizzeriaService: PizzeriaService) {
    this.pizzeriaService.pizzas$.subscribe(pizzas => {
      this.pizzasDetalle = pizzas;
    });
  }

  quitarPizza(index: number) {
    this.pizzasDetalle.splice(index, 1);
    this.pizzeriaService.actualizarPizzas([...this.pizzasDetalle]);
  }

  calcularTotal(): number {
    return this.pizzasDetalle.reduce((acc, item) => acc + item.subtotal, 0);
  }

  terminarPedido() {
    if (this.pizzasDetalle.length === 0) {
      alert('Agrega al menos una pizza antes de terminar.');
      return;
    }

    const clienteInfo = this.pizzeriaService.getClienteActual() || {
      nombre: '',
      direccion: '',
      telefono: '',
      fecha: new Date().toISOString().split('T')[0]
    };

    const payload = {
      nombre: clienteInfo.nombre,
      direccion: clienteInfo.direccion,
      telefono: clienteInfo.telefono,
      fecha: clienteInfo.fecha || new Date().toISOString().split('T')[0],
      total: this.calcularTotal(),
      pizzas: this.pizzasDetalle
    };

    console.log("Enviando pedido a Flask:", payload);

    this.pizzeriaService.registrarPedido(payload).subscribe({
      next: (res: any) => {
        alert(`¡Pedido guardado con éxito! ID: ${res.idpedido}`);
        this.pizzasDetalle = [];
        this.pizzeriaService.actualizarPizzas([]);
        this.pizzeriaService.resetCliente();
      },
      error: (err) => {
        console.error("Error al guardar en Flask:", err);
        alert('Hubo un error al registrar el pedido en la BD.');
      }
    });
  }
}