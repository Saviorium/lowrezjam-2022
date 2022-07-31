return {
    name = "Flying",
    type = "MovingManager",
    maxSpeed = 5,
    friction = 1,
    acceleration = 5,

    update = function (self, dt, entity)
        local controlComp = entity:getComponentByName("Controlled")
        local velocity = entity:getComponentByName("Velocity").velocity

        if controlComp and controlComp.inputSnapshot and controlComp.inputSnapshot.move then
            velocity = velocity + dt*60*controlComp.inputSnapshot.move*self.acceleration
        end
        velocity = velocity / (self.friction)
        velocity.x = math.clamp(-self.maxSpeed, velocity.x, self.maxSpeed)
        velocity.y = math.clamp(-self.maxSpeed, velocity.y, self.maxSpeed)


        entity:getComponentByName("Velocity").velocity = velocity
    end
}