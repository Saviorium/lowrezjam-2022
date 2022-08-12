local Entity = require "game.ecs.entity"
local Components = require "game.ecs.components"
local HC = require 'lib/hardoncollider'

local DrawSystem            = require "game.ecs.systems.draw_system"
local MovingSystem          = require "game.ecs.systems.moving_system"
local PhysicsSystem         = require "game.ecs.systems.physics_system"
local CameraSystem          = require "game.ecs.systems.camera_system"
local ControlSystem         = require "game.ecs.systems.control_system"
local ActionSystem          = require "game.ecs.systems.action_system"
local AnimationSystem       = require "game.ecs.systems.animation_system"
local SoundSystem           = require "game.ecs.systems.sound_system"
local StatesSystem          = require "game.ecs.systems.state_system"
local BeatSystem            = require "game.ecs.systems.beat_system"
local BeatSyncSystem        = require "game.ecs.systems.beat_sync_system"
local ParticleSystem        = require "game.ecs.systems.particle_system"
local RotateSystem          = require "game.ecs.systems.rotate_system"
local ScoreSystem           = require "game.ecs.systems.score_system"
local TriggerSystem         = require "game.ecs.systems.trigger_system"


local EventManager = require "engine.events.event_manager"

local GlobalSystem = Class {
    init = function(self)
        self.HC = HC.new()
        self.objects = {}
        self.removed = {
            entities = {},
            components = {},
        }
        self.newEntityId = 1
        self.eventManager = EventManager()
        self.systems = { -- take system here if you need a quick dirty fix
            ScoreSystem = ScoreSystem(self),
        }
        self._systems = { -- order is important

            ControlSystem(self),
            self.systems.ScoreSystem,
            RotateSystem(self),
            BeatSystem(self),
            StatesSystem(self),
            BeatSyncSystem(self),
            ActionSystem(self),
            MovingSystem(self),
            PhysicsSystem(self),
            AnimationSystem(self),
            CameraSystem(self),
            DrawSystem(self),
            ParticleSystem(self),
            SoundSystem(self),
            TriggerSystem(self),
        }
    end
}

function GlobalSystem:newEntity()
    local newEntity = Entity(self.newEntityId, self)
    self.objects[self.newEntityId] = newEntity
    self.newEntityId = self.newEntityId + 1
    return newEntity
end

function GlobalSystem:registerComponent(entity, componentName, args)
    local newComponent = Components[componentName]
    assert(newComponent, "No such component " .. componentName)
    entity:__doAddComponent(newComponent(args))
    self:updateSystemsPools(entity)
end

function GlobalSystem:updateSystemsPools(entity)
    for systemName, system in ipairs(self._systems) do
        system:addAndPrune(entity)
    end
end

function GlobalSystem:markComponentToRemove(component)
    table.insert(self.removed.components, component)
end

function GlobalSystem:markEntityToRemove(entity)
    table.insert(self.removed.entities, entity)
end

function GlobalSystem:removeComponent(component)
    for systemName, system in ipairs(self._systems) do
        system:handleRemoveComponent(component)
    end
end

function GlobalSystem:update(dt)
    prof.push("Global system update")
    for systemName, system in ipairs(self._systems) do
        prof.push("Global system update: "..systemName)
        system:update(dt)
        prof.pop()
    end
    prof.pop()

    prof.push("Global system removes enitites and components")
    for ind, component in pairs(self.removed.components) do
        local entity = component.entity
        self:removeComponent(component)
        entity:__doRemoveComponent(component.name)
        self:updateSystemsPools(entity)
        self.removed.components[ind] = nil
    end
    for ind, entity in pairs(self.removed.entities) do
        for _, component in pairs(entity.components) do
            self:removeComponent(component)
        end
        for _, component in pairs(entity.components) do -- to remove safely, handlers may still need removed components
            entity:__doRemoveComponent(component.name)
        end
        entity.components = {}
        entity.componentTypes = {}
        self:updateSystemsPools(entity)
        self.objects[entity.id] = nil
        entity.globalSystem = nil
        self.removed.entities[ind] = nil
    end
    prof.pop()
end

function GlobalSystem:draw()
    prof.push("Global system draw")
    local stackDepthBefore = love.graphics.getStackDepth()
    for systemName, system in ipairs(self._systems) do
        prof.push("Global system draw: "..systemName)
        system:draw()
        prof.pop()
    end
    while love.graphics.getStackDepth() > stackDepthBefore do
        love.graphics.pop()
    end
    prof.pop()
end

return GlobalSystem