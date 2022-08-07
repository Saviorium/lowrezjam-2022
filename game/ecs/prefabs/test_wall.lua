return function(globalSystem, position)
    local width, height = 16,128
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Physics'
    local position = position
    local centerOfColider = Vector(width/2,height/2)
    physicsCollider:moveTo(position.x + centerOfColider.x, position.y + centerOfColider.y)

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        --:addComponent('DrawRectangle', {size = Vector(width, height)})
        :addComponent('PhysicsCollider', {collider = physicsCollider})

    return ent
end