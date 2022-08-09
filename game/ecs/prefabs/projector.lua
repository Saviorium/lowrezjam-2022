local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem, position, initialState)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("projector"))
    if not initialState then
        initialState = "dancing"
    end
    animatorInstance:setVariable("state", initialState)

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = position})
        :addComponent('Animator', {animator = animatorInstance})
        :addComponent('DrawAnimation', {center = Vector(24, 2)})
        :addComponent('SyncAnimationToBeat')

        :addComponent('Controlled')
        :addComponent('BeatControlled', {beatMap = {
                                                    {listen = "beat1",send = "beat1"},
                                                    {listen = "beat2",send = "beat2"},
                                                    {listen = "beat3",send = "beat3"},
                                                    {listen = "beat4",send = "beat4"},
                                                   }
                                        })

        :addComponent('RotateThisThing')
        :addComponent('Rotation')
        :addComponent('SinusRotation')
        :addComponent('Colored', {color = config.colors.red})

    return ent
end