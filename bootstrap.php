<?php
return [
    'dsn'      => sprintf('mysql:host=%s;dbname=%s;charset=utf8', getenv('DB_HOST'), getenv('DB_NAME')),
    'user'     => getenv('DB_USER'),
    'password' => getenv('DB_PASS'),
];
