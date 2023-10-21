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