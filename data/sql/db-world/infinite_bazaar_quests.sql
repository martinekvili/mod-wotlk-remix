SET @StartNpcTextID = 200000, @NpcTextCount = 1,
  @StartGossipMenuID = 80100, @GossipMenuCount = 2,
  @StartGameObjectTemplateID = 310000, @GameObjectTemplateCount = 1,
  @StartGameObjectGuid = 6000000,
  @StartCreatureTemplateEntry = 210100, @CreatureTemplateCount = 3,
  @StartCreatureGuid = 2100100,
  @StartQuestTemplateID = 40000, @QuestTemplateCount = 2;

-- Gameobject (map) starting Hero's Call and Warchief's Command quests
DELETE FROM `npc_text`
WHERE `ID` >= @StartNpcTextID
  AND `ID` < @StartNpcTextID + @NpcTextCount;

INSERT INTO `npc_text`
  (`ID`, `text0_0`)
VALUES
  (@StartNpcTextID, 'There are markings on the map, showing various areas where help is needed. Where will you focus your efforts next?');

DELETE FROM `gossip_menu`
WHERE `MenuID` >= @StartGossipMenuID
  AND `MenuID` < @StartGossipMenuID + @GossipMenuCount;

INSERT INTO `gossip_menu`
  (`MenuID`, `TextID`)
VALUES
  (@StartGossipMenuID, @StartNpcTextID),
  (@StartGossipMenuID + 1, 5819);

DELETE FROM `gameobject_template`
WHERE `entry` >= @StartGameObjectTemplateID
  AND `entry` < @StartGameObjectTemplateID + @GameObjectTemplateCount;

INSERT INTO `gameobject_template`
  (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `AIName`, `ScriptName`, `VerifiedBuild`)
VALUES
  (@StartGameObjectTemplateID, 2, 6743, 'Scouting Map', '', '', '', 1, 0, 0, 0, @StartGossipMenuID, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0);

DELETE FROM `gameobject`
WHERE `id` >= @StartGameObjectTemplateID
  AND `id` < @StartGameObjectTemplateID + @GameObjectTemplateCount;

INSERT INTO `gameobject`
  (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`)
VALUES
  (@StartGameObjectGuid, @StartGameObjectTemplateID, 571, 0, 0, 1, 1, 5707.12, 300.577, 575.638, 3.85482, 0, 0, 0, 1, 300, 0, 1, '', NULL, NULL);

-- Add creature template (Relocation Assistant)
DELETE FROM `creature_template`
WHERE `entry` >= @StartCreatureTemplateEntry
  AND `entry` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `creature_template`
  (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `scale`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`)
VALUES
  (@StartCreatureTemplateEntry, 0, 0, 0, 0, 0, 'Omdennos', 'Relocation Assistant', '', @StartGossipMenuID + 1, 80, 80, 2, 35, 1, 1, 1.14286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 8, 512, 2048, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 0),
  (@StartCreatureTemplateEntry + 1, 0, 0, 0, 0, 0, 'Valiance Keep Teleport Credit', '', '', 0, 1, 1, 2, 35, 0, 1, 1.14286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 0),
  (@StartCreatureTemplateEntry + 2, 0, 0, 0, 0, 0, 'Valgarde Teleport Credit', '', '', 0, 1, 1, 2, 35, 0, 1, 1.14286, 1, 1, 20, 1, 0, 0, 1, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, '', 0);

