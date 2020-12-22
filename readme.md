# Untitled P8 space game

## TODO
- [x] Try a simple ECS, litte/no optimization first
  - Seems to work pretty well
- [ ] Combine the scripts and update behaviour into script.lua

- [ ] Make sprite renderer ECS based
- [ ] Make weapon objects, add a couple more weapons
- [ ] Shoot using a shoot flag
- [ ] Make upgrades/items that apply to anything
- [ ] Use behaviour/scripts as control for objects, allow dynamic attaching of scripts
  - [ ] This will also work for levels
- [ ] Create a proper level framework for the campaign
  - [ ] Text and dialogue options
  - [ ] Select next destination
- [ ] Merge scripts and coroutine dispatch
- [ ] Remove autolayering in collision, make simpler
- [ ] Add animation support
- [ ] Add some more enemy types
- [ ] Create passive items
- [ ] Create some mission types
- [ ] Add a main menu and/or mission select
- [ ] Achievements

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