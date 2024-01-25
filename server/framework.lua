if Config.Framework == "ESX" then 
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
end

function PoliceCount()
    if Config.Framework == "ESX" then 
        local players = ESX.GetPlayers()
        local count = 0
    
        for i = 1, #players do
            local player = ESX.GetPlayerFromId(players[i])
            if player.job.name == POLICE_JOB then
                count = count + 1
            end
        end
    
        return count
            
    elseif Config.Framework == "QB" then
        
    local count = 0
    local players = QBCore.Functions.GetQBPlayers()
        for _, v in pairs(players) do
            if v and v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
                count += 1
            end
        end
        return count
    end
end

---@param source any Server id
---@param item string Item name
---@param amount number Amount of item to have
function DoesPlayerHaveItem(source, item, amount)
    if Config.Framework == "ESX" then 
        return ESX.GetPlayerFromId(source).getInventoryItem(item).count >= amount
    elseif Config.Framework == "QB" then
        return exports.ox_inventory:GetItemCount(source, item) >= amount
    end   
end

---@param source any Server id
---@param item string Item name
---@param amount number Amount to add
function AddPlayerItem(source, item, amount)
    if Config.Framework == "ESX" then 
        ESX.GetPlayerFromId(source).addInventoryItem(item, amount)
        return true
    elseif Config.Framework == "QB" then
        if exports.ox_inventory:CanCarryItem(source, item, amount) then
            exports.ox_inventory:AddItem(source, item, amount)
            return true
        else
                 -- Put a Notif of full inventory here
        end
    end       
end

---@param source any Server id
---@param item string Item name
---@return number count Item count
function GetPlayerItemCount(source, item)
    if Config.Framework == "ESX" then 
        return ESX.GetPlayerFromId(source).getInventoryItem(item).count
    elseif Config.Framework == "QB" then  
        return exports.ox_inventory:GetItemCount(source, item)
    end       
end

---@param source any Server id
---@param item string Item name
---@param amount number Amount to remove
function RemovePlayerItem(source, item, amount)
    if Config.Framework == "ESX" then 
        ESX.GetPlayerFromId(source).removeInventoryItem(item, amount)
        return true
    elseif Config.Framework == "QB" then  
        exports.ox_inventory:RemoveItem(source, item, count)
        return true
    end    
end
