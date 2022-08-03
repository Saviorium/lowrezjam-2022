local GlobalSystem = require "game.ecs.global_system"

local beatLogger = require "engine.utils.logger" ('RhythmPrint')

local state = {}

function state:enter(prev_state, args)
    self.world = GlobalSystem()
    local testObject = require "game.ecs.prefabs.test_object" (self.world)

    print("press M to play music")
    MusicPlayer:registerRhythmCallback("bar", function() beatLogger(5, "BANG!") end)
    MusicPlayer:registerRhythmCallback("onBeat", function() beatLogger(5, "ping!") end)
    MusicPlayer:registerRhythmCallback("offBeat", function() beatLogger(5, "pong!") end)
end

function state:mousepressed(x, y)
end

function state:mousereleased(x, y)
end

function state:keypressed(key)
    if key == "m" then
        MusicPlayer:play("testLoop", "out-instant")
    end
end

function state:draw()
    self.world:draw()
end

function state:update(dt)
    self.world:update(dt)
end

return state