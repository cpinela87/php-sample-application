<?php
/**
 * Conexión PDO parametrizada por variables de entorno.
 */
$host = getenv('DB_HOST') ?: 'db';
$port = getenv('DB_PORT') ?: '3306';
$name = getenv('DB_NAME') ?: 'sample';
$user = getenv('DB_USER') ?: 'sampleuser';
$pass = getenv('DB_PASS') ?: 'samplepass';

$dsn  = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8', $host, $port, $name);

return new PDO(
    $dsn,
    $user,
    $pass,
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);
