local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local currencyStore = DataStoreService:GetDataStore("BattleForBrainrots_PlayerData_v1")

local function getCoinsValue(player)
    local leaderstats = player:FindFirstChild("leaderstats") or player:WaitForChild("leaderstats", 10)
    if not leaderstats then
        return nil
    end

    return leaderstats:FindFirstChild("Coins") or leaderstats:WaitForChild("Coins", 10)
end

Players.PlayerAdded:Connect(function(player)
    local success, data = pcall(function()
        return currencyStore:GetAsync(player.UserId)
    end)

    if not success then
        warn("Failed to load player data for", player.UserId)
        return
    end

    local coinsValue = getCoinsValue(player)
    if coinsValue and type(data) == "table" then
        coinsValue.Value = data.Coins or coinsValue.Value
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local coinsValue = getCoinsValue(player)
    if not coinsValue then
        return
    end

    local saveData = {
        Coins = coinsValue.Value,
    }

    local success, err = pcall(function()
        currencyStore:SetAsync(player.UserId, saveData)
    end)

    if not success then
        warn("Failed to save player data", player.UserId, err)
    end
end)
