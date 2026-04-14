local M = {}

local throttleScale = 1.0  -- set by GE extension via setScale()

-- Function to set the throttle scale, clamped between 0 and 1
local function setScale(scale)
  throttleScale = math.max(0.0, math.min(1.0, scale))
end

-- Function to apply the throttle scale to player input each graphics frame
local function updateGFX(dtSim)
  if throttleScale >= 1.0 then return end
  if input.state.throttle and input.state.throttle.val > 0 then
    input.event('throttle', throttleScale, 2)
  end
end

M.setScale   = setScale
M.updateGFX  = updateGFX

return M
