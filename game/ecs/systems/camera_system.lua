local System = require "game.ecs.systems.system"

local MouseCameraSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'CameraTarget', 'Position'})
        self.mainCamera = nil
    end,

    drawableWorldTopLeft = Vector(
        config.camera.topLeft.x,
        config.camera.topLeft.y
    ),
    drawableWorldSize = Vector(
        config.camera.size.x - config.render.screenSize.x,
        config.camera.size.y - config.render.screenSize.y
    ),
}

function MouseCameraSystem:draw()
    love.graphics.push()
    local mouseX, mouseY = love.mouse.getPosition()
    mouseX = mouseX / love.graphics.getWidth()
    mouseY = mouseY / love.graphics.getHeight()

    local worldPosX = math.lerp(self.drawableWorldTopLeft.x, self.drawableWorldSize.x, mouseX)
    local worldPosY = math.lerp(self.drawableWorldTopLeft.y, self.drawableWorldSize.y, mouseY)
    love.graphics.translate(math.floor(-worldPosX), math.floor(-worldPosY))
end

return MouseCameraSystem