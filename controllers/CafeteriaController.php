<?php
require_once __DIR__ . '/../models/CafeteriaModel.php';

class CafeteriaController
{
    private $cafeteriaModel;

    public function __construct(){
        $this->cafeteriaModel = new CafeteriaModel();
    }

    public function obtenerTotalVentas() {
        $xml = $this->cafeteriaModel->obtenerTotalVentas();
        return $xml;
    }

    public function obtenerEmpleadoMasVentas() {
        $xml = $this->cafeteriaModel->obtenerEmpleadoMasVentas();
        return $xml;
    }

    public function obtenerProductoMasVendido(){
        $xml = $this->cafeteriaModel->obtenerProductoMasVendido();
        return $xml;
    }

    public function obtenerSucursalMasVentas(){
        $xml = $this->cafeteriaModel->obtenerSucursalMasVentas();
        return $xml;
    }

    public function obtenerListaVentas() {
        $xml = $this->cafeteriaModel->obtenerListaVentas();
        return $xml;
    }
}
?>
