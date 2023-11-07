<?php

function structure_menu_items($raw_result) {
  $result= [];
  $menu=[];
  
  foreach ($raw_result as $item) {
    $menu_items = array(
      'category' => $item['category'],
      'name' => $item['name'],
      'description' => $item['description'],
      'price' => $item['price'],
    );
  
    if (array_key_exists('menu_name', $menu)) {
      if ($menu['menu_name'] == $item['menu']) {
        array_push($menu['menu_items'], $menu_items);
        $menu['total_price'] += $menu_items['price'];
      } else {
        array_push($result, $menu);
  
        $menu = [];
        $menu['id']=$item['id'];
        $menu['menu_name'] = $item['menu'];
        $menu['menu_items'] = [$menu_items];
        $menu['total_price']= $menu_items['price'];
      }
    } else {
      $menu['id']=$item['id'];
      $menu['menu_name'] = $item['menu'];
      $menu['menu_items'] = [$menu_items];
      $menu['total_price']= $menu_items['price'];
    }
  }

  array_push($result, $menu);
  $menu=[];
  return $result;
} 

// Set environment
require_once('../../../common/php/environment.php');

// Connect to database
$db = new Database();

// Set query
$query = "SELECT menus.id As id,
                 menus.name AS menu, 
                 dish_categories.type As category, 
                 dishes.name As name, 
                 dishes.description AS description, 
                 dishes.price As price
          FROM dishes 
          INNER JOIN dish_categories
                ON dishes.dish_category_id=dish_categories.id
          INNER JOIN menu_dishes
                ON dishes.id=menu_dishes.dish_id
          INNER JOIN menus
                ON menus.id=menu_dishes.menu_id;";

// Execute query with argument
$raw_result = $db->execute($query);
//echo json_encode($raw_result);
$result = structure_menu_items($raw_result);

// Close connection
$db = null;

// Set response
Util::setResponse($result);

//echo  $result;

