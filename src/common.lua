-- miscellanious, should probably have a better home

function draw_shielded(self)
    if self.shielded then
        sspr(0,20,12,12,self.x-2,self.y-2)
    end
end
