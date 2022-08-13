local Animator = require "engine.animation.animator"

return function(globalSystem, position)
    local animator = Animator()
    animator:addInstantTransition("_start", "open")
    animator:addSimpleTagState("open", "open")
    animator:addSimpleTagState("closed", "closed")
    animator:addSimpleTagState("opening", "opening")
    animator:addSimpleTagState("closing", "closing")
    animator:addTransitionOnAnimationEnd("opening", "open")
    animator:addTransitionOnAnimationEnd("closing", "closed")
    animator:addTransition("*", "open", function(animatorInstance)
        return animatorInstance:getVariable("isOpen")
    end)
    animator:addTransition("*", "closed", function(animatorInstance)
        return not animatorInstance:getVariable("isOpen")
    end)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("door"))
    animatorInstance:setVariable("isOpen", true)


    local physicsCollider = globalSystem.HC:rectangle(0, 0, config.positions.doorWidth, config.positions.doorHeight)
    physicsCollider.type = 'Environment'

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(4, 0)})
        :addComponent('PhysicsCollider', {collider = physicsCollider})
        :addComponent('DoWithSun', {
            update = 
            function (self, dt, entity, currentDayState, timer, statesQueue)
                if currentDayState == 'Noon' or  currentDayState == 'Morning' or  currentDayState == 'Afternoon'then
                    entity:getComponentByName("Animator").animator:setVariable("isOpen", false)
                    entity:getComponentByName("PhysicsCollider").collider.type = 'Environment'
                else
                    entity:getComponentByName("Animator").animator:setVariable("isOpen", true)
                    entity:getComponentByName("PhysicsCollider").collider.type = 'Door'
                end
            end})


    -- TODO: ent:getComponentByName("Animator").animator:setVariable("isOpen", false)

    return ent
end