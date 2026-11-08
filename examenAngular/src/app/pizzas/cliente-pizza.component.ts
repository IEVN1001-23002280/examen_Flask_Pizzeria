import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { PizzeriaService } from './pizzeria.service';

@Component({
  selector: 'app-cliente-pizza',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './cliente-pizza.component.html'
})
export class ClientePizzaComponent {
  cliente = {
    nombre: '',
    direccion: '',
    telefono: '',
    fecha: new Date().toISOString().split('T')[0]
  };

  pizzaActual = {
    tamano: 'Chica',
    numPizzas: 1,
    jamon: false,
    pina: false,
    champinones: false
  };

  constructor(private pizzeriaService: PizzeriaService) {
    // Nos suscribimos al cliente$ del servicio: cada vez que alguien
    // (en este caso, resetCliente() después de Terminar) cambie el cliente,
    // este formulario se actualiza solo.
    this.pizzeriaService.cliente$.subscribe(cliente => {
      this.cliente = cliente;
    });
  }

  agregarPizza() {
    if (this.pizzaActual.numPizzas <= 0) {
      alert('El número de pizzas debe ser mayor a 0');
      return;
    }

    let precioBase = 0;
    if (this.pizzaActual.tamano === 'Chica') precioBase = 40;
    if (this.pizzaActual.tamano === 'Mediana') precioBase = 80;
    if (this.pizzaActual.tamano === 'Grande') precioBase = 120;

    let costoIngredientes = 0;
    let listaIngredientes: string[] = [];
    
    if (this.pizzaActual.jamon) { costoIngredientes += 10; listaIngredientes.push('Jamón'); }
    if (this.pizzaActual.pina) { costoIngredientes += 10; listaIngredientes.push('Piña'); }
    if (this.pizzaActual.champinones) { costoIngredientes += 10; listaIngredientes.push('Champiñones'); }

    const subtotal = (precioBase + costoIngredientes) * this.pizzaActual.numPizzas;

    const nuevaPizza = {
      tamano: this.pizzaActual.tamano,
      ingredientes: listaIngredientes.length > 0 ? listaIngredientes.join(', ') : 'Ninguno',
      num_pizzas: this.pizzaActual.numPizzas,
      subtotal: subtotal
    };

    // Obtenemos la lista actual del servicio, le sumamos la nueva y la actualizamos
    const listaActual = this.pizzeriaService.getPizzasActuales();
    listaActual.push(nuevaPizza);
    this.pizzeriaService.actualizarPizzas(listaActual);

    // Guardar cliente en el servicio para el checkout
    this.pizzeriaService.actualizarCliente(this.cliente);

    // Resetear formulario de pizza actual
    this.pizzaActual = { tamano: 'Chica', numPizzas: 1, jamon: false, pina: false, champinones: false };
  }
}