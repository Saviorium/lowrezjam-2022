return function(globalSystem)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, -32)})
        :addComponent('Image', {image = AssetManager:getImage("background-refs")})
        :addComponent('DrawOrder', {order = config.draw.layers.bg})

    return ent
end