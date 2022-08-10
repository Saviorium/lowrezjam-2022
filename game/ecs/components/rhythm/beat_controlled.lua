return {
    name = "BeatControlled",
    type = "InputSource",

    beatMap = {listen = "beat1", send = "jump"},

    updateAndGetInputs = function(self, dt)

        return {
            move = Vector(0, 0),
            attack1 = 0,
            jump = 0,
            startMove = 0,
            hide = 0,
        }
    end,
}