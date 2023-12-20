<?php

// Set environment
require_once('../../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query = "SELECT `products`.`product_name`, 
                 `products`.`price`, 
                 `orders`.`order_date` 
          FROM `products` 
          JOIN `orders` ON `product_id` = `products`.`id` 
          WHERE `orders`.`user_id` = :id";

// Execute query with argument
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);



