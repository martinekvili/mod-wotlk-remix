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

    void AutoTeachSpells(Player *player) const;

    static Trainer::Trainer *GetTrainerForPlayer(Player const *player);

    static void TeachTrainerSpells(Player *player, Trainer::Trainer *trainer);

    void TeachQuestSpells(Player *player, Trainer::Trainer *trainer) const;

    void GrantShamanTotems(Player *player) const;

private:
    struct ShamanTotem
    {
        uint32 itemId;
        uint32 totemCategory;
        uint8 reqLevel;

        ShamanTotem(uint32 itemId, uint32 totemCategory, uint8 reqLevel) : itemId{itemId}, totemCategory{totemCategory}, reqLevel{reqLevel} {}
    };

    static Trainer::Spell createSpell(uint32 spellId, uint8 reqLevel);

    static uint32 getClassTrainerCreatureId(Player const *player);

    static void tryTeachSpells(Player *player, std::vector<Trainer::Spell> const &spells, Trainer::Trainer *trainer);
    static void tryTeachSpell(Player *player, Trainer::Spell const *spell, Trainer::Trainer *trainer);

    std::unordered_map<uint8, std::vector<Trainer::Spell>> questSpellsByClass;
    std::vector<ShamanTotem> shamanTotems;
};

#define sSpellAutoLearnMgr SpellAutoLearnMgr::instance()

#endif