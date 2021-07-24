<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');


$name=$_POST["name"];
$moblie=$_POST["moblie"];
$email=$_POST["email"];
$address=$_POST["address"];
$doctor_name=$_POST["doctor_name"];
$doctor_email=$_POST["doctor_email"];
$photo=$_POST["photo"];
$specialist=$_POST["specialist"];
$fee=$_POST["fee"];
$appointment_date=$_POST["appointment_date"];
$appointment_time=$_POST["appointment_time"];
$payment_status=$_POST["payment_status"];
$payment_upi=$_POST["payment_upi"];
$payment_proof=$_POST["payment_proof"];
$action=$_POST["action"];
$table=$_POST["tb"];


if($action=="bookappointment"){

        $sql = "INSERT INTO $table (name,moblie,email,address,doctor_name,doctor_email,photo,specialist,fee,appointment_date,appointment_time,payment_status,payment_upi,payment_proof) VALUES ('$name','$moblie','$email','$address','$doctor_name','$doctor_email','$photo','$specialist','$fee','$appointment_date','$appointment_time','$payment_status','$payment_upi','$payment_proof')";
        $result = $conn->query($sql);

        echo json_encode("success");
        $conn->close();
        return;


}



?>