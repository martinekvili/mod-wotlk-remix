# Wrath of the Lich King Remix Module

The goal of this module is to achieve a Remix-like experience (think [Pandaria](https://www.wowhead.com/guide/wow-remix-mists-of-pandaria-overview) or [Legion Remix](https://www.wowhead.com/guide/wow-remix-legion-overview)) using AzerothCore and the 3.3.5 client.

## Planned Features

- [ ] Retail-like spell learning experience
  - Spells should be automatically learned when they become eligible, no need to talk to a trainer / complete a quest
  - _Note: I realized halfway in that [mod-learnspells](https://github.com/noisiver/mod-learnspells) already does this, however, their implementation differs enough (using existing Trainer data vs custom SQL for spells) that I decided I'll keep mine. Still, it was good inspiration, especially for the Shaman totem stuff. Definitely worth a check out!_
- [ ] Instant riding skill and flying mount
  - Players should immediately learn all riding skills and get an appropriate mount when first logging in
- [ ] Northrend only
  - Take the "limited to one continent" idea from Pandaria Remix:
    > Timerunning characters are locked to a special version of the Pandaria continent, and cannot leave - No teleportation items outside of the continent work, portals to Stormwind/Orgrimmar in the original locations are disabled.
  - All maps, dungeons and battlegrounds outside Northrend and WotLK dungeons are disabled
  - New characters are teleported to Northrend, with all transportation, portals, etc. outside Northrend disabled
  - A few quest(line)s have steps in other worlds, these have to be tweaked manually:
    - [ ] [An Injured Colleague](https://www.wowhead.com/wotlk/quest=13986/an-injured-colleague) and [A Cautious Return](https://www.wowhead.com/wotlk/quest=14409/a-cautious-return) both start in Dalaran and end in Thunder Bluff and Darnassus respectlively. Just one-off quests, not part of a chain.
    - [ ] [Herald of War](https://www.wowhead.com/wotlk/quest=13257/herald-of-war) and [Reborn From The Ashes](https://www.wowhead.com/wotlk/quest=13347/reborn-from-the-ashes) are both part of the [Battle of Angrathar the Wrathgate](https://wowpedia.fandom.com/wiki/Battle_of_Angrathar_the_Wrathgate), culminating in [Battle for the Undercity](https://wowpedia.fandom.com/wiki/Battle_for_the_Undercity).
    - [ ] [The Etymidian](https://www.wowhead.com/wotlk/quest=12548/the-etymidian) is part of the Lifewarden series in Sholazar Basin that takes part in Un'Goro Crater.
    - [ ] [The Keeper's Favor](https://www.wowhead.com/wotlk/quest=13073/the-keepers-favor) and [The Will of the Naaru](https://www.wowhead.com/wotlk/quest=13081/the-will-of-the-naaru) are part of the [Crusader Bridenbrad](https://www.wowhead.com/wotlk/npc=30562/crusader-bridenbrad) storyline which take the player to Moonglade and Shattrath City respectively.
    - [ ] Journey To The Sunwell ([Horde](https://wowclassicdb.com/wotlk/quest/24562) / [Alliance](https://wowclassicdb.com/wotlk/quest/24522)) is part of the [Restoring the Battered Hilt and Obtaining Quel’delar](https://www.warcrafttavern.com/wotlk/guides/battered-hilt-quest-guide/) questline that takes the player to the Isle of Quel’Danas.
- [ ] ...