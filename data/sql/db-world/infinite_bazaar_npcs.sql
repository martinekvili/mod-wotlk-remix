-- Add creature templates
SET @StartCreatureTemplateEntry = 210000, @CreatureTemplateCount = 2,
  @TrainerId = 200,
  @StartGossipMenuID = 80000, @GossipMenuCount = 2;

DELETE FROM `creature_template`
WHERE `entry` >= @StartCreatureTemplateEntry
  AND `entry` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `creature_template`
  (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
  (@StartCreatureTemplateEntry, 0, 0, 0, 0, 0, 'Onoznos', 'Innkeeper', '', 10201, 80, 80, 2, 35, 65537, 1, 1.14286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 8, 32768, 2048, 0, 0, 2, 4096, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'npc_innkeeper', 0),
  (@StartCreatureTemplateEntry + 1, 0, 0, 0, 0, 0, 'Demdorrius', 'General Class Trainer', '', @StartGossipMenuID, 80, 80, 2, 35, 49, 1, 1.14286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 8, 512, 2048, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 0);

-- Set creature template models
DELETE FROM `creature_template_model`
WHERE `CreatureID` >= @StartCreatureTemplateEntry
  AND `CreatureID` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `creature_template_model`
  (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
VALUES
  (@StartCreatureTemplateEntry, 0, 20515, 1, 1, 0),
  (@StartCreatureTemplateEntry + 1, 0, 20513, 0.4, 1, 0);

-- Set general trainer info
DELETE FROM `trainer`
WHERE `Id` = @TrainerId;

INSERT INTO `trainer`
  (`Id`, `Type`, `Requirement`, `Greeting`, `VerifiedBuild`)
VALUES
  (@TrainerId, 0, 0, 'Welcome!', 0);

DELETE FROM `creature_default_trainer`
WHERE `CreatureId` = @StartCreatureTemplateEntry + 1;

INSERT INTO `creature_default_trainer`
  (`CreatureId`, `TrainerId`)
VALUES
  (@StartCreatureTemplateEntry + 1, @TrainerId);

-- Set general trainer gossip
DELETE FROM `gossip_menu`
WHERE `MenuID` >= @StartGossipMenuID
  AND `MenuId` < @StartGossipMenuID + @GossipMenuCount;

INSERT INTO `gossip_menu`
  (`MenuID`, `TextID`)
VALUES
  (@StartGossipMenuID, 9006),
  (@StartGossipMenuID + 1, 14391);

DELETE FROM `gossip_menu_option`
WHERE `MenuID` >= @StartGossipMenuID
  AND `MenuId` < @StartGossipMenuID + @GossipMenuCount;

INSERT INTO `gossip_menu_option`
  (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
  (@StartGossipMenuID, 0, 0, 'I wish to unlearn my talents.', 62295, 16, 16, 4461, 0, 0, 0, '', 0, 0),
  (@StartGossipMenuID, 1, 0, 'Learn about Dual Talent Specialization.', 33762, 20, 1, @StartGossipMenuID + 1, 0, 0, 0, '', 0, 0),
  (@StartGossipMenuID + 1, 0, 0, 'Purchase a Dual Talent Specialization.', 33765, 18, 16, 10373, 0, 0, 0, 'Are you sure you wish to purchase a Dual Talent Specialization?', 0, 0);

-- Add creature spawns
SET @StartCreatureGuid = 2100000, @CreatureCount = 2;

DELETE FROM `creature`
WHERE `guid` >= @StartCreatureGuid
  AND `guid` < @StartCreatureGuid + @CreatureCount;

INSERT INTO `creature`
  (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
  (@StartCreatureGuid, @StartCreatureTemplateEntry, 0, 0, 571, 0, 0, 1, 1, 0, 5699.23, 287.379, 575.638, 1.12958, 300, 0, 0, 10080, 8814, 0, 0, 0, 0, '', NULL, 0, NULL),
  (@StartCreatureGuid + 1, @StartCreatureTemplateEntry + 1, 0, 0, 571, 0, 0, 1, 1, 0, 5693.51, 293.751, 575.638, 1.01839, 300, 0, 0, 10080, 8814, 0, 0, 0, 0, '', NULL, 0, NULL);
