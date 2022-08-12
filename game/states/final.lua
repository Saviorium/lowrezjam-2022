local state = {}

function state:enter(prev_state, args)
    self.args = args
    self.highScore = self.args.playerScore
end 

function state:mousepressed(x, y)
end

function state:mousereleased(x, y)
end

function state:keypressed(key)
end

function state:draw()
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill', 0, 0, config.worldSize.x, config.worldSize.y)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf('Your score \n'..self.highScore,
        fonts.thin.font,
        4,
        fonts.thin.height*3,
        config.render.screenSize.x - 4,
        'center')
end

function state:update(dt)
end

return state