-- Set creature template models
DELETE FROM `creature_template_model`
WHERE `CreatureID` >= @StartCreatureTemplateEntry
  AND `CreatureID` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `creature_template_model`
  (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
VALUES
  (@StartCreatureTemplateEntry, 0, 19063, 1, 1, 0),
  (@StartCreatureTemplateEntry + 1, 0, 11686, 1, 1, 0),
  (@StartCreatureTemplateEntry + 2, 0, 11686, 1, 1, 0);

-- Set gossip
DELETE FROM `gossip_menu_option`
WHERE `MenuID` >= @StartGossipMenuID
  AND `MenuId` < @StartGossipMenuID + @GossipMenuCount;

INSERT INTO `gossip_menu_option`
  (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
  (@StartGossipMenuID + 1, 0, 0, 'Take me to Valiance Keep.', 26076, 1, 1, 0, 0, 0, 0, '', 0, 0),
  (@StartGossipMenuID + 1, 1, 0, 'Take me to Valiance Keep.', 26076, 1, 1, 0, 0, 0, 0, '', 0, 0),
  (@StartGossipMenuID + 1, 2, 0, 'Take me to Valgarde Port.', 22731, 1, 1, 0, 0, 0, 0, '', 0, 0),
  (@StartGossipMenuID + 1, 3, 0, 'Take me to Valgarde Port.', 22731, 1, 1, 0, 0, 0, 0, '', 0, 0);

-- Smart scripts
DELETE FROM `smart_scripts`
WHERE `source_type` = 0
  AND `entryorguid` >= @StartCreatureTemplateEntry
  AND `entryorguid` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `smart_scripts`
  (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
  (@StartCreatureTemplateEntry, 0, 0, 2, 62, 0, 100, 0, @StartGossipMenuID + 1, 0, 0, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 2232.2593, 5134.1562, 5.344251, 1.2258611, 'Omdennos - On Gossip Option 0 Selected - Teleport'),
  (@StartCreatureTemplateEntry, 0, 1, 6, 62, 0, 100, 0, @StartGossipMenuID + 1, 1, 0, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 2232.2593, 5134.1562, 5.344251, 1.2258611, 'Omdennos - On Gossip Option 1 Selected - Teleport'),
  (@StartCreatureTemplateEntry, 0, 2, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, @StartCreatureTemplateEntry + 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Omdennos - On Gossip Option 0 Selected - Quest Credit 'Hero's Call: Borean Tundra!'"),
  (@StartCreatureTemplateEntry, 0, 3, 5, 62, 0, 100, 0, @StartGossipMenuID + 1, 2, 0, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 589.83185, -5103.2397, 5.260744, 1.4313921, 'Omdennos - On Gossip Option 2 Selected - Teleport'),
  (@StartCreatureTemplateEntry, 0, 4, 6, 62, 0, 100, 0, @StartGossipMenuID + 1, 3, 0, 0, 0, 0, 62, 571, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 589.83185, -5103.2397, 5.260744, 1.4313921, 'Omdennos - On Gossip Option 3 Selected - Teleport'),
  (@StartCreatureTemplateEntry, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, @StartCreatureTemplateEntry + 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Omdennos - On Gossip Option 1 Selected - Quest Credit 'Hero's Call: Howling Fjord!'"),
  (@StartCreatureTemplateEntry, 0, 6, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Omdennos - On Gossip Option 0 Selected - Close Gossip');

-- Add creature spawns
DELETE FROM `creature`
WHERE `id1` >= @StartCreatureTemplateEntry
  AND `id1` < @StartCreatureTemplateEntry + @CreatureTemplateCount;

INSERT INTO `creature`
  (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`)
VALUES
  (@StartCreatureGuid, @StartCreatureTemplateEntry, 0, 0, 571, 0, 0, 1, 1, 0, 5704.34, 306.33, 575.638, 0.41273, 300, 0, 0, 10080, 8814, 0, 0, 0, 0, '', NULL, 0, NULL),
  (@StartCreatureGuid + 1, @StartCreatureTemplateEntry + 1, 0, 0, 571, 0, 0, 1, 1, 0, 5704.34, 306.33, 575.638, 0.41273, 300, 0, 0, 10080, 8814, 0, 0, 0, 0, '', NULL, 0, NULL),
  (@StartCreatureGuid + 2, @StartCreatureTemplateEntry + 2, 0, 0, 571, 0, 0, 1, 1, 0, 5704.34, 306.33, 575.638, 0.41273, 300, 0, 0, 10080, 8814, 0, 0, 0, 0, '', NULL, 0, NULL);

-- Quests
DELETE FROM `quest_template`
WHERE `ID` >= @StartQuestTemplateID
  AND `ID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_template`
  (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 2, 71, 68, 3537, 0, 0, 0, 0, 0, 0, 11672, 1, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1050, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1101, "Hero's Call: Borean Tundra!", 'Report to Recruitment Officer Blythe at Valiance Keep in Borean Tundra.', 'By order of his royal highness, King Varian Wrynn, all able-bodied citizens of the Alliance are to report to Recruitment Officer Blythe at Valiance Keep in Borean Tundra.$B$BThe Valiance Expedition needs your help to keep the forces of the Scourge under control and safeguard civilized lands!$B$BFor the glory and honor of the Alliance!', '', NULL, @StartCreatureTemplateEntry + 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Asked Omdennos for teleportation', '', '', '', 0),
  (@StartQuestTemplateID + 1, 2, 70, 68, 495, 0, 0, 0, 0, 0, 0, 11228, 1, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1101, "Hero's Call: Howling Fjord!", 'Speak with Macalroy in Howling Fjord.', 'All able-bodied citizens of the Alliance are to report to Macalroy in Howling Fjord. The port town of Valgarde is located in the heart of the Howling Fjord, and it allows for the Alliance to have an advantageous position to strike at the Scourge. Assist the soldiers stationed there. Glory to the Alliance!', '', NULL, @StartCreatureTemplateEntry + 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Asked Omdennos for teleportation', '', '', '', 0);

DELETE FROM `quest_template_addon`
WHERE `ID` >= @StartQuestTemplateID
  AND `ID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_template_addon`
(`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`)
VALUES
  (@StartQuestTemplateID, 0, 0, 0, 0, 11672, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
  (@StartQuestTemplateID + 1, 0, 0, 0, 0, 11228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `quest_offer_reward`
WHERE `ID` >= @StartQuestTemplateID
  AND `ID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_offer_reward`
  (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 113, 0, 0, 0, 0, 0, 0, 0, 'The expedition needs your help, $C.', 0),
  (@StartQuestTemplateID + 1, 0, 0, 0, 0, 0, 0, 0, 0, "What is it?!$B$BCan\'t you see I\'m already busy trying to get this port ready, $R?", 0);

DELETE FROM `gameobject_queststarter`
WHERE `quest` >= @StartQuestTemplateID
  AND `quest` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `gameobject_queststarter`
  (`id`, `quest`)
VALUES
  (@StartGameObjectTemplateID, @StartQuestTemplateID),
  (@StartGameObjectTemplateID, @StartQuestTemplateID + 1);

DELETE FROM `creature_questender`
WHERE `quest` >= @StartQuestTemplateID
  AND `quest` < @StartQuestTemplateID + @QuestTemplateCount;
  
INSERT INTO `creature_questender`
  (`id`, `quest`)
VALUES
  (25307, @StartQuestTemplateID),
  (23547, @StartQuestTemplateID + 1);

DELETE FROM `quest_poi`
WHERE `QuestID` >= @StartQuestTemplateID
  AND `QuestID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_poi`
  (`QuestID`, `id`, `ObjectiveIndex`, `MapID`, `WorldMapAreaId`, `Floor`, `Priority`, `Flags`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 0, -1, 571, 486, 0, 0, 1, 0),
  (@StartQuestTemplateID, 1, 0, 571, 510, 0, 0, 1, 0),
  (@StartQuestTemplateID + 1, 0, -1, 571, 491, 0, 0, 1, 0),
  (@StartQuestTemplateID + 1, 1, 0, 571, 510, 0, 0, 1, 0);

DELETE FROM `quest_poi_points`
WHERE `QuestID` >= @StartQuestTemplateID
  AND `QuestID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_poi_points`
  (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 0, 0, 2300, 5236, 0),
  (@StartQuestTemplateID, 1, 0, 5704, 306, 0),
  (@StartQuestTemplateID + 1, 0, 0, 593, -5089, 0),
  (@StartQuestTemplateID + 1, 1, 0, 5704, 306, 0);

-- Set conditions
DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 15
  AND `SourceGroup` >= @StartGossipMenuID
  AND `SourceGroup` < @StartGossipMenuID + @GossipMenuCount;

INSERT INTO `conditions`
  (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
  (15, @StartGossipMenuID + 1, 0, 0, 0, 9, 0, @StartQuestTemplateID, 0, 0, 0, 0, 0, '', "Omdennos only shows 'Take me to Valiance Keep' option if player has taken the quest 'Hero's Call: Borean Tundra!'"),
  (15, @StartGossipMenuID + 1, 1, 0, 0, 28, 0, @StartQuestTemplateID, 0, 0, 0, 0, 0, '', "Omdennos only shows 'Take me to Valiance Keep' option if player has completed the quest 'Hero's Call: Borean Tundra!'"),
  (15, @StartGossipMenuID + 1, 2, 0, 0, 9, 0, @StartQuestTemplateID + 1, 0, 0, 0, 0, 0, '', "Omdennos only shows 'Take me to Valgarde Port' option if player has taken the quest 'Hero's Call: Howling Fjord!'"),
  (15, @StartGossipMenuID + 1, 3, 0, 0, 28, 0, @StartQuestTemplateID + 1, 0, 0, 0, 0, 0, '', "Omdennos only shows 'Take me to Valgarde Port' option if player has completed the quest 'Hero's Call: Howling Fjord!'");
