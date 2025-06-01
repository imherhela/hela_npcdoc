local Core = exports.vorp_core:GetCore()
local Called = false

RegisterCommand(Config.Command, function(source)
    if not Called then
        if IsEntityDead(PlayerPedId()) then
            Called = true
            TriggerServerEvent("hela_npcdoc:requestDoctor")
            Wait(Config.Cooldown * 60000)
            Called = false
        else
            Core.NotifyLeft("Local Doctor", _U("not_unconscious"), "inventory_items_mp", "kit_role_naturalist_sample_kit", 4000, "COLOR_WHITE")
        end
    else
        Core.NotifyRightTip(_U("cooldown"), 4000)
    end
end)

RegisterNetEvent("hela_npcdoc:spawnNPCDoctor")
AddEventHandler("hela_npcdoc:spawnNPCDoctor", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local npcHash = GetHashKey(Config.NPCDoctor.model)

    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Citizen.Wait(10)
    end

    local angle = math.rad(math.random(0, 360))
    local spawnX = playerCoords.x + math.sin(angle) * math.random(10, 20)
    local spawnY = playerCoords.y + math.cos(angle) * math.random(10, 20)
    local spawnZ = playerCoords.z

    local valid, Position = GetSafeCoordForPed(spawnX, spawnY, spawnZ, false, 16)
    if valid then
        spawnX, spawnY, spawnZ = Position.x, Position.y, Position.z
    end

    local Ground, groundZ, _ = GetGroundZAndNormalFor_3dCoord(spawnX, spawnY, spawnZ)
    if Ground then
        spawnZ = groundZ
    else
        Core.NotifyRightTip(_U("error_retrieving_data"), 4000)
        return
    end

    NpcDoctor = CreatePed(npcHash, spawnX, spawnY, spawnZ, 0.0, true, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, NpcDoctor, true)
    print("NPC Spawned at Distance: " .. #(GetEntityCoords(NpcDoctor) - playerCoords))

    TaskGoToEntity(NpcDoctor, playerPed, -1, 0.8, 1.5, 1073741824, 0)

    local reached = false
    CreateThread(function()
        local startTime = GetGameTimer()
        local lastRetryTime = startTime
        while not reached and GetGameTimer() - startTime < 15000 do
            local npcCoords = GetEntityCoords(NpcDoctor)
            local distance = #(npcCoords - playerCoords)
            print("Approach Phase - NPC Distance: " .. distance .. ", IsPedRagdoll: " .. tostring(IsPedRagdoll(NpcDoctor)))
            if distance < 1.0 and not IsPedRagdoll(NpcDoctor) then
                reached = true
            elseif GetGameTimer() - lastRetryTime > 10000 and distance < 5.0 then
                -- Retry routing if stuck near player
                Citizen.InvokeNative(0xE7FA07624574B79A, NpcDoctor) -- ClearPedTasks
                TaskGoToEntity(NpcDoctor, playerPed, -1, 0.8, 1.5, 1073741824, 0)
                print("NPC Retrying Route to Player")
                lastRetryTime = GetGameTimer()
            end
            Wait(500)
        end

        if not reached then
            print("NPC Failed to Reach Player - Proceeding to Post-Animation Sequence")
        end

        -- Perform animation and post-animation sequence regardless of reaching
        if DoesEntityExist(NpcDoctor) then
            local animDict = "mech_revive@unapproved"
            local animName = "revive"

            RequestAnimDict(animDict)
            while not HasAnimDictLoaded(animDict) do
                Wait(10)
            end
            TaskPlayAnim(NpcDoctor, animDict, animName, 8.0, 8.0, -1, 0, 0, false, false, false)
            DoScreenFadeOut(5000)
            Wait(5000)
            print("Revive Animation Completed")

            -- Reset non-reactive flags immediately
            Citizen.InvokeNative(0xC80A74AC829DDD92, NpcDoctor, 0, false) -- SetPedFleeAttributes
            Citizen.InvokeNative(0xB086C8C0F5701D14, NpcDoctor, 46, false) -- SetPedCombatAttributes
            Citizen.InvokeNative(0x18A3E9EE1297FD39, NpcDoctor, 297, true) -- SetPedConfigFlag
            Citizen.InvokeNative(0x18A3E9EE1297FD39, NpcDoctor, 301, true) -- SetPedConfigFlag
            Citizen.InvokeNative(0x18A3E9EE1297FD39, NpcDoctor, 2, true) -- SetPedConfigFlag
            Citizen.InvokeNative(0xF166E484BB6A536C, NpcDoctor, 0.0) -- SetPedSeeingRange
            Citizen.InvokeNative(0xA735353C77334EA0, NpcDoctor, 0.0) -- SetPedHearingRange
            print("Non-Reactive Flags Reset")


            -- Clear tasks
            Citizen.InvokeNative(0xE7FA07624574B79A, NpcDoctor) -- ClearPedTasks
            print("Tasks Cleared")

            -- Ensure NPC is on valid ground
            local npcCoords = GetEntityCoords(NpcDoctor)
            local Ground, groundZ = GetGroundZAndNormalFor_3dCoord(npcCoords.x, npcCoords.y, npcCoords.z)
            if Ground then
                SetEntityCoords(NpcDoctor, npcCoords.x, npcCoords.y, groundZ, false, false, false, false)
            end

            -- -- Set NPC heading away from player
            -- local awayAngle = angle + math.pi
            -- SetEntityHeading(NpcDoctor, awayAngle * 180 / math.pi)

            -- Make NPC wander randomly at normal pace
            Citizen.InvokeNative(0xBB9CE078AE67E3AE, NpcDoctor, 1.0, 0.0) -- TaskWanderStandard
            Citizen.InvokeNative(0x47D6F43D77935C75, NpcDoctor, 1.0) -- SetPedMoveRateOverride
            print("Wander Task Assigned")
            -- Wait for NPC to wander for 5 seconds
            local startTime = GetGameTimer()
            while GetGameTimer() - startTime < 5000 do
                local distance = #(GetEntityCoords(NpcDoctor) - playerCoords)
                print("Wander Phase - NPC Distance: " .. distance)
                Wait(500)
            end
            print("Wander Phase Completed")

            -- Fade out and delete NPC
            if DoesEntityExist(NpcDoctor) then
                Citizen.InvokeNative(0xAE6ADA8FE7E84ACC, NpcDoctor, 0, true) -- SetEntityAlpha
                Wait(1000)
                DeleteEntity(NpcDoctor)
                print("NPC Deleted")
            end
            -- Trigger revive and webhook after NPC disappears
            TriggerEvent("hela_npcdoc:revive")
            TriggerServerEvent("sendWebhook")
            Wait(1000)
            DoScreenFadeIn(1000)
        end
    end)
end)

RegisterNetEvent("hela_npcdoc:revive")
AddEventHandler("hela_npcdoc:revive", function()
    TriggerEvent("vorp_core:Client:OnPlayerRevive", source)
    Core.NotifyLeft("Local Doctor", _U("revived_by_npc") .. Config.NPCDoctor.revivePrice .. ".", "overhead", "overhead_revive", 4000, "COLOR_GREEN")
end)