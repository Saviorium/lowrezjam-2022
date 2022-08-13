return function(globalSystem)
    local nightBg =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, -32)})
        :addComponent('Image', {image = AssetManager:getImage("background-night")})
        :addComponent('DrawOrder', {order = config.draw.layers.bg})

    local dayBg =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, -32)})
        :addComponent('Image', {image = AssetManager:getImage("background-day")})
        :addComponent('DrawOrder', {order = config.draw.layers.bgDay})
        :addComponent('Colored', {color = {1, 1, 1, 0}})
        :addComponent('DoWithSun', {
            alphaColor = 0,
            speed = 0.25,
            update = function(self, dt, entity, currentDayState, timer, statesQueue)
                if currentDayState == "Sunrise" or currentDayState == "Morning" or currentDayState == "Noon" or currentDayState == "Afternoon" then
                    self.alphaColor = self.alphaColor + dt * self.speed
                else
                    self.alphaColor = self.alphaColor - dt * self.speed
                end
                self.alphaColor = math.clamp(0, self.alphaColor, 1)
                local entityColor = entity:getComponentByName("Colored").color
                entityColor[4] = self.alphaColor
            end
        })

    return { night = nightBg, day = dayBg }
end