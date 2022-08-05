return {
    name = "Falling", -- subjected to gravity
    type = "MovingManager",
    g = 10,
    isGrounded = false,
    bouncing = 0,
    minBounceSpeed = 1,

    update = function (self, dt, entity)
        prof.push("Jumping for = "..entity.id)

        local position = entity:getComponentByName("Position").position
        local velocity = entity:getComponentByName("Velocity").velocity
        local collider = entity:getComponentByName("PhysicsCollider").collider

        local collisionWithEnv = false
        if collider then
        for shape, delta in pairs(entity.globalSystem.HC:collisions(collider)) do
            if shape.type == 'Environment' and delta.y < -0.1 then
                collisionWithEnv = true
            end
        end

            if collisionWithEnv then
                if self.bouncing and self.bouncing > 0 and math.abs(velocity.y) > self.minBounceSpeed then
                    velocity.y = -math.abs(velocity.y/self.bouncing)
                else
                    --position.y = 0
                    velocity.y = 0
                    self.isGrounded = true
                end
            elseif not (self.isGrounded) then
                velocity.y = velocity.y + self.g
            else
                self.isGrounded = false
            end
        end
        prof.pop()
    end
}