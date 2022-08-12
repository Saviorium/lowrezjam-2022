local GlobalSystem = require "game.ecs.global_system"

local beatLogger = require "engine.utils.logger" ('RhythmPrint')

local Door = require "game.ecs.prefabs.door"
local Candle = require "game.ecs.prefabs.candle"

local state = {}

function state:enter(prev_state, args)
    self.world = GlobalSystem()
    --local testObject = require "game.ecs.prefabs.test_object" (self.world)
    local houseFloorLevel = config.positions.houseFloorLevel
    local houseWidth = config.positions.houseWidth

    local yardLevel = config.positions.yardLevel
    local yardWidth = config.positions.yardWidth

    local rampLevel = config.positions.rampLevel
    local rampWidth = config.positions.rampWidth

    local floorThikness = config.positions.floorThikness
    local outerWallwidth, outerWallHeight = config.positions.outerWallwidth, config.positions.outerWallHeight
    local innerWallLevel = config.positions.innerWallLevel
    local innerWallwidth, innerWallHeight = config.positions.innerWallwidth, config.positions.innerWallHeight

    local houseFloor     = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth, houseFloorLevel), houseWidth, floorThikness)

    local leftYard       = require "game.ecs.prefabs.wall" (self.world, Vector(0, yardLevel), yardWidth, floorThikness)
    local rightYard      = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth, yardLevel), yardWidth, floorThikness)

    local leftRamp  = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth/2, rampLevel), rampWidth, floorThikness, -math.pi/7)
    local rightRamp = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth - 9, rampLevel), rampWidth, floorThikness, math.pi/7)

    local leftOuterWall  = require "game.ecs.prefabs.wall" (self.world, Vector(-outerWallwidth, houseFloorLevel-outerWallHeight), outerWallwidth, outerWallHeight)
    local rightOuterWall = require "game.ecs.prefabs.wall" (self.world, Vector(config.worldSize.x, houseFloorLevel-outerWallHeight), outerWallwidth, outerWallHeight)

    local doorLeft = Door(self.world, Vector(56, 190-32)):addComponent("Flipped", {flipped = true})
    local doorRight = Door(self.world, Vector(184, 190-32))
    local candleLeft = Candle(self.world, Vector(108, 176-32))
    local candleRight = Candle(self.world, Vector(142, 176-32))

    -- local leftInnerWall  = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
    -- local rightInnerWall = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth-5, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
    -- local roof           = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight+2), houseWidth, innerWallwidth)

    require "game.ecs.prefabs.sun" (self.world)

    local ball = require "game.ecs.prefabs.disco_ball" (self.world)
    local danceFloor = require "game.ecs.prefabs.dance_floor" (self.world)
    local dj = require "game.ecs.prefabs.dj_character" (self.world)
    local djBooth = require "game.ecs.prefabs.dj_booth" (self.world)
    local bg = require "game.ecs.prefabs.background" (self.world)
    local sky = require "game.ecs.prefabs.background_sky" (self.world)

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

    local bat = require "game.ecs.prefabs.bat" (self.world, Vector(110, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(100, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(120, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(130, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(140, 130))

    local smallVampire = require "game.ecs.prefabs.small_vampire" (self.world, Vector(140, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(130, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(120, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(110, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(100, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(90, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(80, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(70, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(60, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(50, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(190, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(200, unistLevel))
    local girlVampire = require "game.ecs.prefabs.girl_vampire" (self.world, Vector(120, unistLevel))
    -- local bat = require "game.ecs.prefabs.bat" (self.world)

    local projector1 = require "game.ecs.prefabs.projector" (self.world, Vector(73, 107))
    :setVariable("Rotation", "rotation", 180+45)
    local projector2 = require "game.ecs.prefabs.projector" (self.world, Vector(179, 107), "dancing-reverse")
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
    if key == "t" then
        StateManager.switch(states.final, {
                playerScore = self.world.systems.ScoreSystem.overallScore
            })
    end
            
end

function state:draw()
    self.world:draw()
end

function state:update(dt)
    self.world:update(dt)
end

return state