return {
    name = "DrawText",
    type = "Drawable",
    font = fonts.thin.font,
    text = '',
    hidden = false,

    draw = function (component, entity)
        love.graphics.print(component.text, component.font, 0, 0)
    end
}