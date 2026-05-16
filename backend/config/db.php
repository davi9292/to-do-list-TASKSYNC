<?php
// Davi de Assis Fabricio
// Ajuste as credenciais conforme seu ambiente XAMPP / servidor local

define('DB_HOST', 'localhost');
define('DB_NAME', 'tasksync');
define('DB_USER', 'root');
define('DB_PASS', '');          // padrão XAMPP sem senha
define('DB_CHAR', 'utf8mb4');

function getConnection(): PDO {
    static $pdo = null;
    if ($pdo === null) {
        $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHAR;
        $options = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];
        $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
    }
    return $pdo;
}