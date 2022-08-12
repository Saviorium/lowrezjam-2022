local state = {}

function state:enter(prev_state, args)
    -- self.image = AssetManager:getImage("tutorial")
    self.tutorialHead = 'Press buttons in beat'
    self.tutorialButtons = 'Z, X, C, V'
    self.tutorialScript = 'Everything in world dancing in beat'
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
    love.graphics.setColor(0,0,0,1)
    love.graphics.rectangle('fill', 0, 0, config.worldSize.x, config.worldSize.y)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf(self.tutorialHead,
        fonts.thin.font,
        4,
        0,
        config.render.screenSize.x - 4,
        'center')

    love.graphics.printf(self.tutorialButtons,
        fonts.thin.font,
        4,
        fonts.thin.height*3,
        config.render.screenSize.x - 4,
        'center')
    love.graphics.printf(self.tutorialScript,
        fonts.thin.font,
        4,
        fonts.thin.height*5,
        config.render.screenSize.x - 4,
        'center')
end

function state:update(dt)
end

return state