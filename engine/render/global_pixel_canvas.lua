local Class = require "lib.hump.class"

-- Global pixelated fixed size scale ajustable canvas
local MainPixelCanvas = Class {
    init = function(self, resolution, scale)
        self.resolution = resolution
        self.canvas = love.graphics.newCanvas(resolution.x, resolution.y)
        self.canvas:setFilter("nearest", "nearest")
        self.maxScale = self:__getMaxScale()
        self:setScale(scale)
    end
}

function MainPixelCanvas:__getMaxScale()
    local width, height = love.window.getDesktopDimensions()
    local maxWidthScale  = width  / self.resolution.x
    local maxHeightScale = height / self.resolution.y
    return math.floor( math.min(maxWidthScale, maxHeightScale) )
end

function MainPixelCanvas:setScale(scaleFactor)
    scaleFactor = math.pow(2, scaleFactor - 1)
    scaleFactor = math.min(self.maxScale, scaleFactor)
    self.scale = scaleFactor
    love.window.setMode(self.resolution.x*scaleFactor, self.resolution.y*scaleFactor)
end

function MainPixelCanvas:getCanvas()
    return self.canvas
end

function MainPixelCanvas:getScale()
    return self.scale
end

function MainPixelCanvas:renderTo(func)
    local prevCanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(self.canvas)
    func()
    love.graphics.setCanvas(prevCanvas)
end

function MainPixelCanvas:draw()
    if not self.canvas then return end
    love.graphics.draw(
        self.canvas,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() / 2,
        0,
        self.scale,
        self.scale,
        self.canvas:getWidth() / 2,
        self.canvas:getHeight() / 2
    )
end

return MainPixelCanvas
