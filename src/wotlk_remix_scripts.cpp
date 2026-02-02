#include "InstantRidingMgr.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAutoLearnMgr.h"
#include "Trainer.h"

// Add player scripts
class WotlkRemixPlayerScript : public PlayerScript
{
public:
    WotlkRemixPlayerScript()
        : PlayerScript(
              "WotlkRemixPlayerScript",
              {
                  PLAYERHOOK_ON_FIRST_LOGIN,
                  PLAYERHOOK_ON_LOGIN,
                  PLAYERHOOK_ON_LEVEL_CHANGED,
                  PLAYERHOOK_ON_PLAYER_LEARN_TALENTS,
              })
    {
    }

    void OnPlayerFirstLogin(Player *player) override
    {
        // teleport player to Krasus' Landing
        player->TeleportTo(571u, 5813.84f, 449.122f, 658.752f, 1.16086f);

        InstantRidingMgr::ApplyInstantRiding(player);
    }

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

    void OnPlayerLearnTalents(Player *player, uint32 /*talentId*/, uint32 /*talentRank*/, uint32 /*spellid*/) override
    {
        sSpellAutoLearnMgr->AutoTeachSpells(player);
    }
};

// Add all scripts in one
void AddWotlkRemixScripts() { new WotlkRemixPlayerScript(); }
