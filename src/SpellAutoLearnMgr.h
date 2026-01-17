#ifndef DEF_SPELLAUTOLEARNMGR_H
#define DEF_SPELLAUTOLEARNMGR_H

#include "Player.h"
#include "Trainer.h"
#include <vector>
#include <unordered_map>

class SpellAutoLearnMgr
{
private:
    SpellAutoLearnMgr();

public:
    static SpellAutoLearnMgr const *instance();

    static Trainer::Trainer *GetTrainerForPlayer(Player const *player);

    static void TeachTrainerSpells(Player *player, Trainer::Trainer *trainer);

    void TeachQuestSpells(Player *player, Trainer::Trainer *trainer) const;

private:
    static Trainer::Spell createSpell(uint32 spellId, uint8 reqLevel);

    static uint32 getClassTrainerCreatureId(Player const *player);

    static void tryTeachSpells(Player *player, std::vector<Trainer::Spell> const &spells, Trainer::Trainer *trainer);
    static void tryTeachSpell(Player *player, Trainer::Spell const *spell, Trainer::Trainer *trainer);

    std::unordered_map<uint8, std::vector<Trainer::Spell>> questSpellsByClass;
};

#define sSpellAutoLearnMgr SpellAutoLearnMgr::instance()

#endif