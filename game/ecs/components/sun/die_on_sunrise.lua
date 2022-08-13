return {
    name = "OnSunriseDieOutdoors",
    type = "SunControlled",

    update = function (self, dt, entity, currentDayState, timer)
        local position = entity:getComponentByName('Position').position
        if (position.x < config.positions.yardWidth or position.x > config.positions.houseWidth + config.positions.yardWidth )
       and (currentDayState == 'Noon' or  currentDayState == 'Morning' or  currentDayState == 'Afternoon') then
            entity:remove()
        end
    end
}