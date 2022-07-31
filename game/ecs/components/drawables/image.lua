return {
    name = "Image",
    type = "Drawable",
    image = nil,
    hidden = false,
    center = {x = 0, y = 0},

    draw = function (component)
        love.graphics.draw(component.image)
    end
}