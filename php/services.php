<?php

// Set environment
require_once('../../../common/php/environment.php');

// Connect to database
$db = new Database();

// Set query
$query = "SELECT `id`,
                 `name` AS `event_types` 
            FROM `event_types`;";

// Execute query with argument
$eventTypes= $db->execute($query);

$query = "SELECT `id`,
                 `place_name`, 
                 `capacity` 
            FROM `event_places`;";

// Execute query with argument
$eventPlaces= $db->execute($query);

// Close connection
$db = null;

$result =array(
      'eventTypes' => $eventTypes,
      'eventPlaces' => $eventPlaces);

// Set response
Util::setResponse($result);