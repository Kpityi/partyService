<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;
use \Language\Language as Language;
use \PHPMailer\Email as Email;

// Set environment
require_once('../../common/php/environment.php');

// Get arguments
$args = Util::getArgs();

// Connect to database
$db = new Database();

//Set query
$query = "SELECT `id`
          FROM   `users`
          WHERE  `email` = :email;";

// Execute query with argument
$result = $db->execute($query, array(
              'email' => $args['email']
          ));
//Check email exist  
if (!is_null($result))
{
    //Set error
    Util::setError("user_email_already_exists");
}

// Set query
$query = "UPDATE `users`
          SET    `email` = :email,
                 `modified` = :modified
          WHERE  `id` = :userId;";

// Set modified datetime
$args['modified'] = date("Y-m-d H:i:s");

// Execute query with argument
$result = $db->execute($query, array(
       'email'       => $args['email'],
       'modified'    =>$args['modified'],
       'userId'      =>$args['userId']
   ));
$result['success'] = "email_changed"; 

// Close connection
$db = null;

// Set response
Util::setResponse($result);