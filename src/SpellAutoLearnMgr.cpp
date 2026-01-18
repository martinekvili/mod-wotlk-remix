#include "SpellAutoLearnMgr.h"
#include "SharedDefines.h"
#include "ObjectMgr.h"

SpellAutoLearnMgr::SpellAutoLearnMgr()
{
    questSpellsByClass = {
        {CLASS_PALADIN,
         {
             createSpell(7329, 12), // Redemption (Rank 1)
         }},
        {CLASS_HUNTER,
         {
             createSpell(1579, 10), // Tame Beast
             createSpell(5300, 10), // Beast Training
         }},
        {CLASS_DEATH_KNIGHT,
         {
             createSpell(52328, 55), // Summon Deathcharger (Summon)
             createSpell(53431, 55), // Runeforging
             createSpell(52821, 55), // Teach: Death Gate
         }},
        {CLASS_SHAMAN,
         {
             createSpell(8073, 4),  // Stoneskin Totem (Rank 1)
             createSpell(2075, 10), // Searing Totem (Rank 1)
             createSpell(5396, 20), // Healing Stream Totem (Rank 1)
         }},
        {CLASS_WARLOCK,
         {
             createSpell(11520, 10), // Teach Summon Voidwalker (Summon)
             createSpell(11519, 20), // Teach Summon Succubus (Summon)
             createSpell(1373, 30),  // Teach Summon Felhunter (Summon)
             createSpell(1413, 50),  // Inferno (Summon)
             createSpell(20700, 60), // Ritual of Doom
         }},
    };
}

SpellAutoLearnMgr const *SpellAutoLearnMgr::instance()
{
    static SpellAutoLearnMgr instance;
    return &instance;
}

Trainer::Trainer *SpellAutoLearnMgr::GetTrainerForPlayer(Player const *player)
{
    uint32 trainerCreatureId = getClassTrainerCreatureId(player);
    if (trainerCreatureId == 0)
        return nullptr;

    return sObjectMgr->GetTrainer(trainerCreatureId);
}

void SpellAutoLearnMgr::TeachTrainerSpells(Player *player, Trainer::Trainer *trainer)
{
    tryTeachSpells(player, trainer->GetSpells(), trainer);
}

void SpellAutoLearnMgr::TeachQuestSpells(Player *player, Trainer::Trainer *trainer) const
{
    std::unordered_map<uint8, std::vector<Trainer::Spell>>::const_iterator it = questSpellsByClass.find(player->getClass());
    if (it == questSpellsByClass.end())
        return;

    std::vector<Trainer::Spell> questSpells = it->second;
    tryTeachSpells(player, questSpells, trainer);
}

Trainer::Spell SpellAutoLearnMgr::createSpell(uint32 spellId, uint8 reqLevel)
{
    Trainer::Spell spell;
    spell.SpellId = spellId;
    spell.ReqLevel = reqLevel;

    return spell;
}

uint32 SpellAutoLearnMgr::getClassTrainerCreatureId(Player const *player)
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

    case CLASS_DEATH_KNIGHT:
        return 28471; // Lady Alistra

    case CLASS_SHAMAN:
        return 986; // Haromm

    case CLASS_MAGE:
        return 328; // Zaldimar Wefhellt

    case CLASS_WARLOCK:
        return 461; // Demisette Cloyce

    case CLASS_DRUID:
        return 3033; // Turak Runetotem

    default:
        return 0;
    }
}

void SpellAutoLearnMgr::tryTeachSpells(Player *player, std::vector<Trainer::Spell> const &spells, Trainer::Trainer *trainer)
{
    for (Trainer::Spell const &spell : spells)
        tryTeachSpell(player, &spell, trainer);
}

void SpellAutoLearnMgr::tryTeachSpell(Player *player, Trainer::Spell const *spell, Trainer::Trainer *trainer)
{
    if (!trainer->CanTeachSpell(player, spell))
        return;

    // learn explicitly or cast explicitly
    if (spell->IsCastable())
        player->CastSpell(player, spell->SpellId, true);
    else
        player->learnSpell(spell->SpellId, false);
}