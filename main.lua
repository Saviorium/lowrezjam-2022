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

states = {
    game = require "game.states.game",
}

fonts = require "data.fonts.fonts"

function love.load()
    PersistantStorage:load()
    StateManager.switch(states.game)
end

function love.draw()
    love.graphics.setFont(fonts.thin.font)
    StateManager.draw()
    if Debug and Debug.showFps == 1 then
        love.graphics.print(""..tostring(love.timer.getFPS( )), 2, 2)
    end
    if Debug and Debug.mousePos == 1 then
        local x, y = love.mouse.getPosition()
        love.graphics.print(""..tostring(x)..","..tostring(y), 2, 16)
    end
    prof.pop("frame")
end

function love.fixedUpdate(dt)
    prof.push("frame")
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
