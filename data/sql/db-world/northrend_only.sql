DELETE FROM disables
WHERE `comment` LIKE 'WotlK Remix - Northrend Only:%';

-- Disable all external maps outside Northrend
INSERT INTO disables
  (`sourceType`, `entry`, `comment`)
VALUES
  (2, 0, 'WotlK Remix - Northrend Only: Disable map - Eastern Kingdoms'),
  (2, 1, 'WotlK Remix - Northrend Only: Disable map - Kalimdor'),
  (2, 530, 'WotlK Remix - Northrend Only: Disable map - Outland');

-- Disable all Battlegrounds
INSERT INTO disables
  (`sourceType`, `entry`, `comment`)
SELECT 3, `ID`, CONCAT('WotlK Remix - Northrend Only: Disable BG - ', `Comment`)
FROM battleground_template;

-- TODO: Disable all Dungeons outside Northrend

-- Disable all game events
INSERT INTO disables
  (`sourceType`, `entry`, `comment`)
SELECT 9, `eventEntry`, CONCAT('WotlK Remix - Northrend Only: Disable Event - ', `description`)
FROM game_event;

-- Remove all portals teleporting outside Northrend
DELETE gameobject
FROM gameobject_template
INNER JOIN gameobject ON gameobject_template.entry = gameobject.id
INNER JOIN spell_target_position ON gameobject_template.`Data0` = spell_target_position.`ID`
WHERE gameobject_template.type = 22
  AND gameobject.map = 571
  AND spell_target_position.`MapID` <> 571;