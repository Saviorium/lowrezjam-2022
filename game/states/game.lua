local GlobalSystem = require "game.ecs.global_system"

local beatLogger = require "engine.utils.logger" ('RhythmPrint')

local state = {}

function state:enter(prev_state, args)
    self.world = GlobalSystem()
    --local testObject = require "game.ecs.prefabs.test_object" (self.world)
    local testPlain = require "game.ecs.prefabs.test_plain" (self.world, Vector(0, 191), 256, 16)
    local testWall1 = require "game.ecs.prefabs.test_plain" (self.world, Vector(0, 191-64), 4, 64)
    local testWall2 = require "game.ecs.prefabs.test_plain" (self.world, Vector(250, 191-64), 4, 64)
    local ball = require "game.ecs.prefabs.disco_ball" (self.world)
    local danceFloor = require "game.ecs.prefabs.dance_floor" (self.world)
    local dj = require "game.ecs.prefabs.dj_character" (self.world)
    local djBooth = require "game.ecs.prefabs.dj_booth" (self.world)
    local bg = require "game.ecs.prefabs.background" (self.world)

    -- Денсеры
    local dancer = require "game.ecs.prefabs.beat_dancer" (self.world, Vector(158, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(148, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(138, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(128, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(118, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(108, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(98, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(120, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(130, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(140, 158))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(135, 158))

    local bat = require "game.ecs.prefabs.bat" (self.world, Vector(158, 130))
    local smallVampire = require "game.ecs.prefabs.small_vampire" (self.world, Vector(140, 158))
    local girlVampire = require "game.ecs.prefabs.girl_vampire" (self.world, Vector(120, 158))
    -- local bat = require "game.ecs.prefabs.bat" (self.world)

    local projector1 = require "game.ecs.prefabs.projector" (self.world, Vector(73, 107))
    :addComponent('ChangeColorFirst', {color = config.colors.red, input = 'beat1'})
    :addComponent('ChangeColorSecond', {color = config.colors.blue, input = 'beat2'})
    :setVariable("Rotation", "rotation", 180+45)
    local projector1 = require "game.ecs.prefabs.projector" (self.world, Vector(179, 107), "dancing-reverse")
    :addComponent('ChangeColorFirst', {color = config.colors.green, input = 'beat3'})
    :addComponent('ChangeColorSecond', {color = config.colors.purple, input = 'beat4'})

    :setVariable("Rotation", "rotation", -45)
    print("press M to play music")
end

function state:mousepressed(x, y)
end

function state:mousereleased(x, y)
end

function state:keypressed(key)
    if key == "m" then
        MusicPlayer:play("testLoop", "new-bar")
    end
    if key == "q" then
        MusicPlayer:play("night1", "forth-bar")
    end
    if key == "w" then
        MusicPlayer:play("night2", "forth-bar")
    end
    if key == "e" then
        MusicPlayer:play("night3", "forth-bar")
    end
    if key == "r" then
        MusicPlayer:play("night1Chill", "forth-bar")
    end
end

function state:draw()
    self.world:draw()
end

function state:update(dt)
    self.world:update(dt)
end

return state