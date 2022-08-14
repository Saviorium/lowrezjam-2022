return {
    name = "Falling", -- subjected to gravity
    type = "MovingManager",
    g = 1,
    isGrounded = false,
    bouncing = 0,
    minBounceSpeed = 1,
    maxFallingSpeed = 15,

    update = function (self, dt, entity)
        prof.push("Falling for = "..entity.id)

        local position = entity:getComponentByName("Position").position
        local velocity = entity:getComponentByName("Velocity").velocity
        local colliderComp = entity:getComponentByName("PhysicsCollider")

        local collisionWithEnv = false
        if colliderComp and colliderComp.collider and colliderComp.collisions then
            for shape, delta in pairs(colliderComp.collisions) do
                if shape.type == 'Environment' and delta.y < -0.1 then
                    collisionWithEnv = true
                end
            end
            velocity.y = math.min(velocity.y + self.g, self.maxFallingSpeed)

            if collisionWithEnv then
                -- if self.bouncing and self.bouncing > 0 and math.abs(velocity.y) > self.minBounceSpeed then
                --     velocity.y = -math.abs(velocity.y/self.bouncing)
                -- else
                --     --position.y = 0
                --     velocity.y = 0
                --     self.isGrounded = true
                -- end
                velocity.y = 0
                self.isGrounded = true
            -- elseif not (self.isGrounded) then
            --     velocity.y = velocity.y + self.g
            -- elseif velocity.y < 0 then
            --     self.isGrounded = false
            end
        end
        prof.pop()
    end
}