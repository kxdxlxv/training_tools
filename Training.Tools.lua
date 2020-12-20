require 'lib.moonloader'
require 'lib.sampfuncs'

script_name    'Training.Tools'
script_author  '1keda'
script_version 'v0.1.0'

local ev = require 'lib.samp.events'
local SCRIPT_IS_ACTIVE = false

function dist(x1, y1, x2, y2)
  return math.sqrt(((x1-x2)^2) + ((y1-y2)^2))
end

function ev.onServerMessage(color, text)
  if SCRIPT_IS_ACTIVE and color == -10092289 then
    local match = text.find(text, 'CB')

    if match then
      sampAddChatMessage(text.match(text, ': {FFFFFF}(.*)'), -1)
      return false
    end
  end
end

function ev.onCreateObject(objectid, data)
  if SCRIPT_IS_ACTIVE then
    local x = data['position']['x']
    local y = data['position']['y']
    local z = data['position']['z']
    if dist(1256.8667, -2006.4934, x, y) < 10.0 then return false end
    if dist(1263.5092, -2006.2415, x, y) < 10.0 then return false end
    if dist(1268.6796, -2006.4419, x, y) < 10.0 then return false end
  end
end

function main()
  if (not isSampLoaded()) or (not isSampfuncsLoaded()) or (not isSampAvailable()) then return end

  local ip, port = sampGetCurrentServerAddress()

  if ip ~= '37.230.162.117' and port ~= 7777 then return end

  local result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)

  if not result then
    sampAddChatMessage('[Training.Tools]{FFFFFF} Не удалось подгрузить скрипт, ошибка #1.', 0x666AAA)
    return
  end

  local name = sampGetPlayerNickname(id)

  if name == 'Bemep' or name == 'KOCTO' or name == 'AHAPXUCT' or name == 'tolyanraketa' or name == 'morkovkin' then
    sampAddChatMessage('[Training.Tools]{FFFFFF} Ошибка загрузки скрипта, ошибка #SampookDetected.', 0x666AAA)
    return
  end

  SCRIPT_IS_ACTIVE = true

  wait(-1)
end
