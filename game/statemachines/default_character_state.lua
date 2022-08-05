local State = require "game.statemachines.state"

local CharacterState = Class {
    __includes = State,
    init = function(self)
        State.init(self)
        self.priority = 0
        self.timeout = 0
        self.canBlock = false
        self.nextState = "idle"
        self.stateOnDamage = "stun_lock"

        self.physicsCollider = {
            size = Vector(20, 78),
            center = Vector(0, 0),
        }
        self.takingDamageCollider = {
            size = Vector(20, 78),
            center = Vector(0, 0),
        }
    end
}

function CharacterState:changeCollider(entity)
    local collider = entity:getComponentByName("PhysicsCollider")
    if collider then
        collider.size = self.physicsCollider.size
    end
end

function CharacterState:onDamage(entity, dmg, modifiers)
    if self.stateOnDamage then
        if modifiers.lifting then
            entity:getComponentByName("StateMachine"):goToState("flying_invincible") -- TODO: fix hardcode? it goes through block
            entity:getComponentByName("Liftable").isLaunched = true
        else
            entity:getComponentByName("StateMachine"):goToState(self.stateOnDamage)
        end
    end
end

return CharacterState