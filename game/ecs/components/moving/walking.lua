return {
    name = "Walking",
    type = "MovingManager",
    maxSpeed = 5,
    friction = 30,
    acceleration = 5,
    dashing = false,
    dashingTimer = 0.1,

    update = function (self, dt, entity)
        local snapshot = entity:getComponentByName("Controlled").inputSnapshot
        if not snapshot then
            return
        end
        local velocity = entity:getComponentByName("Velocity").velocity

        local dirrectX, dirrectY = velocity.x > 0 and 1 or -1 , math.clamp(-1, velocity.y, 1)
        velocity.x = velocity.x + dt*60*snapshot.move.x*self.acceleration
        velocity.x = math.abs(velocity.x) - self.friction*dt > 0 and velocity.x - dirrectX * self.friction*dt or 0
        if not self.dashing then
            velocity.x = math.clamp(-self.maxSpeed, velocity.x, self.maxSpeed)
        end

        velocity.y = velocity.y + dt*60*snapshot.move.y*self.acceleration
        velocity.y = math.abs(velocity.y) - self.friction*dt > 0 and velocity.y - dirrectY * self.friction*dt or 0
        if not self.dashing then
            velocity.y = math.clamp(-self.maxSpeed, velocity.y, self.maxSpeed)
        end
        if self.dashing then
            self.dashingTimer = self.dashingTimer - dt
        end
        if self.dashingTimer < 0 then
            self.dashing = false
            self.dashingTimer = 0.1
        end
        entity:getComponentByName("Velocity").velocity = velocity

    end
}