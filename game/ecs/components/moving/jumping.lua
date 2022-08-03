local log = require "engine.utils.logger" ("Walking")
return {
    name = "Jumping",
    type = "MovingManager",
    maxSpeed = 500,
    jumpForce = 500,

    update = function (self, dt, entity)
        prof.push("Jumping for = "..entity.id)

        local snapshot = entity:getComponentByName("Controlled").inputSnapshot

        log( 3, "Snapshot : move (".. snapshot.move.x ..",".. snapshot.move.y ..")")

        if not snapshot then
            return
        end
        local velocity = entity:getComponentByName("Velocity").velocity
        if entity:getComponentByName('Falling').isGrounded and snapshot.move.y > 0 then
            velocity.y = math.clamp(-self.maxSpeed, velocity.y + dt*60*snapshot.move.y*self.jumpForce, self.maxSpeed)
            entity:getComponentByName('Falling').isGrounded = false
        end
        entity:getComponentByName("Velocity").velocity = velocity

        prof.pop()
    end
}