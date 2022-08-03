require "settings"

Utils = require "engine.utils.utils"
Vector = require "lib.hump.vector"
Class = require "lib.hump.class"

prof  = require "lib.jprof.jprof"

PersistantStorage = require "engine.storage.storage" ("stats.lua", config.storage.default)

StateManager = require "lib.hump.gamestate"

AssetManager = require "engine.utils.asset_manager"
AssetManager:load("data")

local SoundData = require "data.sound.sound_data"
SoundManager = require "engine.sound.sound_manager" (SoundData)

local MusicData = require "data.music.music_data"
MusicPlayer = require "engine.sound.music_player" (MusicData)

states = {
    game = require "game.states.game",
}

fonts = require "data.fonts.fonts"

local pixelCanvas = require "engine.render.global_pixel_canvas" (
    Vector(config.render.screenSize.x, config.render.screenSize.y),
    config.render.initialResolution
)

function getScale()
    return pixelCanvas:getScale()
end

function getScreenDimensions()
    return pixelCanvas.resolution
end

function love.load()

    PersistantStorage:load()
    StateManager.switch(states.game)
end

function love.draw()

    pixelCanvas:renderTo( function()
        love.graphics.clear({0,0.2,.7,1})
        love.graphics.setFont(fonts.thin.font)
        StateManager.draw()
        if Debug and Debug.showFps == 1 then
            love.graphics.print(""..tostring(love.timer.getFPS( )), 2, 2)
        end
    end )
    pixelCanvas:draw()

    prof.pop("frame")
end

function love.fixedUpdate(dt)
    prof.push("frame")
    MusicPlayer:update(dt)
    StateManager.update(dt)
end

function love.mousepressed(x, y)
    if StateManager.current().mousepressed then
        StateManager.current():mousepressed(x, y)
    end
end

function love.mousereleased(x, y)
    if StateManager.current().mousereleased then
        StateManager.current():mousereleased(x, y)
    end
end

function love.keypressed(key)
    if StateManager.current().keypressed then
        StateManager.current():keypressed(key)
    end
end

function love.quit()
    prof.write("prof.mpack")
end

function love.resize( w, h )
    -- TODO
end
