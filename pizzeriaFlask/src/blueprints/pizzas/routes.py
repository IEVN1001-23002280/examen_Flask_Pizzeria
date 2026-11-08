from flask import Blueprint, jsonify, request
from database import mysql

pizzas_bp = Blueprint(
    'pizzas',
    __name__,
    url_prefix='/api'
)

DIAS_SEMANA = {
    0: 'lunes', 1: 'martes', 2: 'miercoles', 3: 'jueves',
    4: 'viernes', 5: 'sabado', 6: 'domingo'
}

MESES = {
    'enero': 1, 'febrero': 2, 'marzo': 3, 'abril': 4, 'mayo': 5, 'junio': 6,
    'julio': 7, 'agosto': 8, 'septiembre': 9, 'octubre': 10, 'noviembre': 11, 'diciembre': 12
}

def normalizar(texto):
    texto = texto.lower().strip()
    reemplazos = {'á': 'a', 'é': 'e', 'í': 'i', 'ó': 'o', 'ú': 'u'}
    for a, b in reemplazos.items():
        texto = texto.replace(a, b)
    return texto


# 1. Registrar Pedido Completo
@pizzas_bp.route('/pedidos', methods=['POST'])
def agregar_pedido():
    cursor = None
    try:
        data = request.get_json()

        nombre = data.get('nombre')
        direccion = data.get('direccion')
        telefono = data.get('telefono')
        fecha = data.get('fecha')
        total = data.get('total')
        pizzas = data.get('pizzas', [])

        cursor = mysql.connection.cursor()

        cursor.execute(
            "INSERT INTO pedidos (nombre, direccion, telefono, fecha, total) VALUES (%s, %s, %s, %s, %s)",
            (nombre, direccion, telefono, fecha, total)
        )
        mysql.connection.commit()

        id_pedido_generado = cursor.lastrowid

        for pizza in pizzas:
            tamano = pizza.get('tamano')
            ingredientes = pizza.get('ingredientes')
            num_pizzas = pizza.get('num_pizzas')
            subtotal = pizza.get('subtotal')

            cursor.execute(
                "INSERT INTO detalle_pedidos (idpedido, tamano, ingredientes, num_pizzas, subtotal) VALUES (%s, %s, %s, %s, %s)",
                (id_pedido_generado, tamano, ingredientes, num_pizzas, subtotal)
            )

        mysql.connection.commit()
        return jsonify({'mensaje': '¡Pedido registrado correctamente!', 'idpedido': id_pedido_generado, 'exito': True}), 201

    except Exception as ex:
        return jsonify({'error': str(ex), 'exito': False}), 500
    finally:
        if cursor is not None:
            cursor.close()


# 2. Consultar ventas por fecha exacta (la dejamos, no estorba, aunque el PDF pide por día de la semana - punto 4)
@pizzas_bp.route('/ventas/dia/<string:fecha>', methods=['GET'])
def ventas_por_dia(fecha):
    cursor = None
    try:
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT idpedido, nombre, total FROM pedidos WHERE fecha = %s", (fecha,))
        ventas = cursor.fetchall()

        cursor.execute("SELECT SUM(total) FROM pedidos WHERE fecha = %s", (fecha,))
        resultado = cursor.fetchone()
        total_dia = resultado[0] if resultado and resultado[0] is not None else 0

        return jsonify({'ventas': ventas, 'total_dia': total_dia, 'exito': True})
    except Exception as ex:
        return jsonify({'error': str(ex), 'exito': False}), 500
    finally:
        if cursor is not None:
            cursor.close()


# 3. Consultar ventas por nombre de mes (ej. "enero") - lo que pide el PDF
@pizzas_bp.route('/ventas/mes/<string:mes>', methods=['GET'])
def ventas_por_mes(mes):
    cursor = None
    try:
        numero_mes = MESES.get(normalizar(mes))
        if not numero_mes:
            return jsonify({'error': 'Mes no válido', 'exito': False}), 400

        cursor = mysql.connection.cursor()
        cursor.execute(
            "SELECT idpedido, nombre, fecha, total FROM pedidos WHERE MONTH(fecha) = %s",
            (numero_mes,)
        )
        ventas = cursor.fetchall()

        cursor.execute("SELECT SUM(total) FROM pedidos WHERE MONTH(fecha) = %s", (numero_mes,))
        resultado = cursor.fetchone()
        total_mes = resultado[0] if resultado and resultado[0] is not None else 0

        return jsonify({'ventas': ventas, 'total_mes': total_mes, 'exito': True})
    except Exception as ex:
        return jsonify({'error': str(ex), 'exito': False}), 500
    finally:
        if cursor is not None:
            cursor.close()


# 4. Consultar ventas por día de la semana (lunes, martes...) - lo que pide el PDF literalmente
@pizzas_bp.route('/ventas/diasemana/<string:dia>', methods=['GET'])
def ventas_por_dia_semana(dia):
    cursor = None
    try:
        dia_norm = normalizar(dia)
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT idpedido, nombre, fecha, total FROM pedidos")
        todas = cursor.fetchall()

        ventas_filtradas = []
        total_acumulado = 0
        for v in todas:
            idpedido, nombre, fecha, total = v
            if DIAS_SEMANA[fecha.weekday()] == dia_norm:
                ventas_filtradas.append(v)
                total_acumulado += float(total)

        return jsonify({'ventas': ventas_filtradas, 'total_dia': total_acumulado, 'exito': True})
    except Exception as ex:
        return jsonify({'error': str(ex), 'exito': False}), 500
    finally:
        if cursor is not None:
            cursor.close()


# 5. Ver el detalle de una venta específica
@pizzas_bp.route('/pedidos/<int:idpedido>/detalle', methods=['GET'])
def detalle_de_venta(idpedido):
    cursor = None
    try:
        cursor = mysql.connection.cursor()
        cursor.execute(
            "SELECT nombre, direccion, telefono, fecha, total FROM pedidos WHERE idpedido = %s",
            (idpedido,)
        )
        pedido = cursor.fetchone()
        if not pedido:
            return jsonify({'error': 'Pedido no encontrado', 'exito': False}), 404

        cursor.execute(
            "SELECT tamano, ingredientes, num_pizzas, subtotal FROM detalle_pedidos WHERE idpedido = %s",
            (idpedido,)
        )
        pizzas = cursor.fetchall()

        return jsonify({'pedido': pedido, 'pizzas': pizzas, 'exito': True})
    except Exception as ex:
        return jsonify({'error': str(ex), 'exito': False}), 500
    finally:
        if cursor is not None:
            cursor.close()