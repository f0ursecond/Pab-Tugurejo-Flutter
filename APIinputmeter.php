<?php 

header('Content-Type: application/json');

$dbh = new PDO('mysql:host=localhost; dbname=pab_tugurejo', 'root', '');

$db = $dbh->prepare('SELECT * FROM tbuser');
$db->execute();
$tbuser = $db->fetchALL(PDO::FETCH_ASSOC);


$data = json_encode($tbuser);
echo $data;


?>

