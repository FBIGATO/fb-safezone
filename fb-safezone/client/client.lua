AddEventHandler('onResourceStart', function(resource)
    local partB = 'fb-safezone' -- nombre real del recurso
    local name = tostring(partB)

    if resource == GetCurrentResourceName() and GetCurrentResourceName() ~= name then
        print('^1[ERROR]^7 El recurso debe llamarse ^3'..name..'^7, pero se llama ^1'..GetCurrentResourceName()..'^7.')

        -- Mostrar mensaje al jugador
        exports['vms_notifyv2']:Notification({
            title = "Error de Seguridad",
            description = "Este recurso no está nombrado correctamente y no funcionará.",
            type = "error",
            icon = "fa-solid fa-ban",
            time = 8000,
            color = "red"
        })

        -- Detener ejecución del resto del script
        CreateThread(function()
            while true do
                Wait(100000) -- bloquea ejecución futura
            end
        end)
    end
end)



local isInSafeZone, isInRedZone = false, false

local function Notify(title, msg, tipo)
    exports['vms_notifyv2']:Notification({
        title = title,
        description = msg,
        type = tipo or "info",
        icon = "fa-solid fa-circle-info",
        time = 4000,
        color = "#3daeff"
    })
end

-- ZONAS SEGURA y ROJA normales
CreateThread(function()
    while true do
        local sleep = 1000
        local coords = GetEntityCoords(PlayerPedId())

        -- Zona Segura
        local inSafe = false
        for _, zone in pairs(Config.SafeZones) do
            if #(coords - zone.coords) < zone.radius then
                inSafe = true
                if not isInSafeZone then
                    isInSafeZone = true
                    Notify("Zona Segura", "Has entrado en una zona segura. No puedes usar armas.", "info")
                    SendNUIMessage({action = "showZone", label = "Zona Segura", color = "green", icon = "fa-solid fa-shield-halved"})
                end
            end
        end
        if isInSafeZone and not inSafe then
            isInSafeZone = false
            Notify("Zona Segura", "Has salido de la zona segura.", "warning")
            SendNUIMessage({action = "hideZone"})
        end

        -- Zona Roja
        local inRed = false
        for _, zone in pairs(Config.RedZones) do
            if #(coords - zone.coords) < zone.radius then
                inRed = true
                if not isInRedZone then
                    isInRedZone = true
                    Notify("Zona Roja", "¡Cuidado! Has entrado a una zona peligrosa.", "error")
                    SendNUIMessage({action = "showZone", label = "Zona Roja", color = "red", icon = "fa-solid fa-skull-crossbones"})
                end
            end
        end
        if isInRedZone and not inRed then
            isInRedZone = false
            Notify("Zona Roja", "Has salido de la zona roja.", "success")
            SendNUIMessage({action = "hideZone"})
        end

        Wait(sleep)
    end
end)

-- Desactivar armas en zona segura
CreateThread(function()
    while true do
        Wait(1)
        if isInSafeZone then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 142, true)
            DisablePlayerFiring(PlayerPedId(), true)
        else
            Wait(500)
        end
    end
end)

-- ########## ZONA DE CARGA
local isInLoadZone = false

CreateThread(function()
    while true do
        local sleep = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        local inLoad = false

        for _, zone in pairs(Config.LoadZones) do
            if #(playerCoords - zone.coords) < zone.radius then
                inLoad = true
                if not isInLoadZone then
                    isInLoadZone = true
                    exports["lb-phone"]:ToggleCharging(true)

                    -- Notificación al entrar
                    Notify("Zona de Carga", "Estás en zona de carga. Tu XR Phone se está cargando.", "info")

                    -- Mostrar HUD
                    SendNUIMessage({
                        action = "showZone",
                        label = zone.label or "Zona de Carga",
                        color = "yellow",
                        icon = "fa-solid fa-bolt-lightning"
                    })
                end
            end
        end

        if isInLoadZone and not inLoad then
            isInLoadZone = false
            exports["lb-phone"]:ToggleCharging(false)

            -- Notificación al salir
            Notify("Zona de Carga", "Saliste de la zona de carga. Tu XR Phone dejó de cargarse.", "warning")

            -- Ocultar HUD
            SendNUIMessage({action = "hideZone"})
        end

        Wait(sleep)
    end
end)
