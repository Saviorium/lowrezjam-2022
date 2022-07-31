local LINE_SIZE = 7
local INDENT_SIZE = 5
local MAX_DEPTH = 2

local function recursiveFieldsView(component, line, indent)
    for name, field in pairs(component) do
        if name ~= 'collider' and name ~= "entity" then
            if type(field) == 'table' then
                love.graphics.print(name, indent*INDENT_SIZE, line*LINE_SIZE)
                line = line + 1
                if indent < MAX_DEPTH then
                    line = recursiveFieldsView(field, line, indent+1)
                end
            elseif type(field) ~= 'function' then
                love.graphics.print(name..' = '.. tostring(field), indent*INDENT_SIZE, line*LINE_SIZE)
                line = line + 1
            end
        end
    end
    return line
end

return {
    name = "DrawDebug",
    type = "Drawable",
    color = { 1, 0, 1, 1 },

    draw = function (self, entity)
        prof.push("Draw debug entity = "..entity.id)
        if Debug.drawCharacterDebug then

            love.graphics.setColor(1,1,1,1)
            local line = 0
            local indent = 0
            for ind, component in pairs(entity.components) do

                prof.push("Draw debug component = "..component.name)
                love.graphics.print(ind, indent*INDENT_SIZE, line*LINE_SIZE)
                line = recursiveFieldsView(component, line+1, indent+1)
                prof.pop()
            end

        end
        if Debug.drawStateMachineDebug then
            local stateMachine = self.entity:getComponentByName("StateMachine")
            if stateMachine then
                local str = stateMachine:getCurrentStateName() .. " " .. stateMachine.timeInState
                love.graphics.print(str, 0, 0)
            end
        end
        prof.pop()
    end
}