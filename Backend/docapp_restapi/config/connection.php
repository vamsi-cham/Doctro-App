<?php

$username = 'u666708222_doctroapp';
$password = '@Doctroapp54321';
$dbname = 'u666708222_doctroapp';
$servername = 'mnds.tech';
$port=3306;

$conn = mysqli_connect($servername, $username, $password, $dbname, $port);

if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}

?>