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
    AutoLearnSpellsScript() : PlayerScript("AutoLearnSpells", {PLAYERHOOK_ON_LOGIN, PLAYERHOOK_ON_LEVEL_CHANGED}) {}

    void OnPlayerLogin(Player *player) override
    {
        sSpellAutoLearnMgr->AutoTeachSpells(player);
    }

    void OnPlayerLevelChanged(Player *player, uint8 oldLevel) override
    {
        uint8 level = player->GetLevel();
        if (oldLevel >= level)
            return;

        sSpellAutoLearnMgr->AutoTeachSpells(player);
    }
};

// Add all scripts in one
void AddAutoLearnSpellsScripts() { new AutoLearnSpellsScript(); }
