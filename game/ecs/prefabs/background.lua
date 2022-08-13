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

    local bloomImage = AssetManager:getImage("background-bloom")
    local bloomBgOverlay =  globalSystem:newEntity()
        :addComponent('Position', {position = Vector(0, -32)})
        :addComponent('Image', {image = bloomImage})
        :addComponent('DrawOrder', {order = config.draw.layers.characterBack})
        :addComponent('Colored', {color = {1, 1, 1, 0}})
        :addComponent('Cropped', {size = Vector(bloomImage:getWidth(), 1)})
        :addComponent('DoWithSun', {
            showAmount = 0, -- 1 == full
            alphaColor = 1,
            speed = 0.25,
            update = function(self, dt, entity, currentDayState, timer, statesQueue)
                if currentDayState == "Sunrise" then
                    self.alphaColor = 1
                    self.showAmount = self.showAmount + dt * self.speed
                elseif currentDayState == "Noon" then
                    self.alphaColor = self.alphaColor - dt * self.speed
                end
                self.alphaColor = math.clamp(0, self.alphaColor, 1)
                self.showAmount = math.clamp(0, self.showAmount, 1)
                local entityColor = entity:getComponentByName("Colored").color
                entityColor[4] = self.alphaColor

                local entityCrop = entity:getComponentByName("Cropped")
                entityCrop.size.y = math.lerp(0, bloomImage:getHeight(), self.showAmount)
            end
        })

    return { night = nightBg, day = dayBg, bloom = bloomBgOverlay }
end