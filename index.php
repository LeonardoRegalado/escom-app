<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "escom_proyect";

// Create connection
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
  echo "Algo se rompio uppssss";
}

$sql = "SELECT * FROM areas";
$result = $conn->query($sql);

if (mysqli_num_rows($result) > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo " id: " . $row["id"]. " - id_academia: " . $row["id_academia"]. " - nombre:" . $row["nombre"]. "<br>";
    //echo "Areas: $fila[1] $fila[2] $fila[3] <br>";
  }
} else {
  echo "0 results founded";
}
$conn->close();

?>  