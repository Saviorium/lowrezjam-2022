local System = require "game.ecs.systems.system"
local Tutorial = require "game.ecs.prefabs.tutorial_animated"

local SunSystem = Class {
    __includes = System,
    init = function(self, globalSystem)
        System.init(self, {'SunControlled'})
        self.statesQueue = {Night = {timer = 1, next = 'Sunrise'}, 
                            Sunrise = {timer = 10, next = 'Morning', direction = 'up'}, 
                            Morning = {timer = 5, next = 'Noon', direction = 'up'}, 
                            Noon = {timer = 1, next = 'Afternoon'}, 
                            Afternoon = {timer = 10, next = 'Sunset', direction = 'down'}, 
                            Sunset = {timer = 5, next = 'Night', direction = 'down'} }
        self.currentDayState = 'Night'
        self.timer = self.statesQueue[self.currentDayState].timer
        self.tutorialShown = false
        self.globalSystem = globalSystem
    end
}


function SunSystem:update(dt)

    self.timer = self.timer - dt
    if self.timer < 0 then
        self.currentDayState = self.statesQueue[self.currentDayState].next
        self.timer = self.statesQueue[self.currentDayState].timer
    end

    if not self.tutorialShown and self.currentDayState == 'Sunrise' then
        Tutorial(self.globalSystem, "tutorial-space", Vector(10, 40))
        self.tutorialShown = true
    end

    for _, entity in pairs(self.pool) do
        for _, comp in pairs(entity:getComponentsByType("SunControlled")) do
            comp:update(dt, entity, self.currentDayState, self.timer, self.statesQueue)
        end
    end
end

function SunSystem:draw()
end

return SunSystem