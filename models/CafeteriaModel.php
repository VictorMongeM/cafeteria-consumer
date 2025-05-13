<?php

class CafeteriaModel {
    private $apiUrl;
    private $jwt;

    public function __construct() {
        $this->jwt = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NDcxNDY1NTN9.9yA6Tb23S9sySMMst0M_vrLFovT2tvPynL1zlkHYMb0';
        $this->apiUrl = 'http://localhost:8080/api/';
    }

    private function sendRequest($url, $method, $xmlData = null) {
        # Inicializar cURL, cRUL es una librería que permite realizar peticiones HTTP
        $ch = curl_init($url);

        # Configurar la petición
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        # Configurar el método de la petición
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);

        # Configurar el tipo de contenido
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            "Content-Type: application/xml",
            "Authorization: Bearer {$this->jwt}"
        ]);

        # Configurar los datos a enviar, si existen datos a enviar en la petición HTTP (POST) se configuran con esta opción
        if ($xmlData) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $xmlData);
        }

        # Ejecutar la petición
        $response = curl_exec($ch);

        # Verificar si la petición fue exitosa
        if ($response === false) {
            die("Error al realizar la petición cURL: " . curl_error($ch));
        }

        # Cerrar la petición
        curl_close($ch);

        # Retornar la respuesta
        return $response;
    }

    public function obtenerTotalVentas() {
        $url = $this->apiUrl . 'ventas/total';
        $response = $this->sendRequest($url, 'GET');
        $xml = simplexml_load_string($response);

        return $xml;
    }

    public function obtenerEmpleadoMasVentas(){
        $url = $this->apiUrl . 'ventas/empleado';
        $response = $this->sendRequest($url, 'GET');
        $xml = simplexml_load_string($response);
        return $xml;
    }

    public function obtenerProductoMasVendido(){
        $url = $this->apiUrl . 'ventas/sucursal';
        $response = $this->sendRequest($url, 'GET');
        $xml = simplexml_load_string($response);
        return $xml;
    }

    public function obtenerSucursalMasVentas(){
        $url = $this->apiUrl . 'ventas/lista';
        $response = $this->sendRequest($url, 'GET');
        $xml = simplexml_load_string($response);
        return $xml;
    }

    public function obtenerListaVentas() {
        $url = $this->apiUrl . 'ventas/lista';
        $response = $this->sendRequest($url, 'GET');
        $xml = simplexml_load_string($response);
        return $xml;
    }

}
?> 