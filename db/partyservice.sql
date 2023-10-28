-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Okt 26. 19:01
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

DELIMITER $$
--
-- Függvények
--
CREATE DEFINER=`root`@`localhost` FUNCTION `BASE64_ENCODE` (`textIn` LONGBLOB) RETURNS LONGTEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci NO SQL BEGIN
/*
	Convert blob to base64 text, remove start, end spaces,
	newline, carriage return, and tab characters from text 
*/
DECLARE textOut LONGTEXT CHARSET utf8mb4 DEFAULT '';
IF (textIn IS NOT NULL) THEN
	SET textOut = TO_BASE64(textIn);
    SET textOut = TRIM(textOut);
    IF (LENGTH(textOut) > 0) THEN
    	SET textOut = REPLACE(textOut,"\n","");
    	SET textOut = REPLACE(textOut,"\r","");
    	SET textOut = REPLACE(textOut,"\t","");
    END IF;
END IF;
RETURN textOut;
END$$

DELIMITER ;

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
(8, 'cabbage_rolls', 'des_cabbage rolls', 9, 2000),
(9, 'boiled_sausag', 'des_boiled_sausage', 9, 1000),
(10, 'cheese_platter', 'des_cheese_platter', 9, 4500),
(11, 'cheese_platter', 'des_cheese_platter', 5, 4500),
(12, 'chocolate_cake', 'des_chocolate_cake', 4, 1400),
(13, 'drink_package_1', 'des_drink_package_1', 6, 12000),
(14, 'cold_fruit_soup', 'des_cold_fruit_soup', 2, 1000),
(15, 'cold_platter', 'des_cold_platter', 5, 3000),
(16, 'drink_package_2', 'des_drink_package_2', 6, 10000),
(17, 'sandwich', 'des_sandwich', 5, 2000),
(18, 'drink_package_3', 'des_drink_package_3', 6, 4000);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dish_categories`
--

CREATE TABLE `dish_categories` (
  `id` int(1) UNSIGNED NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `dish_categories`
--

INSERT INTO `dish_categories` (`id`, `type`) VALUES
(1, 'finger_foods'),
(2, 'appetizer'),
(3, 'main_course'),
(4, 'dessert'),
(5, 'cold_platter'),
(6, 'drinks'),
(7, 'slide_dish'),
(8, 'salad'),
(9, 'midnight_dinner');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `events`
--

CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `user_id` int(10) NOT NULL,
  `event_places_id` int(1) NOT NULL,
  `event_type_id` int(1) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `adults` int(3) DEFAULT NULL,
  `childrens` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `event_places`
--

CREATE TABLE `event_places` (
  `id` int(1) UNSIGNED NOT NULL,
  `place_name` varchar(50) NOT NULL,
  `capacity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `event_places`
--

INSERT INTO `event_places` (`id`, `place_name`, `capacity`) VALUES
(1, 'Külső helyszín', 500),
(2, 'Kisterem', 60),
(3, 'Nagyterem', 150),
(4, 'Szabadtéri', 300);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `event_types`
--

