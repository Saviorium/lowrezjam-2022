return function(globalSystem)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, -32)})
        :addComponent('Image', {image = AssetManager:getImage("bg-sky")})
        :addComponent('Scaled', { scale = Vector(16, 1) })
        :addComponent('DrawOrder', {order = config.draw.layers.bgFar})


    return ent
end