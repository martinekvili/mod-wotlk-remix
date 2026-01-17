/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU
 * AGPL v3 license:
 * https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ObjectMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
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

        uint32 trainerCreatureId = getClassTrainerCreatureId(player);
        if (trainerCreatureId == 0)
            return;

        Trainer::Trainer *trainer = sObjectMgr->GetTrainer(trainerCreatureId);
        if (!trainer)
            return;

        for (Trainer::Spell const &spell : trainer->GetSpells())
        {
            if (!trainer->CanTeachSpell(player, &spell))
                continue;

            // learn explicitly or cast explicitly
            if (spell.IsCastable())
                player->CastSpell(player, spell.SpellId, true);
            else
                player->learnSpell(spell.SpellId, false);
        }
    }

private:
    uint32 getClassTrainerCreatureId(Player const *player) const
    {
        TeamId teamId = player->GetTeamId();

        switch (player->getClass())
        {
        case CLASS_WARRIOR:
            return 913; // Lyria Du Lac

        case CLASS_PALADIN:
            if (teamId == TEAM_ALLIANCE)
                return 927; // Brother Wilhelm
            else if (teamId == TEAM_HORDE)
                return 16275; // Noellene
            else
                return 0;

        case CLASS_HUNTER:
            return 987; // Ogromm

        case CLASS_ROGUE:
            return 917; // Keryn Sylvius

        case CLASS_PRIEST:
            return 376; // High Priestess Laurena

        default:
            return 0;
        }
    }
};

// Add all scripts in one
void AddAutoLearnSpellsScripts() { new AutoLearnSpellsScript(); }
