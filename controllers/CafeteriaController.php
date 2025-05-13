<?php
require_once __DIR__ . '/../models/CafeteriaModel.php';

class CafeteriaController {
    private $model;

    public function __construct() {
        $this->model = new CafeteriaModel();
    }

    public function getDatosResumen() {
        $datos = [
            'total_ventas' => $this->model->getTotalVentas(),
            'empleado_mas_ventas' => $this->model->getEmpleadoMasVentas(),
            'producto_mas_vendido' => $this->model->getProductoMasVendido(),
            'sucursal_mas_ventas' => $this->model->getSucursalMasVentas(),
            'lista_ventas' => $this->model->getListaVentas()
        ];

        return $datos;
    }

}

// Si se manda un fecth a este archivo inicializar el controlador y retornar datos
if($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['obtener_datos'])){
    $controller = new CafeteriaController();
    $datos = $controller->getDatosResumen();
    header('Content-Type: application/json');
    echo json_encode($datos);
} else {
    http_response_code(405);
    header('Content-Type: text/plain; charset=utf-8');
    echo 'Método no permitido';
}
?>
