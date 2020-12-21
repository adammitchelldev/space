-- TODO make this a scene init thing?
collision_handler(player, enemy, handler("hit", "hit"))
collision_handler(player, enemy_bullet, handler("hit", "hit"))
collision_handler(player, powerup, handler(nil, "collect"))
collision_handler(player_bullet, enemy, handler("hit", "hit"))
