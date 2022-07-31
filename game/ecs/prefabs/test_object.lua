return function(globalSystem)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(100, 100)})
        :addComponent('DrawRectangle', {size = Vector(10, 20)})
        :addComponent('UserControlled')
        :addComponent('Controlled')
        :addComponent('Flying', {maxSpeed = 50})
        :addComponent('Velocity', {velocity = Vector(0,0)})

    return ent
end