local states = Utils.importRecursively("game/statemachines/character_states")

local initStateMachine = function()
    local stateMachine = {}
    for _, state in pairs(states) do
        local stateInstance = state()
        stateMachine[stateInstance.name] = stateInstance
    end
    return stateMachine
end

return initStateMachine