ESX = exports["es_extended"]:getSharedObject()

local inv = exports.ox_inventory

RegisterNetEvent("postalJob:takeMaterials", function()
    inv:AddItem(source, Config.item, Config.takeItem)
end)

RegisterNetEvent("postalJob:delivery", function()
    inv:RemoveItem(source, Config.item, Config.quantity)
    inv:AddItem(source, Config.money, math.random(Config.reward.a,Config.reward.b))
end)

AddEventHandler('playerDropped', function()
    local xPlayer = ESX.GetPlayerFromId(source)
	local count = inv:Search(source, "count", Config.item)
    if xPlayer ~= nil then
        inv:RemoveItem(source, Config.item, count)
        TriggerClientEvent("postal:playerDisconnected", source)
    end
end)