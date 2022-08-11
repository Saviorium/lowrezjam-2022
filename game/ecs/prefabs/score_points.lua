return function(globalSystem, position, text, color)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position + Vector(-10,-10)})
        :addComponent('Velocity', {velocity = Vector(0,-10)})
        :addComponent('DrawText', {text = text})
        :addComponent('DrawOrder', {order = config.draw.layers.common})
        :addComponent('DeathByTimer', {timer = 1})
        :addComponent('Colored', {color = color})

    return ent
end