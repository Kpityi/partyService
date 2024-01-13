<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Set query
$query = "UPDATE `users`
					 SET `email` = :email,
                         `modified` = :modified
                     WHERE `id` = :userId;";

// Set modified datetime
$args['modified'] = date("Y-m-d H:i:s");

// Execute query with argument
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);