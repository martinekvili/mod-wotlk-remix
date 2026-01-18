#ifndef DEF_INSTANTRIDINGMGR_H
#define DEF_INSTANTRIDINGMGR_H

#include "Player.h"

class InstantRidingMgr
{
public:
    static void ApplyInstantRiding(Player *player);

    static void TeachAllRidingSkills(Player *player);

    static void GrantDefaultMount(Player *player);

private:
    static void teachSpell(Player *player, uint32 spellId);

    static uint32 getDefaultMountSpellForPlayer(Player const *player);
};

#endif