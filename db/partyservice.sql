-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Jan 14. 09:47
-- Kiszolgáló verziója: 10.4.27-MariaDB
-- PHP verzió: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `partyservice`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dishes`
--

CREATE TABLE `dishes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(20) NOT NULL,
  `dish_category_id` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `dishes`
--

INSERT INTO `dishes` (`id`, `name`, `description`, `dish_category_id`, `price`) VALUES
(1, 'pastries', 'des_pastries', 1, 800),
(2, 'chicken_soup', 'des_chicken_soup', 2, 2200),
(3, 'ragout_soup', 'des_ragout_soup', 2, 2200),
(4, 'roast_platter1', 'des_roast_platter1', 3, 3500),
(5, 'roast_platter2', 'des_roast_platter2', 3, 4500),
(6, 'slide_dish', 'des_slide_dish', 7, 1000),
(7, 'salad', 'des_salad', 8, 800),
(8, 'cabbage_rolls', 'des_cabbage_rolls', 9, 2000),
(9, 'boiled_sausag', 'des_boiled_sausage', 9, 1000),
(10, 'cheese_platter', 'des_cheese_platter', 9, 4500),
(11, 'cheese_platter', 'des_cheese_platter', 5, 4500),
(12, 'chocolate_cake', 'des_chocolate_cake', 4, 1400),
(13, 'drink_package_1', 'des_drink_package_1', 6, 12000),
(14, 'cold_fruit_soup', 'des_cold_fruit_soup', 2, 1000),
(15, 'cold_platter', 'des_cold_platter', 5, 3000),
(16, 'drink_package_2', 'des_drink_package_2', 6, 10000),
(17, 'sandwich', 'des_sandwich', 5, 2000),
(18, 'drink_package_3', 'des_drink_package_3', 6, 4000),
(19, 'custom', 'des_custom', 10, 0);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
