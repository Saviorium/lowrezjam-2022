return {
    name = "MoveWithSun",
    type = "SunControlled",
    speed = 10,

    update = function (self, dt, entity, currentDayState, timer, statesQueue)
        local velocity = entity:getComponentByName('Velocity')
        if statesQueue[currentDayState].direction then
            velocity.velocity.y = (statesQueue[currentDayState].direction == 'up' and -1 or 1) * self.speed 
        end
        
    end
}