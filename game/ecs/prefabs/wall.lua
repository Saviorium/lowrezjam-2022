return function(globalSystem, position, width, height, angle)
    local width, height = width or 128, height or 16
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Environment'
    local position = position
    local centerOfColider = Vector(width/2,height/2)
    physicsCollider:moveTo(position.x + centerOfColider.x, position.y + centerOfColider.y)
    if angle then
        physicsCollider:rotate(angle)
    end

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        --:addComponent('DrawRectangle', {size = Vector(width, height)})
        :addComponent('PhysicsCollider', {collider = physicsCollider})

    return ent
end