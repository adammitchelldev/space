-- TODO make this a scene init thing?
collision_on(player, enemy, handler("hit", "hit"))
collision_on(player, enemy_bullet, handler("hit", "hit"))
collision_on(player, powerup, handler(nil, "powerup"))
collision_on(player_bullet, enemy, handler("hit", "hit"))
