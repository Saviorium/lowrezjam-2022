local GlobalSystem = require "game.ecs.global_system"

local state = {}

function state:enter(prev_state, args)
    self.world = GlobalSystem()
    local testObject = require "game.ecs.prefabs.test_object" (self.world)
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