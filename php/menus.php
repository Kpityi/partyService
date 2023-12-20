<?php
declare(strict_types=1);

// Using namespaces aliasing
use \Util\Util as Util;
use \Database\Database as Database;

// Set environment
require_once('../../common/php/environment.php');

// Connect to database
$db = new Database();

// Set query
$query = "SELECT menus.name AS menu_name,
            CONCAT(
                '[',
                GROUP_CONCAT(
                    JSON_OBJECT('name', dish.name, 'type', dish_category.type, 'description', dish.description, 'price', dish.price) ORDER BY dish.id
                ),
                ']'
            ) AS menu_items
          FROM menus 
          JOIN menu_dishes AS menu_dish ON menus.id = menu_dish.menu_id
          JOIN dishes AS dish ON menu_dish.dish_id = dish.id
          JOIN dish_categories AS dish_category ON dish.dish_category_id = dish_category.id
          GROUP BY menus.id, menus.name;";

// Execute query with argument
$result = $db->execute($query);



// Close connection
$db = null;

// Set response
Util::setResponse($result);