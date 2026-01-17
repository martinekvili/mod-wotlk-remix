/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU
 * AGPL v3 license:
 * https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAutoLearnMgr.h"
#include "Trainer.h"

// Add player scripts
class AutoLearnSpellsScript : public PlayerScript
{
public:
    AutoLearnSpellsScript() : PlayerScript("AutoLearnSpells") {}

    void OnPlayerLevelChanged(Player *player, uint8 oldLevel) override
    {
        uint8 level = player->GetLevel();
        if (oldLevel >= level)
            return;

        Trainer::Trainer *trainer = SpellAutoLearnMgr::GetTrainerForPlayer(player);
        if (!trainer)
            return;

        SpellAutoLearnMgr::TeachTrainerSpells(player, trainer);
        sSpellAutoLearnMgr->TeachQuestSpells(player, trainer);
    }
};

// Add all scripts in one
void AddAutoLearnSpellsScripts() { new AutoLearnSpellsScript(); }
