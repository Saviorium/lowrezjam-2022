local System = require "game.ecs.systems.system"

local BeatSyncSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {"SyncToBeat"})

        self.prevFrameBeatPos = 0
        self.prevFrameBeat = 0
    end,

    defaultAnimationBpm = 60, -- make your animations 1000ms long
}

function BeatSyncSystem:update(dt)
    local beatPos = MusicPlayer:getCurrentBeat()
    local beat = math.floor(beatPos)

    local isNextBeat = beat~=self.prevFrameBeat

    for _, entity in pairs(self.pool) do
        if isNextBeat and beat == 1 then
            local syncAnimationComp = entity:getComponentByName("SyncAnimationToBeat")
            if syncAnimationComp then
                local animator = entity:getComponentByName("Animator").animator
                local animationSpeed = MusicPlayer:getBpm() / self.defaultAnimationBpm

                animator:setSpeed(animationSpeed)
                animator:restart()
            end
        end

        local actionComp = entity:getComponentByName("ActionToBeat")
        if actionComp and self:shouldReactToCurrentBeat(actionComp, self.prevFrameBeatPos, beatPos) then
            local controllerComp = entity:getComponentByName("Controlled")
            if controllerComp then
                controllerComp.inputSnapshot[actionComp.action] = 1
            end
        end

        local doOnBeatComp = entity:getComponentByName("DoOnBeat")
        if doOnBeatComp and self:shouldReactToCurrentBeat(doOnBeatComp, self.prevFrameBeatPos, beatPos) then
            doOnBeatComp:onBeat(entity)
        end
    end

    self.prevFrameBeatPos = beatPos
    self.prevFrameBeat = beat
end

function BeatSyncSystem:shouldReactToCurrentBeat(comp, fromBeatPos, toBeatPos)
    if comp.everyBeat then
        local fromBeatPosTrunc = fromBeatPos % 1
        local toBeatPosTrunc = toBeatPos % 1
        for _, beatPos in pairs(comp.everyBeat) do
            local beatPosTrunc = beatPos % 1
            if beatPosTrunc > fromBeatPosTrunc and beatPosTrunc < toBeatPosTrunc
            or fromBeatPosTrunc > toBeatPosTrunc and (beatPosTrunc > fromBeatPosTrunc or beatPosTrunc < toBeatPosTrunc)
            then
                return true
            end
        end
    end
    if comp.barPoints then
        for _, beatPos in pairs(comp.barPoints) do
            if beatPos > fromBeatPos and beatPos < toBeatPos
            or fromBeatPos > toBeatPos and (beatPos < fromBeatPos or beatPos > toBeatPos) then  -- overflow check
                return true
            end
        end
    end
    return false
end

return BeatSyncSystem