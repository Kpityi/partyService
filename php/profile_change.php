<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../../common/php/environment.php');

// Set query
$query = "UPDATE `users`
					(`email`, `password`, `created`, `verification_code`) 
					 VALUES 
					(:first_name, :last_name, :born, :gender, :country, :country_code, :phone, :city, :postcode, :address, :email, :password,  :created, :verification_code)";


// Creates a new password hash
$args['password'] = password_hash($args['password'], PASSWORD_DEFAULT);

// Set random verification code
$args['verification_code'] = bin2hex(random_bytes(16));

// Set created datetime
$args['created'] = date("Y-m-d H:i:s");

// Close connection
$db = null;

// Set response
Util::setResponse($result);