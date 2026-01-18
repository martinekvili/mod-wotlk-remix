#include "InstantRidingMgr.h"
#include "ObjectMgr.h"
#include "Trainer.h"
#include "Config.h"
#include <algorithm>
#include <vector>

void InstantRidingMgr::ApplyInstantRiding(Player *player)
{
    if (!sConfigMgr->GetOption<bool>("WotlkRemix.EnableInstantRiding", false))
        return;

    TeachAllRidingSkills(player);
    GrantDefaultMount(player);
}

void InstantRidingMgr::TeachAllRidingSkills(Player *player)
{
    Trainer::Trainer *ridingTrainer = sObjectMgr->GetTrainer(28746); // Pilot Vic
    if (!ridingTrainer)
        return;

    std::vector<Trainer::Spell> const &ridingSkills = ridingTrainer->GetSpells();

    // make sure we are applying the riding skills in the proper order
    std::vector<Trainer::Spell> sortedRidingSkills = std::vector<Trainer::Spell>(ridingSkills.size());
    std::partial_sort_copy(
        ridingSkills.begin(), ridingSkills.end(),
        sortedRidingSkills.begin(), sortedRidingSkills.end(),
        [](Trainer::Spell const &x, Trainer::Spell const &y)
        { return x.ReqLevel < y.ReqLevel; });

    for (Trainer::Spell const &spell : sortedRidingSkills)
        teachSpell(player, spell.SpellId);
}

void InstantRidingMgr::GrantDefaultMount(Player *player)
{
    // get the appropriate (very fast) mount players can start with
    uint32 defaultMountSpell = getDefaultMountSpellForPlayer(player);
    if (defaultMountSpell == 0)
        return;

    teachSpell(player, defaultMountSpell);
}

void InstantRidingMgr::teachSpell(Player *player, uint32 spellId)
{
    // avoid duplications, otherwise disregard every other check (e.g., required level, etc.)
    if (player->HasSpell(spellId))
        return;

    player->learnSpell(spellId, false);
}

uint32 InstantRidingMgr::getDefaultMountSpellForPlayer(Player const *player)
{
    switch (player->GetTeamId())
    {
    case TEAM_ALLIANCE:
        return sConfigMgr->GetOption<uint32>("WotlkRemix.InstantRidingAllianceDefaultMountSpell", 32242); // Swift Blue Gryphon
    case TEAM_HORDE:
        return sConfigMgr->GetOption<uint32>("WotlkRemix.InstantRidingHordeDefaultMountSpell", 32246); // Swift Red Wind Rider
    default:
        return 0;
    }
}