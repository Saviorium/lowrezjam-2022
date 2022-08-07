local System = require "game.ecs.systems.system"

local MouseCameraSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'CameraTarget', 'Position'})
        self.mainCamera = nil
    end,

    drawableWorldSize = Vector(
        config.worldSize.x - config.render.screenSize.x,
        config.worldSize.y - config.render.screenSize.y
    ),
}

function MouseCameraSystem:draw()
    love.graphics.push()
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX / love.graphics.getWidth()
    mouseY = mouseY / love.graphics.getHeight()

    local worldPosX = math.lerp(0, self.drawableWorldSize.x, mouseX)
    local worldPosY = math.lerp(0, self.drawableWorldSize.y, mouseY)
    love.graphics.translate(math.floor(-worldPosX), math.floor(-worldPosY))
end

return MouseCameraSystem