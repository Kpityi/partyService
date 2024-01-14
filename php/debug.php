<?php

// Set arguments
$_POST['data'] = '{"userId":1,"email":"kertesz.istvan-e2022@keri.mako.hu","cart":[{"id":2,"name":"balloon_blue","price":500,"quantity":1},{"id":5,"name":"balloon_bd_red","price":500,"quantity":1},{"id":11,"name":"balloon_smile","price":500,"quantity":2}],"total":2000,"lang":{"id":"hu","type":"east"},"userName":"István"}';


// Call php file to debug
require_once('set_order.php');
