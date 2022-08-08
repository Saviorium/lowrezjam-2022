return {
    name = "SinusRotation",
    type = "Rotation",
    angle = 120,

    update = function (self, dt, entity)
        local rotation = entity:getComponentByName("Rotation")
        self.angle = self.angle + dt
        rotation.rotation = rotation.rotation + math.sin(self.angle*2)
    end
}