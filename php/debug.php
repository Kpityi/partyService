<?php

// Set arguments
$_POST['data'] = 
'{"userId":1,"email":"odry.attila@keri.mako.hu","cart":[{"id":2,"name":"balloon_blue","price":500,"quantity":1},{"id":3,"name":"balloon_green","price":500,"quantity":1},{"id":5,"name":"balloon_bd_red","price":500,"quantity":1},{"id":6,"name":"balloon_birthday_blue","price":500,"quantity":1},{"id":8,"name":"ballon_birtday_green","price":500,"quantity":1}],"shipping":1250,"total":3750,"lang":{"id":"hu","type":"east"},"userName":"Attila"}';


// Call php file to debug
require_once('set_order.php');
