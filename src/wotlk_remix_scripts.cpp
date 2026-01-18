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
              })
    {
    }

    void OnPlayerFirstLogin(Player *player) override
    {
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
};

// Add all scripts in one
void AddWotlkRemixScripts() { new WotlkRemixPlayerScript(); }
