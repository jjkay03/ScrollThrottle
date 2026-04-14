local M = {}

local throttleScale = 1.0
local scrollStep = 0.1

local function clamp(val, lo, hi)
  return math.max(lo, math.min(hi, val))
end

local function showHUD()
  ui_message(string.format("Throttle: %d%%", math.floor(throttleScale * 100 + 0.5)), 1.5, "throttleLimit")
end

local function syncToVehicle()
  local veh = be:getPlayerVehicle(0)
  if veh then
    veh:queueLuaCommand(string.format(
      'if extensions.scrollThrottleVeh then extensions.scrollThrottleVeh.setScale(%.4f) end',
      throttleScale
    ))
  end
end

function M.throttleUp()
  throttleScale = clamp(throttleScale + scrollStep, 0.0, 1.0)
  showHUD()
  syncToVehicle()
end

function M.throttleDown()
  throttleScale = clamp(throttleScale - scrollStep, 0.0, 1.0)
  showHUD()
  syncToVehicle()
end

local function onVehicleSpawnComplete(vehId)
  syncToVehicle()
end

M.onInit = onInit
M.onVehicleSpawnComplete = onVehicleSpawnComplete

return M