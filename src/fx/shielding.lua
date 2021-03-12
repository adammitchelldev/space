-- shielding effect

shielding = entity {
    layer = bg_fx,
}

function shielding:draw()
    local target = self.target
    if target and not target.dead then
        local x1,y1,x2,y2 = self.origin.x,self.origin.y,target.x,target.y
        local dx,dy = (x2-x1)/10, (y2-y1)/10
        x1,y1 = x1+4,y1+4
        fillp(░)
        for i=1,self.shield_progress do
            x1 += dx
            y1 += dy
            circfill(x1,y1,flr(i/2)+1,13)
        end
        fillp(0)
    end
end
