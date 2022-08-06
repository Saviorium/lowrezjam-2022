local Animator = require "engine.animation.animator"

local characterAnimator = Animator()
characterAnimator:addSimpleVarToTagState("stateMachine", "state")
characterAnimator:addInstantTransition("_start", "stateMachine")

return characterAnimator
