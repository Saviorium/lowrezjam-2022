local System = require "game.ecs.systems.system"
local InputManager = require "engine.controls.user_input_manager" (config.inputs)

local log = require "engine.utils.logger" ('BeatLogger')

local BeatSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {"BeatControlled"})

        self.streak = 0
        self.prevFrameBeat = 0
        self.prevFrameBeatUnFloored = 0
        self.keysPressedOnCurrentBeat = 0
        self.offBeatHappened = false
        self.isInputSent = false
    end
}

function BeatSystem:update(dt)
    InputManager:update(dt)
    local input = InputManager.inputSnapshot.pressed
    local keysPressed = Utils.count(input, function(v) return v end)

    local beatPos = MusicPlayer:getCurrentBeat()
    local currentBeat = math.floor(beatPos-0.5) % MusicPlayer:getSignature() + 1
    if currentBeat ~= self.prevFrameBeat then
        self:handleNextBeat()
    end

    local isOnBeat = self.isHitOnBeat(beatPos)
    local missBeat = self.isMissedBeat(beatPos)

    if not missBeat and not self.offBeatHappened then
        self.keysPressedOnCurrentBeat = self.keysPressedOnCurrentBeat + keysPressed

        if keysPressed > 0 and ( not isOnBeat or self.keysPressedOnCurrentBeat > 1 ) then
            log(2, string.format("offbeat! %f", beatPos))
            self:handleOffBeat()
        else
            if keysPressed == 1 and isOnBeat then
                log(2, "hit!")
                log(3, string.format("beatPos %f", beatPos))
                self:sendInputToEntites(input)
            end
        end
    else
        if keysPressed == 1 then
            if self.offBeatHappened then
                log(2, "Ignoring beat after miss")
            else
                log(2, string.format("Complete miss %f", beatPos))
            end
        end
    end

    for _, entity in pairs(self.pool) do
        local beatMapping = entity:getComponentByName("BeatControlled")
        local beatDelta = self.prevFrameBeatUnFloored <= beatPos and (beatPos - self.prevFrameBeatUnFloored) or (beatPos - self.prevFrameBeatUnFloored + 4)
        beatMapping.beatsFromLastInput = (beatMapping.beatsFromLastInput or 0) + beatDelta
        beatMapping.beatDelta = beatDelta
    end

    self.prevFrameBeat = currentBeat
    self.prevFrameBeatUnFloored = beatPos
end

function BeatSystem:sendInputToEntites(input)
    for _, entity in pairs(self.pool) do
        local beatMapping = entity:getComponentByName("BeatControlled")
        beatMapping.beatsFromLastInput = 0
        local controller = entity:getComponentByName("Controlled")
        for _, beatInput in pairs(beatMapping.beatMap) do
            print(beatInput.listen, input[beatInput.listen], beatInput.send)
            if input[beatInput.listen] then
                controller.inputSnapshot[beatInput.send] = 1
            end
        end
    end
    self.isInputSent = true
end

function BeatSystem:handleNextBeat()
    log(4, "Next beat")
    self.offBeatHappened = false
    self.keysPressedOnCurrentBeat = 0
    self.isInputSent = false
end

function BeatSystem:handleOffBeat()
    self.streak = 0
    self.offBeatHappened = true
end

function BeatSystem.isHitOnBeat(beat)
    return 1 - math.abs( (beat % 1) * 2 - 1) < config.music.rhythmHitTolerance
end

function BeatSystem.isMissedBeat(beat)
    return 1 - math.abs((beat % 1) * 2 - 1) > config.music.rhythmCompleteMiss
end



return BeatSystem