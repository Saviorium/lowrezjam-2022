local logger = require "engine.utils.logger" ("StateMachine")

local log = function(comp, lvl, msg)
    logger(lvl, "Entity #" .. comp.entity.id .. ": " .. msg)
end

return {
    name = "StateMachine",

    states = {},
    currentState = nil,
    timeInState = 0,
    lastState = nil,
    entity = nil,
    __nextState = nil,

    goToState = function (self, stateName, params)
        if not self.__nextState then
            self.__nextState = { state = stateName, params = params }
        else
            log(self, 2, "Tried to switch to "..stateName.." but nextState is already "..self.__nextState.state)
            local newStatePriority = self.states[stateName].priority
            local oldStatePriority = self.states[self.__nextState.state].priority
            if newStatePriority > oldStatePriority then
                log(self, 2, "Switch to "..self.__nextState.state.." is overriden by "..stateName)
                self.__nextState = { state = stateName, params = params }
            end
        end
    end,

    __switchState = function (self, stateName, params)
        log(self, 3, "Switch to state " .. stateName)
        local newState = self.states[stateName]
        if not newState then
            log(self, 1, "Tried to go to unknown state ", stateName)
            if Debug and Debug.StateMachine > 1 then
                error("Tried to go to unknown state " .. stateName)
            end
            return
        end
        if self:getCurrentStateName() == stateName then
            return
        end
        self.lastState = self.currentState
        if self.currentState then
            self.currentState:onExit(self.entity)
        end
        self.currentState = newState
        newState:onEnter(self.entity, params)
        self.timeInState = 0
    end,

    getCurrentStateName = function (self)
        return self.currentState and self.currentState.name or ''
    end,

    update = function (self, dt)
        if not self.currentState then
            self:__switchState("idle") -- special state
        end
        self.timeInState = self.timeInState + dt
        self.currentState:update(self.entity, dt)
    end
}
