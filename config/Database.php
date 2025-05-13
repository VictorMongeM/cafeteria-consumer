<?php
class Database {
    private $host = 'localhost';
    private $db_name = 'cafeteria';
    private $username = 'cafeteria';
    private $password = '123';
    private $conn;

    public function getConnection() {
        $this->conn = null;

        try {
            $this->conn = new mysqli($this->host, $this->username, $this->password, $this->db_name);
            
            // Verificar conexión
            if ($this->conn->connect_error) {
                throw new Exception("Error de conexión: " . $this->conn->connect_error);
            }
            
            // Establecer charset
            $this->conn->set_charset("utf8");
        } catch(Exception $e) {
            echo 'Error de conexión: ' . $e->getMessage();
        }

        return $this->conn;
    }
}
?>
