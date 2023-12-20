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
$query = "INSERT INTO `events`
					(`date`,`user_id`, `event_places_id`, `event_type_id`, `menu_id`, `drink_package_id`, `guests`) 
					 VALUES 
					(:date, :userId, :eventPlaceId, :eventTypeId, :menuId, :drinkPackageId, :guests);";

// Execute query with arguments
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);