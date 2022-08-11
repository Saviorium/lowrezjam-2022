local state = {}

function state:enter(prev_state, args)
    self.image = AssetManager:getImage("tutorial")
end

function state:mousepressed(x, y)
end

function state:mousereleased(x, y)
    StateManager.switch(states.game)
end

function state:keypressed(key)
    StateManager.switch(states.game)
end

function state:draw()
    love.graphics.draw(self.image, 0, 0)
end

function state:update(dt)
end

return state