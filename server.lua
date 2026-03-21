local Core = exports.vorp_core:GetCore()

local function getPlayerData(source)
    local user = Core.getUser(source)  
    if not user then return nil end 
    local Character = user.getUsedCharacter

    if not Character then return nil end

    local steamId = GetPlayerIdentifiers(source)[1] or "Unknown"
    local steamName = GetPlayerName(source) or "Unknown"

    local discordId = "Unknown"
    for _, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.find(v, "discord:") then
            discordId = string.gsub(v, "discord:", "")
            break
        end
    end

    return {
        firstname = Character.firstname or "Unknown",
        lastname = Character.lastname or "Unknown",
        money = Character.money or 0,
        job = Character.job or "Unemployed",
        steamId = steamId,
        steamName = steamName,
        discordId = discordId,
        removeCurrency = function(currencyType, amount) 
            Character.removeCurrency(currencyType, amount) 
        end
    }
end

local function isOnDuty()
    if Config.UseSociety and Config.Society then
        if Config.Society == "syn" then
            if type(Config.Job) ~= "table" then return false end
            for _, job in ipairs(Config.Job) do
                local onDuty = exports["syn_society"] and exports["syn_society"]:GetPlayersOnDuty(job)
                if onDuty and type(onDuty) == "table" and #onDuty > 0 then
                    return true
                end
            end
        elseif Config.Society == "dl" then
            if type(Config.Job) ~= "table" then return false end
            for _, job in ipairs(Config.Job) do
                if exports.dl_society and exports.dl_society:getPlayerDutyStatus(job) then
                    return true
                end
            end
        end
    else
        local players = GetPlayers()
        for _, playerId in ipairs(players) do
            local data = getPlayerData(tonumber(playerId))
            if data then
                if type(Config.Job) ~= "table" then return false end
                for _, job in ipairs(Config.Job) do
                    if data.job == job or (Config.Prefix and data.job == Config.Prefix .. job) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

RegisterServerEvent("hela_npcdoc:requestDoctor")
AddEventHandler("hela_npcdoc:requestDoctor", function()
    local src = source

    if isOnDuty() then
        TriggerClientEvent("vorp:TipRight", src, _U("doctor_on_duty"), 5000)
        return
    end

    local data = getPlayerData(src)
    if not data or data.money == nil then
        TriggerClientEvent("vorp:TipRight", src, _U("error_retrieving_data"), 5000)
        return
    end

    local reviveCost = Config.NPCDoctor.revivePrice

    if not Config.Negative and data.money < reviveCost then
        TriggerClientEvent("vorp:TipRight", src, _U("not_enough_money") .. ".", 5000)
        return
    end

    data.removeCurrency(0, reviveCost)
    TriggerClientEvent("vorp:TipRight", src, _U("npc_doctor_on_way"), 5000)
    TriggerClientEvent("hela_npcdoc:spawnNPCDoctor", src)
end)

RegisterServerEvent("sendWebhook")
AddEventHandler("sendWebhook", function()
    local src = source
    local data = getPlayerData(src)
    if not data then return end
    
    local webhookURL = Config.Webhook
    if not webhookURL or webhookURL == "" then return end

    local embed = {
        {
            ["author"] = {
                ["name"] = data.steamName,
                ["icon_url"] = "https://i.imgur.com/aXJqSPN.png",
            },
            ["title"] = Config.WHTitle or "NPC Doctor Revive",
            ["color"] = Config.WHColor or 65280,
            ["description"] = "**Name:** " .. data.firstname .. " " .. data.lastname ..
                             "\n**Steam ID:** " .. data.steamId ..
                             "\n**Discord ID:** <@" .. data.discordId .. ">",
            ["footer"] = {
                ["text"] = (Config.WHFooter or "NPC Doctor Log") .. os.date(" %m/%d/%y %I:%M:%S %p"),
                ["icon_url"] = Config.WHIcon or "",
            },
        }
    }

    local payload = {
        ["username"] = "Offline Doctor",
        ["avatar_url"] = Config.WHIcon or "",
        ["embeds"] = embed
    }

    PerformHttpRequest(webhookURL, function(err, text, headers) 
        if err ~= 200 then
            print("Webhook failed with error: " .. err)
        end
    end, 'POST', json.encode(payload), { ['Content-Type'] = 'application/json' })
end)

function CheckTable(table, element)
    for _, v in pairs(table) do
        if v == element then
            return true
        end
    end
    return false
end

-- =============================================
--  Version Checker
-- =============================================
function checkUpdate(resource, repo, token)
    local current = GetResourceMetadata(resource, 'version')

    local url, headers

    if token then
        local repos = repo:gsub("https://github.com/", "")
        url = 'https://api.github.com/repos/' .. repos .. '/contents/version'
        headers = {
            ['Authorization'] = 'Bearer ' .. token,
            ['Accept']        = 'application/vnd.github+json',
            ['User-Agent']    = 'RedM-Script'
        }
    else
        local repos = repo:gsub("https://github.com/", "")
        url = 'https://raw.githubusercontent.com/' .. repos .. '/main/version'
        headers = { ['Content-Type'] = 'application/json' }
    end

    PerformHttpRequest(url, function(err, response, headers)
        if not response or response == "" then
            print("^1❕ Failed to check version file for " .. resource .. "^0")
            return
        end

        local content = response

        if token then
            local data = json.decode(response)
            if not data or not data.content then
                print("^1❕ Invalid API response for " .. resource .. "^0")
                return
            end
            content = base64Decode(data.content:gsub("\n", ""))
        end

        local latest = content:match("<%d?%d.%d?%d.?%d?%d?>")
        if latest then
            latest = latest:gsub("[<>]", "")
        else
            print("^1❕ Invalid version format in the file for " .. resource .. "^0")
            return
        end

        local update = latest > current

        if update then
            print("\n^8❌ -OUTDATED! ^6⋘ "..resource.."⋙ ^3 (Version "..current..")^0")
            print("^2New Version ^0("..latest..") ^5~"..repo.."~\n")
        else
            print("\n^2✔️ -UPDATED! ^6⋘ "..resource.."⋙ ^3 (Version "..current..")\n")
        end
    end, 'GET', '', headers)
end

AddEventHandler('onResourceStart', function(Resource)
    if Resource == GetCurrentResourceName() then
        checkUpdate(Resource, "https://github.com/imherhela/hela_npcdoc")
    end
end)
