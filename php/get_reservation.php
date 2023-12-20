<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query = "SELECT  `events`.`date` As `date`, 
                  `event_places`.`place_name` AS `event_place`, 
                  `event_types`.`name` AS `event_type`, 
                  `menu`.`name` AS `menu_package`,
                  `drink`.`name` AS `drink_package`,
                  `events`.`guests` 
          FROM `events` 
          JOIN `event_places` ON `events`.`event_places_id` = `event_places`.`id`
          JOIN event_types ON events.event_type_id = event_types.id
          LEFT JOIN menus AS `menu` ON menu.id = events.menu_id  
          LEFT JOIN menus AS `drink` ON drink.id=events.drink_package_id
          WHERE `events`.`user_id`=:id ";

// Execute query with argument
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);