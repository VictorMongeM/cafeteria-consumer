# Sistema de información de cafetería

Sistema para visualizar estadísticas y datos de ventas de una cafetería. Este sistema muestra:

* Total de ventas en cantidad (número de ventas realizadas) y el total de las ventas (cantidad en pesos).
* Empleado con mas ventas.
* Producto más vendido.
* Sucursal con más ventas.
* Lista de las ventas

## Estructura MVC

- **config/Database.php**: Configuración de la conexión a la base de datos usando mysqli.
- **models/Cafeteria.php**: Modelo con las consultas a la base de datos.
- **controllers/CafeteriaController.php**: Controlador que maneja la lógica del negocio.
- **views/index.html**: Vista principal con la interfaz de usuario.

## Funcionamiento

La aplicación utiliza una arquitectura MVC. La interfaz utiliza JavaScript para cargar los datos de manera asíncrona desde el controlador utilizando fetch API.
