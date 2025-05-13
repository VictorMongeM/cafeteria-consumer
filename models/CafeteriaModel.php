<?php
require_once __DIR__ . '/../config/Database.php';

class CafeteriaModel {
    private $conn;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    // Obtener el total de ventas (cantidad y monto)
    public function getTotalVentas() {
        try {
            $query = "SELECT COUNT(*) AS total_cantidad, SUM(total_venta) AS total_pesos 
                     FROM Ventas";
            $result = $this->conn->query($query);
            
            if ($result) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("Error en la consulta: " . $this->conn->error);
            }
            
        } catch(Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Obtener el empleado con más ventas
    public function getEmpleadoMasVentas() {
        try {
            $query = "SELECT e.empleado_id, e.nombre, e.apellido, COUNT(*) AS total_ventas, SUM(v.total_venta) AS monto_total
                     FROM Empleados e
                     INNER JOIN Ventas v ON e.empleado_id = v.empleado_id
                     GROUP BY e.empleado_id
                     ORDER BY total_ventas DESC
                     LIMIT 1";
            $result = $this->conn->query($query);
            
            if ($result) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("Error en la consulta: " . $this->conn->error);
            }
        } catch(Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Obtener el producto más vendido
    public function getProductoMasVendido() {
        try {
            $query = "SELECT p.producto_id, p.nombre_producto, SUM(v.cantidad_vendida) AS total_vendido, 
                     SUM(v.total_venta) AS monto_total
                     FROM Productos p
                     INNER JOIN Ventas v ON p.producto_id = v.producto_id
                     GROUP BY p.producto_id
                     ORDER BY total_vendido DESC
                     LIMIT 1";
            $result = $this->conn->query($query);
            
            if ($result) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("Error en la consulta: " . $this->conn->error);
            }
        } catch(Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Obtener la sucursal con más ventas
    public function getSucursalMasVentas() {
        try {
            $query = "SELECT s.sucursal_id, s.nombre, COUNT(v.venta_id) AS total_ventas, 
                     SUM(v.total_venta) AS monto_total
                     FROM Sucursales s
                     INNER JOIN Empleados e ON s.sucursal_id = e.sucursal_id
                     INNER JOIN Ventas v ON e.empleado_id = v.empleado_id
                     GROUP BY s.sucursal_id
                     ORDER BY total_ventas DESC
                     LIMIT 1";
            $result = $this->conn->query($query);
            
            if ($result) {
                return $result->fetch_assoc();
            } else {
                throw new Exception("Error en la consulta: " . $this->conn->error);
            }
        } catch(Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }

    // Obtener lista de todas las ventas
    public function getListaVentas() {
        try {
            $query = "SELECT v.venta_id, p.nombre_producto, v.cantidad_vendida, v.total_venta, 
                     v.numero_mesa, CONCAT(e.nombre, ' ', e.apellido) AS empleado
                     FROM Ventas v
                     INNER JOIN Productos p ON v.producto_id = p.producto_id
                     INNER JOIN Empleados e ON v.empleado_id = e.empleado_id
                     ORDER BY v.venta_id";
            $result = $this->conn->query($query);
            
            if ($result) {
                $ventas = [];
                while ($row = $result->fetch_assoc()) {
                    $ventas[] = $row;
                }
                return $ventas;
            } else {
                throw new Exception("Error en la consulta: " . $this->conn->error);
            }
        } catch(Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
}
?> 