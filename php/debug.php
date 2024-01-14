<?php

// Set arguments
$_POST['data'] = '{"userId":1,"email":"kertesz.istvan-e2022@keri.mako.hu","cart":[{"id":1,"name":"balloon_red","price":500,"quantity":1},{"id":2,"name":"balloon_blue","price":500,"quantity":2},{"id":5,"name":"balloon_bd_red","price":500,"quantity":1}],"shipping":1250,"total":2000,"lang":{"id":"hu","type":"east"},"userName":"István"}';

//$_POST['data'] ='{"lang":{"id":"hu","type":"east"},"email":"kertesz.istvan-e2022@keri.mako.hu","message":"kjhjmjjlkj"}';


// Call php file to debug
require_once('set_order.php');
