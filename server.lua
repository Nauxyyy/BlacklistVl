ESX = nil

local function LoadESX()
    if Config.UseESXLegacy then
        -- Legacy
        ESX = exports["es_extended"]:getSharedObject()
    else
        -- old ESX
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end

-- Load ESX
LoadESX()

ESX.RegisterServerCallback('BlVl:getGroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local plyGroup = xPlayer.getGroup()
        cb(plyGroup)
    else
        cb("user")
    end
end)
