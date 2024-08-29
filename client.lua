ESX = nil

-- Fonction pour obtenir ESX basé sur la version
local function LoadESX()
    if Config.UseESXLegacy then
        -- Legacy
        ESX = exports["es_extended"]:getSharedObject()
    else
        -- old ESX
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end

-- Load  ESX
LoadESX()

local playerGroup = "user"  -- Default

function GetGroup()
    ESX.TriggerServerCallback("BlVl:getGroup", function(group)
        playerGroup = group
    end)
end

GetGroup()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.CheckDelay)  -- Delay
        local vehicles = GetGamePool('CVehicle')

        for _, vehicle in ipairs(vehicles) do
            local model = GetEntityModel(vehicle)
            for _, blockedVehicle in ipairs(Config.BlockedVehicles) do
                if model == GetHashKey(blockedVehicle) then
                    local driver = GetPedInVehicleSeat(vehicle, -1)
                    if driver and IsPedAPlayer(driver) then
                        local driverId = NetworkGetPlayerIndexFromPed(driver)
                        if driverId and driverId ~= -1 then
                            ESX.TriggerServerCallback("BlVl:getGroup", function(group)
                                if not table.contains(Config.ExemptGroups, group) then
                                    DeleteEntity(vehicle)
                                end
                            end, driverId)
                        end
                    else
                        DeleteEntity(vehicle)
                    end
                end
            end
        end
    end
end)

function table.contains(t, val)
    for _, v in ipairs(t) do
        if v == val then
            return true
        end
    end
    return false
end
