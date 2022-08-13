local System = require "game.ecs.systems.system"
local InputManager = require "engine.controls.user_input_manager" (config.inputs)

local log = require "engine.utils.logger" ('BeatLogger')

local BeatUiSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {})
        self.inputManager = globalSystem.systems.BeatSystem
        self.keysPressedOnCurrentBeat = {}
        self.prevBeatPos = 0
    end,
    rulerConfig = config.positions.beatRuler,
}

function BeatUiSystem:update(dt)
    local beatPos = MusicPlayer:getCurrentBeat()
    InputManager:update(dt)
    local input = InputManager.inputSnapshot.pressed
    local keysPressed = Utils.count(input, function(v) return v end)

    if keysPressed > 0 then
        table.insert(self.keysPressedOnCurrentBeat, 1, beatPos)
    end

    if #self.keysPressedOnCurrentBeat > self.rulerConfig.keysToShow then
        for i, v in ipairs(self.keysPressedOnCurrentBeat) do
            if i > self.rulerConfig.keysToShow then
                self.keysPressedOnCurrentBeat[i] = nil
            end
        end
    end

    self.prevBeatPos = beatPos
end

function BeatUiSystem:draw()
    local goodHitStartPoint = math.ceil(self:toPointOnRuler(0.5 - config.music.rhythmHitTolerance / 2))
    local goodHitEndPoint = math.ceil(self:toPointOnRuler(0.5 + config.music.rhythmHitTolerance / 2))
    local currentBeatPoint = self:toPointOnRuler((self.prevBeatPos + 0.5) % 1)

    love.graphics.push()
    love.graphics.origin()
    love.graphics.translate(self.rulerConfig.position.x, self.rulerConfig.position.y)
    love.graphics.setColor(config.colors.rulerMissBg)
    love.graphics.rectangle("fill", 0, 0, self.rulerConfig.size.x, self.rulerConfig.size.y)

    love.graphics.setColor(config.colors.rulerHitBg)
    love.graphics.rectangle("fill", goodHitStartPoint, 0, goodHitEndPoint - goodHitStartPoint, self.rulerConfig.size.y)

    love.graphics.setColor(config.colors.rulerBeatMark)
    self:drawMark(self:toPointOnRuler(0.5))

    love.graphics.translate(self.rulerConfig.marksPos.x, self.rulerConfig.marksPos.y)
    love.graphics.setColor(config.colors.rulerBeatMark)
    self:drawMark(currentBeatPoint)

    local color = config.colors.rulerKeyMark
    for i, hitPoint in pairs(self.keysPressedOnCurrentBeat) do
        love.graphics.setColor(color[1], color[2], color[3], (self.rulerConfig.keysToShow-i)/self.rulerConfig.keysToShow)
        self:drawMark(self:toPointOnRuler((hitPoint + 0.5) % 1))
    end
    love.graphics.pop()
end

function BeatUiSystem:toPointOnRuler(x)
    local rulerConf = self.rulerConfig
    return math.lerp(rulerConf.position.x, rulerConf.position.x + rulerConf.size.x, x)
end

function BeatUiSystem:drawMark(point)
    love.graphics.rectangle(
        "fill",
        math.ceil(point - self.rulerConfig.marksSize.x/2),
        math.ceil(0 - self.rulerConfig.marksSize.x/2),
        self.rulerConfig.marksSize.x,
        self.rulerConfig.marksSize.y
    )
end

return BeatUiSystem