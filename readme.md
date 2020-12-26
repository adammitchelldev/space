# Untitled P8 space game

An untitled roguelike arcade space shooter, see [design](docs/design.md) for design notes.

## TODO
### Now
- [ ] Refactor shooting into actual weapons so we can add some more

### Simple cleanup
- [ ] Deduplicate the main `_update` and `_draw` code
- [ ] Make achievements global instance based rather than numbered
- [ ] Refactor some scripts that don't need to be scripts into update hooks
- [ ] Fix the bullet rendering!

### Game features
- [ ] Refactor out the floaty movement from shield guy so other entities can use it
- [ ] Think about generic stats/powerup system to make items easier
- [ ] Make some item pickups
- [ ] Main menu!
- [ ] Break level manager down into "waves" that can be generated from some rules
- [ ] Dialogue for missions and campaign
- [ ] Proper campaign and level system
- [ ] Destination select?

### Engine features
- [ ] Bring in old effects from Find Gold
- [ ] Create proper collision query methods e.g. get closest/all within box/range
- [ ] Script inheritence? Probably better to provide a table concat(...)
- [ ] Simple particle effects?

### Fun stuff
- [ ] Make an enemy editor and a level editor that save to binary form
  - These guys can use the persistent cart RAM and cartdata to hold over state and provide quick iteration capabilities, allowing you to set up a test level and save it.
  - The code will register all available params and scripts and then the enemy editor lets you define prefabs.
