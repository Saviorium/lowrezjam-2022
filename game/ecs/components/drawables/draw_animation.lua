return {
    name = "DrawAnimation",
    type = "Drawable",
    hidden = false,

    draw = function (component, entity)
        entity:getComponentByName("Animator").animator:draw()
    end
}