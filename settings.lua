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
    },
    draw = {
        layers = { -- must be consecutive
            bg = 1,
            common = 2,
            characterBack = 3,
            characterFront = 4,
            bullets = 5,
            ui = 6,
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
    teleportDistance = 16
}

Debug = {
    showFps = 1,
    mousePos = 0,
    RhythmPrint = 5,
    drawCollidersDebug = true,
    BeatLogger = 2,
}
