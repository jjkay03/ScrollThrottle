local M = {}

local throttleScale = 1.0
local scrollStep = 0.1

-- Function to clamp a value between a minimum and maximum
local function clamp(val, lo, hi)
  return math.max(lo, math.min(hi, val))
end

-- Function to show the current throttle percentage on the HUD
local function showHUD()
  ui_message(string.format("Throttle: %d%%", math.floor(throttleScale * 100 + 0.5)), 1.5, "throttleLimit")
end

-- Function to sync the current throttle scale to the player's vehicle
local function syncToVehicle()
  local veh = be:getPlayerVehicle(0)
  if veh then
    veh:queueLuaCommand(string.format(
      'if extensions.scrollThrottleVeh then extensions.scrollThrottleVeh.setScale(%.4f) end',
      throttleScale
    ))
  end
end

-- Function to increase the throttle scale by one step
function M.throttleUp()
  throttleScale = clamp(throttleScale + scrollStep, 0.0, 1.0)
  showHUD()
  syncToVehicle()
end

-- Function to decrease the throttle scale by one step
function M.throttleDown()
  throttleScale = clamp(throttleScale - scrollStep, 0.0, 1.0)
  showHUD()
  syncToVehicle()
end

-- Function to handle vehicle spawn completion and sync throttle to the new vehicle
local function onVehicleSpawnComplete(vehId)
  syncToVehicle()
end

M.onInit = onInit
M.onVehicleSpawnComplete = onVehicleSpawnComplete

return M