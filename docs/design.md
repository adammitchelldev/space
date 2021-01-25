# Design Doc

## Synopsis

This is an arcade-style space shooter with a roguelite approach to extended gameplay value. The core gameplay is balanced between space shoot-em-up and bullet hell whilst the roguelite focus is on ship upgrades, mission selection, navigation and unlocks.

## Basic experience

First time players should not be overloaded with options, presenting the game as more of a classic arcade title and performing a couple of cold starts a la Rogue Legacy and Hades. Since nothing is unlocked at this point, this is also fair. The first couple of levels and the first powerups should be hand selected as an effective tutorial just to warm the player up.

The main campaign gameplay loop breaks down into levels, each with substages that provide some kind of challenge based on the environment and current game status.

## Levels and Stages

The player progresses through the game by FTL jumping between levels. Each level will have at least a couple of substages involving different obstacles or enemies, such as asteroids and mining, storms, swarms, regular firefights, pirate ambushes, bosses, escapes, collectathons, speed sections, races/chases, rescue/recovery, defending, stealth and combinations of the above. Some stages may be peaceful and involve decisions that will change the next stage and/or activate new missions. Generally, the score for a particular stage or fight is recorded and a grade/rank is given on completion. Grades are also used for missions to provide higher targets to hit and encourage better players to push themselves or value missions that highly coincide. At the end of the level, the player gets to see some information about the next areas and chooses which direction to take.

## Campaign

The player collects missions naturally through their campaign and accepting missions changes which enemies and challenges they will face. Missions come from factions or requests for help from strangers. Sometimes, missions may have diverging decisions and stages, although they will follow fairly typical patterns so as not to be totally unpredictable. Mostly, the missions act as ways to gain bigger rewards. When a mission is accepted, it means that there is some guaranteed opportunity to complete the mission coming up e.g. accepting a smuggling mission means that a port will come up for the delivery, but it also means you will likely be hunted by someone. Taking a bounty mission means you will be able to track and find the target soon.

As the player plays through and completes certain mission types and specific "story missions", they will unlock further mission types, story missions and characters. However, there will always be a specific "main mission" that the player selects, or otherwise some lasting reward for surviving longer. Playing as a character both earns a lasting XP or currency for the character (could be unique per character) and earns some overall progress. Beating certain score thresholds with characters will also unlock things.

Once multiple main missions are unlocked, the player will be able to choose their character and choose a main mission, which will always give them an angle to grind for something specific (the main missions have a large effect on the early environment and options). There will also be achievements for bonus item unlocks (unlocking findable items) and a mode for playing with a "random" mission or for pure hiscore mode.

Generally the captains are unlocked by completing a story mission involving them from the point of view of another character. Each captain has a unique set of story missions only they can play, but they may appear in other character's story missions. The captains can unlock badges that change their nature. The goal is to max every captain and every ship, which is only possible by beating every story mission and every captain specific achievement.

Idea: Badges are earned by complete x/y in a list of achievements. The badges are maxed when all of those achievements are maxed. There's something like this for ship B unlocks in FTL. The trick is for this to be a semi-lategame thing, and also for the achievements to unlock permanent items.

### Missions

Player will be presented with mission choices during the campaign. The presented choices will show their reward item.

### Mission types:
* Cargo missions: -1 module capacity, specific destination, may attract pirates/police
  * Smuggling
* Escort missions: gain an ally ship temporarily but face more enemies.
  * May be a trap
* Combat missions: assist in a specific fight.
* 

## Ship mechanics

Main resources:
#### Hull
You die if it falls below 0. Upgrading hull/armour upgrades max health.
#### Energy
The main power resource: energy is used to power up your weapons and abilities. Whilst you can always use your primary weapon, certain upgrades will unlock the ability for it to be powered by energy. Generally, this provides a downside to powerful upgrades, but there are also upgrades and modules that increase your ship's ability to generate and use power. 
#### Scrap
Currency-like, used to power certain secondary items, like scrap guns or scrap missile launchers.
#### Anti-matter
High value single-use items, used to power advanced items like black hole bombs, super lasers and lifesavers. Generally late-game.
#### Special resources
High value items used to upgrade specific module types, or sold for scrap.
* Tech - computer control
* Crystal - lasers
* Lithium - battery and energy
* Alloy - hull and guns
* Carbon - dynamics
* Nano - auto-repair and high-tech

## Tiers

* Common (white)
* Uncommon (green)
* Rare (blue)
* Epic (red)
* Legendary (gold)

## Ship + Weapons + Upgrades

The ship itself will be upgradeable with weapons and items, following various rarity tiers. The weapons affect the types of attacks the ship has available whilst the upgrades provide passive benefits. Items are mostly only available as stage/level rewards, missions, shops or bosses/unique encounters, but temporary powerups will drop during the stage from enemies (and many items will boost or change the effect of powerups.) Items and powerups are ranked by rarity a la Ring of Pain, Hades, Risk of Rain 2.

Upgrades are great but not unlimited and may come with various drawbacks. High firepower can result in lower armour (more damage taken) and higher energy use. Lots of heavy modules or high loads can counteract mobility too, mostly felt as acceleration. Certain upgrades are mutually exclusive. The ship can also be levelled up to unlock more room to play with upgrades, and the level up options are specific to each ship and captain.

### Weapon types

* Plasma blasters
* Machine guns
* Missiles
* Flamethrowers
* Acid throwers
* Lasers
* Black hole cannons
* Railgun
* Lightning/elec gun
* Cluster bombs/flak
* Limpet mines
* Kinetic disk
* Gamma gun (alternative lasers)

### Upgradable weapon aspects

* Split shot/spread
* Double shot
* Fire rate
* Shot speed/power
* Homing
* Bigger explosions
* More penetration/anti-shield
* Knockback
* Stun/slow/EMP
* Melting
* Charged shots

### Item ideas

Items sit on slot B, most require energy to use.

* Boosters: use energy to move faster.
* Barrier: use energy to become invulnerable (min activation duration and additional grace period)
* Scrap:
  * Cannon: use scrap to fire powerful cannon.
  * Machine guns: use scrap to fire high-rate machine guns.
  * Missiles: use scrap to fire high-rate swarm missiles.
  * Furnace: consume scrap to power up weapons or energy.
* Mega overdrive: increase energy consumption to power up other bonuses.
* Repulsion?: use energy to curve things away from you.
* A-mat:
  * Furnace: consume an a-mat to overdrive energy and weapons for a time.
  * Cannon: fire a-mat, super destructive and piercing, good for bosses.
  * Bomb: damage all enemies.
* Time dilator?:
  * Uses energy to slow down time.

### Upgrades

Base stats:
* Hull capacity
* Energy capacity
* Shield capacity
* Projectile speed
* Projectile range
* Projectile size?
* Weapon speed
* Ship speed

### Power ups

The player can collect various powerups in the level, such as instant hull repairs, overdrives, energy boosts etc.

## Drones and Allies

Drones autonomously bounce around the battlefield and seek out targets, depending on the drone type and whatever special upgrades the player may have.

The player can also gain ally ships, which join the players formation and are controlled by them. They fire additional weapons. Certain special ally ships have unique abilities or support powers that will automatically activate and they will level up over time too. Ally ships are not as complex as the player ship and they don't take damage.

## Detailed implementation notes

Would be nice for items to apply generically to any game object, so that they can also be used to generate random enemies a la Risk of Rain 2.

Objects should be controlled with the "behaviour" list, which functions like the current "update", but not permanent i.e. the behaviours or scripts end, but they can replace themselves with new behaviours.

### Text

Come up with a generic campaign/level control system so that levels can be written minimally.