<?php
// Cross Origin Access
require('config/cors.php');
require('config/connection.php');

$moblie=$_POST["moblie"];
$action=$_POST["action"];
$tb=$_POST["tb"];

$invalid="User already existed";
$error="An Error Occurred";

if($action=="checkuser"){

    $sql="SELECT * FROM `$tb` WHERE moblie='$moblie'";
    $result = $conn->query($sql); 
    if($result){// run query
        $db_data = array();
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
         // Send back the complete records as a json

         $param=[
             'status'=>200,
             'message'=>$invalid,
             'data'=>$db_data,
         ];
            echo json_encode($param);
        }else{

            $param=[
                'status'=>201,
                'message'=>"success",
                'data'=>[],
            ];
            echo json_encode($param);

        }
    }else{

        $param=[
            'status'=>500,
            'message'=>'error',
            'data'=>[],
        ];

        echo json_encode($param);
    }
}

$conn->close();

?>