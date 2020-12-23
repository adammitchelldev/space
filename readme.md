# Untitled P8 space game

## TODO
- [x] Try a simple ECS, litte/no optimization first
  - Seems to work pretty well
- [ ] Combine the scripts and update behaviour into script.lua
  - [x] Partially completed, layer and update are removed, although I'm missing layer somewhat and might bring the concept back since it made ordering draws much easier.
  - [ ] Migrate global scripts to use layer scripts
- [ ] Make sprite renderer system-component based
- [ ] Cleanup time!
  - [ ] Make spawning sfx into a script helper function
  - [ ] Make explosions not be the cause of remove
    - May need to figure out a proper way to inherit death listeners
  - [ ] Make explosions use prefab style
  - [ ] Move to "spawn"/"destroy" functions and terms?
  - [ ] Refactor enemies into their own files!
- [ ] Allow script inheritence?
- [ ] Create proper collision query methods e.g. get closest/all within box/range
- [ ] Collision cleanup

Idea: could reuse collision grids for draw sorting within a layer?
Simplify:
- 4 total collision layers: players, enemies, player_bullets, enemy_bullets
  - Pickups go under enemy_bullets
- 4 additional render layers: starfield, under_fx, over_fx and game_text
- Total render order:
    {
        starfield/bg,
        under_fx,
        player_bullets,
        enemy_bullets,
        enemies,
        over_fx,
        game_text,
        players,
        GUI (not clipped)
    }
- Back to using "layer" param.

# Fun stuff
- [ ] Make an enemy editor and a level editor that save to binary form
  - These guys can use the persistent cart RAM and cartdata to hold over state and provide quick iteration capabilities, allowing you to set up a test level and save it.
  - The code will register all available params and scripts and then the enemy editor lets you define prefabs.

# Balance TODO
- [x] Stop shielder from accelerating into player
- [x] Add a conenction/disconnection time to the shielder so that they can't surprise shield a green one.
- [ ] Reconsider hunter balance.
  - [x] Added initial delay
  - Are bullets too fast?
  - Needs a warning? When he zips in and kills you with no warning its a bit shit.
  - If he's going to be that zippy and strong, he should leave the stage after using his volley.

- [ ] Make weapon objects, add a couple more weapons
- [ ] Shoot using a shoot flag
- [ ] Make upgrades/items that apply to anything
- [ ] Use behaviour/scripts as control for objects, allow dynamic attaching of scripts
  - [ ] This will also work for levels
- [ ] Create a proper level framework for the campaign
  - [ ] Text and dialogue options
  - [ ] Select next destination
  - [ ] Missions
- [ ] Merge scripts and coroutine dispatch
- [x] Remove autolayering in collision, make simpler
- [ ] Add animation support
- [x] Add some more enemy types
- [ ] Create passive items
- [ ] Create some mission types
- [ ] Add a main menu and/or mission select
- [x] Achievements

### Features:
- [x] Start screen
- [ ] Credits
- [ ] Improved hiscore table
- [x] Ship boundaries and hit detection
- [x] Ship lives and game over
- [x] Score counter
- [ ] Cool enemy movement patterns (kind of done?)
- [x] More enemy types
- [x] Powerups
- [ ] More weapons (missiles)

### Refactoring:
- [x] Further organise files
- [x] Use hook/event style for draw/update/collisions
- [x] Automatic layer derivation from draw layers and collision hooks
- [ ] Better init hooks?
- [x] Better automatic layer management

### Engine:
- [x] Prebuilt methods and draw types
- [ ] Bring in old effects from Find Gold
- [ ] Particle effects?
- [x] More efficient collision detection (grid)
- [ ] Game states?