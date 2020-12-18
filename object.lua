object = {}
object_mt = {
    __index = object,
}
setmetatable(object, {
    __call = function(obj, t)
        local mt = {
            __index = t
        }
        setmetatable(t, {
            __index = object,
            __call = function(class, instance)
                setmetatable(instance, mt)
                instance:add()
                return instance
            end
        })
        return t
    end
})

function object:add()
    layer_add(self.layer, self)
end

function object:remove()
    layer_remove(self.layer, self)
end

function object:explode()
    explosion_make(self)
    self:remove()
end
