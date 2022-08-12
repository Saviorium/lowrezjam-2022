local log = require "engine.utils.logger" ("Walking")
return {
    name = "Friction",
    type = "MovingManager",
    groundFriction = 100,
    airFriction = 1000,
    maxSpeed = 200,

    update = function (self, dt, entity)
        prof.push("Friction for = "..entity.id)

        local velocity = entity:getComponentByName("Velocity").velocity

        local grounded = true
        if entity:getComponentByName('Falling') then
            grounded = entity:getComponentByName('Falling').isGrounded
        end

        local friction

        if grounded then
            friction = self.groundFriction*dt
        else
            friction = self.airFriction*dt
        end
        local directionX = velocity.x > 0 and 1 or -1
        velocity.x = math.abs(velocity.x) - friction > 0 and velocity.x - directionX * friction or 0

        velocity.x = math.clamp(-self.maxSpeed, velocity.x, self.maxSpeed)
        -- velocity.y = math.clamp(-self.maxSpeed, velocity.y, self.maxSpeed)

        entity:getComponentByName("Velocity").velocity = velocity

        prof.pop()
    end
}