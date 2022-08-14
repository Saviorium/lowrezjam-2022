local GlobalSystem = require "game.ecs.global_system"

local beatLogger = require "engine.utils.logger" ('RhythmPrint')

local Door = require "game.ecs.prefabs.door"
local Candle = require "game.ecs.prefabs.candle"
local Tutorial = require "game.ecs.prefabs.tutorial_animated"

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

    doorLeft:getComponentByName('PhysicsCollider').collider:moveTo(config.positions.yardWidth-2, config.positions.innerWallLevel)
    doorRight:getComponentByName('PhysicsCollider').collider:moveTo(config.positions.yardWidth + config.positions.houseWidth+2, config.positions.innerWallLevel)

    local candleLeft = Candle(self.world, Vector(108, 176-32))
    local candleRight = Candle(self.world, Vector(142, 176-32))

    local funcForWalls = function (self, dt, entity, currentDayState, timer, statesQueue)
                if currentDayState == 'Noon' or  currentDayState == 'Morning' or  currentDayState == 'Afternoon'then
                    entity:getComponentByName("PhysicsCollider").collider.type = 'Environment'
                else
                    entity:getComponentByName("PhysicsCollider").collider.type = 'NotEnvironment'
                end
            end
    local leftInnerWall  = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
        :addComponent('DoWithSun', { update = funcForWalls})
    local rightInnerWall = require "game.ecs.prefabs.wall" (self.world, Vector(houseWidth + yardWidth-5, innerWallLevel - innerWallHeight), innerWallwidth, innerWallHeight)
        :addComponent('DoWithSun', { update = funcForWalls})
    local roof           = require "game.ecs.prefabs.wall" (self.world, Vector(yardWidth-2, innerWallLevel - innerWallHeight+2), houseWidth, innerWallwidth)
        :addComponent('DoWithSun', { update = funcForWalls})
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

    local bat = require "game.ecs.prefabs.bat" (self.world, Vector(110, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(100, 150))
    require "game.ecs.prefabs.bat" (self.world, Vector(120, 130))
    require "game.ecs.prefabs.bat" (self.world, Vector(130, 140))
    require "game.ecs.prefabs.bat" (self.world, Vector(140, 130))

    local smallVampire = require "game.ecs.prefabs.small_vampire" (self.world, Vector(140, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(130, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(120, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(110, unistLevel))
    require "game.ecs.prefabs.small_vampire" (self.world, Vector(100, unistLevel))

    local girlVampire = require "game.ecs.prefabs.girl_vampire" (self.world, Vector(120, unistLevel))
    require "game.ecs.prefabs.girl_vampire" (self.world, Vector(150, unistLevel))
    require "game.ecs.prefabs.girl_vampire" (self.world, Vector(110, unistLevel))
    require "game.ecs.prefabs.girl_vampire" (self.world, Vector(130, unistLevel))
    -- local bat = require "game.ecs.prefabs.bat" (self.world)

    local projector1 = require "game.ecs.prefabs.projector" (self.world, Vector(73, 107))
    :setVariable("Rotation", "rotation", 180+45)
    local projector2 = require "game.ecs.prefabs.projector" (self.world, Vector(179, 107), "dancing-reverse")
    :setVariable("Rotation", "rotation", -45)


    local tutorialZxcv = Tutorial(self.world, "tutorial-zxcv", Vector(4, 26))
    print("press QWE to switch music")

    MusicPlayer:play("night", "forth-bar")
end

function state:mousepressed(x, y)
end

function state:mousereleased(x, y)
end

function state:keypressed(key)
end

function state:draw()
    self.world:draw()
end

function state:update(dt)
    self.world:update(dt)
end

return state