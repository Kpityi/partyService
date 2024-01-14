<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query = "SELECT `product_name`, 
                 `price`, 
                 `quantity`, 
                 `order_date`,
                 `order_id`
          FROM `orders`  
          WHERE `user_id` = :id";

// Execute query with argument
$result = $db->execute($query, $args);

// Close connection
$db = null;

//add order number
$result['order_number'] = date("Y/m/d") . "/";

// Set response
Util::setResponse($result);



