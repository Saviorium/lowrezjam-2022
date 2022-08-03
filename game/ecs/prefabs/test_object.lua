return function(globalSystem)
    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, 200)})
        :addComponent('DrawRectangle', {size = Vector(10, 20)})
        :addComponent('UserControlled')
        :addComponent('Controlled')
        :addComponent('Walking', {maxSpeed = 50})
        :addComponent('Falling')
        :addComponent('Friction')
        :addComponent('CameraToObjects')
        :addComponent('Velocity', {velocity = Vector(0,0)})

    return ent
end