import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class PizzeriaService {
  private apiUrl = 'http://127.0.0.1:5000/api';

  private pizzasSource = new BehaviorSubject<any[]>([]);
  pizzas$ = this.pizzasSource.asObservable();

  private clienteSource = new BehaviorSubject<any>({
    nombre: '',
    direccion: '',
    telefono: '',
    fecha: new Date().toISOString().split('T')[0]
  });
  cliente$ = this.clienteSource.asObservable();

  constructor(private http: HttpClient) {}

  getPizzasActuales(): any[] {
    return this.pizzasSource.getValue();
  }

  actualizarPizzas(pizzas: any[]) {
    this.pizzasSource.next(pizzas);
  }

  actualizarCliente(cliente: any) {
    this.clienteSource.next(cliente);
  }

  getClienteActual(): any {
    return this.clienteSource.getValue();
  }

  resetCliente() {
    this.clienteSource.next({
      nombre: '',
      direccion: '',
      telefono: '',
      fecha: new Date().toISOString().split('T')[0]
    });
  }

  registrarPedido(pedidoData: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/pedidos`, pedidoData);
  }

  getVentasPorDia(fecha: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/ventas/dia/${fecha}`);
  }

  getVentasPorMes(mes: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/ventas/mes/${mes}`);
  }

  getVentasPorDiaSemana(dia: string): Observable<any> {
    return this.http.get(`${this.apiUrl}/ventas/diasemana/${dia}`);
  }

  getDetalleVenta(idpedido: number): Observable<any> {
    return this.http.get(`${this.apiUrl}/pedidos/${idpedido}/detalle`);
  }
}