return {
    name = "CameraToObjects",
    type = "CameraTarget",
    minScale = 0.4,
    zoomSpeed = 0.2,
    speed = 0.2, -- 1 = instant
    padding = 1.4, -- 2 = equal distance from objects to borders of the screen

    scale = 8,
    objects = {},

    update = function (self, dt)
        local arenaSize = Vector(config.arena.size.x, config.arena.size.y)
        local arenaCenter = Vector(config.arena.center.x, config.arena.center.y)
        -- find rect around objects
        local targetRect = { upLeft = nil, downRight = nil }
        for _, obj in pairs(self.objects) do
            local newPos = obj:getComponentByName("Position").position
            if targetRect.upLeft == nil then
                targetRect.upLeft = newPos:clone()
                targetRect.downRight = newPos:clone()
            else
                if newPos.x < targetRect.upLeft.x then
                    targetRect.upLeft.x = newPos.x
                end
                if newPos.x > targetRect.downRight.x then
                    targetRect.downRight.x = newPos.x
                end
                if newPos.y < targetRect.upLeft.y then
                    targetRect.upLeft.y = newPos.y
                end
                if newPos.y > targetRect.downRight.y then
                    targetRect.downRight.y = newPos.y
                end
            end
        end
        targetRect = {
            center = targetRect.upLeft + (targetRect.downRight - targetRect.upLeft) / 2,
            size = targetRect.downRight - targetRect.upLeft
        }
        -- resize rect, to add padding
        targetRect.size = targetRect.size * self.padding
        -- if either side is smaller than minScale then set it to minScale
        local scale = Vector(targetRect.size.x / arenaSize.x, targetRect.size.y / arenaSize.y)
        if scale.x < self.minScale then
            targetRect.size.x = arenaSize.x*self.minScale
        end
        if scale.y < self.minScale then
            targetRect.size.y = arenaSize.y*self.minScale
        end
        -- set lowest side to comply to screen aspect ratio
        local screenWidth, screenHeight = love.graphics.getDimensions()
        local screenAspectRatio = screenWidth / screenHeight
        if targetRect.size.y == 0 then -- workaround div by 0
            targetRect.size.y = targetRect.size.x / screenAspectRatio
        else
            local rectAspectRatio = targetRect.size.x / targetRect.size.y
            if screenAspectRatio > rectAspectRatio then
                targetRect.size.x = targetRect.size.y * screenAspectRatio
            else
                targetRect.size.y = targetRect.size.x / screenAspectRatio
            end
        end
        -- fit screen to min dimension
        if targetRect.size.x > arenaSize.x then
            targetRect.size.x = arenaSize.x
            targetRect.center.x = arenaCenter.x
            if targetRect.size.y > arenaSize.y then
                targetRect.center.y = arenaCenter.y
            end
            targetRect.size.y = targetRect.size.x / screenAspectRatio
        end
        if targetRect.size.y > arenaSize.y then
            targetRect.size.y = arenaSize.y
            targetRect.center.y = arenaCenter.y
            if targetRect.size.x > arenaSize.x then
                targetRect.center.x = arenaCenter.x
            end
            targetRect.size.x = targetRect.size.y * screenAspectRatio
        end
        -- if rect is outside arena then move it sideways inside
        local leftOutside = math.max(0, (arenaCenter.x - arenaSize.x/2) - (targetRect.center.x - targetRect.size.x/2))
        local rightOutside = math.min(0, (arenaCenter.x + arenaSize.x/2) - (targetRect.center.x + targetRect.size.x/2))
        local upOutside = math.max(0, (arenaCenter.y - arenaSize.y/2) - (targetRect.center.y - targetRect.size.y/2))
        local downOutside = math.min(0, (arenaCenter.y + arenaSize.y/2) - (targetRect.center.y + targetRect.size.y/2))
        if leftOutside > 0 and rightOutside < 0 then -- screen is bigger than arena - show it on the center of the screen
            targetRect.center.x = arenaCenter.x
        else
            targetRect.center.x = targetRect.center.x + leftOutside + rightOutside
        end
        if upOutside > 0 and downOutside < 0 then
            targetRect.center.y = arenaCenter.y
        else
            targetRect.center.y = targetRect.center.y + upOutside + downOutside
        end
        -- set pos to upper left point of that rect multiplied by speed
        local pos = self.entity:getComponentByName("Position").position
        self.entity:getComponentByName("Position").position = math.lerp(pos, targetRect.center - targetRect.size/2, self.speed)
        -- set scale to rect size / arenaSize
        scale = (arenaSize.x / targetRect.size.x) * (screenWidth / arenaSize.x)
        self.scale = math.lerp(self.scale, scale, self.zoomSpeed)
    end
}