-- Layers
bullets = {}
explosions = {}
enemies = {}

player = {
    sprite = 2,
    shot = {
        delay = 10,
        speed = 5,
        width = 2
    }
}

bullet = object {
    layer = bullets,
    explosion = 5,
    col = { l=0, r=2, u=0, d=6 }
}

enemy = object {
    layer = enemies,
    sprite = 3,
    explosion = 8,
    col = { l=0, r=8, u=0, d=8 }
}

heat_colors = {7, 10, 9, 8, 2}

explosion_dither = {
	0b0000000000000000,
	0b1010000010100000,
	0b1010010110100101,
	0b1111010111110101,
	0b1111010111110101,
}