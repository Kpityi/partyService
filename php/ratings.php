<?php

// Set environment
require_once('../../../common/php/environment.php');

// Connect to database
$db = new Database();

// Set query
$query = "SELECT `rating`, 
                 `rating_text`, 
                 `rating_answer`,
                 `date`, 
                 `users`.`first_name`, 
                  BASE64_ENCODE(`users`.`img`) AS `img`, 
                 `users`.`img_type`, 
                 `users`.`gender_id`  
          FROM `ratings`
          INNER JOIN `users` 
          ON `user_id` = `users`.`id`;";

// Execute query with argument
$result = $db->execute($query);

// Close connection
$db = null;        

// Set response
Util::setResponse($result);
