# Untitled P8 space game

An untitled roguelike arcade space shooter, see [design](docs/design.md) for design notes.

## TODO
### Now
- [ ] Bake sprite renderer into standard draw

### Simple cleanup
- [ ] Deduplicate the main `_update` and `_draw` code
- [ ] Make achievements global instance based rather than numbered
- [ ] Fix the bullet rendering!

### Game features
- [ ] Refactor into actual weapons
- [ ] Generic upgrade/item system
- [ ] Main menu
- [ ] Dialogue
- [ ] Proper campaign and level system

### Engine features
- [ ] Bring in old effects from Find Gold
- [ ] Create proper collision query methods e.g. get closest/all within box/range
- [ ] Script inheritence?
- [ ] Simple particle effects?

### Fun stuff
- [ ] Make an enemy editor and a level editor that save to binary form
  - These guys can use the persistent cart RAM and cartdata to hold over state and provide quick iteration capabilities, allowing you to set up a test level and save it.
  - The code will register all available params and scripts and then the enemy editor lets you define prefabs.
