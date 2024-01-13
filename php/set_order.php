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
$query = "SELECT MAX(`order_id`) as `order_id` FROM `orders` LIMIT 1;";

// Execute query with argument
$result = $db->execute($query);

if (is_null($result[0]['order_id']))
			$orderId = '0001';
else 	$orderId = substr(('0000' . strval(intval($result[0]['order_id'])+1)), -4);

// Set query
$query = "INSERT INTO `orders` (`product_id`,`product_name`,`price`,`quantity`,`user_id`, `order_id`) VALUES ";

$params = array();
foreach($args['cart'] as $item) {
	$item['user_id'] = $args['userId'];
	$item['order_id'] = $orderId;
	$params = array_merge($params, array_values($item));
}

// Execute query with argument
$result = $db->execute($query, $params);
if ($result['affectedRows']>0) $result['order_id'] = date("Y/m/d") . "/" . $orderId;

// Close connection
$db = null;

// Set response
Util::setResponse($result);