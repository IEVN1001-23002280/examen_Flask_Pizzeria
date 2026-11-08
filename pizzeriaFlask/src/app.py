from flask import Flask
from flask_cors import CORS
from config import config
from database import mysql
from blueprints.pizzas.routes import pizzas_bp

app = Flask(__name__)
CORS(app)

# Cargar configuración de desarrollo
app.config.from_object(config['development'])

# Inicializar MySQL con la app
mysql.init_app(app)

# Registrar el Blueprint
app.register_blueprint(pizzas_bp)

if __name__ == '__main__':
    app.run(debug=True, port=5000)