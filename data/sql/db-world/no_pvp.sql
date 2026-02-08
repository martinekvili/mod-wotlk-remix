-- Wintergrasp should no longer be a PVP Zone
SET @wintergraspAreaID = 4197;

DELETE FROM areatable_dbc
WHERE `ID` = @wintergraspAreaID
  OR `ParentAreaID` = @wintergraspAreaID;

INSERT INTO areatable_dbc
  (`ID`,`ContinentID`,`ParentAreaID`,`AreaBit`,`Flags`,`SoundProviderPref`,`SoundProviderPrefUnderwater`,`AmbienceID`,`ZoneMusic`,`IntroSound`,`ExplorationLevel`,`AreaName_Lang_enUS`,`AreaName_Lang_enGB`,`AreaName_Lang_koKR`,`AreaName_Lang_frFR`,`AreaName_Lang_deDE`,`AreaName_Lang_enCN`,`AreaName_Lang_zhCN`,`AreaName_Lang_enTW`,`AreaName_Lang_zhTW`,`AreaName_Lang_esES`,`AreaName_Lang_esMX`,`AreaName_Lang_ruRU`,`AreaName_Lang_ptPT`,`AreaName_Lang_ptBR`,`AreaName_Lang_itIT`,`AreaName_Lang_Unk`,`AreaName_Lang_Mask`,`FactionGroupMask`,`LiquidTypeID_1`,`LiquidTypeID_2`,`LiquidTypeID_3`,`LiquidTypeID_4`,`MinElevation`,`Ambient_Multiplier`,`Lightid`)
VALUES 
  (4197,571,0,1827,151012417,0,0,463,445,0,-1,'Wintergrasp','','','','','','','','','','','','','','','',16712190,0,81,0,0,0,1000,0,0),
  (4538,571,4197,2439,1090536513,0,0,0,0,0,80,'The Sunken Ring','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4539,571,4197,2441,1224754241,0,0,0,0,0,80,'The Broken Temple','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4575,571,4197,2564,1224754241,0,0,0,0,0,80,'Wintergrasp Fortress','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4576,571,4197,2567,1224754241,0,0,0,0,0,80,'Central Bridge','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4577,571,4197,2570,1224754241,0,0,0,0,0,80,'Eastern Bridge','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4578,571,4197,2573,1090536513,0,0,0,0,0,80,'Western Bridge','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4581,571,4197,2582,1224754241,0,0,0,0,0,80,'Flamewatch Tower','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4582,571,4197,2585,1224754241,0,0,0,0,0,80,"Winter's Edge Tower",'','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4583,571,4197,2588,1224754241,0,0,0,0,0,80,'Shadowsight Tower','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4584,571,4197,2591,1224754241,0,0,0,0,0,80,'The Cauldron of Flames','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4585,571,4197,2594,1224754241,0,0,0,0,0,80,'Glacial Falls','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4586,571,4197,2597,1224754241,0,0,0,0,0,80,'Windy Bluffs','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4587,571,4197,2600,1224754241,0,0,0,0,0,80,'The Forest of Shadows','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4589,571,4197,2606,1224737857,0,0,0,0,0,80,'The Chilled Quagmire','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4590,571,4197,2609,1224754241,0,0,0,0,0,80,'The Steppe of Life','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4611,571,4197,2672,1224754241,0,0,0,0,0,-1,'Westspark Workshop','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0),
  (4612,571,4197,2675,1224754241,0,0,0,0,0,-1,'Eastspark Workshop','','','','','','','','','','','','','','','',16712190,0,0,0,0,0,-500,0,0);

SET @areaFlagWintergrasp = 1 << 24;
SET @areaFlagWintergrasp2 = 1 << 27;

UPDATE areatable_dbc
SET `Flags` = `Flags` & ~@areaFlagWintergrasp & ~@areaFlagWintergrasp2
WHERE `ID` = @wintergraspAreaID
  OR `ParentAreaID` = @wintergraspAreaID;