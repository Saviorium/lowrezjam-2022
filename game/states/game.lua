local GlobalSystem = require "game.ecs.global_system"

local beatLogger = require "engine.utils.logger" ('RhythmPrint')

local state = {}

function state:enter(prev_state, args)
    self.world = GlobalSystem()
    --local testObject = require "game.ecs.prefabs.test_object" (self.world)
    local houseFloorLevel = 192
    local houseWidth = 116

    local yardLevel = 210
    local yardWidth = (config.worldSize.x - houseWidth)/2

    local rampLevel = houseFloorLevel + (yardLevel - houseFloorLevel)/2 - 1
    local rampWidth = yardWidth/2 + 8

    local floorThikness = 16
    local outerWallwidth, outerWallHeight = 4, 64
    local innerWallLevel = houseFloorLevel - 20
    local innerWallwidth, innerWallHeight = 4, 64

    local houseFloor     = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth, houseFloorLevel), houseWidth, floorThikness)

    local leftYard       = require "game.ecs.prefabs.wall" (self.world, Vector(0, yardLevel), yardWidth, floorThikness)
    local rightYard      = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth, yardLevel), yardWidth, floorThikness)

    local leftRamp  = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth/2, rampLevel), rampWidth, floorThikness, -math.pi/7)
    local rightRamp = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth - 9, rampLevel), rampWidth, floorThikness, math.pi/7)
    
    local leftOuterWall  = require "game.ecs.prefabs.wall" (self.world, Vector(-outerWallwidth, houseFloorLevel-outerWallHeight), outerWallwidth, outerWallHeight)
    local rightOuterWall = require "game.ecs.prefabs.wall" (self.world, Vector(config.worldSize.x, houseFloorLevel-outerWallHeight), outerWallwidth, outerWallHeight)
    
    local leftInnerWall  = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
    local rightInnerWall = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth-5, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
    local roof           = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight+2), houseWidth, innerWallwidth)
    
    local ball = require "game.ecs.prefabs.disco_ball" (self.world)
    local danceFloor = require "game.ecs.prefabs.dance_floor" (self.world)
    local dj = require "game.ecs.prefabs.dj_character" (self.world)
    local djBooth = require "game.ecs.prefabs.dj_booth" (self.world)
    local bg = require "game.ecs.prefabs.background" (self.world)

    local unitHeight = 12
    local unistLevel = houseFloorLevel - unitHeight
    -- Денсеры
    local dancer = require "game.ecs.prefabs.beat_dancer" (self.world, Vector(158, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(148, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(138, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(128, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(118, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(108, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(98,  unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(120, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(130, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(140, unistLevel))
    require "game.ecs.prefabs.beat_dancer" (self.world, Vector(135, unistLevel))

    local bat = require "game.ecs.prefabs.bat" (self.world, Vector(unistLevel, 130))
    local smallVampire = require "game.ecs.prefabs.small_vampire" (self.world, Vector(140, unistLevel))
    local girlVampire = require "game.ecs.prefabs.girl_vampire" (self.world, Vector(120, unistLevel))
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