CREATE TABLE `event_types` (
  `id` int(10) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `event_types`
--

INSERT INTO `event_types` (`id`, `name`) VALUES
(1, 'Születésnap'),
(2, 'Esküvő'),
(3, 'Legénybúcsú'),
(4, 'Lánybúcsú'),
(5, 'Gyerekzsúr'),
(6, 'Egyéb'),
(7, 'Szilveszteri party'),
(8, 'Ballagás');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `genders`
--

CREATE TABLE `genders` (
  `id` int(1) UNSIGNED NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `genders`
--

INSERT INTO `genders` (`id`, `name`) VALUES
(1, 'male'),
(2, 'female');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `event_type_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `menus`
--

INSERT INTO `menus` (`id`, `name`, `event_type_id`) VALUES
(1, 'wedding_menu_I', '2'),
(2, 'wedding_menu_II', '2'),
(3, 'birthday_menu', '1'),
(4, 'hen_party_menu', '4'),
(5, 'stag_party_menu', '3'),
(6, 'kids_party_menu', '5'),
(7, 'other_menu_I', '6'),
(8, 'other_menu_II', '6'),
(9, 'other_menu_III', '6'),
(10, 'new_year_menu', '7'),
(11, 'graduation_menu', '8'),
(12, 'drink_package_1', ''),
(13, 'drink_package_2', ''),
(14, 'drink_package_3', '');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `menu_dishes`
--

CREATE TABLE `menu_dishes` (
  `id` int(3) UNSIGNED NOT NULL,
  `menu_id` int(3) NOT NULL,
  `dish_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `menu_dishes`
--

INSERT INTO `menu_dishes` (`id`, `menu_id`, `dish_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 4),
(4, 1, 6),
(5, 1, 7),
(6, 1, 12),
(7, 1, 8),
(8, 2, 1),
(9, 2, 3),
(10, 2, 5),
(11, 2, 6),
(12, 2, 7),
(13, 2, 12),
(14, 2, 8),
(15, 3, 1),
(16, 3, 2),
(17, 3, 1),
(18, 3, 6),
(19, 3, 7),
(20, 3, 12),
(21, 4, 17),
(22, 5, 11),
(23, 6, 1),
(24, 6, 17),
(25, 7, 1),
(26, 7, 11),
(27, 8, 1),
(28, 8, 15),
(29, 9, 1),
(30, 9, 17),
(31, 10, 1),
(32, 10, 4),
(33, 10, 6),
(34, 10, 7),
(35, 11, 1),
(36, 11, 14),
(37, 11, 5),
(38, 11, 6),
(39, 11, 7),
(79, 12, 13),
(80, 13, 16),
(81, 14, 18);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) NOT NULL,
  `product_id` int(10) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `image` varchar(50) NOT NULL,
  `description_hu` text NOT NULL,
  `description_en` text NOT NULL,
  `description_de` text NOT NULL,
  `category` varchar(20) NOT NULL,
  `price` int(10) NOT NULL,
  `stock` int(10) NOT NULL,
  `is_stock` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`id`, `product_name`, `image`, `description_hu`, `description_en`, `description_de`, `category`, `price`, `stock`, `is_stock`) VALUES
(1, 'Lufi (piros)', 'lufi_szines.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(2, 'Lufi (kék)', 'lufi_szines.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(3, 'Lufi (zöld)', 'lufi_szines.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(4, 'Lufi (sárga)', 'lufi_szines.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(5, 'Lufi (szülinapos-piros)', 'lufi_szülinapos.pjg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(6, 'Lufi (szülinapos-kék)', 'lufi_szülinapos.pjg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(7, 'Lufi (szülinapos-sárga)', 'lufi_szülinapos.pjg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(8, 'Lufi (szülinapos-zöld)', 'lufi_szülinapos.pjg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(9, 'Lufi (szív alkú-piros)', 'lufi_sziv.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(10, 'Lufi (szív alkú-piros-feliratos)', 'lufi_sziv_feliratos.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(11, 'Lufi (smile)', 'lufi_smile.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(12, 'Papír tányér', 'papirtanyer.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(13, 'Papír tányér (kék)', 'papirtanyer-kek.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(14, 'Szívószál (piros)', 'szivoszal_piros.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(15, 'Szívószál (sárga)', 'szivoszal_sarga.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(16, 'Szívószál (rózsaszín)', 'szivoszal_tobb szin.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(17, 'Szívószál (kék)', 'szivoszal_tobb szin2.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(18, 'Lufi súly', 'lufi_suly.jpg', 'Számos méretben és színben elérhető lufik, hogy tökéletesen illeszkedjenek minden alkalomhoz. Legyen szó születésnapról, esküvőről vagy bármilyen ünnepről, válaszd a kedvenc színedet és méretedet, hogy feldobd a hangulatot!', 'Balloons available in various sizes and colors to suit every occasion. Whether it\'s a birthday, wedding, or any other celebration, choose your favorite color and size to elevate the mood!', 'Luftballons in verschiedenen Größen und Farben, perfekt für jede Gelegenheit. Ob Geburtstag, Hochzeit oder jedes andere Fest, wähle deine Lieblingsfarbe und Größe, um die Stimmung zu heben!', 'Díszítés', 500, 998, 1),
(19, 'Party kalap (csillámos)', 'kalap1.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(20, 'Party kalap (sárga)', 'papirtanyer.jpg', '', '', '', 'Díszítés', 500, 990, 1),
(21, 'Party kalap (kék)', 'papirtanyer.jpg', '', '', '', 'Díszítés', 500, 990, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ratings`
--

CREATE TABLE `ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) NOT NULL,
  `rating` int(1) NOT NULL,
  `rating_text` text DEFAULT NULL,
  `rating_answer` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_role_id` int(1) NOT NULL DEFAULT 2,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `born` date NOT NULL,
  `gender_id` int(1) NOT NULL,
  `img` blob DEFAULT NULL,
  `img_type` varchar(100) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `country_code` varchar(10) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `city` varchar(50) NOT NULL,
  `postcode` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified` datetime DEFAULT NULL,
  `last_login` datetime NOT NULL,
  `wrong_attempts` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `valid` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `verification_code` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `user_role_id`, `last_name`, `first_name`, `born`, `gender_id`, `img`, `img_type`, `country`, `country_code`, `phone`, `city`, `postcode`, `address`, `email`, `password`, `created`, `modified`, `last_login`, `wrong_attempts`, `valid`, `verification_code`) VALUES
(1, 1, 'Kertész', 'István', '1983-06-24', 1, 0xffd8ffe000104a46494600010100000100010000ffe201d84943435f50524f46494c45000101000001c86c636d73021000006d6e74725247422058595a2007e2000300140009000e001d616373704d53465400000000736177736374726c0000000000000000000000000000f6d6000100000000d32d68616e649d91003d4080b03d40742c819ea5228e000000000000000000000000000000000000000000000000000000000000000964657363000000f00000005f637072740000010c0000000c7774707400000118000000147258595a0000012c000000146758595a00000140000000146258595a00000154000000147254524300000168000000606754524300000168000000606254524300000168000000606465736300000000000000057552474200000000000000000000000074657874000000004343300058595a20000000000000f35400010000000116c958595a200000000000006fa0000038f20000038f58595a2000000000000062960000b789000018da58595a2000000000000024a000000f850000b6c463757276000000000000002a0000007c00f8019c0275038304c9064e08120a180c620ef411cf14f6186a1c2e204324ac296a2e7e33eb39b33fd646574d3654765c17641d6c8675567e8d882c92369caba78cb2dbbe99cac7d765e477f1f9ffffffdb0043000503040404030504040405050506070c08070707070f0b0b090c110f1212110f111113161c1713141a1511111821181a1d1d1f1f1f13172224221e241c1e1f1effdb0043010505050706070e08080e1e1411141e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1e1effc00011080190019003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f9528a28afb63d50a28a2800a28a2800a28a7b4acd1244426d424821003ce3a9c64f4efd3b500328a28a0028a28a0028a29f24b24891a3b12b12ec41e8324e3f327f3a0065145140051451400514535ce10d09ea4c9d910b1a6d068ad4e16ee1451452ba00a28a284ee20a28a298c28a28a4dd8029ed1b88d6464608f9dac47071d714ca29b130a28a2818bda96300919e94b2a796c1772b6543654e47201c7d46707de97a213ebc50b505a8c639349451405ee145141381cd4b620a4660a393cd46d2f614cce7ad613af6d109b1cd21238a61e68a2b9dc9bdc9dc2ae69964979f69df7f6969e45bbcc3ed0cc3cd2b8fdda601cb9cf00e071d4553a2a1aba04145145318514514099a7451524d188e428b324a300ee4ce3919ee01f6aeeb9ea11d1450012702800a2bb5f04fc31f1678aed756b9d3ec1a18f4cb637121b9464f33d1138e58804fa71c91c571558d3c4d2a92718bbb4369a0a7480038539e076f6a6d15b087c4222c7cd7755dad82aa18eec1c0ea3827009ec39c1e859451458028a8e49513dcd5696776e01c0ace55631329d5512e3ca8bd58540d72a3a0cd5524f5a4c562eb5ce795693d8b06e9c9e80527da24f51f954147353ed1f733e79137da64f51f954b14ecc8c7683b7a81f8d54ef5a1a1a07b8208c823047e15956ad2846f7055257dc4599762c87804f5eb525e44555654c344c3208a9e2b4449a4b593fd5c9f321a5b30f6ac6cee8031b7dc6ec7dab95639a7cc5b9c9ee6777ab7a669b79a95ca5bd95bcb3c8e76aaa29249f4f7ad1b2d3ac7fb4e17bdf3fec7bc79c2000c817fd904804fe22bd35fe2de8de10b46d3fe1cf84a3b56dbb5b52d4c079dff00e02bc2fe78ff0066a3179b5595a1878eaceac353a2d73556717acfc3cd73c3f0e9971e20b56d3edf5097cb492660bb318c961cb000367919c03c55ff001afc32d57c2c62fed4b664866ff53711482489ff0011fc8e0d627883c75e2af155dc5ff0916b5717d107cac4d858d188c642280075c74aeb23f881a84bf0f24f076ad6e6fe089e37b0b82d992dc29fb873f79769207719c72318f13193cca8b8cb9aefad8f430b5b08ea38ca3a33cbeee17b79da17eaa6a1ad3d75d26bb57872c360078c739359a411d6bebb0389f6b462e7b9e562a118d56a1b095247197491b7a2f96bbb0cd82dc8181ea79cfd01a8e8aedbae8ce7dc296ac225a1b199e59e61741d0451ac40a32fcdb8b36e0548c2e0007393c8c735a9a95c614f2a044afbd492c46c19dc318e7d3073fa1a6529eb4d898945140e4e314c0722ee6c74a591b2d81d07029cc762edee7ad47492298945151c926381533a8a24b761cee178ef50b12d49f5a3f0ae39d4722428a2951d91d5d18ab29c820e083eb59084e68a7cd24934cf34d23492c8c59dddb73313c9249ea6994200a952077b6927062db1b2ab032286c9ce30a4e5870724020719c645454734f5e81b85145140c28a7c6630afe62b3315f9086c05391c9e0e463231c75073c60b2816e69d14515dc7a814fb796582e239e07292c6c1d1875041c834ca2a651e64d01fa1df0fb59fb7785f445d62fec1b5abdb18e79a189941662a093b73ef5f1d7ed13ade8bab7c45bdb5d17c3767a2c7a6cd2da4ad04611ae5d5c832301c75071df1d7d079ed85e5d585e457965712db5cc4dba396262ac87d411d292f2e27bcbb96eaea69269e672f24923659d89c924f739af032ec93ea789956e6bdcd25539958868a28afa16ec664f772dbbc36cb0db792f1c45667f30b095f7b1df8fe1f94aae3fd9cf7aa134ffc29d7d6ae5869d7dab4fe4d9c45803f331e157ea6bb7d0fc21a7d90496f00bb9f1939fb80fb0eff008fe95f3f9967b43069c6f767760b29c563dda9ab2ee709a5689aaeaae16cece5901fe2c6147d49e2baad3be1b5f48435edfc100feea02e7fa0aeff004b8c0932a005518c0eded5a190588cf22be2b15c5188a8ed4f43e829f0c50a0ed51dd98fa07c28f0d9b28e6bc9af6e6460720c8157a9e800cfeb4cd5fe1df862daf4ac56932a3282a3ce638ed5dd787a62f6ad19eb1b647d0ff9355bc4a009a16ee548af988e778e7886a53677c72ac2c63f02386b1f86fe1cbcba58585e46ac0e4a4a3238f706b1f5af86b6768ef1c17f382ac466450d81dba62bd374019bf27d109aafe2951f6994faa8cd75d3cff1b0adcaa63864d83a9249c0f13d43c11aa4019ed8c572a0f456c363e87ffaf59da45bcb6f3b2cc8c8e090558608c7b57a4f88750feceb02e8479d21d9103ea7bfe1d6b8539fb58cb16254924f5273c9afb1cb731c462a93f6bb1f29c4397e1705554283d47cf1f989903e65395fad2c4e2455907de53d0f6229d51491b06df11009eabd9abbee7ce0e6deac48f994f381d47d28cc532e30adf51d2923995ced20abff0074f5ff00f552bc68e72c39f5079a36d80824b285fb60d4d2c97265790ac4fb8e485509efc0e83e829bbda120b1dc878dde9f5a9860818a6e4e5bb0442268dbe591761f4714ad6f0be7318fc2a47557186008a88c4f0e4c2df2f7427f950a4d6cc4c8dec2dcf4047d0d40fa62f547fceaf4522c8a482463a8ee29e2b58e22a4766331a4b09907438fa5556465ea2ba3a86e2057cba801ff00435d74731a90f8b511824e4fb76a4ad63650ce9bd3e46e8c3d0d519ece684f232bd8f6af528e634ea3b3d0110629fc4638e5bf950484e14827d7d3e951d7a09dcad10507819345432bee381d2a2a545144b62cb213c03c5474515c32936ee4301d6b4f55d512f74dd36c974bd3ad0d8c6e8d716f19596e4b36edd2924ee23a0c01c5665150e298ee145145500e2abe5860e092482b839038e7fcfa5368a2810714576df03fc289e33f897a5689710996d19fcdba5c903cb5e7071d89da3f1af64fda93e0c69da1e931f89bc2560b05bdb2edbb8224014a0fe3c018c8efeabcff0009cf9d5733a34abaa327ab368d194a3cc8f996a6826f2a29e3f2a27f3a309b9d72530cad953d8fcb8cfa123bd434577a6a5b18dac14b494b568669514f9571c8e86995ddb1e9d8d3f0c685aa78935bb7d1b46b53757d70488e30c067032793c0e297c4da06afe1bd5e6d275bb19acaf223f34720ea3d411c11ee2bddff00657f85be238fc47a6f8f3508e3b3d3514bdba487f793865c0600741ce79fe55f4d6a7a0687aa5f5bdeea5a4d9dddcdb8c452cb182c9f435f1b99f1553c0e27d95ae8da147995cfcdc747438752a719c118e29b5eaffb54eaf6da9fc5dbdb5b4b44b78f4d863b4c88f6f9840dc5bdf96c7e15e515f5184c47d628c6a5ad7326acec15d5781bc1775e2290dddd335ae95112659bbbe3aaa67f9f41efd293e1e78526f13ea989034761060cf20efe88bee7f4fcb3ebde239a0d3b4d8749b28d228c280113a2a0e83f1af8ee25e23fabbfab61dfbcf7f23e8326c9de2a6a753e139586daced14c16302c16e189441e9ee7b9f735660b77979c617fbd535adb0389241c7615740006000057e7f3a92a8f9a4eecfbb956a7423ece92b5889b65bdb92074fd4d45a6866123b1cee23fcfeb516a120690463a2f27eb56acd36db2e7ab726b3429c7969733dd9b1e1d72b78ebd990d3fc46c0dc449fdd5c9fc4fff005aa2d0413a8023b2927e950eaae65bf9893d1b68fc38ae2e4ff68b9c45df0dc6774d37b051fcff00c2b2fc512eeb9940e9b82fe55bf6fb6c348dcc3e6c6ec7ab1e83f95721aa484b28272c724d14173d57336c3c6f3380f164fe7eb7e493f25bc6063fda6e49fcb158ce31771f3d54d686b60af882f9586092a7f0da2b3ae86d55907f0367f0afd3701151c3c523f30ce6a4a78c9b97727a281820107ad15da79432689645c30e47461d45362918318a52370e847f10a96a3b952537afde5f98526224383c11c1ebef5143fbb91a12781ca9f6a91183a2b0e879a8ee7e52928e369e7e8698c968a28a0082e14a3f9f18e47de1ea2a752194303907141e841e86a1b5f955a32794623f0a0458a6d14500431802ee451d1806a958061820118c62a34f9ae646ec00507f9d4b426331b52b610bef5fba6a9d6e6a4bbad8e7b5624714f713a5b5ac324d34842aa46a59989ec00eb5efe0312dd2b4ba1326a2aec8657cf03a5475ed9e19fd9b7c71a869f69a86b525ae890dd91e5432e5ee19480776c1c01c818241cf6af4cbaf80ff000f3c17aaa41ad58ea1e218dd86566bc30e5422ee6531edfe32c0039e13df344eba6fb9c15730a54deacf91e8e6bebbd43e0ffc2f3e24b37b0d0673a45e289e38daee60e141656424b9e43237e18ae7fc73f00fc2765ae9b3b1bfbfb4b594a4b6f3ee12030be086da40248191d4722946aa6cc166d44f9928ed5eb1e32f807e38d02096e6d628757863944412d49333310c788f193f74f426bca64474768e452aea70548c107d2b4524ceea55e1555e2c6d14514cd82bd43f67ff00856bf13b54be866d4fec76f64a85c263cc72d9c6339c0f94f383f4af2fad9f08789f5cf09eaf1eaba0dfcb67728464a9f95c7a30e8457362a352749aa6eccba7652d4fbb7e167c1ff09fc3cbe3a8e931c925fb446269e47662ca7b1c9c63201e00e95df5ddb5bde5b3db5dc2b342e30c8dd0d709f00fc7b77f113c08bacea16715add452795288db21c8246467a74e9fcfad7a0804ff0009c7ad7e359a54c5c714d5477923e828a87269b1c578afc3ff000ff41f0f5e6aba9687a55bdbc31312ed1f4c0f439e95f9f1e209ac6e35ed42e34c84c1632dd4af6d111cc71172514fd06057d6dfb6fdbeaede0ad3eeed6e655d3d6e156ee15e8c0e704fb06dbc772c3d057c77f9d7e8dc31094b0ded252bb67938c6b9ec9052d2515f50711aa8fb782320f514ae831b97907f4a65391ca9fe75dfa5ac7aa99ecbf043e32f8ab46d7746f0e5edec775a3cb3476a1664f9a25242a80c31c671d73c57d29f157e2af867e1d9b24d584f757178c4a416bb4bac7fdf39c71fa9af82932583c4c55c1c8c1c107d41ab1ad6a9a9eb37bf6cd5afae2f6e7684f32672cd81d064d7cc661c3587c66215592d0d6355c558f46fda23c71e12f1eeb761ac787b4fbcb6bb10b25ebcea17cce46ce0139239e7dfbf6f35d2ac2e353d460b0b45df3cee1107f53ec3a9f61556bd63e06685849fc41709c9cc36d9f4fe26fe43f035ae6989a79365edc5eda237c0e1de2ab289de685a6597863c3a96908023857748f8c191fbb1f73fe02b99691efefa4b89b904e71fc8568f8b352f3a6fb1c2dfbb43f391ddbffad54ed1364238e4f26bf1d84a7564eb54f8a47e974a92c350496e4f8c5417532c29db71e829d73308a3c9e4f61eb598eccec598e49adae561f0fcef9a5b0e891a69429e72793ed5abec3802abd943e5a6f61f337e82adc31bcd2ac71a96663c52ba4aec8c5d5529596c8d6f0dc5c4d39f651fccff004aad6108bbd4d8e331872e7e99e2acde4ab6364b6313032b0f9c8ed9eb535baae9ba634aebfbc6e48f53d8579ae4eedf739d15bc43739956d90f09cb7d6b94b87f325661d33c7d2af6a33b6d20b66493249ef5c6f88b5928ed6566d871c4b20fe1f61efefdbebd3d6cbf053a8d4225d4c5d2c05175aafc8cdf19790baac33472ab395f2e503f879e33596ca194a9e41a1d43a1561907ad4513b46e2293fe02c7bd7e8185a3ec69a8367e579862d62ebcaaa56b8404a3181fa8e54fa8a9a9b347e628c1c32f2a7d29b0c9b8947e240391d8fbd749c08928a28a06456dc2327f71881f4a7ccbba261ea31f8d313e5b971fde00ff004a96801b036e89187391fad3a996dc45b7fba48fd69f48482a14e2e64c7700d4d51819b963fec0fe6698c9292470885dbb7ea696a263e64c07f0a1c9f76a403add364783f78f2d4fa299349b30aa3739e8298115d8f399600719e49f415ed9fb3ad9f83a2911a3945aea102f997b2cc419dd47510fae7a6074ea7819af17863080b31cb9e49f7ab363757563790de595ccb6b750389219a272af1b0390ca472083deb5a55a50d11cb8ac3bad0b5cfbce0d4b51b9f11c0b770c6ba9dd102cec80ff008f08719df27fb58e42faf271c0ae6bc737b1eb8b7b768bf2da5c18e224ff0008c0fd7393ef5e7bf037e27d9dce91ab47ab4cdff0964919586561f2dc4640cb03fdfc92cc3d1463a903b7b2d3ee65d052c608cbdd5ec836a9f562393f80cd77d049fbc7c666119d29723dc8ad72343b1ba97816d0ce533df73617ff001edf4ff15a4ba85c7866d2342677d2ade20075e5982f1f4c1fc6935d314f736fe1fd3650d6f6ca12498fdd3b725dcfa2fde63e99f6abfe17782e7c46daddcb1b7b4857c9b6661931aaa6c46c77da02e71df35a357d4e653d1a7d4de69237f105942b962dacc322f7ca812e4febfad791fc44f85fa0f8d7e1a1d6d2da2b4f105accb125ec4a4174cb7cb281c303b9003f786ce0e320fa0e8b731dd78b1e7b094dd5be9f6f3dcab94d9bd8a6c5da0f41b8a019efe99e13c0415fc3de23b773bedc35b3ab1e995909cfe3c7e559b6d3baf23bf0f5e545269f73e0cf11e8ba9787b589f4ad56d5edaea0386561dbb107b83eb59d5f617c5cf005bfc43f065eeab671471eaf6376c2d67c00d2462224427a70c4704f4273d09cfc7ceac8c5586083822bb232e63e93038b58985fa8940a28ab3d03ea2fd993e2af837c15f0bafacf5bd4162bd8ae1a55b7da77483a8c7af5edf8e2b96f10fed37e31b8f159d434982dedf4c4f963b4941cb0f5254f07db91eb9eb5e0d45790f25c34aacaac95db36faccd45451ef7f13bf6843e36f87771e1cb8f0ff00937770543cad20645008391c0c9e3d060e0e4e315e09de8ef4577617094f0d1e5a6ac889cdcddd852d2515d26669d14515dc7a802a412678619f7ef51d14c0992169a45487e77620051d493dabe82644f0df856d34cb6c2c8b108c11c738cbb7e2493f8d78d7c35b217fe36d32165caacbe69ff8002dfcc0af57f175c79ba9f940fcb1285fc4f27f9fe95f98f1b627dad7850e8b53ecf85f0aa6dd468c750cee173924e2b59d9238cb3700567c71f973c3e6704e1b1e83b7f8fe34b7b3798fb57ee0fd4fad7c75cfb1ad49d49a4b6229a569642cdf80f415358c3bdbcd61951d07ad32da033be0fdd1d4d6ac10b48cb144993d00146888c4d654e3c9108e2796458e31b98f415a4648b4c8b647b5ee987ccdd92a233a594661b660d2b0c3ca3b7b0a7697a79b92269bfd5673cff11ae5ab3d2f2d8f2c9348b369641773e768395cff0011f5aadafea0af2615bf771f0bfed1abdaeea51db42608dc06c61b1d87a7d6b90b899a6937374ec3d2a2841ce5cf23ab0f41cdddec667893517b3b096e01ccce42443dcf4fcbafe15c42820724b13d49ea4fa9addf1bb49f6db281810a22328cf7c9da3f91ac2afd0326c3a851e7eacf81e28c6bab89f649e910a96d2cae351bb86c6d607b8b89dc245120cb3b138000f5e6a32715f487ecc1e005b3d397c6baadbffa55d291a723af31c47832f3d0b76ff679e7771ea56aaa946e7cee1e8bab2b1e6fe27f821e3ad0b4d86f21b74d650c61a68ecf2f2c0ddc6deae3dd73f4af37beb496099a0ba865b7b88faac8a55d0fb83cd7e82557bfb1b2bf87cabeb3b7ba8ffbb3c41c7e44579f1c7b5ba3d29e5b17f0b3f3f9242adb25e18f43d9aa4afb96ebc0fe0dbab67b69bc2ba2989d4a90b651a9c7b10320fb8af16f1efecf5711c925e782efd64889ddf60bc7c32fb249dfd006c7bb1ae9a78e849d99cb5301382bad4f00938991cf4ced3f8d3ebabd47e18f8f6da67b59bc29aa330e37430f9ab9f665c83f9d636bda0eb7e1ebb165aee99736172503059971b81ee0f423e9d0f1d4574aab17b3391d19c7a19518daeebef91f8d3e90fcac1bb7434b5a5c8b05313995dbe83fcfe7521200249e29a9f2a64e06793eded49d84b51246da38fbc7851ef446bb06debea7d6a4b4b69eeae963b78649a673b523452cc7f01debd93e197c0ad5f58923d43c5625d26c010c2d8605c4c3d083feac7d79f61d6b3a95a30576cda9d09d47648f37f04783f5ff0019eaa34fd0acfcd2b833dc39db0c0a7bbb76f6039383815ea9e38fd9fa4d27c329a8787af2e753d46de2dd790c8bcce7b9880e98ec9c92075278afa0fc3ba2695e1fd2a2d2f46b286ced22fbb1c63a9eec4f56278c93926b47ad7993c6c9caeb63d5a7808a8da5b9f9f278247714b5ee7fb4dfc3a8f4e98f8d744b7096d3c98d4e241809231c0980f46270dfed1079c9af0b15e951aaaa46e8f2abd274e5663ede79ed2e62bab594c5710b878dc7f0b0e95f5c7863c6f06bde07d36f34842fabea9179732460936ad928c8bdcb31071fec91eb5f22d7b3fecd3a9dc0b3d6f42b18952ede549bed24fcd1c4ebb5c2ff007725464f5c1c0ea73df87934f94f9ece6841d2f68f747acc1666246d1ad5d5ee24c1d42e570420073e529efc8c93dc818e17253c477b1db5b2e9567f28000931d87a7d7d6ac5fdc5be85602d2d466e1c6727f22c7fa0aabe0af0e4fe24d548919a3b284f997939fe15ea403d3279fe7dabd26d538ea7c74632ad3b2d8bfa0ac9a7783ee5a151f6ed6dfecf0e46364087f78ff424e3f0abee21d2fc07ac5bc2d87610464f7259c924fd429a7f896fec6d2e1eea288246a820b58471b635e8a3d3d49f535cfea77138f07db99ffd66a37af3920ffcb38d422fe1b99ff2acb97ddbbea74a95e765b22e077d3fe19460f0d7d7b2321ff642aaff008d7c85f1c3421a3f8ce4b88536db6a0bf684c0e0313871f9f3ff000215f6278bec661e1ed1ed22ddbacad54cd1e390ce379fcb22bc47f693d1f7fc27d235716a0c91eb12a79d8e56331a71f42c07fdf35a52763d0caeb72623956c7cdb45145749f5e145145030a28a2800a5a4a5a680d2a28a2bb4f4c92e0422522dd9de3ec5d4293f8027f9d47451401ddfc1431c7e27bbb9931b60b177ff00c7907f5aedb4f81b53d49a4989099324cde83ad79dfc3890c777788a7992100fb80c0e3e99c7e55e996128b6f0f5e4838799c440fe193fa135f90f165febed9fa3f0e439707ccb76665dcbe7dd492e36866c81e83b0a6c31195f6afe27d29a8acee154649ad8d3ad0bbac110cb1ea7fad7cf6896a7bf5eb2a51b2dc5b4b72d88a2000c6493d00f5353bccb14660b62769fbf2777ff00014ebb95101b5b73f203f3b1eae7fc2ac693a719c89a61888741fdeffeb5633a892e691e3b6e4eec4d2f4ff3c8966e21ebfef7ff005aa6d57578e08cc36c400060b0fe42a2d77515506088ed8870e47f17b0ae62e25699f92703a0ec2b2853755f3cce9c3e1dd4777b05c4cf33ee73f856be81a235d15b9b905201c85eeffe0293c33a50bb90dcdc2fee50f4fef1ff000ae8b5abd5b0d3d9d480e46d8c0f5ffeb5156bb5254e1b9d55aaa8af6703c73e235d2dcf8def56323cab748e1403a00076fc735835635862fafdfb1c93e601927d0556afd332f8f2e1e2bc8fc77346de2a77ee6af8434693c45e2cd2b418f77fa75d244e57aac79cbb7e0a18fe15f75da410da5ac36b6d12c50431ac71c6a301140c003d80af95ff00655d2d2f7e27cb7cea0ae9ba7c92292338772107d3e52f5f5757263a779f29d99753b439828a28ae03d20a28a2800aa5ab697a66af6a6d354b0b5be8339f2ee2257507d704707deaef5a2a93689714f738b83e15fc3d86ebed09e15b1df9ce1b732ffdf2491fa571be3ff80ba2eb378f7fe1ebc1a34ce72f6fe5ef80ff00ba01053e9c8f615ecd47e15a471134f732961e9cb74788f87ff676d021b565d7756bdbc9db1836f889508eb8ceecfe35d97863e11780f4190cd0e8c97b31e8f7dfbfc67d148dbfa66bbca3f1a72c45496ec51c2d38ec8a1a668ba3e9673a6e93616471b736f6c91f1dc7ca055fa314119ac6526f766ca2a3b20a28a291451f106976bade877ba45eaeeb6bd81e09077c30c647b8eb5f06df59dc69da85d69b76bb6e6d2778261e8e8c54fea2bf403bd7c6ff00b43e9a34bf8bfac08d76c578b15da8f764018fe2cac7f1af47013b3713cbcca178a91c0815e85fb3eeadfd95e3bbbc0dc6e34d92341db7874209fc03579ed779fb3dd8ff00697c5dd32cfca595648672e1e5f2d76ac65b2cdd4018c9c72470319c8f6a8be59dcf99cc29f3d0944f7ad1748bfd7efbcc25b633ed926db925bfbaa3f89b1d076ea481cd777af6a963e18d01742b3daab9fdeaa364b37f74b639ff0069bd78e00c554d6f5fb0f0f5b9b2d3592e2f7cbf2fcd55dab129fe18d7f857d4f53d7deb8d9d9a1996ff00545135c3e1a2b67c81b7a82e0745e985ea473c0c67d2b39eacf8a6d535cb11b2da6b1abcf05c9b3b964b99961864f2c88cb1380a1ba56f5f59dadef8d22d2f3ff12bd16dc473c80758e2e6427dd9cb0fc4574fa2eada8e95e04bbf116b170f34f2385b185c008ae0155da83e5006589c0ed8eab5c94b637567a40d2638d8ea77e567bf773fea62ea9193ea7ef91d7eed66a729cac6f2a50a34d3ee644badea773abdcde42ec24bb98b98c7cc324f0003e9c0fc2b9efdaca6583e1641a65edcbb5ec4202f0a8f9524662ed9f7dac07e15e8fe14d1228af90313e5c43cdb87dbba49147f022f6c9217d4e7e95e35fb5f6af66be17834e7902eaba8ea5f689628d8308d115b2aedddb2e9851c2e3939e06eadcc91596c1ceaa97767cbb45145751f6ab60a28a28185145140054c8aaabe649f80f5ff00eb5351401bdfa761eb4ec33b6e6fc055462db04ac5da28a2bb0f4c2acea37b77a8df4d7d7f732dd5ccec5e59a562ceec7b927a9aad4516ea2bdce9be1eb81ab4aa7bc071f9ad7a049331b48edc13b5599cfd4e07f202bcc3c2138b7d7ed9db386629ff007d0207ea457a5a29760a3b9c57e5bc5f45c316a5dd1fa3f0b5552c234fa17ac62d89e61fbcddfdab6ec40834eb8bbe8cdfbb43fe7fcf159a3a5695f0d9a759db2fde7f988f73ff00ebaf8daef6475d59b9c9b63748b0fb549e6483f74a79ff0068fa56b6ab76b67664821588c28f4f7fc2a68d12d2cc0ed1a64fbf735c7eb9772dcc80b9fbddbd07a570c13c454bbd9052873cac50b999a66cff00083c54ba559497f78b020c0eaede83d6aad5ed3b539f4f8a45b7440d2632e4648af4a57e5b44f6dc3961689d85c5c59e9564aacc111061107535c8df5d4faadeef7c04fe15eca2a026eaf65324b2339cf2cd57228d625dabf89f5aca861d537ccf73cea8e3462fab3cbf5e40be23d45002b897fa554ad2f1746f0f8bb5047520b796e38ec501acdafd2b0724e845aec7e438fbfd6677ee7d0dfb1dd8ff00a3789b54619324d05ba9f4d8acc7f3de3f2afa03bd78f7ec936ab07c32b9b8c0dd73aa4cf9ef80a8a07fe3a7f3af61af2b132bd467af848da920a28a2b9ce90a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800af99bf6bfb11178bf41d4c0ff008f9b192dc9f5f2df77fed5afa66bc17f6c6b50da1f872f8e330de4b08ff81a03ff00b2575611daa238f1b1bd267ce7dabb0f82a6e97e26e9df63204a619c64b0000f2ce492781c7735c7d773f0174f6d47e25448a88fe4d9cb2fcec401d17b0f7f6fad7d0d15efa3e4b1ced4247bdc4f0da485ad71a85f72c67652638bd5867ef11fde6c01e8783573c35a249aaea22e6f0cb344d2ed1b58efba94f3b149fcd9ba28c9f4ad687c3b690240daddeb2c52106dec2dd30f39e830a32483fde3cfa66bb0ba92c341812368619354921d9159c7c2db447b311ca83d4f763c0ee6bd09d4e88f8ea34bed4b62aeab1096e2d2eaf562fecfd3fe4b0b5030b7128183211ff3cd700283d401ebce1df4c6346b991c44b3c8dfbd64dcd239ea11472ed9fa007a9153ebfaa45a6a1bed5b1757f3a66dedba2edeccc07dd8c765ea7f32706e2f2e74b6fed6d51cc9aeca98b481978b34c70e57a03fdd4edd48e94a1eead02afef6577b13f8af563a4c3fd8da5c92c3712a03a94be6ee919bb4648e06d04e42e064e39c127e3cf8dfaf2eb1e3496de17dd6d60bf674c1e0b67e73f9f1ff000115eebf18f594f05f82e4bcbfb968f5cd494ae9d681879d86ce677079541ce38cb3600e3247ca0cc5d89624927249ea6ba6945247b79561a57f692565d04a28a2b73de0a28a5504d095c3713bd4d14781b9fa1e83d7ff00ad4f8e2118dcfcb765ff001a563939ade9d06f565a5dc43f31cb73452e292baa314b6065aa28a2a0f4428048079eb4a0648031d7b9c525003e291a2955d09054820fa1af5ed0674be861ba4c6d640e40e80fa7e073f9578f577df0bb55199b4b94f38df0e4fe63fafe75f23c578075e87b58ef13e8720c77b0a8e9bda477a17732a8ea4e056bdd90dae4116788f68feb59d6237dec0b8cfcebfcea4b8b8dbabbce390b2fe80e2bf26ac9ca56f23eb0e95943a1461904608ae5b57d2da363b94b440e55c76fad7528caea190e548c834a4023079af2a8d795191a45b8bba383fb147fdf6a963b58579db93ef5d64da759ca49308527ba9c543fd8f69bb3ba5fa6e1fe15e8471f4dee53af51e9739fce3802b534bd35a5659a75c46390a7ab7ff5ab520b2b3b7f99625c8eec738fceaadf6ad0c40a41891fd7f847f8d4cb133abeed3465f11e5ff17edc41e328a551817166ac78c72188fe4057255d57c4e97ed1756174cdbdc33a3b7ae40c7f235ca93804d7e8f93c9bc2453e87e719cd174b17256dcfaf7f66787c9f833a331ce667b890e7de7900fd00af49e2b96f84da35cf87be1c687a45e27977305a832a673b1d8972bf816c7e15b3e21d674cf0fe9136ababde45696908cb48e7a9ec00eec7b01c9ae4abef4dd8f428b50a4ae5fef4b5f31f8dbf682d7af6e6487c296b0e9966bf767b88c493b0f520e517e986fad72d1fc6af893b47fc54ab27b9b2b7e7f28eb68e12724612c6c22ed63ec5a4af96345fda07c6768bb350b6d33521ddde231bfe6840fd2bd23c29f1fbc2ba9bac1acdadd68d29e8edfbe87fefa5191ff7cfe3532c25488e18da72d0f60a2abd85e5adf5a457965730dcdb4a331cb1386461ec475ab15ccd3475a69aba0a29296800a4a2a0d42f6d34fb29af6fae22b6b6854bcb2c8db5540ee49a718bd909b495d963eb50dedd5ad95bbdc5edcc36d04632d24ae1117ea4f02bc03e21fed032f9b259782ed5020257edf72992dee887a7d5bd7a0af14d6f5cf10789f5049354d46f753ba9182468cc5c924f0aaa3a73d80aeba783935796870d4c7462ed1d4fae351f8b5f0eac2e0dbdc78a2d59c75f2239265ffbea3523f5ab7e1df891e07f10dd8b3d2fc456b25c310a914a1a16727b28902ee3f4cd783f83be00f89f57b54bbd6efa0d0e3719585a3334ff00f025042ae7fde247703a574779fb37218bfd0bc5afe685e93590dacdf50ff28fc0d54a9515a5c235abcb5e53e82af1dfdade132fc31b4906efdcead0bf1ee922f3ff007d556f07ea7e3bf869343a478da07d4fc37911c7aac0c6516838c1727e611e481f3018ed90315d37ed0ba3dc6bff00097535b0513496fe5de22a9fbcb1b066c7afcbb88f5aca9af67513b9ad597b4a4f4d4f8fc1cd7b2fec9ba5cf3f88fc45ae24560a963691406eef9c7956e6562c084fe37fdd9c0e99ebdabc6148c71c83d2bd07e08f88b42b196f74ad4b5186c26b99fcc335c3aa44100007cc48e724f1f8f4ce3e8a841ce5a1f1f9839468be5573e948b59f2b51957c3ef35fea52e44dac5dafce074fdda1fb831eb93db8e2b52dadbfb26cd2e9a09752d4aed89b5b7605dee5fbc9277d83f5fa64d735e1df1cfc25d16366d47c67a4b88d8030c53091a5638e495c8dbcf63ebf434bc67fb40fc29b48ae264d4ee3589e5f95ed34f8245dea3f85e670b94ff65703be39cd76b4d3e58a3e669612b54f7a4be46e5a5addb6a72dc40135bd798f992ce70d6d647fbccc7e56718e3f84638dd8ae3fe23fc41f0b7c3259649aea3f11f8be4cb2c7bb7470b919ded9f7e72dc9e303f8878dfc43fda27c59afdb3e95e1db5b7f0ce97c858ed79908c63ef60609f50323fbd5e313cb2cf3bcf348f24b23167776dccc4f2493dcd74428bfb47a787cb1b7799a5e2ff11eb1e2cf105ceb9aede3dddedc3659d8f0a3b281d80f4ac8a5029c2363daba634dec91ee462a2ac86500126a6112f7a992318cf007ad6f1a0dee5a8b6429096201efdaa70162e1705bd7d286618c2703d7b9a8eba234d44b564293939a4a28ad04145145005aa28a2b23d00a28a28027bdb79edee4c5736cf6cf80fe5ba9042b00ca79e7054820f7041a5b1ba9acaf22bab77db244db94d40cd939639a4acea535520e12ea3849c249a3de3c19a841abc316a10fdd442d22f7460395fce9cedb9893dce6bca3c11e26b8f0edecab8f32cee97cb9d3b8ff00687b8e7ebf963d4ade686e2049e07124520dcac3a115f90e7593cf0388724bdd7b1f739763a389a693dd1a5a7ea52da8d840922cfdd3dbe95a69ac5a15cb8910fa115cf9a315f3753094e6ee7a8740dac5a01951237b05c5579b5b720ac3085f42c7358dcd473dc470e72727d054c3054d30e56f63d9fe1e7852d350f0eaea1ae422ea4bb3bd11c7089db007af5cd5cd5be17f86ef61290a4f68c7f8a390fe58391fa5759a2c31d9e89670a28448a045c0ec02d63cdaecf12cb76cd025aa3107790b800e3249e3afd2be92961694209247ce4f155554724cf02f8ddf0cf50f0ff85a7d5a2b85bab2b59a376206d64dcc14123bfde03f1e95c9fc0bf0f8f11fc4ed2ad658cbdb5ab1bdb8e32364782011dc1728a7fdeaf78f8abe30f0a6b3f0c7c43a6c9e20d245c4b63218a2fb5a1679179550b9ce4b2818c75af24fd993c4be16f0eeb1ad6abe20d62dec24fb2471402556cb82c59f181ce36271ef5ed6117b2a0d23c4c7d5788c4a9cd9f58d790eb9e11d4fe2a7891750d66ea6b0f08d9b11a7db46712de76331cfdd0dd89e76e300649adf4f8c9f0ca425478aedba7f141281faad49ff000b83e1b7fd0d967ff7c49ffc4d73c79a2ee6b270968d9bfe1bf09f86fc3902c3a2e8b65678182e9103237d5cfccdd4f535735bd1748d6ed4db6afa5d9dfc473f25c42ae07b8c8e0fb8ae3d7e33fc3276da3c576e0fbc12a8fcca7b56b69bf11bc07a847badbc5fa29efb64bb48dbf2620f6a1ba97b8d7b2b58f30f885fb3eda4fbaf7c1574b692672d6174e5a23fee3f2cbf439073d45789ebbe07f186853347aa786f518769c6f584c919fa3a654fe75f6de9f7f63a84027b0bcb7ba88f478655753f883ed56ab7862e71d1ea7354c1539bba3c4bf655d17c4da5e93aa4faac37769a6dc321b5b7b842a59f9dd22a9e4020a8ce39fc2bdb68a2b9aa4f9ddceba34fd9c79428a28accd44af38fda23c37aef897c04b6ba02bcf34172b34b6cac019d0061819ea4120e3be38e702bd228ab849c5dd11522a71e567c67e1bf84de3dd72ec429a05c58459c3cf7e0c089ef823737fc041afa27e15fc2ad0fc0c9f6b2c751d61861af244c08c7758d79d83d4e493eb8e2bd0ea3b89e0b789a6b89638a35e4bbb0503f135d153153a8ac72d2c253a4ee3e8ac997c4de1a88912788349423a86bc8c63f5a853c65e10760a9e29d0d98f000d42224ff00e3d5cfcacebe789b6ca190ab00ca41041e845456f6b6d05aada430c71dba2ec58957e455fee81d00ed8e80715413c4be1d7195d7f4a619dbc5e4679f4eb57adafacae9f65bde5bccdb776d8e40c71ebc1e942b93cd167c43f11f401e15f1ceb1a1a8221b6b8260ff00ae4e03c7ff008eb01f5adef86bf0135cf195941ae6a5791e97a6dc00f1606f9654f503a283d89c9f6adffdae6d960f1fdadca20027d290b103ef32c922ff002db5f42689710683e14d2b4b51b8d9d9c36fc6719540b81dcf4af5658e9d0a69c77679743091a955a670ba07eceff0e34e897ed76575aa4839f32e6e581ffbe536afe95cc7ed15f07fc3567f0fa6d73c33a441a7dd698c249442302588f0dbb9edc1cf5e0fad7b27f6cdeac892c891ac458064c7cdcf19fceadf8beca0d53c21ab594e82486e6c65465f5050d73e1730ab2ac9b677d5c1538c1a48fce7f287ad3846a29dda8afd1e9d38b8a67cdca293b00c76a5eb4a8a58ff008d38b2a0c21e7d7fc2b5b25b02428555e5faff0077fc698ec5bfc05275a4a2f60bf60a2b67c33e18d6fc45a9d9d8699a7dc4ad77288a393cb6f2c1cf24b63181ce7e956be23784753f02f8baefc37aab4525c5b84612c59d92232860cb903d71f504573ac5d1f69ecf9b51f23b5ce7281cd2819fa7ad3b3e95d171074f426994514c0b395fef0a5aab4bb8fad4f29baafdd1669f214ddfbb0c0607de39e71cfeb9aacb21efcd48ac1ba54b46b1a8a43a8ab88ba71d2642cf75fda22e1046a117c9f276b6e24e73bb76cc0c631bb9e954ea53b9a0a6ba2f0a788aeb446549774b65213ba3cf2bfed2ff008573f044d34ab1a0f998e055cd7a316fa9cb663fe5d8f927fde5e1bf5cd706328d2c5fee26ae7561ea4e87ef227ac5beaf0ddc0b359b2c913746ff00eb763ed4e3772ffb3f95792695aa5de9b379b6d2601c6e53cab7d45769a4789ec6f1552e185acbfed1f909f63dbf1fd6bf39cd786ebe164e54d5e27dd6559ce16bc542ae923a47b89981cbe07b0c543ef9cd00ee19078ed8a5af9a7194256923e96d0707c87d5f79308341798f45833fa57c6ffb423de2fc4092de6b891e1169034485c9550506703a0cb6e35f586897cbe28f002cb6840966b73195cf0ae0608fcc62bc03f69cd1daf2cb4bf13db46d9b706c6f14afcd1725933f8971f88f5afa3c2cd5d1f9a63e9c9292ea99e7df07fc130f8d7c412da5e5f359d9db45e6cce8b976e400abd8139ea7d0d7bd687f04fe1e1c996d6f6ef6632b2dd9191efb36d785fc11d6ff00b23c6421660b1dec461271fc5d47f2c7e35f41e99af1b6bd493712a0e187aaf7af2f39ad8a855b539591c78354daf796a5e5f83df0d94003c2f19038e6ea73ff00b3d38fc21f86ddfc310e3febe66ffe2ebb05955943290430c820f515cf78c3529564b3d2ad32d7376f80a0f2464607e27f957cf2c4631bf8d9e938514afca60ddfc2af85657c95f0ea97c10045773e41ff00bef1f9e6b9fbbf839f0f65663145a85b83d025d671f9835e8fe26863f0d784894f9a795d62925ee739271e838c62b93d13c53636715d2ddd98ba322011938f94f3ebeb91f956f1c46323f6d9ced527d0e32ebe086829297d2bc45a959fa6e55720fd46dab967e10f8b1a44bff14f7c496b9118fdd437d23fccbd80570ebfafe35a9fdb43fbc7f3aef3c02d0ebfa0dc5bdca96104b846e8c9919e0fd726baa199e362f57721d3a5d0f3e5f1efc69f0b44a7c4be0db7d6ad532cf3da0c395f52632cabf8a0ad8f0d7ed0fe0cbf9120d66daff449c9218cb1f9b129edf327cdff008e8aec6ddb5cb0bf7b1ba805dc0a46c9d5c062a7a1209e7bfe47ad7927ed47e19d364f0fc7e25b6b58e2bf866549a48c01e6a1e3e6f520edc1f4cd7a782ccfdb5454eac6cd91529ca11e68bd0f6ed37c6be10d4add6e2c7c4da44d1b296ff8fb40401d7209c8fc6aa6bff11bc0ba1c45f52f1469884646c8a6133f1feca65bf4af8328af7beaeb7393ebb2dac7d59ab7ed19a33dcada785fc37aa6b170f9540ffbadc7b6000cc7f2154478abe3ef8882be9be1db2d0600705a68d55fea44cc491f45aeabe0af86f4af0f780b4a96cede21777d691dc5cdc6c1be42ea1b04ff0074670074e33d49aed2e5ee5d4476611a77385de4ed5f5271e95f3b8acddd39b8528fde7753a2e51e69b3c62efe1ffc54d4863c4bf139ede0946644b69a56cfa8d8a114ff002aa83e06e933cdbf54f196a7798e4e2dc2b13f5666af69f10c29a27872eafcb34d761554ccfd41660323fbbd78c5711a6f88b4d8aceed2f2092599d310329e14f3d79fa7ad79d3cd31b27a3b7c83d9d239fb7f81df0fd42096ff005e91b1f31f3a200fbe02569c5f00fe1fc8c258e6d59d08fba2e5707ff1ccd3175d20821c820e41cf4af4a820b8bcd12db57d3b6add490ac8f111849b8e463b1eb83584b1b8e7f6d9a46145743ce1ff0067ef0233645c6b28339c0b84c7fe8159579fb397879989b3f10ea50ff74c91a391cfb6daf59d2355835281a48f292c6db2689b868dbb8349afde7d9348b89f382171f9903fad286658e8bb731aba145ad8f937e2df80353f05cb6f34babff6ad8cced1c538dc0a118382a49c67d891c5753f00bc75e24d47c776fa46b1aa4da85b4d049b4dc9ded1b2aeedc18f3db1563f683d604de19b1b1dca5a4ba0f83d70aac38ffbeab97fd9cede29be23c524acbfbab7628a467731655c7e449fc2bebf095275b0bcd5773ca4943116833ea5d414bd85c283cf96d8f638e2b716513f861a603efdab11ff007c9ac0bd961b4b63b5305fe58e341cb31ec0537c6dacc1e09f855797da894692deccc69196c079586d54c8f738cd3c1c5cab4523d4c43b533e09a902851973ff0001a0b051f2727d698493d6bf58a4ad048f9095b998e67278e83b0a6514559214514ea181f55fec73e2b161e06d6a0d775bb1b4d26c2e57ecc279423445c167eff749c1fae6ad7ed99e25d2ed3c33a5e99168ba66a171ac46ef16a5222bc96f1a3213e59c6413bb19cf4c8c735f25138fbbc54d737b79730c10dcdd4f3456e9b2149242cb1afa283d07b0af9c790c5e3beb7cdf23a7eb1fbbe4212d9a6d1457d1a4730a0120903803278e9494f8e49115d11d956450ae01c6e190707d46403f50299496e2414514531852838a4a280278e4dc707ad3eaad4f0b6ee3bd6536a2ae74d19b93e5675ff0d2c95f589b549903c1a5dbcb7ae1870de52160a7fde6dabff02ae5647691d9dd8b331c924f24d7a668f69fd95f053c4baa91896f66b7d36261db2e25907e21545798d78995d6fac54a957cec7ad8b8fb38c6014d90e1734ea8e63c015edd93d19e6ce5caae8b5a7eb3a8581ff45ba9117fbb9cafe478aed7c17acebde25d6a0d1b4ed185f5dcc7e5111dbb47766272001dcf02b9af01f8435cf1aeb91e93a25a995ce0cb2b644702ff0079dbb0fd4f419afa9f4cb2f077c0cf07019fb66ab76bf330004f7920ec3fb91827e83dd8f3f13c475b034d3a71827519ebe5388c6a7eecda4755e14b3d33c05a5d969d7ba94426be9f61def8f365207083d0600ffeb915a5e2ff000d43a9c134d15bc33199365c5bc8bb92e13d08f5f435f22f8f7c69a9eb9ac3eb5ab5c96b8ce208e32556100e42a0ec07af5cf3d6be86fd9ebe28c1e33d0d74bd4e548f5bb340255271e72740ea3f2cfa13e8457cfe0f2eaea8f3b5a1e8e32bc54ecdde4f73e5df1658c5a778c3538b4a47b58acefe448626625a3d8d8c64f5c107afa57a8e89ad4b7da45b5f488d1f9a98208e370386c7e35e5da9de1d4355bed40f5bbba9673cff0079cb7f5ad4f0d6ba74d8dec6e84b2d84afbc8423742f8c6f5cf1d3195e37003904023d0c565f1ad4d7747cb2c4f2547d8faafc0da81d47c2f673e7732a98dbeabc7f203f3a6f8274ebbd47e22eb1ab6a10ec8f4f4482d109073b81f9863db27fe05ed5ccfc02b9fb7687a9436b730dec504cb2868892543a91f3290197943d460f3824735dddc584eb75f6fd32f5ec2fb68432050e92a8e8b221e1c0c9f4619382326be5a583f6551a923da551d5a69c4d8f1b68326bde1abbd3a375499d7742e7a071c8cfb1e9f8d7cc5ab4d7fa55f4963a8c125b5cc4db5e371820f15f48db78b755b26f2f5bf0e4d70a38fb5694e255fab44e55d7e8bbea2d5f5df867af2aa6bc215655c0fed2b096ddd3be37488a47e07078f515bac2c5ec71ca738e8d1f39596a725d28b1b6b33717734abe5b26e693b8da14707248ed9e057d21f0cbc3775a0785e282f702f276f3a751cec240c2e7d87ea4d3343d47e16e88fbb427d37cdfba1ac6d9e790671f2828acde9c56c378aada71ff0012fd2f509c11c493c46dd07d449871f821a6f09144c67396c4bad5b6eb5f3bf8a33c1f635e19fb51dd2c1f0e2280baabdc5ec6817232c00663fa815ec97b79757c36cdb123ce44499c77c64ff17e83dabe69f8f17575e36f89ba7782f463e70b20cb26d0085908dd237fc051791ec475a30b868fb7525d0eb7292a7caf766b7eccbf0ab49d634697c59e28d392f61999a2b0b6986632a386908fe2e72a01e9b49ee08cbfda5be155a7868c7e2af0d5a0834a95847776d183b6de43d1d7d118f18e80e3fbc00fa63c2b6d6b67e1ad32d2c63115ac3691244b9e8a100152ebfa5596b9a2de68fa8c225b4bb85a2954fa1ee3d08ea0f62057aded9b95fa0beac942dd4f2ff809ad2eb3f0c34b6326f9ac94d9cbc63694e147fdf053f3af52d0add0c2d3f57276fd07f9fe95f337c2ab8bbf863f15750f026bae56d2fa40b6d3b0c2b3ff00cb271ece0ed3ef807a1afa22232c44989d909e0ed38cd78d89c228d672e8cd29c9ce9f2f5469f88b478f59d12ef4c958a2dc46543819dadd4363be0807f0af9a3c5361ae786b506b3d5ed2581836124c7eee51eaadd0ff0031df06be876bfd75037917969203d7ed36db8fd01465c7e47fa55697c41e2c40e87c3fa1de26dc1ff898cb0e7d723c971fad25420ce771a8ba1e1de09d1f5bf175e456ba7dab2db2b9f3af0a1d918e3393d091d97aff003afa4b4fd3e2b1b182ce00de5411ac699e4e146066b9893c47e38986d83c39a0591e9ba6d4e49bf1dab0aff3155668fc5fa8ff00c853c4eb6919fbd0e936821fc3cc90bb7e5b4d0e841046351943e205849a778c34bd4344b8812faf64f2aeed1dbfd62004990a8e70318271d76fbd41f132e85b785266c905e58d463fde07fa56e68ba0d969ecff0061b567b89b996676692694fab3b659bf135c9fed077b1f873c0f6f75770a4f3cd7e91c36f9046ed8ec19ff00d91b791dfa719cd4d3c17b6aa924744a4e9527767cd9f13aeee753f121b565648ecd045f30c7ce796e3afa0fc2a5f84978da678d748b889598bcea8e075209e4561dd4f2dc4f25cdc48d24d2b9791d8e4b313924fbe4d5ef0a482dfc4fa5cc0e36de44c7fefb19afaf8e1a34e8f223c385693aaa47daba068f224a353d4f6b5d11fbb8ff008611edefef5f32fed5fe3d5d7fc491f85f4e9b7d8696e5a723a49718c11d7f841c7d491dabd73f68af8a107837417d234b9d5b5cbe42b16d20f90bd0c8dfae3d48ee01af8d6591e591a491d9dd896666392c49e4935e8643967bdeda6bd0efcc31778f2219451457d99e3052e3d78a4a5cd003b8a6514500145153450a496d34c6e228da3dbb636cee93271f2e0638ea7247e349e8221a28a0924f34c614514500145145001455b8e0b66d36e2e1ef963b98e58d62b631b132a307dce187036955183c9dfc743552a54ae2b055bd222f3afe243d3393f41cd54ad7f0ca0376ce7f853fa8ae0cd2aba5859b5d8edcbe9fb4c4451eb9f122dce9ff00b3af85e1036b5eeaaf7527b90b228ffc7715e2d5f497c4bf0eea1e21fd9e7c312e8d6735e4d606395e2850bb9428cac401c9c3107e99f4af26f0bfc26f1f7882754b7f0fdcd9c47ef4f7c860451ebf30c9ff0080835f33c3f9961a8e15ba9249dd9ece614672ada2386af4af853f0735ff001bcd15fde07d2f42cee6ba917e7987a44a7aff00bc7e51ef8c57b0780be06785fc2b0ff6c78c2f6df539e11e6379c447670e3b90df7beadc7b566fc4ef8d3e6c4fa37811f6c78d92ea6530140e36c2a47fe3c460761d0d73e3f892789fdd60d7cc5472ebeb33a1f12f8abc21f08b411e19f0ad8dbcfaa6d045b2b67048ff005b70e39f7c753c0181c8f9dbc5de25bed4b529b55d66edef2fe7ea4f000eca074551d80ffebd646a7aaac4d26c91a7b9918b4b2bb162cc7a924f535812c8f2397918b31e4934f2ac865565ed2b75efbb34c4e3e1858f253dff0021d77712dcca64958927f4a9f44d4eff0046d520d474cba92daea16ca48870467820fa823823b8aa54e8c6645fad7da4e8c29d1714b43e6a5567397337a9d041c411ff00ba29f489c46a3b6296be525b907b37ec95a80b7f1edfd8962bf6ab0253d4b23a91fa16fcabe9f60927fad8e390fab0e7f31cd7c6ff00b3fea034ff008b7a2bb1c473bbdbb738077a328ffc7b6d7d93dabc4c6c1739eee5ef9a9d885ed2d9ba7991fe4c2a33607f8248dbf1c7f3c55aa2b83911dbca5436138e7ca623d40c8fcc547f67ff0066aff7c83823d29fe7cdff003d5ffefaa3d9a60935b1522b10a775c2ed00709ddbfc3fce2b9cd03c19e0af085dcfa969fa6db595d5c0225b99e669247c9e46e9189e4f5c75e2b67c4179716b6f0a5b1513dd4eb046efc84273f311df8078a9f48d12da294ceecd3dcf1ba798ee73f4fee8f6142d34895c897bd220d1a48e2b0b7b589269045184dc62655207b9001ad2abeb0c118e40fab555b93197fdd81ef815495b70e7bb399f17782bc2fe2cf25bc41a3c17af00c45212c9220f40c84301ed9ad85d3a211471daee01142ed772ec70319dc492c7ea49fad59aaa2f631a8fd864052465df193d241df07d4771ef44acd598b93aa23368eafb0a9dde8473520d3e6c731edff7be5fe7571649546d591c0f40c69a7ae6a3d9c507bc561a7aa9f9e741ec83273fcbf5a916dad53fe59990ff00b4703f21fe352f347e154a115d02ddc01c29550114f5551807f2af9ebf6c4d406ef0de948f9e6e2e645cf4c04553fabd7d0bd2be44fda67561aa7c5abbb7421934cb58ad010782d83237e39931f8576e0a37a871e3a4a348f3375dc8ca3b8a75a4ef1bc370870e8438f620d254507caf247fdd6c8fa1e6bdc8d9c95cf053d4a7acdfdfeb3a9cda8ea97525d5d4c72eee79e38007a003803b0aa7e5a8ed4f6fbc47bd257d6d14a30491d8a29eac8da3c8eb513020e2acd232861cd6a999ce8ae856a295860d255277399ab0514514c45fd0748d4f5dd561d2f47b296f6f66cf970c4b966c024fe4013542a48659617df0c8f1be08dcac41c10411c7a8247e34ca85cdcde43164db91b0b1181c918e71cfeb4da28ab420a294027a53f00753f80a57191d14514c028a28a002b5fc3520174c84e372715914f8a468a40e8c430e4115c58fc3bc4509535d4e9c157fabd65367d3df063e29693a0f86c685e2079625b77636d3246594ab1c9538e7218939f43ed5bfe24f8eba15ac2cba1d85cea1718f95a51e5443dfb93f4c0fad7cb716b131405a2427d79151cfa95cc830084ff7457e76b846aceadd9f5d3ccb0ad732dcee3c7de3ad6bc5573e6ebfa896815b745650e5604f7099393d79624fbd705a96a934c4c717eee3e9c753f5aaecc58e4924f7aaf27df35f6197e45470d6e6d5a3c4c6e6539c7961a21868a28afa0514b44786db7b853a2ff58bf5a6d3e2ff00582b2c47f0d858de04f9ca0ff709fe5525300fdf6eedb71fad3ebe3e4f502ce99793e9fa95adfdb3159eda649a36cf21958107f315f77f87f53b7d6b43b2d5ad4830de40b3260e7018671f51d3f0af81ebe99fd953c582ff00c3973e15b9941b8d38996dc13cb42c791ff01627fefa15c18ea7cd1e63d2cbeaf2cf959edb494541a85e5a69f6725e5fdd436b6d10dcf2cce11147a927815e4c637d0f65b4b72c71495c04ff0019fe19c373f677f1540cf9c663b799d7fefa5423f5adbd0fc7be0bd6dd23d33c4fa54f2bfdd885caac87fe02d86fd2a9d29f6255685f716c6d7fb72d2ea6d426956613322223616d8a1e0aff00b5df269743f132c574da7df5cc4d2236c4bb8ce6297d327a2b7e95b1159408d7402068ee5b7c8847ca49500fe600a7cb6768f686d1ada13011831ed017f015872c933a39e32562c3167392c4e7d4d56bdbb86d554c8c4bb9c471a8cbb9f403fce2b3a3d3352b2cc5a66a2ab6c7a47731990c5feeb641fc0d5cd3b4e8ed5da79247b9ba7fbf3c9f78fb0eca3d8557337a12e29162de66932b241242f8ced7c1c8fa824566df235c78a34e0a3e5b48a49a46f4de36a8fe7f956c100fd474a8d845107998a20c6e77271c01d49f4a7cadec2e651d592515c9ea5f127c05a74e6deebc5ba4ac8382a972b2153e876e707eb57bc3fe31f0af881c47a2f8834dbe94ff00cb28ae14c98f5299cfe95a7b392e864aac2f6b9bd45252d458bb999e2ad6acbc39e1dbfd73507db6d65034afce0b63a28f727007b915f09ea17b73aa6a577aa5e306b9bd9dee262071b9d8b1fe75edff00b5978c1ae2fed7c0d672e22882ddea1b5bef31ff005719fa0f9883eaa7b578557b182a5cb1e667878fadcd2e55d06c84aae7d0e4d308db739e8197f97ffaea46019483dc114c88ef48dcf51ffea35df1d1a3cf5b9932f12b8f734da7cffeb9ff00de3fce995f5b4be04774760a28a2aca229877a8aa797eed5cf0bd969fa8f882c6c755d5134ab19e6549ef1a32e2153d5b03ad129f2c5bec72548fbd61979a36ad65a659ea777a7dcc1657c18dacef190930070769efc8aa15fa29e09d07c2b0f80745d334b7b1d7348b1887d8ae66f2e657604fce0818ce49e838af893e3dc1aac1f16f5ff00ed8b78e0b87b8dca8806df2f0021e38fba067df35e0e559dbc7579d2e5b58bab4392299c2d14e0a4d3be55e9c9afa339ec3429347cabfed52124f5a4a56b85ec2927d69282715149213c03c544ea280ae4b451456830a28a2800a28a720c90295ee095d96761112b92b8248ea33c63b75eff00e7149451599de95905412fde353d4530e869a7a995657891514515a1ca14e8ff00d62fd69b4e8fefafd6b1aeaf4d8b63a253840c7a6334b51161f640c3fb82a5af9096e30adef017896efc25e2cb1d76cf2c607fdec79e258cf0ebf88fc8e0f6ac1a5a89454959950938bba3eedb7f1368b37853fe1285bd41a57d98dcb4e7f8500c9c81ce474c75cf15f26fc72f88b71e3ed7a38ac4dc41a1da28f22de538323f795d41233d80cf0076c9ac4d3bc61abd8782f54f09ac825d375131928e4e6165915c943db3b704573483e425891b8e4d7251c2a84aecedaf8c7522a2862f98bf22ba923b05cff5a7189997e67539ff0064548bb1461700529e9c575e8ce2f791b9e17f1bf8c7c2ee8ba2f88eee0881cfd99cf99091fee36547e001af4ad37f68bf155bc78d4f47d1ef00006e8fcc849faf2c33f415e2bb963240cb39eddcd091b160f2919eca3a0aca54212dd1a4313521b33e8cb2fda4ed1d47db3c23710b63fe595eab8fd5569d79fb49592ae2d3c27732bf3c4d7a231fa2b57ce0ee555a56e83ee834d818cb1e0e448bebf4acfea94fb1b7d7ab773da7c43fb43f8b2ee1f2f48d2f4cd2cb71e6b6e9dc1f6ce17f306bcbbc47e25f147896466f106bf7da82939f29e622207d907ca3f002b301591082bf51e94ab90a0139f735ac28423b231957a93dd91a44abf7624c7d7ffad48ca519648d1564520ab2b6d39ed83daa465c1dca707f434d32a630e554f704d6965d4cd4a5ba3d9fe0efc6fd474590693e339eef50d376fee6ed87993c2de8c73975f73c8f71d3df35ef1d787b4bf013f8cc5f4573a6183ccb7646c19d8fdd8d41e431231823230738c1af86d1d1b28aea73c70791531bcbebab48acaeaf6e65b5b576f22dda42628c93962abd0127938ae5a9848ca5747652c74e31e564fabea579aceaf7dad6a2fbef2fa669e53d8127803d80e00ec2ab29ca83ea28938463e80d241c4283bed15d4924ac8e2726ddd8ea641c1917d1bf9f34fa8938b993dc03fd2ad6e232e6c79cff00ef1fe74da748419188fef1a6d7d5d1fe1a3ba3b0514515a94365ff00566abd4f2fdc22a355e324e2a96c72d6f88eb23f889e288fe1e5bf816daf4db6950dcb5c6612565624e761607ee86cb63d4d72f71712dc4ad35ccd24f2b757762c4fe26a22dd80c0a4aca961a9526dc15ae66e6d8a5b34da28add121471d4d151cadc102a272e4426ec3657c9c76a651de8ae172727a90d9668a28af48d028a28a4d8055a8dadcdac68207170b23334be670c842ed5db8e08218e73ceee9c55615241d4fd2a5a2e9af78968a28a93b429b20ca9a7514d68292bab1568a95d0939504d5ad1f4abed5b518b4ed36d26bcbb98e238604dccdff00d6f7ed4e53514e4ce2e469d87c7a0eb32684faea69b74da6472794f742326356f427f2acf553d40afbcbe017822f7c35f09e3f0e78a2c2d8c970d235c5b31122b2b93f2b7627071587f113e1bfc2af02fc35f116b27c2f68ecb6b2089ee1ccae257f9502336769dc4631d2be3ffd6ca32c4cb0d6bbbd91d4f06d4798f9090e74fce7a2d5ac8db91dea969ade65a94eff00fd6a995898636f4233fca94d5a4ce3b13d1499c36d27b52f6cd400d7e9ed56b419e1b4d66c6fae21f3e382e6395e3c643056076e3f0aae6a3838debfdd63fcf343574ca8bb34cfb9359f07f85f5ab18dc687a3ca701e091ece3653dc751c8356bc3ff0b7e0ff008c2dde0d53c0ba65aea50f17115b17b6e7fbcbe532fca7dba67df2791fd9d3c52be22f8796f6b2c81af74a22d2604f2500fddb7d0af19ee54d773a845756b7716b3a6318ef6df9c75122f7523bf19ff38af269d6952a8e323dc9e1e389a2b97730f59fd92fe1addc9249a75ff8874a2df76386ed1e35fc244663ff007d571baa7ec7eb19ce9de33b99d7fbb340108fc4673fa57a6cff00b47fc3ed1f575d1fc5cfa8e8172ca19269ed5a582507babc7b8e3391f32ae08e78e6bbef0c7c43f02789ca2f87fc61a1ea523748a0bd8ccbf8a6770fc457a2a573c16a54a56923e625fd96dad9ff00d221d5ef1b3c11770843f86dcfe751a7eca77f7d382b7d7966a7f8a79236cfb7c83fa57d73a3eb1a6eb02f0e9b72970b6775259ceca0e1668f01d3dc82707dc11dab47028b6a6cf1578db951f2be91fb1d690086d57c6ba9b8ee96f0227fe3cd9cfe55af0fec7fe0659019bc51e2874eea92c2a7f3319fe55f48d56d42ee0b1b492eae6648a24196663802aaece6bb93d0f9675efd9efe1c68fe26b2d22dc6b1a8610c972d777b9c8ec3f76ab8e87d3a8a6fc46f05fc3cf03fc38d6b55b2f0ae98b3a5b3476cd347e7b099fe4420c9b8e43303f857a2e9570fab6b1a8eb92820cf2958f3d428e83f01b47e15e15fb5a78a167bdd3fc256b2822dff00d2ef003d1c822353e8402cdff025af3f9e552b593d0f7e74a14282bad4f9fbca5327cb81b170081de9f6cc595d88eac6949fde2a03db71a58d76291ee4feb5ea23c4625c13e4951d4fcbf9d3c000003b5230c919e839a5a0421243201dcff434c38fb4939fe01fce9cff007a31fed7f4351cc487761da3a71d582dcca3d68a28afada4ad048ef5b0500127029429efc0f5a527b0e95632394aa8f53503124e49cd3a6397a6f6ad16c715495e4251451426405153594714d790c33dc25b44ee15e6752c2304f2c42824e3d054468e61586c8d81ef5067269d2b64d32b86acf9992f70a28a2b302cd14515e9961451450015341d0d435e99e03f831e3af14dbc3776da7ada5a4e03a4d70c46e53ce42a82dd3a640cd72e27134f0f0e6a8ec6b462dcb42f7c22f83ba9fc42f0f6a3acc1a82d9456ac638c18779918004f7181ce38cf7f4e7cef59d3af348d56e74cd42130dd5b4863950f623fa1ea0f706befdf83fe10ff00841bc0563a0b3abcf192f33aff00139249fd49ae5fe257c0df0cf8dfc41fdb5737375637063daff662a377a672ad9c76f6e3b0af89a1c5f4962e70a8fdde87a7ec1d8f880231e7b7ad3be45ebf31fd2bdbfe3e7c19d1be1f786a0d5f4fd6aeae2479550c372c84b03fddc2ae0f7efc03e95e195f6583c5d3c553f694f63192e562bb6e18e83d2b53c17e26d5fc19e23b7d7b449234ba8010048bb9581ea08c8fd08e959541c1eb5d152319c5c65b194a37d4fb9bf678f8a13fc4ad0afe6d46ce0b4bed3e4559046f90ea4677fb7718f6eb553c6bf15fe116b3a7eafe13d735b49627125b4ebe43eddc3bab63a823823b8af8f7c33e29f117866df518740d527b04d421f26ebcbc7cebce392383c9e473cd73ccac0fcdf9d7c8c784a87d6dd7bdbb153c44e30e566a59b411df4f0dac8f25bef611c8c305973c123b715659488658c76391f4ebfe35a3a2f81f587f0d3f8a2f26b5d2ec0a13642e98896fd87685002c46782e709db7678aa48caea1d7b8e7d6baf1b41d39dd6c79aaac64da4c66ef9e271d1863f3e7fa54a7918f5aad8220745eb13647d3a8ab20860181c82335c2521233ba3539c9c734814ace48e8e3f51490fcbbd3fbad91f8f34fa00ee3e09f8d1bc19e3482e6791869b778b7bd51923613c3e07753cf4ce32075afb323749115d19595864303907debf3ec57d39fb3278f9756d1ff00e111d4e71f6fb04cd9b31e66807f0fb94ffd071c7ca4d79d8da2dfbc8f5b0188b3e466afc74f873a7f8b743911d562704bc1305e6094f7ff0075bb8feb8c7c49e21d1eff0040d62e34ad4a030dcdbbed753d3d883dc11c83e86bf4b2e228e781e19577238da45792fc49f83fa678b2547beb59249621b62bab791525099ced390411c9ea0fea6b2c3e2395599db8bc1ac42e65a33e3bf0e78d7c63e1b04787bc55ade92a5b715b3be9225627ae42b007f1aed6dff68af8d5044234f1fea240ef2450b9fcd909af49b9fd99acbfe595f6ae98ce77468f9fc80aa13fecd0dbcf97ac6a283b06d3f763ea430aecf6f03c879657e8799ea3f1b7e2ddfc0609fe21f88d6339cf957ad11393ea9835d7fecf5a36b1e2cf14bf8a75dbdbdd492c1bcbb76ba99a5679d87ab13f741cfd4ad69b7ecd374870de22b807d0e94dff00c72bde7e11f8360f0ce9169611c2eb0d94780ee9b4cb21e59c8fccfb703b56756bae5d0ecc165d3854e7a8b44753aaea165e12f085c6a77ac16dec20323e0e0bb7f747bb31007d457c4be24d5ef35fd7efb59bf7dd7379334af8270b9e8067b01803d80af62fda93c7097f7f1f8374d9f75bda3896f994fdf9bf863fa28e4fb9f55af0da784a565ccfa98e6188e79f2ad88a23ba495fdf68fc2a4a640088c67a924e7f1a7d769e70514514c0639fdec43dc9fd3ffaf50de9db1487d5401f99a98f3373d157f99ffeb555d4d892b10fa9adb0f073a891514dc8a229c063af5f4a0617dcd34f35f569591dcb44293934945326385c7ad3444dd95c898e4d368a2b4389bb855fd6351fed192d5bec363662ded63b70b6b0f961f60c6f7ea59d8e4b31ea7d0600a1524c23594ac6fe6203c36dc67f0a96b515c695f954e473ee38ff000a631c0cd3bbd325fbb4a6ec989e8407ad14515e78828a28a00b3451457a65851454c9180374870a4703b9a022ae31119ce14135f5cfc02f8f1a4de58d87847c4fb2c6f1156082e507eea53c000fa31fc89e87902be497972bb546d5f41fe79adaf870aafe3ff0fa38cab6a76c08cffd355af2738c053c661e5199d1427c92563f4858770720f20fad35890acc17790a485f5e3a573be34f1a787bc19a02ea9ae5f471a08d42461b2f21dbc0007535c1783ff68af026b7288750927d1e52703ed2a117fefac951f8b0afc6e9e418a9cdd4842f14cf65d556b33e72fda1fc5fad789be215fdbea41a1b7d3a66860b7ce40ff6ff00e043047a0c0f527cdabd2ff694bcf0f6a1f14aeaf7c3b770dd412c286692220af980918c8e0e1420af34afd9f2c82861a0ad6d0f3e6f50a38a64922c6393f85559a767c80702baa55144c2756312c493a29c0e6bb9f0478762b68e2d6f5eb54b87741258d84a328411959a55eebce550fdee19be4c092b7c24f0b69dab5f8d5fc4731b7d1a19bc843b431967238f94fde48c10ef8cf0557f8c11daeb16f7969aa5cdb6a0185d472112963925b3d73dc1ea0f70735db97e1fdbcef3d8f9dcd73294172c3728eb8d79ab5e35eddddc93dc3000b4873c018007f7401c003803a0ae4b57d3e6b495aea38ced3cc8a3f98aec28382304020d7af8cc051af47d9b563e7f0f8ba94aa73a3802ca5d65539571b49fe5fad107cbba2fee1e3e9573c511e9ba75c6f82e614321c3db6ee47b8c74fc7154b7ab2acc87200c37b8afcdf1587fabd4706ee7d950acaac14ac29f96e41fef820fd454b4c994b4794c6410ca69c8c19038e8466b98d8473864f76c7e86aee8fa95ee91aa5b6a9a6dc3dbdddb48248a45ea08fe63b1078209154273840dd9581a929349ad46a4d34d1f6a7c29f1f699e3bd016ee06483528405bdb3ddf344dea07743d41fc3a835d8d7c09a56a3a86917f1ea1a55f5c595e47f72682428c0719191d47b1e2bb0d47e307c46bfd1a5d2e7f10288a542924b1dac692b29182370031f51835e6cf04f9ef13d58660b92d2dcc21e33f175bdd4c6c3c61e208a0595c42a35190aecc9c719c74aefbe09f8e7c63aafc4fd0f4cd57c51a8dcd8caf22cb1c8c18362272a0f19fbc16bc7e3011fca5ce0203cfd6b5340d5af743d66d356d3a511dd5acab24648c8c83d08ee0f435d93a3170b25a9c54f11253bb7a1f7bd79d7c6ff0088b6de08d09adad2547d76f2322d221c9894e479cc3d07607ef118e80e3c6af3f684f1ccd66618ad344b595971e7c76ee5978ea033919fa835e59ab6a77dabea971a8ea77935e5e4edba59a56dccc7d3d8018000e00e057151c1c94af33bebe609c6d1219e696e279279e47965918bbbb9cb31272493dcd328a2bd34924790db6ee14514531064060a7ae338fc68a645f34d23765c2d24f3a429b9c803a0a12b8ae24b22c2a5dba9e00acd9642ee58f53d4d134cf2b9673f4f6a8ebdfc0e15535ccf73ae942cae1451457a46c15048db9b352cad85c7ad41deaa2ba9cd5a7d04a28a9ec25821beb79aead85d5bc72ab4b06f29e6a8392bb872b919191d3354dd91ce8828a7ccc8d2bb468510b12aa4e768ec33de994277d4614d97fd5fe34ea490650d44d5e2c4caf45068ae02428a28a00b34e552c400324f4c50a858f1d29ece106d4efd4fafff005abd3344bb8ef922f467fd0544cc58e589269b450272b854903bc52ac88c55d482ac0e083eb51d6cf83fc33ac78b35a4d2343b5fb4ddba960bb828c7b93c0c9207d48acaace108de6f4085efa06b3aceafacc91c9ab6a7777ef12ec46b899a42a3d064f15429648a5b79e5b5b88de29a17292230c15607041f7cd324754196ace0a0a3eeec76a9d95d8a480324e2abcd71da3a8a6999fd87a545594aa7447354ad7d101249c9356b49b0b9d5754b4d36ca3f36eaee648214c81b9d880064f0393d6aad7a57c06f0aea5e21d5357bcd2feccd756564d15b472ce91996698326c40df79bcaf388039ca823d2a209392bbd0e2ad53920e4686ad25a41341a6692e5b4ed353ecf6ae01065c125e620f432312f83d010bd145745a75d2f89b4e86c9c635ab38c470633fe990a8e13feba201c0fe25c28e5543729a859de69d7b2d8dfdacd6b73136d922950aba9f7079aa7797a34e80de972862c3295383bbb60f639afae946953a0a717b1f1edcead5b3ea6aeadaa5a6956de7ddc81739daa3ef39f402b87d53c49ab6acc52d33676c4e320fccc3dcf5fcbd6abeb1a9ea5e28d666d6f5b9c4d3cc41fb814360632400073d49eac492724925be800e057c46639e56c43e583b23dfc36069d1576aecad0d8c4a773e656ee5ba7e54e6d416d2f163c7cb8f9b9e95649c026b9a91cbca5db924e4d785293dd9e8d3bdceced64574013a000e3d01a727c8ecbd8fccbfd6be8bb3f847a5f8dbe0d785b51b1f2f4ef10269106cba0b859c6ce16503a8ec1ba8e3a818af00d6b4dd4745d566d2757b47b4beb7621a37ef8e320f423af22b1a75a3376ea7a15284a093e855954346ca7b8a4b76dd0a9ef8c1fad3ea341b2675cfcaff32ff5adae602cf909bc75539c53c105430e9da8a88210ad0f4eea6801ccbfbd471d81069646d91b37a76f5a542c50161838e45248bbd36fb827f3a3601d51dbfccacffde6cfe1523e4a301de9140550a3a0c62810bc63269b1b1640c7bf34dbae2120756f947e352200a001d00a062d35d822163d8669dcd4ba7e9b7fabde8b3d36d64b995177b845c845cfde63d8648fc703bd27251576349cb44522e208016e5db9c7a9351a430df42eb38dcc7ff1dfa560a5fcd3ea48d21c293b76fd6b621731c8187e3f4a2e73d493bd8a1346f633f92ec5a26e158f6352d68eab6e2e6cdb18240c822b26d1cc908cfde0769fad7b796e25cbdc91d785ace4acc968a722b3baa229666385006493e82ae789744d6340b98ed759d36eb4f9a48c48893c654b29ee3d6bd5752316a2d9d52765732646dcd9a4ed45256cadd0e26eeee14514550828a28a0028a28a4d5c44122ed34dab0c01151794dbba71eb5c7529b8bba25a19d6a5d8107ef0f3fddff1a0b04fb9d7fbdfe151139acb40d8bb238c6d5e9fcea3a53495e916c28a28a002beecfd9c62b5d4be1c689afdce8161a75ff966349a050be60195dd81d095e7f1af84eaf47e22d7608ed22b7d67518e3b27df6a8b72e1606ce728338539f4c57859e60258ea3c919599ad1aaa9bbb47b27ed7b27816c3c6d2e93e1fd124b6f11a4c2e755bc562b0bf988240a13a163bc316e31d39c9c7833b333126b4fc51e20d67c4faccbac6bda84b7f7f285579a4c02428000c0000c01dab2a8c151950a31a727768cead4e7770a28a2ba8cc2bd4bc0300b6f04412636cb77792cc4f3f346a1113f2612fe66bcb941660057b0e870343e08f0d312ac25b19586d18ff0097bb81cfaf20d77e5d18cab2e63cdcce4e34343af8bc5dfda1611e9be2fd322f10dac69b219a5731de40be8938c9c0ce76b061ed5e4ff1793444f105b69be1abebeb8b26884d2addc4a9242e49f9095243600077003ef74ab1aaf8c2d6d2f1ed6dad5eedd090c55b033edc1cd71f25e49a96b7737d347e5bb003675da381fc8573e738ba1183a7425eaba1c397e1aa2973d45e8580a02855e001814ea295002ea0f738af943d6246876da891fef120fd05731770982e5939c672a4f715dadca6e89d47a71f5ae7b5683cc83cc51f3273f854cb62e9caccfd01f8528c9f0b7c268e0865d16cc11e844095c87c57f04e97e29bc92cafa0c4ae37db4e9c491b11d8f7c91d3a1fd6ba0f81daedaf887e13f876fed187eeec63b69573cac91288d87e6b91ec456978d226416b791f0d1b6dcfea3f91af9ead29426da3ed30d18ce093dac7c69e2ff0ceafe14d43ec9a9c5be076220bb41fbb947fecadec7ffaf58aea5864704722beccf1df87ac354d399ae2ce3b8d3ef141963619009e41f6ebc1ec6be6cf1ffc37d4fc3b33de6911cda86939c9006e96dfd881f797dc7e38efe8e171ca5eecf73cbc5e5ee1ef4354710a4119a3029892c6fcab29fc69e41c100e0fad7a49a6794d35b851c536262c086e1c7045358949b3fc0dc37b1f5a6224a28a295c06b8dcca3b0e69d4d79114e0b0cfa77af5af857f04f5af13b47a9789527d1f473c88986db9b81ec0fdc5f73cfa0e7359d4ab182bb35a746751d92386f02784758f1a6b51e9ba520488b859eee407cb8477ff0079b1fc23ff00af5f55695e05d0fc15f0fefb4bd22126468b7dc5cc9832dc329ce58fb7381d07e75a1e1cd1f4bd2f588f4bd1eca2b3b0d3e1db1c718c0c9ea4f724e4e49e4e2ba2d6a3f3747bd8fbbdbbaffe3a6bc7ab8a755e9b1eed0c1c68abbdcfccfb8530ddba839d8e403f435bb23ec5dc7eee403f4aabe21b368fc5fa8d9b0e62bc951bfe02e41a975170b64f9f4c57b107a1f315d7bed1b162dbe02a79c1c7e1585718b4d42456e12439fa1ff3fceb6b4c56fb3ee6ee7fa5665c9597526460194c64f3df27ff00ad5bd2aae9c94919d39384ae779f06bc07e26f17789ec6e747d35e5b2b4bb8e4b8b893e5880560c5727a9c761ea338afb67c67e09f0cf8c6c2dacbc4ba5c57ab6ccad19c9565200e8c39c1c74ef5f14fc29f8ade2cf85dbadb4f58f51d0e693cc92ca6fe138e4a3755e9eff4ef5f5de97f173c0d7df0f9fc6abacc22c21451731af334329ff96663ea1b3d3d472091cd781c4188c7d7ab19515f71ede16b539af78f9fff006c1d2fc1be1aff00847fc3be1dd0ecb4fbd5592e667b78f6b7967e550deb9209fc3debe7bafa33f69bf1cfc31f1e785adaf743d465b8d76d26090e6d5e32d19fbc18b01c77fa8fad7ce9dabee320757ea715553e6eb738f116e7d04a28a2bda4ac62145145300a29402697217eef5f5a4d8587050bcb9fc3bd35db771c63d293926928b5f70bf618d10ed4d319f5cd4b4564e8c589a41451456c30a28a64af8e2a273515a8b61247c702a2a3ad15c339b93b921453e668dcaf97194c280d96ce4f73edf4a654882942963c53dda499c176dcc1428fa0000fd050ec106d53f53ebffd6a1798d016da36a9fa9af504bb7b5f87be17bc4937451e9f711b0238575bcb862bf93a9ff815795d6f49e236b9f02d978463b45f321d467bb6bb2e73e5c89128880e980d196fa9e31ce5ac62c37bcce5c551f6d148a1a52e62790e72ee79f6ff0039a8d098f576527fd62ff4ff00eb55c890468a83a0aa1aaab23c370bd54e3fa8feb5f3736e4dc8a89a740243061d8e69b138923571d186453a824d60c19430e8466b36ee2f2e4e3ee3722a4b59fcbc237ddfe556e5459632a7073d0d488eeff666f88abe05f15bf87b589c47e1fd5a4056473f2db4fc05727b29e15be8a7b1afaefc436ff69d1ee13192abbc7d473fd2bf3caf6d83a34328e4743e87d6be9bfd95fe2a7f6c58a780fc4738fed4b48f6d84ae7fe3ea103ee64f5651f9affba6bccc6e1f997323dfcaf1b66a123db3c3de5ddf87e38a550ebb4c6ca7d013fd31598fe1590dc3edba458739525496fc4568f862336e979664e7c9b838fa10315b15e528df73e81cecf4382d67e157843558667d4349b7baba753fbdf2c46c5bb64ae1bf5ae2b4ef82df0ef5526d5edf52d3ae97a082edb0dd7fbe1b9e7a7b7d6bdc6b9cf11e8d2bce6fec57327de755e1b3ea3deb5f6b521aa662e8d3a9a491e6b71fb36f8518016de20f10c67bf99244ff00c905507fd9b34cf3005f12ea263cf2484071f4db5eb9a378855b16da97eea5071e611807ebe86ba0565750ca4107a107835a2c5547d4c9e0a9c774789c3fb37784867cfd7bc42e4f4d934498fce335ab63fb3ffc3b81819edf52bd00f227bd600ffdf1b6bd628c53789a8fa8961692e872fe1cf87de0af0eca9368fe1ad3ade6439499a2f3255fa3be587e75d2cceb144f2b70a8a589f4029c062b23c5539874878d73ba66083f99fd056339b7ab66f4e9c62ec887c248cf15d5fc9f7ae25fe5ff00d73fa551f8a7e37d17c09e179b54d5a40f248ad1da5a29fde5cc98e147a0f53d00fc01a7e3cf1c681f0cfc2705c6af2f9976c856d6ca223cdb993a90076504f2c7819f5201f8dbc73e2ad6fc6be229b5dd76e03ccdf2c1029fdddb479e2341e9ea7b9e4d74e130ae7abd8e1cc31d1a4ad1dcc49a49aeafeeb51ba0a6e6ee669a5206002cc5881ed93546f5fcebb8ad93955397ff003fe7ad3efef7c91e545cc87ff1da9b42b261219661976e4e6bd9b5b447cc49b6f999aea3c9b5ce790b9fc6b0ad4893509e4feee147f9fc2b575ab9105a1f5ebfe1599a54652d0330f99ceee6a895b1a967203fb971953d3daa96aba73c61a6b62573c951d0fd6a4190c181e95ab2289222a7a1154b47712935b1cb432074cf43dc5483ad32e13c9d45907471bb1fe7e94eafa8c0d7f6b4933aa2eeae14514a012702bb8a13ad2e38c938a0103a7341249c9a4980a5bdb8a6d145300a28a2800a28a2800a28a2801b236d1506727269f3125f15bb6be0ef10dcf82aebc630e9ecda35accb0cd396030cc40040ea4648191dcfd6bccc46223195a4ec4d9bd8e7e8a28a090a5505880393da907269cf2a440ae72dfc47d3daa6538c7761b0f660abb57af73eb5154666cb61559aa48e2ba7385b76ff0081715cf2c6535d41c8665de4114409635ab636ab6f163ab9fbcd51e9b04902bb498dcc7d6add7935aaba8eecc672bec2818a8aea212c2e84f51c7b1a9a8acec4a763374998ab35ac870ca78cfea2b4ab3f52b7627ed30e43a7271d7eb53595cadcc6093871f787f5a91c95f52d54f6d72633b1ce53f9541455925fba89664dcb82c071ee2b3375d5addc1a8584cf6d7b6ae24826462acac39183f5ab76b3f967639f93f95497b0e479b18073c9ff001a96931c24e2ee8fac7f67af8ab61e3db392d35074b6f1243127daa03c0b8dbc19507bf195ec7db15ebbed5f9c96b737fa46ab6fade8d70f6ba85a48258a48fae47f3fa1e08e0d7dbff047e21d9fc46f0747a9a7970ea36e445a85b29ff57263ef01d76b751f423a835e462b0dc8f9a3b1f4b80c6fb65cb2dcef28a28ae13d4209ed2d67399ade290fab20269d6f6f0dba9582248d7d1462a5eb45164176145145001dabc9fe3d7c44b3f050b62b125e6a7b4b5a5a336159ff00bef8e422f04faf418ce47a1f8b75fd37c2fe1cbdd7b579c4367671191ce7963d95477627000ee48af837c7fe2cbcf1578a2fbc4bac36d9ee9bf77006c88231f7235f603193dce4f7aebc361fdabbbd8f3f1b8cf631b47722f126b7aaf88f5a9f5cd7af9efafa6fbf2bf015474551d1547a0ae7eeef5a56f22d4124f1b875fc3fc69a7ed57eff002feea1f7e87fc6b56c34d5890003683d49ea6bd84acac8f9a9c9b7796e54d3b4fd8c19b2f29ffc76b6d425ac1f31e7afd4d35e58ad97620cb7a7f8d626a5a83bc9e54277c8c7191fc35467f111ea52bdf5f0815b2a0e5f1dbffd557e3002ed1c0c62ab69f6c208f2dcc8c3e63fd2add090e4fa044a6491547735afdbd8552d3e2e4ca7e82a2d6af96d602a082edd050d9295cc9d59d45fa3e41eb9fc69296188359bb4d9324c723d73da9cd15ca228548a4da31900ab1faf6af4f2fc6c68de32378492d18839a09c703a542d3143896378fea38a72c88ff7581af729e2a94f666bcc98ea28a2ba534f6185145140051451493b80514514c028a28a00ddf86ba84fa6fc42d1ae20b0b5d41daee387ecd7281925de7660e7a7dee0f638afd09bad0fc3afe18bbd1eef4ab3fecb784b5d59841b76fde3f28f71c63b8afcd62cd1ca24462aca41520e0822b6b4af1b78b749bdbbbeb1f116a30dcde4461b995a72e654208c36ece7a9c1ea33c57c8675954b1738c94ad636a15d524d3433c7979e1cbff15df5df84f4ab8d2b46771f66b69e5f31d540009279c64e4e32719c64e2b019803b40258f000a7c714d390225217bb915a36d6d140a303737763d6b79627d9c1422ef639273572a43612c8374cfb01fe15eb56e3b2b78c7faa0c7d5b9cd4d8a7119ae294e53d598b93622285185000f414ea28a448d6c8e579f51eb48aea46579069f50bc6d9dd1b6d6f71c1fad2026a2abadc056db30f2cfa9e87e86a753914c00f359f7568e920b8b43871d57d7fcfa568d149ab8d3b15ed2e927047dd907de53c558a867b78e5218e55c74653834b1798bf23956f461c7e6292b83b0fab16b70626dae4953fa543453b089eea00bfbc8f953d71dab4fe1af8d753f871e3383c41a7869ace43e5dfdae7e59a22791ec7b83d8fb120e55b5c18be56e54f51525c5b47326e88860472beb5124a4accd29d474e5747df5e12f10e93e2af0fda6b9a2dd2dcd9dca06523aa1eeac3b30e847635adc57c15f0bfc7be22f86bac9b9d218dd69b330377a6cac424a3d41e76b63a30fc7238afb23e1b7c42f0cf8ff004bfb66857a0cc8a0dc59cb859e03e8cbe9fed0c83eb5e3e230d283bad8fa7c263a15a367b9d6d14515c877854577716f696b2dd5dcf1c10428649259182aa28192c49e0003bd3dd963467760aaa324b1c003d7d2be49fda2fe2d3f8cae64f09f866e58787e17c5d5cc67fe3f9c1fbabff4cc1ffbe8f3d00ade851954765b1cb89c4c68c6ef731bf68ef8acfe3dd75345f0f3b3681a7b96490e545ccdd3cc23fba06768ebc927a803cbecf4bf31bcd94f9addd9ba7e5572de082dd079981e883fad3e5beda87661147727a57b74e0a0ac8f96ad5a5565cccb090c16cbb98f3d89ebf8553d435348811bb6ff00e846b367be9ae1cc76cace4f573d296dec1436f9dbcd73d73d2aee6565d480c9777d9112f9511ea7d7fc6ae5a59c76e38f99fbb54fc2f41c52919a121362d3e085a57f451d4d3a081a5e7a2773534d7315bc456152cc07000a6485fddc56106723207ca0573d0a4b7f706e6e3fd5839e7bfb5596b796ea7335db67d101a57ccf27d9a33b624ff5847f215268b443e02657f38f08388c7f5ab3f9535381800003a014eaa20902c0fc3129efd454336911c83722a1cf4287146df7a9124743946228bb5b05da33e5d36e213fbb91b1d838e3f3aaeef2c3febe2603fbc3915d0c77838122f3ea29d225ace0805413ef8ae9a78bab4f665aa8d1cfa3ab8ca90696ad5fe9250996dc853d46de9ffd6aa31c84b18e41b241d47ad7b384cc6357dd968cda334c929692afc7a36ab2e892eb71e9f72fa6c328824ba58c98d24233b4b7407047e63d457a32a9182bc99a2bbd8a1451455c64a4ae8028a28a605dd1f4f8752bc6b69b51b5d3c79323acb7258216552c13201c162303b648aa1a7dbace5a5946e556c2af6fad3892013ed53e9836d9271c9c9fd6bc1cd5b4d58caa3b22c9505769aaed29b79824c731b70ae7b1f4356aa29a2596331b7423f2af16e60992f1da8aa36333231b59b874fba7d455d2714d31356168a28a6014514500359430c1c107a8238aac6d8c7cdbc863ff0064f2bffd6ab74520b953ed4d1b6db94319ecc3953fe156a268d8677601efd45232ab0c10083d411c5556b568db7dac8633dd49ca9a571e868791211b970ebeaa6a320838208fad538af9e170b70ad0bf40c3a1ad28af03a00e16453d0d17135621a2ad88ade603cb6da7d2a292d655fba0381e9540434f865789b2a78ee298410704628a405d5782e5402006fd69b672ea3a2ea90eafa4decd657d036e8ae606daca7dfd41e841e08e2a9818a9e0ba64e1fe64ef9a9767b8e32707747d5df00fe3245e352be1ef10ac569e238e3263641b63be503964feeb81d57f11c640f5ed42eed6c6ca6bdbdb88ededade3692596460aa8a064924f40057e79f99359dddbea3a6dc3dbdcc122cb6f34670d148a7208fc6bd6fe2e7c6093c79e08d0340b26fb3cb75109f5e44e007462a211fecb3297c7a6cf7af3aae0ef34e3b1eee1f32fdd3e6dd09f1abe335ff8da19f41f0d0974ef0e31293dcb12b35eafa63f8233fddea475c0256bc79e6585765b46c7031b8607f3e9525c4bb98220c46bc002a32335df4e9469ab23c8ad5e55a579155daf589d8b147fef124d345919087b995a5f45e8055da2ad98b90d8d11142a2855f4029d4515420ef8009a7a6c5c33fcc7fba0ff003a6514807bdc4920dbc2afa0a65559ef60886376f6f45a8b65cddffac1e4c47f847534ae34874b3b4ae60b66e7f8dfb28ab16f12c29b14703bfad2c30a44812300015250903614514550828a28a401c77aa8f72cf298add0391f7989c28a351b8f261210fef1f85c7f3a7d94221b754efd58fbff009e29363b771d12ccdcc922fbaa8fea6a2d4a012c45d47ef13907dbd2ad00052d5276d413b1996acb305dce1327049e83df8afbcbe00f867c19a67c327d2342d6ad3c516371399afa5654646959141531f3b46157e56c9af82215f2ee26840e8dc5765e0ff883e24f0a786b5cd0745ba5b783595459e400f991edc83e5b03c16048279e3a60f35dd9860eb665848aa72b347a386ab183bb47a27ed8f677f6df116cda5b1b7b6d30d8aa69e6140aacaa7e6e80742c38e9823debc3eac5dde5ddd95377753dc1518532c85b1f4cd57af730387961e8469c9dda22a4b9a5741451457612365ff54ff4abd68a05a4407f705519d49b7908e80735a48bb6355f418af9ecda5efa4615741d451457946250d5616da2e23e1e3e491e9562d265b880483827861e86a62158107907ad65db93657e6127f77274fe9fe150ca5aa3568a28ab2428a28a0028a28a0028a28a006ba248bb5d4303d8d527b3789b7da4a50f5284f06afd191eb49ab8d3b1416fda37d9731346dfde157a0d4908f96e1187a31c7f3a6ba2b8c3a861e8466ab49a7db3e48464ff0074d4ea3d19a9f6a491712c21bdc1a630b661f2bbc67d0f22b23fb3307314eebf8521b4be43f2dd03ec58d01ca8d46423eeb2b7d0d31ce1492400064d6714d517a48ac3ea3fad437925fa425671856e33c7f4a2e0a05ab1b99a59e4192d0e4e1b18c629ba7ddaff00694fb4e04a081f8554863be7b609129f2cf71819a9db4d2201b1bf7c39ebc1a45d92245be99aec41e48524e304f35a3582f2cb15dac93a12ebd8f19ab7fda33b7faab627f3354992e3d8d2c7bd348c566f9ba9ca3e58c20ff771fce97ec77b2ffadb9007a6e2690b97bb341e58a3fbf228fa9c54126a16abff002d0b7b28a863d2a11cbc8eff004e05598eceda3fbb0a7fc0b9fe745d85a2556d42494edb7b72dee68fb35e5c0ff489f62ff747ff005ab43200c0fc853a84ae1cdd8ad6d690423e44cb0fe26e4d59a28aa26f70a28a2980514514005359c2a9663800649f6a75676b131c25b47cb3f5c7e952d8e2aec8ecc35e5db5c3e42270a0fe95a8062a1b480436eb18ea073ee6a7a6824eec28a28a62326e323546ff006803fa5494cd432351438ea9fd4d3ebe832977a6d1d34f60a28a2bd6343fffd9, 'image/jpeg', 'Magyarország', '36', '303390610', 'Hódmezővásárhely', '6800', 'Beöthy u. 11.', 'kertesz.istvan-e2022@keri.mako.hu', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-11 06:07:07', NULL, '2023-10-25 15:37:27', 0, 1, '');
INSERT INTO `users` (`id`, `user_role_id`, `last_name`, `first_name`, `born`, `gender_id`, `img`, `img_type`, `country`, `country_code`, `phone`, `city`, `postcode`, `address`, `email`, `password`, `created`, `modified`, `last_login`, `wrong_attempts`, `valid`, `verification_code`) VALUES
(2, 1, 'Joó', 'Mária', '1968-09-05', 2, NULL, 'image/webp', 'Magyarország', '36', '308061386', 'Makó', '6900', 'Bajcsy-Zs.ltp. A/2.', 'joo.maria-e2022@keri.mako.hu', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:12:48', NULL, '2023-09-26 21:17:36', 0, 1, ''),
(3, 1, 'Hevesi', 'Szabolcs', '1992-06-12', 1, NULL, 'image/jpeg', 'Magyarország', '36', '702301503', 'Szeged', '6725', 'Rábéi u.9.', 'hevesi.szabolcs-e2022@keri.mako.hu', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:17:14', NULL, '2023-09-24 17:13:25', 0, 1, ''),
(4, 2, 'Kovács', 'Gábor', '1980-01-15', 1, NULL, NULL, 'Magyarország', '36', '123456789', 'Csongrád', '6640', 'Kossuth utca 12', 'kovacs.gabor@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '2023-10-09 16:09:51', 0, 1, ''),
(5, 2, 'Tóth', 'Zsuzsanna', '1995-03-20', 2, NULL, NULL, 'Magyarország', '36', '987654321', 'Szeged', '6720', 'Petőfi utca 8', 'toth.zsuzsanna@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '2023-10-15 16:00:24', 0, 1, ''),
(6, 2, 'Szabó', 'András', '1987-07-10', 1, NULL, NULL, 'Magyarország', '36', '234567890', 'Hódmezővásárhely', '6800', 'Rákóczi utca 15', 'szabo.andras@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(7, 2, 'Horváth', 'Katalin', '1976-11-25', 2, NULL, NULL, 'Magyarország', '36', '345678901', 'Makó', '6900', 'Jókai utca 3', 'horvath.katalin@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(8, 2, 'Kiss', 'László', '1990-04-30', 1, NULL, NULL, 'Magyarország', '36', '456789012', 'Szentes', '6600', 'Ady Endre utca 7', 'kiss.laszlo@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(9, 2, 'Nagy', 'Mária', '1985-08-05', 2, NULL, NULL, 'Magyarország', '36', '567890123', 'Csongrád', '6640', 'Dózsa György utca 20', 'nagy.maria@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(10, 2, 'Kovács', 'Péter', '1973-12-18', 1, NULL, NULL, 'Magyarország', '36', '678901234', 'Szeged', '6720', 'Bajnai utca 10', 'kovacs.peter@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(11, 2, 'Tóth', 'Anna', '1988-06-22', 2, NULL, NULL, 'Magyarország', '36', '789012345', 'Hódmezővásárhely', '6800', 'Petőfi Sándor utca 5', 'toth.anna@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(12, 2, 'Szabó', 'István', '1977-09-12', 1, NULL, NULL, 'Magyarország', '36', '890123456', 'Makó', '6900', 'Kossuth tér 1', 'szabo.istvan@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(13, 2, 'Horváth', 'Zsófia', '1993-02-08', 2, NULL, NULL, 'Magyarország', '36', '901234567', 'Szentes', '6600', 'Rákóczi tér 6', 'horvath.zsofia@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:43:41', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(14, 2, 'Kiss', 'Ferenc', '1982-09-14', 1, NULL, NULL, 'Magyarország', '36', '345678901', 'Csongrád', '6640', 'Kossuth utca 25', 'kiss.ferenc@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(15, 2, 'Nagy', 'Éva', '1989-03-02', 2, NULL, NULL, 'Magyarország', '36', '456789012', 'Szeged', '6720', 'Petőfi utca 12', 'nagy.eva@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(16, 2, 'Tóth', 'György', '1983-07-08', 1, NULL, NULL, 'Magyarország', '36', '567890123', 'Hódmezővásárhely', '6800', 'Rákóczi utca 9', 'toth.gyorgy@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(17, 2, 'Szabó', 'Ildikó', '1992-12-01', 2, NULL, NULL, 'Magyarország', '36', '678901234', 'Makó', '6900', 'József Attila utca 6', 'szabo.ildiko@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(18, 2, 'Kovács', 'Pál', '1975-05-20', 1, NULL, NULL, 'Magyarország', '36', '789012345', 'Szentes', '6600', 'Bajnai utca 5', 'kovacs.pal@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(19, 2, 'Takács', 'Zsolt', '1997-10-10', 1, NULL, NULL, 'Magyarország', '36', '890123456', 'Csongrád', '6640', 'Dózsa utca 10', 'takacs.zsolt@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(20, 2, 'Varga', 'Judit', '1984-04-17', 2, NULL, NULL, 'Magyarország', '36', '901234567', 'Szeged', '6720', 'Rákóczi tér 2', 'varga.judit@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(21, 2, 'Molnár', 'Lajos', '1991-08-22', 1, NULL, NULL, 'Magyarország', '36', '012345678', 'Hódmezővásárhely', '6800', 'Petőfi Sándor tér 1', 'molnar.lajos@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(22, 2, 'Farkas', 'Mónika', '1978-01-03', 2, NULL, NULL, 'Magyarország', '36', '123456789', 'Makó', '6900', 'Kossuth tér 8', 'farkas.monika@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(23, 2, 'Balogh', 'Ferenc', '1994-06-12', 1, NULL, NULL, 'Magyarország', '36', '234567890', 'Szentes', '6600', 'Rákóczi tér 5', 'balogh.ferenc@example.com', '$2y$10$/AYGAbH1sQoN8UJpGSJ7n.68yQO8FZz.8pY0XZtPaBrxL8pBmPgBm', '2023-09-24 15:45:08', NULL, '0000-00-00 00:00:00', 0, 1, ''),
(24, 2, 'István', 'Kertész', '1983-06-24', 2, NULL, NULL, 'hungary', '36', '303390610', 'Hmv', '6800', 'Beöthy u. 11.', 'pityi@gmail.com', '$2y$10$JK8oLnm7CiVk7K1sgyha9OIlSQ6oTjh/17oGuM38FjzQuXkaEs36y', '2023-10-16 08:45:28', NULL, '0000-00-00 00:00:00', 0, 1, 'bf20b4c721d962df1ef56eedf84826c6'),
(25, 2, 'Tomi', 'K', '1985-02-05', 2, NULL, NULL, 'HUNGARY', '36', '2255565', 'Hmv', 'Hmv', 'nemtudom', 'hjk@hjk.hu', '$2y$10$gUm1vKxH83IqdRd.3JQICOeaTrMuGwIGZicXG5sHQTXPGmYmJVRlO', '2023-10-16 08:52:25', NULL, '0000-00-00 00:00:00', 0, 1, '05ec77f7e351f1e5e82013b315056f0f'),
(26, 2, 'Orsolya', 'Kőhegyi', '1980-12-13', 1, NULL, NULL, 'HUNGARY', '36', '20819778', 'Hmv', '6800', 'Hattyas u. 12', 'orsika@freemail.hu', '$2y$10$OLSdPaGliv/eGPIOfdoc4.QgyH4KkjdhUOQxXBarTtXY.H8aHfFAm', '2023-10-16 08:56:15', NULL, '0000-00-00 00:00:00', 0, 1, '103002ad0f5b5dcb86bb287439d233bd'),
(27, 2, 'kk', 'jkjk', '1990-05-07', 2, NULL, NULL, 'ARGENTINA', '54', '552422247', 'hkk', '555s', 'dsfk', 'kk@jj.hu', '$2y$10$6FigSzkArA7VZhFeQIWmFu.4eYDWRblQko0YK7RcDf9eYMEVgTSKS', '2023-10-16 09:38:58', NULL, '0000-00-00 00:00:00', 0, 1, 'e265f00b335e266186baba56edb2388f'),
(28, 2, 'fgdh', 'ztr', '2005-09-21', 2, NULL, NULL, 'ANTIGUA AND BARBUDA', '1-268', '22255555', 'éoloőo0', '56554', 'lkfdlé', 'jj@jj.hu', '$2y$10$./8nfB/YnFznmtOmwX6Mv.bkZ0V0So1bQwYO2NLzrBtcOpOIouVhW', '2023-10-16 09:41:46', NULL, '0000-00-00 00:00:00', 0, 1, '30d6cca323131ebd49eb530b13762178'),
(29, 2, 'dsf', 'dfs', '2005-09-27', 2, NULL, NULL, 'CYPRUS', '357', '564565465', 'hgfghg', '5', 'fdgfd', 'kk@kk.ji', '$2y$10$vcPhHxOrn8XpOZdeBhTox.hgeNi4q71u3zqN7UpZREHaTu4.ZIWiW', '2023-10-16 09:44:15', NULL, '0000-00-00 00:00:00', 0, 1, '538dc86516896fff032ff6fd8cfc3f25');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `user_roles`
--

CREATE TABLE `user_roles` (
  `id` int(1) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `user_roles`
--

INSERT INTO `user_roles` (`id`, `name`) VALUES
(1, 'administrator'),
(2, 'user'),
(3, 'guest');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `dishes`
--
ALTER TABLE `dishes`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `dish_categories`
--
ALTER TABLE `dish_categories`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `event_places`
--
ALTER TABLE `event_places`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `event_types`
--
ALTER TABLE `event_types`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `genders`
--
ALTER TABLE `genders`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `menu_dishes`
--
ALTER TABLE `menu_dishes`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `dishes`
--
ALTER TABLE `dishes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT a táblához `dish_categories`
--
ALTER TABLE `dish_categories`
  MODIFY `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT a táblához `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `event_places`
--
ALTER TABLE `event_places`
  MODIFY `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `event_types`
--
ALTER TABLE `event_types`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `genders`
--
ALTER TABLE `genders`
  MODIFY `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT a táblához `menu_dishes`
--
ALTER TABLE `menu_dishes`
  MODIFY `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT a táblához `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT a táblához `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` int(1) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
