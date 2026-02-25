local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local cashInRequest = remotes:WaitForChild("CashInRequest")
local notify = remotes:WaitForChild("Notify")

local passiveCores = {}

local function ensureLeaderstats(player)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        return leaderstats
    end

    leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local coins = Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = 0
    coins.Parent = leaderstats

    return leaderstats
end

Players.PlayerAdded:Connect(function(player)
    ensureLeaderstats(player)
    passiveCores[player] = {}

    task.spawn(function()
        while player.Parent do
            task.wait(5)
            local leaderstats = player:FindFirstChild("leaderstats")
            local coins = leaderstats and leaderstats:FindFirstChild("Coins")
            if not coins then
                continue
            end

            local totalTick = 0
            for i = #passiveCores[player], 1, -1 do
                local core = passiveCores[player][i]
                core.TicksRemaining -= 1
                totalTick += core.TickReward

                if core.TicksRemaining <= 0 then
                    table.remove(passiveCores[player], i)
                end
            end

            if totalTick > 0 then
                coins.Value += totalTick
                notify:FireClient(player, {
                    Type = "PassiveIncome",
                    Message = string.format("+%d Passive Coins", totalTick),
                })
            end
        end
    end)
end)

cashInRequest.OnServerEvent:Connect(function(player, payload)
    local leaderstats = ensureLeaderstats(player)
    local coins = leaderstats:FindFirstChild("Coins")
    if not coins or type(payload) ~= "table" then
        return
    end

    local mode = payload.Mode
    local reward = tonumber(payload.Reward) or 0
    reward = math.max(0, math.floor(reward))

    if mode == "Instant" then
        coins.Value += reward
        notify:FireClient(player, { Type = "CashIn", Message = string.format("Cashed in +%d", reward) })
    elseif mode == "Passive" then
        local tickReward = tonumber(payload.TickReward) or 0
        local ticks = tonumber(payload.Ticks) or 0
        tickReward = math.max(0, math.floor(tickReward))
        ticks = math.max(1, math.floor(ticks))

        table.insert(passiveCores[player], {
            TickReward = tickReward,
            TicksRemaining = ticks,
        })

        notify:FireClient(player, {
            Type = "Processor",
            Message = string.format("Processor running: %d x %d", tickReward, ticks),
        })
    end
end)

Players.PlayerRemoving:Connect(function(player)
    passiveCores[player] = nil
end)
