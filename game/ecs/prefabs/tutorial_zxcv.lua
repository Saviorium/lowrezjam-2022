local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("tutorial-zxcv"))
    animatorInstance:setVariable("state", "dancing")
    animatorInstance:play("dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(5, 26)})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(0, 0)})
        :addComponent('DrawOnOrigin')
        :addComponent('DrawOrder', {layer = config.draw.layers.ui})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')
        :addComponent('DoOnBeat', {onBeat = function(component, entity)
            component.beatsPassed = component.beatsPassed and component.beatsPassed + 1 or 1
            if component.beatsPassed > 16 then
                entity:remove()
            end
        end
        })

    return ent
end