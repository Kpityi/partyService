<?php

// Set environment
require_once('../../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query (Check user already exist)
$query = "SELECT `id` 
					FROM 	`users` 
					WHERE `email` = :email
					LIMIT 1;";

// Execute query with arguments
$result = $db->execute($query, array(
						'email' => $args['email']
					));

// Check result
if (!is_null($result)) {

	// Set error
	Util::setError('There is already a user with this email address!', $db);
}

// Set query
$query = "INSERT INTO `users`
					(`first_name`,`last_name`, `born`, `gender_id`, `country`, `country_code`, `phone`, `city`, `postcode`, `address`, `email`, `password`, `created`, `verification_code`) 
					 VALUES 
					(:first_name, :last_name, :born, :gender, :country, :country_code, :phone, :city, :postcode, :address, :email, :password,  :created, :verification_code)";

// Creates a new password hash
$args['password'] = password_hash($args['password'], PASSWORD_DEFAULT);

// Set random verification code
$args['verification_code'] = bin2hex(random_bytes(16));

// Set created datetime
$args['created'] = date("Y-m-d H:i:s");

// Execute query with arguments
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);