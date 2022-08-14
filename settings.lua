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
    camera = {
        topLeft = { x = 0, y = 0 },
        size = { x = 256, y = 239 },
    },
    colors = {
        red = { 0.9, 0.1, 0.2 },
        blue = { 0.1, 0.2, 0.9 },
        green = { 0.1, 0.9, 0.2 },
        purple = { 0.9, 0.1, 0.7 },
        rulerMissBg = { 1, 1, 1 },
        rulerHitBg = Utils.colorFromHex("1e8a4c"),
        rulerKeyMark = Utils.colorFromHex("cccccc"),
        rulerBeatMark = Utils.colorFromHex("ffffff"),
    },
    draw = {
        layers = { -- must be consecutive
            bgFar = 1,
            bgSun = 2,
            bg = 3,
            bgDay = 4,
            bgFront = 5,
            common = 6,
            characterBack = 7,
            characterFront = 8,
            bullets = 9,
            ui = 10,
        },
    },
    render = {
        screenSize = { x = 64, y = 64 },
        initialResolution = 4,
        drawOrderGrid = 4
    },
    randomMoveDistance = 10,
    scaleKeyBind = false,

    music = {
        rhythmHitTolerance = 0.21,
        rhythmCompleteMiss = 0.4,
    },
    speed = {
        slow = 10,
        average = 20,
        fast = 30
    },
    positions = {
        houseFloorLevel = 190,
        houseWidth = 105,

        yardLevel = 210,
        yardWidth = (256 - 105)/2, -- (config.worldSize.x - houseWidth)/2

        rampLevel = 190 + (210 - 190)/2 - 1, -- houseFloorLevel + (yardLevel - houseFloorLevel)/2 - 1
        rampWidth = ((256 - 105)/2) /2 + 8, -- ardWidth/2 + 8

        floorThikness = 16,
        outerWallwidth = 4,
        outerWallHeight = 64,

        innerWallLevel = 190-15, -- houseFloorLevel - 15

        innerWallwidth = 4,
        innerWallHeight = 64,

        doorHeight = 32,
        doorWidth  = 6,

        beatRuler = {
            position = { x = 0, y = 64-1 },
            size = { x = 64, y = 1 },
            marksPos = { x = 0, y = -1 },
            marksSize = { x = 1, y = 1 },
            keysToShow = 8,
        },
    },
    sun = {
        speed = 15,
        timerToLeave = 20
    },
    teleportDistance = 16,
    beatsForMove = 4
}

Debug = {
    showFps = 1,
    mousePos = 0,
    RhythmPrint = 1,
    drawCollidersDebug = false,
    BeatLogger = 1,
}
