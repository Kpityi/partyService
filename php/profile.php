<?php

// Set environment
require_once('../../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

// Set query
$query 	= "UPDATE `users` 
							SET `first_name` 		= :firstName,
						 			`last_name` 		= :lastName,
						 			`gender_id`			= :gender,
						 			`img` 					= :img,
						 			`img_type` 			= :img_type,
						 			`born` 					= :dateOfBirth,
						 			`country` 			= :country,
						 			`country_code`	= :country_code,
						 			`phone` 				= :phone,
						 			`city` 					= :city,
						 			`postcode` 			= :postcode,
						 			`address` 			= :address,
						 			`modified`			= :modified
						WHERE `id` = :id";

// Check image exist
if ($args['img']) {

	// Decode image
	$args['img'] = Util::base64Decode($args['img']);
}

// Set modified datetime
$args['modified'] = date("Y-m-d H:i:s");

// Execute query with arguments
$result = $db->execute($query, $args);

// Close connection
$db = null;

// Set response
Util::setResponse($result);