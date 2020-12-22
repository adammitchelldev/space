-- TODO make this a scene init thing?
collision_handler("player", "enemy", "hit")
collision_handler("player", "enemy_bullet", "hit")
collision_handler("player", "powerup", "collect")
collision_handler("player_bullet", "enemy", "hit")
