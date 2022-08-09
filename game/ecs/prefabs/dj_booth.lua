local animator = require "game.ecs.prefabs.dancer_animator"

return function(globalSystem)
    local animatorInstance = animator:newInstance(AssetManager:getAnimation("floor-lights"))
    animatorInstance:setVariable("state", "dancing")

    local ent =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(107, 199-32)})
        :addComponent('Image', {image = AssetManager:getImage("dj-booth")})

    return ent
end