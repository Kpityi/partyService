


SELECT	`users`.`first_name`,
				`users`.`last_name`,
        `users`.`email`,
        `orders`.`id` AS `order_id`
FROM `orders`
INNER JOIN `users`
ON `users`.`id` = `orders`.`user_id`
WHERE `users`.`id` = 1;