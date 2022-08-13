local System = require "game.ecs.systems.system"

local CropSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'Cropped'})
        self.globalSystem = globalSystem
    end
}

function CropSystem:handleUpdateEntityFunc(dt, entityId, entity)
    local croppedComp = entity:getComponentByName("Cropped")
    if not croppedComp.quad then
        self:initQuad(entity)
    end

    local imageComp = entity:getComponentByName("Image")
    local imageSize = Vector(imageComp.image:getDimensions())

    local x, y = croppedComp.topLeft:unpack()
    local width, height = croppedComp.size:unpack()
    croppedComp.quad:setViewport(x, y, width, height, imageSize.x, imageSize.y)
end

function CropSystem:initQuad(entity)
    local croppedComp = entity:getComponentByName("Cropped")
    local imageComp = entity:getComponentByName("Image")
    local image = imageComp.image
    croppedComp.originalImage = image

    local x, y = image:getDimensions()
    local quad = love.graphics.newQuad(0, 0, x, y, x, y)
    croppedComp.quad = quad
    imageComp.draw = function (component)
        local quad = entity:getComponentByName("Cropped").quad
        love.graphics.draw(component.image, quad)
    end
    return quad
end

function CropSystem:draw()
end

return CropSystem