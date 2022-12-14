local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem, tutorialType, absPosition)
    -- tutorialType = "tutorial-zxcv" or "tutorial-space"
    local animatorInstance = animator:newInstance(AssetManager:getAnimation(tutorialType))
    animatorInstance:setVariable("state", "dancing")
    animatorInstance:play("dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = absPosition})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(0, 0)})
        :addComponent('DrawOnOrigin')
        :addComponent('DrawOrder', {layer = config.draw.layers.ui})
        :addComponent('SyncAnimationToBeat')
        :addComponent('Controlled')
        :addComponent('DoOnBeat', {onBeat = function(component, entity)
            component.beatsPassed = component.beatsPassed and component.beatsPassed + 1 or 1
            entity:setVariable("DrawAnimation", "hidden", component.beatsPassed > 15)
        end
        })

    return ent
end