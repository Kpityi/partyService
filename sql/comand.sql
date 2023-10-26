SELECT  `orders`.`orderId` AS `orderId`,
	`orders_item`.`id` AS `ordersItemId`,
        `products`.`product_name` AS `name`,
        `orders_item`.`price`,
        `orders_item`.`quantity`,
        `orders_item`.`price` * `orders_item`.`quantity` AS `total`,
        `users`.`first_name`,
	`users`.`last_name`,
        `users`.`email`
FROM `orders_item`
INNER JOIN  (SELECT `orders`.`id` AS `orderId`,
             	`orders`.`user_id` AS `userId`
            FROM `orders`
            INNER JOIN `users`
            ON `users`.`id` = `orders`.`user_id`
            WHERE `users`.`id` = 1
) AS `orders`
ON `orders`.`orderId` = `orders_item`.`order_id`
INNER JOIN `users`
ON `users`.`id` = `orders`.`userId`
INNER JOIN `products`
ON `products`.`id` = `orders_item`.`product_id`
ORDER BY `orders`.`orderId`, `orders_item`.`id`;

/* Menü lekérdezés */

SELECT menus.name AS menu, dish_categories.type As category, dishes.name As name, dishes.description AS description, dishes.price As price
FROM dishes 
INNER JOIN dish_categories
      ON dishes.dish_category_id=dish_categories.id
INNER JOIN menu_dishes
      ON dishes.id=menu_dishes.dish_id
INNER JOIN menus
      ON menus.id=menu_dishes.menu_id
	
/* menünként*/
 WHERE menus.id=1;	


/* tábla hossza*/

SELECT COUNT(*)
FROM menus;


SELECT menu.name AS menu_name, 
CONCAT
( '[', GROUP_CONCAT( JSON_OBJECT('name', dish.name, 'type', dish_category.type, 'price', dish.price) ), ']' ) AS menu_items 
FROM menus AS menu 
JOIN menu_dishes AS menu_dish ON menu.id = menu_dish.menu_id 
JOIN dishes AS dish ON menu_dish.dish_id = dish.id 
JOIN dish_categories AS dish_category ON dish.dish_category_id = dish_category.id 
GROUP BY menu.id, menu.name;



SELECT `menus`.`mame` AS menu, 
`dish_categories`.`type` As category, `dishes`.`name` As name, `dishes`.`description` AS description, `dishes`.`price` As price
GROUP_CONCAT(DISTINCT `menus`.`name`
        ORDER BY `menus`.`name`)
FROM `dishes` 
INNER JOIN `dish_categories`
      ON `dishes`.`dish_category_id` = `dish_categories`.`id`
INNER JOIN `menu_dishes`
      ON `dishes`.`id` = `menu_dishes`.`dish_id`
INNER JOIN `menus`
      ON `menus`.`id` = `menu_dishes`.`menu_id`;




SELECT menu.name AS menu_name, 
CONCAT( '[', GROUP_CONCAT( 
JSON_OBJECT('name', dish.name, 'type', dish_category.type, 'price', dish.price) ), ']' ) AS menu_items 
FROM menus AS menu 
JOIN menu_dishes AS menu_dish ON menu.id = menu_dish.menu_id 
JOIN dishes AS dish ON menu_dish.dish_id = menu_dish.id JOIN dish_categories AS dish_cyategory ON dish.dish_category_id = dish_categor.id GROUP BY menu.id, menu.name; 