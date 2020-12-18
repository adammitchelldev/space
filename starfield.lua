stars = {}
function starfield_make()
	for i = 1,100 do
		stars[i] = {
			x = rnd(128),
			y = rnd(136) - 8,
		}
	end
end

function starfield_update()
	for s in all(stars) do
		s.y += 1
		if s.y > 128 then
			s.y = rnd(8) - 8
			s.x = rnd(128)
		end
	end
end

function starfield_draw()
	color(1)
	fillp(0)
	for s in all(stars) do
		pset(s.x, s.y)
	end
end