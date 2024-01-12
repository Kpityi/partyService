<?php

// Set arguments
$_POST['data'] = '{"userId":1,"cart":[{"id":3,"quantity":1},{"id":4,"quantity":1},{"id":2,"quantity":5},{"id":10,"quantity":1}]}';

// Call php file to debug
require_once('set_order.php');
