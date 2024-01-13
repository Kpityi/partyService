-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Jan 13. 18:35
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
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description` varchar(20) NOT NULL,
  `category` varchar(20) NOT NULL,
  `price` int(10) NOT NULL,
  `stock` int(10) NOT NULL,
  `is_stock` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`id`, `product_name`, `image`, `description`, `category`, `price`, `stock`, `is_stock`) VALUES
(1, 'balloon_red', 'lufi_piros.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(2, 'balloon_blue', 'lufi_kek.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(3, 'balloon_green', 'lufi_zold.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(4, 'balloon_yellow', 'lufi_sarga.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(5, 'balloon_bd_red', 'lufi_szulinapos_red.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(6, 'balloon_birthday_blue', 'lufi_szulinapos_blue.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(7, 'ballon_birtday_yellow', 'lufi_szulinapos_yellow.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(8, 'ballon_birtday_green', 'lufi_szulinapos_green.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(9, 'ballon_heart_shaped_red', 'lufi_sziv.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(10, 'balloon_heart-shaped with red lettering', 'lufi_sziv_feliratos.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(11, 'balloon_smile', 'lufi_smile.jpg', 'desc_balloon', 'decoration', 500, 998, 1),
(12, 'paper-plate', 'papirtanyer.jpg', 'desc_paper_plate', 'tableware', 125, 1200, 1),
(13, 'paper_plate_blue', 'papirtanyer_kek.jpg', 'desc_paper_plate', 'tableware', 125, 1225, 1),
(14, 'straw_red', 'szivoszal_piros.jpg', 'desc_straw', 'tableware', 95, 1500, 1),
(15, 'straw_yellow', 'szivoszal_sarga.jpg', 'desc_straw', 'tableware', 95, 1525, 1),
(16, 'straw_pink', 'szivoszal_pink.jpg', 'desc_straw', 'tableware', 95, 1615, 1),
(17, 'straw_blue', 'szivoszal_kek.jpg', 'desc_straw', 'tableware', 95, 1600, 1),
(18, 'balloon_weight', 'lufi_suly.jpg', 'desc_balloon_weight', 'decoration', 450, 625, 1),
(19, 'party_hat_glitter', 'kalap_glitter.jpg', 'desc_party_hat', 'decoration', 500, 990, 1),
(20, 'party_hat_yellow', 'kalap_sarga.jpg', 'desc_party_hat', 'decoration', 500, 990, 1),
(21, 'party_hat_blue', 'kalap_kek.jpg', 'desc_party_hat', 'decoration', 500, 990, 1),
(22, 'helium_bottle_without_balloons', 'helium_palack.jpg', 'desc_helium_bottle_w', 'decoration', 325, 13200, 1),
(23, 'helium_spray_without_balloons', 'helium_spray.jpg', 'desc_helium_spray_w', 'decoration', 415, 4200, 1),
(24, 'biding_tape_orange_225m', 'bidingtape.jpg', 'desc_biding_tape_ora', 'decoration', 187, 915, 1),
(25, 'napkin', 'szalveta.jpg', 'desc_napkin', 'tableware', 135, 1640, 1),
(26, 'party_glasses_red', 'partyszemuveg_red.jpg', 'desc_party_glasses', 'decoration', 517, 785, 1),
(27, 'party_glasses_gold', 'partyszemuveg_gold.jpg', 'desc_party_glasses', 'decoration', 330, 780, 1),
(28, 'tablecloth_gold', 'asztalterito_gold.jpg', 'desc_tablecloth', 'tablecloth', 465, 1500, 1),
(29, 'tablecloth_silver', 'asztalterito_silver.jpg', 'desc_tablecloth', 'tableware', 465, 1500, 1),
(30, 'tablecloth_white_gold', 'asztalterito_white_gold.jpg', 'desc_tablecloth', 'tableware', 465, 1500, 1),
(31, 'tablecloth_chrome_silver', 'asztalterito_chrome_silver.jpg', 'desc_tablecloth', 'tableware', 514, 980, 1),
(32, 'tablecloth_white', 'asztalterito_white.jpg', 'desc_tablecloth', 'tableware', 565, 950, 1),
(33, 'wig_blue_short', 'paroka_blue.jpg', 'desc_wig', 'decoration', 265, 4400, 1),
(34, 'wig_orange_short', 'paroka_orange.jpg', 'desc_wig', 'decoration', 265, 4400, 1),
(35, 'wig_black_curly', 'paroka_black.jpg', 'desc_wig', 'decoration', 345, 6300, 1),
(36, 'hair_coloring_hair_chalk_blue', 'hajkreta_blue.jpg', 'desc_hair_coloring_h', 'decoration', 315, 1280, 1),
(37, 'hair_coloring_hair_chalk_red', 'hajkreta_red.jpg', 'desc_hair_coloring_h', 'decoration', 318, 1280, 1),
(38, 'floot_candle_white_6db', 'uszogyertya_white.jpg', 'desc_floot_candle', 'decoration', 625, 1618, 1),
(39, 'floot_candle_red_6db', 'uszogyertya_red.jpg', 'desc_floot_candle', 'decoration', 625, 1618, 1),
(40, 'floot_candle_silver_6db', 'uszogyertya_silver.jpg', 'desc_floot_candle', 'decoration', 625, 1618, 1),
(41, 'glass_footed_floating_candle_holder', 'uszogyertya_tarto.jpg', 'desc_glassFFCH', 'decoration', 158, 2200, 1);

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
