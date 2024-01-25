Start = false

RegisterServerCallback('azakit_scrapaircon:Start', function(source, cb)
    if Start then
        cb({
            time = false,
            cops = PoliceCount() >= POLICE_REQ
        })
        return
    end

    cb({
        time = true,
        cops = PoliceCount() >= POLICE_REQ
    })

    Start = false

end)

RegisterServerCallback('azakit_scrapaircon:itemTaken',function(source, cb)
    if Framework == "ESX" then
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(ITEM)
        local itemtick = xPlayer.getInventoryItem(TICKETITEM)
        if TICKETITEM_REQ and TICKETITEM_REMOVE then
            if item.count >= 1 and itemtick.count >= TICKETITEM_AMOUNT then
                xPlayer.removeInventoryItem(TICKETITEM, TICKETITEM_AMOUNT)
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**Identifier:** " .. xPlayer.identifier .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        elseif TICKETITEM_REQ and not TICKETITEM_REMOVE then
            if item.count >= 1 and itemtick.count >= TICKETITEM_AMOUNT then
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**Identifier:** " .. xPlayer.identifier .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        else
            if item.count >= 1 then
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**Identifier:** " .. xPlayer.identifier .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        end
    elseif Framework == "QB" then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local item = exports.ox_inventory:GetItem(src, ITEM, nil, true)
        local itemtick = exports.ox_inventory:GetItem(src, TICKETITEM, nil, true)
        if TICKETITEM_REQ and TICKETITEM_REMOVE then
            if item >= 1 and itemtick >= TICKETITEM_AMOUNT then
                exports.ox_inventory:RemoveItem(src, TICKETITEM, TICKETITEM_AMOUNT)
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**CID:** " .. Player.PlayerData.citizenid .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        elseif TICKETITEM_REQ and not TICKETITEM_REMOVE then
            if item >= 1 and itemtick >= TICKETITEM_AMOUNT then
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**CID:** " .. Player.PlayerData.citizenid .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        else
            if item >= 1 then
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**CID:** " .. Player.PlayerData.citizenid .. "\n**ID:** " .. src .. "\n**Log:** Started Metalscrap."
                discordLog(message, Webhook)
            cb(true)
             else
            cb(false)
             end
        end
    end
end)


RegisterServerCallback("azakit_scrapaircon:exchangeProcess", function(source, cb, index)
    if Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local src = source
        local item = xPlayer.getInventoryItem(ITEM)
        local amount = math.random(Minrewardamount, Maxrewardamount)
        local reward = amount
        if ITEM_REMOVE then
             if item.count >= 1 then
                  xPlayer.removeInventoryItem(ITEM, 1)
                 xPlayer.addInventoryItem(Rewarditem, reward)
                 cb(true)
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**Identifier:** " .. xPlayer.identifier .. "\n**ID:** " .. src .. "\n**Log:** Successful metalscrap!"
                 discordLog(message, Webhook)
             else
                 cb(false)
             end
        else
            if item.count >= 1 then
               xPlayer.addInventoryItem(Rewarditem, reward)
               cb(true)
               local message = "**Steam:** " .. GetPlayerName(src) .. "\n**Identifier:** " .. xPlayer.identifier .. "\n**ID:** " .. src .. "\n**Log:** Successful metalscrap!"
               discordLog(message, Webhook)
           else
               cb(false)
           end
        end
    elseif Framework == "QB" then
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local item = exports.ox_inventory:GetItem(src, ITEM, nil, true)
        local amount = math.random(Minrewardamount, Maxrewardamount)
        local reward = amount
        if ITEM_REMOVE then
             if item >= 1 then
                if exports.ox_inventory:CanCarryItem(source, Rewarditem, reward) then
                    exports.ox_inventory:RemoveItem(src, ITEM, 1)
                    exports.ox_inventory:AddItem(src, Rewarditem, reward)
                    return true
                else
                         -- Put a Notif of full inventory here
                        Data = {
                            title = "OX Inventory",
                            description = "Inventory is Full",
                            type = 'error',
                            duration = 5000
                        }
                        TriggerClientEvent('ox_lib:notify', source, Data)
                end
                 cb(true)
                 local message = "**Steam:** " .. GetPlayerName(src) .. "\n**CID:** " .. Player.PlayerData.citizenid .. "\n**ID:** " .. src .. "\n**Log:** Successful metalscrap!"
                 discordLog(message, Webhook)
             else
                 cb(false)
             end
        else
            if item >= 1 then
                if exports.ox_inventory:CanCarryItem(source, Rewarditem, reward) then
                    exports.ox_inventory:AddItem(src, Rewarditem, reward)
                    return true
                else
                         -- Put a Notif of full inventory here
                        Data = {
                            title = "OX Inventory",
                            description = "Inventory is Full",
                            type = 'error',
                            duration = 5000
                        }
                        TriggerClientEvent('ox_lib:notify', source, Data)
                end
               cb(true)
               local message = "**Steam:** " .. GetPlayerName(src) .. "\n**CID:** " ..Player.PlayerData.citizenid .. "\n**ID:** " .. src .. "\n**Log:** Successful metalscrap!"
               discordLog(message, Webhook)
           else
               cb(false)
           end
        end
    end
end)

function discordLog(message, webhook)
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'AzakitBOT', embeds = {{["description"] = "".. message .."",["footer"] = {["text"] = "Azakit Development - https://discord.com/invite/DmsF6DbCJ9",["icon_url"] = "https://cdn.discordapp.com/attachments/1150477954430816456/1192512440215277688/azakitdevelopmentlogoavatar.png?ex=65a958c1&is=6596e3c1&hm=fc6638bef39209397047b55d8afbec6e8a5d4ca932d8b49aec74cb342e2910dc&",},}}, avatar_url = "https://cdn.discordapp.com/attachments/1150477954430816456/1192512440215277688/azakitdevelopmentlogoavatar.png?ex=65a958c1&is=6596e3c1&hm=fc6638bef39209397047b55d8afbec6e8a5d4ca932d8b49aec74cb342e2910dc&"}), { ['Content-Type'] = 'application/json' })
end
