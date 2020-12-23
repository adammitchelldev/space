text = entity {
    layer = game_text
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

function text:new(tx, x, y, bg, fg)
	return self:spawn{
        x = x - ((#tx) * 2),
        y = y,
        w = #tx,
        bg = bg or false,
        fg = fg or 7,
		text = tx,
		draw = text_draw
	}
end

function text_scene_type(self, delay)
    local tx = self.text
	for p=1, #tx do
		self.text = sub(tx, 1, p)
		wait(delay)
	end
end

text_rising = text {
    ttl = 30,
    scripts = {
        function(self)
            text_scene_type(self, 2)
        end,
        function(self)
            for i = 1, 5 do
                wait(2)
                self.y -= 1
            end
        end
    }
}
