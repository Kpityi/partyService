<?php

// Set environment
require_once('../../../common/php/environment.php');

// Connect to database
$db = new Database();

// Set query
$query = "SELECT * FROM `products`;";

// Execute query with argument
$result = $db->execute($query);

// Close connection
$db = null;        

// Set response
Util::setResponse($result);
