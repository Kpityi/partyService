-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2023. Nov 07. 21:34
-- Kiszolgáló verziója: 10.4.28-MariaDB
-- PHP verzió: 8.2.4

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
-- Tábla szerkezet ehhez a táblához `ratings`
--

CREATE TABLE `ratings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) NOT NULL,
  `rating` int(1) NOT NULL,
  `rating_text` text DEFAULT NULL,
  `rating_answer` text DEFAULT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `ratings`
--

INSERT INTO `ratings` (`id`, `user_id`, `rating`, `rating_text`, `rating_answer`, `date`) VALUES
(1, 1, 5, 'A PartyService mindig megmenti a napomat! A legutóbbi születésnapi bulim káprázatos volt, köszönhetően az elképesztő dekorációknak és a segítőkész csapatnak. ', 'Köszönjük szépen az értékelést!', '2022-09-08'),
(2, 10, 4, 'Az esküvőnk a PartyService segítségével igazi álom volt. Minden részletre odafigyeltek, és a dekoráció gyönyörű volt!', NULL, '2021-05-13'),
(3, 18, 5, 'Nagyszerű élmény volt együttműködni a PartyService csapatával a cégem éves rendezvényének szervezésekor. Profik az utolsó pillanatig!', NULL, '2023-06-06'),
(4, 9, 5, 'Csak a PartyService-ben bízok, ha egy különleges partit szervezek. Kiváló termékek és fantasztikus szolgáltatás minden alkalomra!', NULL, '2022-08-19'),
(5, 11, 5, 'Nem találhatnék jobb partiszervizt Magyarországon. A PartyService mindig új és izgalmas ötletekkel áll elő, és segít megvalósítani az elképzeléseimet.', NULL, '2019-10-21'),
(6, 15, 5, 'A PartyService hűséges ügyfeleként azt kell mondanom, hogy mindig a legjobbat kapjuk. A termékeik minősége és az elképesztő kreativitásuk garantálja a sikerünket. Mindig bízom bennük, hogy minden részletre odafigyelnek, és a rendezvényünk minden elvárásunkat felülmúlja.', NULL, '2022-05-29'),
(7, 6, 5, 'Egyszerűen nem tudom elképzelni egy rendezvényt a PartyService nélkül. Minden alkalommal meglepnek a szakértelemmel és az odaadással. A csapat mindig elérhető, hogy megoldást találjon az összes kihívásra, és garantálja, hogy a buli tökéletes legyen minden szempontból.', NULL, '2023-06-08');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
