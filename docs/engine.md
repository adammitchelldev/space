# Engine Design

Need to figure out the whole layers shebang. I liked how it worked in Find Gold somewhat, although it would be nice to have more "systemic" options for when objects are added and removed.

I would also like it to be really easy to script events and stuff. Having a more "lightweight" way to do simultaneous events would be nice, could probably also seamlessly mix coroutines with more traditional animation components. The easier it is to script new things the better.

Should try the idea of "adding" scripts to a gameobject that automatically self expire. Would also be a good system for adding multiple sprites and colliders. Should definitely either choose to distinguish between classes and instances at this point or go back to the Find Gold method and effectively ditch the metatables. Perhaps thinking about a stronger differentiation between static parts i.e. class level colliders with dynamic parts i.e. scripts.

### Progress on scripting

I've added in Find Gold's scripting, and I have made the regular events "coroutine available", so they will run in a coroutine if something yields. I have also added the ability to have multiple "update" or "draw" functions.

However, my current thinking is to make it classes a "behaviour" list, where each behaviour defines the update function or draw function. This would make composing multiple behaviours a little easier, a bit like composing systems from ECS, just done manually rather than from queries over components.

### Tags vs Layers
In a layer-based design, you place the objects in phyiscally controlled layers and then iterate on the layers. This can be fairly straightforward but gets complicated with many layers, as functionality duplicated between objects in different layers. However, it is possible to have new layers for different purposes and allow objects to live in multiple layers, but the responsibility of tracking that can be annoying. In a tag-based design, your objects are automatically sorted based on the tags you put on them, effectively "auto-layers".

Layers could have sub-layers.

### Known engine problems

- [ ] The grid based collision system picks up duplicate collisions.
