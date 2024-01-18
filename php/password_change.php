<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;
use \Language\Language as Language;

// Set environment
require_once('../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

//Set query
$query = "SELECT `password`
          FROM   `users`
          WHERE  `password` = :password;";

// Execute query with argument
$result = $db->execute($query, array(
              'password' => $args['oldPassword']
          ));

//Check password  
if (is_null($result))
{
	// Simplify result
	$result = $result[0];

  //Set error
   Util::setError("password_incorrect");
	 
}

// Verify the password
if (password_verify($args['oldpassword'], $result['password'])) {

	// Set modified datetime
	$args['modified'] = date("Y-m-d H:i:s");

	// Set query
	$query = 	"UPDATE `users` 
								SET `password` = :password
										'modified' = :modified
								WHERE `id` = :id;";

	// Execute query with arguments
	$success = $db->execute($query, array(
									'password' 	=> $args['oldPassword'],
									'modified' 	=> $args['modified'],
									'id'				=> $args['userId']
							));
}

$result['success'] = "password_changed"; 

// Close connection
$db = null;

// Set response
Util::setResponse($result);