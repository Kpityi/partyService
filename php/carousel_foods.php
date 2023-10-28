<?php

// Find all image in carousel folder, encode json to string
$skeleton = "../media/image/food/*.*";
$files = glob($skeleton, GLOB_BRACE);
$result = array();
foreach($files as $file){
    $result [] = basename($file);
}

echo json_encode($files, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);

