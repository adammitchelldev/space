texts = layer {}

text = class {
    layer = texts
}

function text_draw(obj)
	if obj.bg then
		color(obj.bg)
		rectfill(obj.x - 1, obj.y - 1, obj.x + (obj.w * 4) - 1, obj.y + 5)
    end
    if obj.fg then
        print(obj.text, obj.x, obj.y, obj.fg)
    end
end

function text_box(tx, x, y)
	return text {
        x = x,
        y = y,
        w = #tx,
		bg = 0, fg = 7,
		text = tx,
		draw = text_draw
	}:add()
end

function text_scene_type(obj, tx, delay)
	for p=1, #tx do
		obj.text = sub(tx, 1, p)
		wait(delay)
	end
end

function text_rising_box(tx, x, y)
	return function()
		local t = text_box(tx,
				x - ((#tx) * 2),
				y - 3)
		t.bg = false
		wait(
			play(function()
				text_scene_type(t, tx, 2)
			end),
			play(function()
				for i = 1, 5 do
					wait(2)
					t.y -= 1
				end
			end)
        )
		wait(20)
		t:remove()
	 end
end
