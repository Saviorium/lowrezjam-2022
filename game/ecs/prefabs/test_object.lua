local stateMachine = require "game.statemachines.character_states"

return function(globalSystem)
    local width, height = 4,8
    local physicsCollider = globalSystem.HC:rectangle(0, 0, width, height)
    physicsCollider.type = 'Unit'

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, 16)})
        :addComponent('DrawRectangle', {size = Vector(width, height)})
        :addComponent('PhysicsCollider', {collider = physicsCollider, center = Vector(width/2, height/2)})
        :addComponent('UserControlled')
        :addComponent('Controlled')
        :addComponent('Walking', {maxSpeed = 50})
        :addComponent('Falling')
        :addComponent('Friction')
        :addComponent('Jumping', {maxSpeed = 1000, jumpForce = 1000})
        :addComponent('CameraToObjects')
        :addComponent('StateMachine', {states = stateMachine()})
        :addComponent('MoveInRandomDirection')
        :addComponent('Velocity', {velocity = Vector(0,0)})

    return ent
end