return {
    name = "Falling", -- subjected to gravity
    type = "MovingManager",
    g = 10,
    isGrounded = false,
    bouncing = 1.8,
    minBounceSpeed = 200,

    update = function (self, dt, entity)
        prof.push("Jumping for = "..entity.id)

        local position = entity:getComponentByName("Position").position
        local velocity = entity:getComponentByName("Velocity").velocity

        if position.y >= 0 then
            if self.bouncing and self.bouncing > 0 and math.abs(velocity.y) > self.minBounceSpeed then
                velocity.y = -math.abs(velocity.y/self.bouncing)
            else
                position.y = 0
                velocity.y = 0
                self.isGrounded = true
            end
        elseif not (self.isGrounded) then
            velocity.y = velocity.y + self.g
        else
            self.isGrounded = false
        end
        prof.pop()
    end
}