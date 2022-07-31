return {
    name = "UserControlled",
    type = "InputSource",
    inputManager = require "engine.controls.user_input_manager" (config.inputs),

    updateAndGetInputs = function(self, dt)
        self.inputManager:update(dt)
        return self.inputManager.inputSnapshot
    end
}