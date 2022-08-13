local System = require "game.ecs.systems.system"

local DrawSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Position', 'Drawable'})
        self.globalSystem = globalSystem
        self.layers = self.initLayers()
    end
}

local layers = config.draw.layers

function DrawSystem.initLayers()
    local result = {}
    for k, v in pairs(layers) do
        result[v] = {}
    end
    return result
end

function DrawSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local drawOrder = entity:getComponentByName("DrawOrder")
    if not drawOrder then
        if not self.layers[layers.common][entityId] then
            self.layers[layers.common][entityId] = entity
        end
        return
    end
    if drawOrder.__previous then
        if drawOrder.__previous == drawOrder.order then
            return
        end
        self.layers[drawOrder.__previous][entityId] = nil
    end
    drawOrder.__previous = drawOrder.order
    self.layers[drawOrder.order][entityId] = entity
end

function DrawSystem:draw()
    for layer, entities in ipairs(self.layers) do
        for entityId, entity in pairs(entities) do
            love.graphics.push()

            local absolute = entity:getComponentByName("DrawOnOrigin")
            if absolute then
                love.graphics.origin()
                --love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
                local animatior = entity:getComponentByName("Animator") -- hack: this would look better in a dedicated system, that would handle fullscreen overlays
                if animatior and animatior.animator and animatior.animator.animation then
                    local scaleX = love.graphics.getWidth()/animatior.animator.animation:getWidth()
                    local scaleY = love.graphics.getHeight()/animatior.animator.animation:getHeight()
                    local scale = math.max(scaleX, scaleY)
                    --love.graphics.scale(scale, scale)
                end
            end

            local pos = entity:getComponentByName("Position").position
            local rotateEntity = entity:getComponentByName("RotateThisThing") ~= nil
            if rotateEntity then
                love.graphics.translate(pos.x, pos.y)
            else
                love.graphics.translate(math.floor(pos.x), math.floor(pos.y))
            end

            local shaking = entity:getComponentByName("Shaking")
            if shaking and shaking.isActive then
                local time = love.timer.getTime()
                if time % (1/shaking.frequency) * shaking.frequency > 0.5 then
                    love.graphics.translate(shaking.amplitude:unpack())
                end
            end

            local colorComp = entity:getComponentByName("Colored")
            local entityColor
            if colorComp then
                entityColor = colorComp.color
            else
                entityColor = {1,1,1,1}
            end

            local blendComp = entity:getComponentByName("ColorBlendModifier")
            if blendComp then
                love.graphics.setBlendMode(blendComp.blendMode, blendComp.blendAlphaMode)
            else
                love.graphics.setBlendMode("alpha")
            end

            for _, drawable in pairs(entity:getComponentsByType("Drawable")) do
                love.graphics.push()
                if rotateEntity then
                    local rotation = entity:getComponentByName("Rotation").rotation
                    love.graphics.rotate( rotation*math.pi/180 + math.pi/2)
                end
                local scale = entity:getComponentByName("Scaled")
                if scale then
                    scale = scale.scale
                    love.graphics.scale(scale.x, scale.y)
                end
                if drawable.center then
                    love.graphics.translate(-drawable.center.x, -drawable.center.y)
                end

                if drawable.color then
                    love.graphics.setColor(drawable.color)
                else
                    love.graphics.setColor(entityColor)
                end

                if not drawable.hidden then
                    drawable:draw(entity)
                end
                love.graphics.pop()
            end
            love.graphics.pop()
            love.graphics.setColor({1,1,1,1})
        end
    end

    if Debug and Debug.drawArena == true then
        local arena = config.arena
        love.graphics.rectangle("line", arena.center.x - arena.size.x/2, arena.center.y - arena.size.y/2, arena.size.x, arena.size.y)
    end
    if Debug.drawCollidersDebug then
        local shapes = self.globalSystem.HC:hash():shapes()
        for _, shape in pairs(shapes) do
            love.graphics.setColor(1, 0, 0, 0.3)
            shape:draw("fill")
        end
    end
    love.graphics.setColor(1, 1, 1, 1)

end

function DrawSystem:handleRemoveComponent(component)
    if component.type == "Drawable" then
        for layer, entities in ipairs(self.layers) do
            entities[component.entity.id] = nil
        end
    end
end

return DrawSystem