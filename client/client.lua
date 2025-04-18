local config = lib.require 'config'

blipFarm = AddBlipForCoord(config.coordsPed.x, config.coordsPed.y, config.coordsPed.z)
SetBlipSprite(blipFarm, 280)
SetBlipColour(blipFarm, 29)
SetBlipScale(blipFarm, 0.8)
SetBlipAsShortRange(blipFarm, true)
BeginTextCommandSetBlipName('STRING')
AddTextComponentSubstringPlayerName('Farm')
EndTextCommandSetBlipName(blipFarm)

local function spawnPeds()
    local model = GetHashKey(config.model)
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    local pedModel = CreatePed(0, model, config.coordsPed.x, config.coordsPed.y, config.coordsPed.z, config.coordsPed.w, false, false)
    SetEntityInvincible(pedModel, true)
    FreezeEntityPosition(pedModel, true)
    SetBlockingOfNonTemporaryEvents(pedModel, true)
    SetModelAsNoLongerNeeded(pedModel)
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        spawnPeds()
    end
end)