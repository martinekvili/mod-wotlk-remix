-- Gameobject (map) starting Hero's Call and Warchief's Command quests
SET @StartNpcTextID = 200000, @NpcTextCount = 1,
  @StartGossipMenuID = 81000, @GossipMenuCount = 1,
  @StartGameObjectTemplateID = 310000, @GameObjectTemplateCount = 1,
  @StartGameObjectGuid = 6000000;

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
  (@StartGossipMenuID, @StartNpcTextID);

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

-- Quests
SET @StartQuestTemplateID = 40000, @QuestTemplateCount = 2;

DELETE FROM `quest_template`
WHERE `ID` >= @StartQuestTemplateID
  AND `ID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_template`
  (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RequiredFactionId1`, `RequiredFactionId2`, `RequiredFactionValue1`, `RequiredFactionValue2`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardMoney`, `RewardMoneyDifficulty`, `RewardDisplaySpell`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `Flags`, `RequiredPlayerKills`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardTalents`, `RewardArenaPoints`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `TimeAllowed`, `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `RequiredNpcOrGo1`, `RequiredNpcOrGo2`, `RequiredNpcOrGo3`, `RequiredNpcOrGo4`, `RequiredNpcOrGoCount1`, `RequiredNpcOrGoCount2`, `RequiredNpcOrGoCount3`, `RequiredNpcOrGoCount4`, `RequiredItemId1`, `RequiredItemId2`, `RequiredItemId3`, `RequiredItemId4`, `RequiredItemId5`, `RequiredItemId6`, `RequiredItemCount1`, `RequiredItemCount2`, `RequiredItemCount3`, `RequiredItemCount4`, `RequiredItemCount5`, `RequiredItemCount6`, `Unknown0`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 2, 71, 68, 3537, 0, 0, 0, 0, 0, 0, 11672, 1, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1050, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1101, "Hero's Call: Borean Tundra!", 'Report to Recruitment Officer Blythe at Valiance Keep in Borean Tundra.', 'By order of his royal highness, King Varian Wrynn, all able-bodied citizens of the Alliance are to report to Recruitment Officer Blythe at Valiance Keep in Borean Tundra.$B$BThe Valiance Expedition needs your help to keep the forces of the Scourge under control and safeguard civilized lands!$B$BFor the glory and honor of the Alliance!', '', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0),
  (@StartQuestTemplateID + 1, 2, 70, 68, 495, 0, 0, 0, 0, 0, 0, 11228, 1, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1101, "Hero\'s Call: Howling Fjord!", 'Speak with Macalroy in Howling Fjord.', 'All able-bodied citizens of the Alliance are to report to Macalroy in Howling Fjord. The port town of Valgarde is located in the heart of the Howling Fjord, and it allows for the Alliance to have an advantageous position to strike at the Scourge. Assist the soldiers stationed there. Glory to the Alliance!', '', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', '', '', 0);

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
  (@StartQuestTemplateID + 1, 0, -1, 571, 491, 0, 0, 1, 0);

DELETE FROM `quest_poi_points`
WHERE `QuestID` >= @StartQuestTemplateID
  AND `QuestID` < @StartQuestTemplateID + @QuestTemplateCount;

INSERT INTO `quest_poi_points`
  (`QuestID`, `Idx1`, `Idx2`, `X`, `Y`, `VerifiedBuild`)
VALUES
  (@StartQuestTemplateID, 0, 0, 2300, 5236, 0),
  (@StartQuestTemplateID + 1, 0, 0, 593, -5089, 0);

