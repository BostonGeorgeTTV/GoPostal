ESX = exports["es_extended"]:getSharedObject()

local inv = exports.ox_inventory

local insideZone, startPostal, zonePostalDelivery = false, false, nil
isBusy = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false}

local ped = PlayerPedId()

--functions
local loading = function()
    lib.progressBar({
        duration = 10000,
        label = Config.translate.ritiro,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            mouse = false,
            car = true,
            move = true,
            combat = true,
        },
        anim = {
            dict = 'missheistdockssetup1clipboard@base',
            clip = 'base' 
        },
        prop = {
            {
                model = `prop_notepad_01`,
                bone = 18905,
                pos = vec3(0.1, 0.02, 0.05),
                rot = vec3(10.0, 0.0, 0.0)
            },
            {
                model = `prop_pencil_01`,
                bone = 58866,
                pos = vec3(0.11, -0.02, 0.001),
                rot = vec3(-120.0, 0.0, 0.0)
            }
        },
    })
end

local delivery = function()
    lib.progressBar({
        duration = 5000,
        label = Config.translate.consegna,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'anim@heists@box_carry@',
            clip = 'idle' 
        },
        prop = {
            {
                model = `hei_prop_heist_box`,
                bone = 60309,
                pos = vec3(0.025, 0.08, 0.255),
                rot = vec3(-145.0, 290.0, 0.0)
            },
        },
    })
end


local startJob = function()
    if ESX.Game.IsSpawnPointClear(vec3(Config.Start.van.x, Config.Start.van.y, Config.Start.van.z), 6.0) then
        loading()
        
        lib.requestModel(Config.Vehicle)
        ESX.Game.SpawnVehicle(Config.Vehicle, vec3(Config.Start.van.x, Config.Start.van.y, Config.Start.van.z), Config.Start.van.w, function(vehicle)
            van = vehicle
            plate = GetVehicleNumberPlateText(van)
        end)
        startPostal = true
        startBlip()
        TriggerServerEvent("postalJob:takeMaterials")
    else
        ESX.ShowNotification(Config.translate.postoVan, "error")
    end
end

-- Start
RegisterNetEvent("startPostalJob",function()
    if startPostal == false then
        startJob()
    else
        ESX.ShowNotification(Config.translate.alreadyWork, "error")
    end
end)

-- Stop
RegisterNetEvent("stopPostalJob", function()
    local count = inv:Search("count", Config.item)
    local coords = GetEntityCoords(PlayerPedId())
    local veh = ESX.Game.GetClosestVehicle(coords)
    local numPlate = GetVehicleNumberPlateText(veh)

    if startPostal == true then
        stopBlip()
        TriggerServerEvent("ox_inventory:removeItem", Config.item, count)
        if numPlate == plate then
            ESX.Game.DeleteVehicle(van)
        end
    else
        TriggerServerEvent("ox_inventory:removeItem", Config.item, count)
        ESX.ShowNotification(Config.translate.nojob, "error")
    end
end)

-- Delivery
Citizen.CreateThread(function()
    for _,v in pairs(Config.Delivery) do
        isBusy[_] = false
        local zonePostalDelivery = lib.zones.sphere({
            coords = vec3(v.x, v.y, v.z),
            radius = 3.0,
            --debug = true,
            onEnter = function()
                insideZone = true
                if not IsPedInAnyVehicle(ped, false) and startPostal == true then
                    lib.showTextUI('[E] - ' .. Config.TexUiText.delivery, Config.TextUiStyle)
                end
            end,
            inside = function()
                insideZone = true 
                DisableControlAction(0, 24, true)
                DisableControlAction(0, 25, true)
                if IsControlJustPressed(0, 51) and not IsPedInAnyVehicle(ped, false) then
                    if insideZone == true and startPostal == true then
                        if isBusy[_] == false then
                            lib.hideTextUI()
                            local count = inv:Search("count", Config.item)
                            if count >= 1 then
                                delivery()
                                isBusy[_] = true
                                TriggerServerEvent("postalJob:delivery")
                                RemoveBlip(blips[_])
                            else
                                ESX.ShowNotification(Config.translate.no_item, "error")
                            end
                        else
                            ESX.ShowNotification(Config.translate.already_delivered, "error")
                        end
                    else
                        ESX.ShowNotification(Config.translate.nojob, "error")
                    end
                end
            end,
            onExit = function()
                lib.hideTextUI()
                insideZone = false
            end
        })
    end
end)

--blip
blips = {}

Citizen.CreateThread(function()
    local coords = vec3(Config.Start.coords.x,Config.Start.coords.y,Config.Start.coords.z)
    blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 478)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipDisplay(blip, 2)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Posta")
    EndTextCommandSetBlipName(blip)
end)

function startBlip()
    Citizen.CreateThread(function()
        for _,v in pairs(Config.Delivery) do
            local coords = vec3(v.x,v.y,v.z)
            if startPostal == true then
                blip = AddBlipForCoord(coords)
                SetBlipSprite(blip, 478)
                SetBlipScale(blip, 0.5)
                SetBlipColour(blip, 1)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString("Consegna")
                EndTextCommandSetBlipName(blip)
                table.insert(blips, blip)
            end
        end
    end)
end

function stopBlip()
    Citizen.CreateThread(function()
        for _, blipId in pairs(blips) do
            RemoveBlip(blipId)
        end
        blips = {}
        
        for i = 1, #isBusy do
            isBusy[i] = false
        end
        startPostal = false
        insideZone = false
    end)
end

RegisterNetEvent("postal:playerDisconnected", function()
    stopBlip()
end)
