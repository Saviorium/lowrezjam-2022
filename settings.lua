config = {
    inputs = {
        controls = {
            beat1 = {'key:z'},
            beat2 = {'key:x'},
            beat3 = {'key:c'},
            beat4 = {'key:v'},
            hide = {'key:space'},
        },
    },

    storage = {
        default = {
            highScore = 0,
        }
    },

    worldSize = {
        x=256,
        y=256,
    },
    colors = {
        red = { 0.9, 0.1, 0.2 },
        blue = { 0.1, 0.2, 0.9 },
        green = { 0.1, 0.9, 0.2 },
        purple = { 0.9, 0.1, 0.7 },
    },
    draw = {
        layers = { -- must be consecutive
            bg = 1,
            bgFront = 2,
            common = 3,
            characterBack = 4,
            characterFront = 5,
            bullets = 6,
            ui = 7,
        },
    },
    render = {
        screenSize = { x = 64, y = 64 },
        initialResolution = 4,
        drawOrderGrid = 4
    },
    randomMoveDistance = 10,

    music = {
        rhythmHitTolerance = 0.2,
        rhythmCompleteMiss = 0.4,
    },
    speed = {
        slow = 8,
        average = 12,
        fast = 16
    },
    positions = {
        houseFloorLevel = 192,
        houseWidth = 116,

        yardLevel = 210,
        yardWidth = (256 - 116)/2, -- (config.worldSize.x - houseWidth)/2

        rampLevel = 192 + (210 - 192)/2 - 1, -- houseFloorLevel + (yardLevel - houseFloorLevel)/2 - 1
        rampWidth = ((256 - 116)/2) /2 + 8, -- ardWidth/2 + 8

        floorThikness = 16,
        outerWallwidth = 4,
        outerWallHeight = 64,

        innerWallLevel = 192-20, -- houseFloorLevel - 20

        innerWallwidth = 4,
        innerWallHeight = 64,
    },
    sun = {
        speed = 10
    },
    teleportDistance = 16
}

Debug = {
    showFps = 1,
    mousePos = 0,
    RhythmPrint = 5,
    drawCollidersDebug = true,
    BeatLogger = 2,
}
