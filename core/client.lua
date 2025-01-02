function CreateProp(modelHash, ...)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local obj = CreateObject(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end

function PlayAnim(ped, dict, ...)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(ped, dict, ...)
end

local interactTick = 0
local interactCheck = false
local interactText = nil


HelpNotifyType = 'Modern-Draw-Text' -- ['GTA-O' / 'Modern-Draw-Text']

function HelpNotify(txt, t, c)
    if t == 'GTA-O' then
        AddTextEntry('HelpNotification', txt)
        BeginTextCommandDisplayHelp('HelpNotification')
        EndTextCommandDisplayHelp(0, false, true, -1)
    elseif t == 'Modern-Draw-Text' then
        AddTextEntry('FloatingHelpNotification', txt)
        SetFloatingHelpTextWorldPosition(1, c.x, c.y, c.z + 0.8)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
        BeginTextCommandDisplayHelp('FloatingHelpNotification')
        EndTextCommandDisplayHelp(2, false, true, -1)
    end
end


function ShowInteractText(text)
    local timer = GetGameTimer()
    interactTick = timer
    if interactText == nil or interactText ~= text then 
        interactText = text
        lib.showTextUI(text)
    end
    if interactCheck then return end
    interactCheck = true
    CreateThread(function()
        Wait(150)
        local timer = GetGameTimer()
        interactCheck = false
        if timer ~= interactTick then 
            lib.hideTextUI()
            interactText = nil
            interactTick = 0
        end
    end)
end
