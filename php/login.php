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
$query = "SELECT 	`id`,
									`user_role_id`,
									`first_name`,
									`last_name`,
									`gender_id` 		 As `gender`, 
									BASE64_ENCODE(`img`) AS `img`,
									`img_type`,
									`email`,
									`password`,
									`valid`,
									`wrong_attempts` 
					FROM 	`users` 
					WHERE `email` = ?
					LIMIT 1;";

// Execute query with argument
$result = $db->execute($query, array($args['email']));

// Check user exist
if (is_null($result)) {

	// Set error
	Util::setError('user_not_exist', $db);
}

// Simplify result
$result = $result[0];

// Check user valid
if (!$result['valid']) {

	// Set error
	Util::setError('the_user_is_disabled', $db);
}

// Check the number of attempts
if ($result['wrong_attempts'] > 5) {

	// Set error
	Util::setError('the user is disabled, because the number of attempts has exceeded the limit', $db);
}

// Verify the password
if (!password_verify($args['password'], $result['password'])) {

	// Set query
	$query = 	"UPDATE `users` 
								SET `wrong_attempts` = `wrong_attempts` + 1
								WHERE `id` = ?;";

	// Execute query with arguments
	$success = $db->execute($query, array($result['id']));

	// Set error
	if ($success['affectedRows'])
				Util::setError('password_incorrect', $db);
	else		Util::setError('failed_to_increase_retries', $db);
}

// Unset not necessary key(s)
unset(
	$result['password'], 
	$result['valid'], 
	$result['wrong_attempts']
);

// Set query
$query = 	"UPDATE `users` 
							SET `last_login` = :dateNow,
									`wrong_attempts` = 0
							WHERE `id` = :id;";

// Execute query with arguments
$success = $db->execute($query, array(
	"dateNow" 		=> date("Y-m-d H:i:s"), 
	"id" 					=> $result['id']
));

// Close connection
$db = null;

// Check not success
if (!$success['affectedRows']) {

	// Set error
	Util::setError('failed_to_administer_login');
}

// Set response
Util::setResponse($result);