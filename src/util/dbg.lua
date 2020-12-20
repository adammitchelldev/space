function collision_grid_draw_debug(grid)
    for x, col in pairs(grid) do
		for y, list in pairs(col) do
			rect(x * 16, y * 16, (x+1) * 16, (y+1) * 16)
		end
    end
end
