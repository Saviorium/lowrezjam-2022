return {
    name = "DrawCircle",
    type = "Drawable",
    color = { 1, 0, 0.5, 1 },
    fillMode = "fill",
    style = "rough",
    radius = 0,
    center = {x = 1, y = 1},

    draw = function (self)
        prof.push("Draw circle")
        local circle = self
        love.graphics.setColor(circle.color)
        love.graphics.setLineStyle(circle.style)
        love.graphics.circle(circle.fillMode, 0, 0, circle.radius)
        love.graphics.setColor(1,1,1,1)
        prof.pop()
    end
}