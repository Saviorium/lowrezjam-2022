config = {
    inputs = {
        controls = {
            left = {'key:left'},
            right = {'key:right'},
            up = {'key:up'},
            down = {'key:down'},
            attack1 = {'key:x'},
            jump = {'key:z'},
        },
        pairs = {
            move = {'left', 'right', 'up', 'down'}
        },
    },

    storage = {
        default = {
            highScore = 0,
        }
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
}

Debug = {
    showFps = 1,
    mousePos = 0,
    RhythmPrint = 5,
}
