<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query = "INSERT INTO `ratings`
          (`user_id`, `rating`, `rating_text`) 
          VALUES (:user_id, :rating, :rating_text);";

// Execute query with argument
$result = $db->execute($query, $args);

// Close connection
$db = null;        

// Set response
Util::setResponse($result);
