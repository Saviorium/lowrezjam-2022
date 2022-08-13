return {
    name = "MoveWithSun",
    type = "SunControlled",
    speed = 10,

    update = function (self, dt, entity, currentDayState, timer, statesQueue)
        local velocity = entity:getComponentByName('Velocity')
        if statesQueue[currentDayState].direction then
            local direction = statesQueue[currentDayState].direction == 'up' and -1 or (statesQueue[currentDayState].direction == 'down' and 1 or 0)
            velocity.velocity.y = direction * self.speed * (statesQueue[currentDayState].speed or 1)
        else
            velocity.velocity.y = 0
        end
    end
}