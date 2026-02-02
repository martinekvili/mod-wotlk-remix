#include "SpellAutoLearnMgr.h"
#include "SharedDefines.h"
#include "ObjectMgr.h"
#include "Config.h"

SpellAutoLearnMgr::SpellAutoLearnMgr()
{
    questSpellsByClass = {
        {CLASS_PALADIN,
         {
             createSpell(7329u, 12u), // Redemption (Rank 1)
         }},
        {CLASS_HUNTER,
         {
             createSpell(1579u, 10u), // Tame Beast
             createSpell(5300u, 10u), // Beast Training
         }},
        {CLASS_DEATH_KNIGHT,
         {
             createSpell(52328u, 55u), // Summon Deathcharger (Summon)
             createSpell(53431u, 55u), // Runeforging
             createSpell(52821u, 55u), // Teach: Death Gate
         }},
        {CLASS_SHAMAN,
         {
             createSpell(8073u, 4u),  // Stoneskin Totem (Rank 1)
             createSpell(2075u, 10u), // Searing Totem (Rank 1)
             createSpell(5396u, 20u), // Healing Stream Totem (Rank 1)
         }},
        {CLASS_WARLOCK,
         {
             createSpell(11520u, 10u), // Teach Summon Voidwalker (Summon)
             createSpell(11519u, 20u), // Teach Summon Succubus (Summon)
             createSpell(1373u, 30u),  // Teach Summon Felhunter (Summon)
             createSpell(1413u, 50u),  // Inferno (Summon)
             createSpell(20700u, 60u), // Ritual of Doom
         }},
    };

    shamanTotems = {
        ShamanTotem{5175u, 2u, 4u},  // Earth Totem
        ShamanTotem{5176u, 4u, 10u}, // Fire Totem
        ShamanTotem{5177u, 5u, 20u}, // Water Totem
        ShamanTotem{5178u, 3u, 30u}, // Air Totem
    };
}

SpellAutoLearnMgr const *SpellAutoLearnMgr::instance()
{
    static SpellAutoLearnMgr instance;
    return &instance;
}

void SpellAutoLearnMgr::AutoTeachSpells(Player *player) const
{
    if (!sConfigMgr->GetOption<bool>("WotlkRemix.EnableSpellAutoLearn", false))
        return;

    Trainer::Trainer *trainer = GetTrainerForPlayer(player);
    if (!trainer)
        return;

    TeachQuestSpells(player, trainer);
    TeachTrainerSpells(player, trainer);
    GrantShamanTotems(player);
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

void SpellAutoLearnMgr::GrantShamanTotems(Player *player) const
{
    if (player->getClass() != CLASS_SHAMAN)
        return;

    for (ShamanTotem const &shamanTotem : shamanTotems)
    {
        // check level requirement
        if (player->GetLevel() < shamanTotem.reqLevel)
            continue;

        // check if player already owns this totem
        if (player->HasItemTotemCategory(shamanTotem.totemCategory))
            continue;

        player->AddItem(shamanTotem.itemId, 1);
    }
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
        return 913u; // Lyria Du Lac

    case CLASS_PALADIN:
        if (teamId == TEAM_ALLIANCE)
            return 927u; // Brother Wilhelm
        else if (teamId == TEAM_HORDE)
            return 16275u; // Noellene
        else
            return 0;

    case CLASS_HUNTER:
        return 987u; // Ogromm

    case CLASS_ROGUE:
        return 917u; // Keryn Sylvius

    case CLASS_PRIEST:
        return 376u; // High Priestess Laurena

    case CLASS_DEATH_KNIGHT:
        return 28471u; // Lady Alistra

    case CLASS_SHAMAN:
        return 986u; // Haromm

    case CLASS_MAGE:
        return 328u; // Zaldimar Wefhellt

    case CLASS_WARLOCK:
        return 461u; // Demisette Cloyce

    case CLASS_DRUID:
        return 3033u; // Turak Runetotem

    default:
        return 0u;
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