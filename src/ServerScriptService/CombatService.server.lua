local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Weapons = require(ReplicatedStorage.Config.Weapons)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local attackRequest = remotes:WaitForChild("AttackRequest")
local notify = remotes:WaitForChild("Notify")

local playerState = {}

local function getPlayerWeaponData(player)
    local state = playerState[player]
    if not state then
        state = {
            EquippedWeapon = "Pistol",
            LastAttack = 0,
        }
        playerState[player] = state
    end

    return state, Weapons[state.EquippedWeapon]
end

local function isValidTarget(targetModel)
    if not targetModel or not targetModel:IsA("Model") then
        return false
    end

    if targetModel.Parent ~= workspace:FindFirstChild("ActiveBrainrots") then
        return false
    end

    return targetModel:FindFirstChildOfClass("Humanoid") ~= nil
end

local function rollCrit(weaponData)
    local critChance = weaponData.CritChance or 0
    return math.random() < critChance
end

attackRequest.OnServerEvent:Connect(function(player, targetModel)
    local state, weaponData = getPlayerWeaponData(player)
    if not weaponData then
        return
    end

    local now = os.clock()
    if now - state.LastAttack < weaponData.FireRate then
        return
    end

    state.LastAttack = now

    if not isValidTarget(targetModel) then
        return
    end

    local humanoid = targetModel:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end

    local damage = weaponData.Damage
    if rollCrit(weaponData) then
        damage *= weaponData.CritMultiplier or 1.5
    end

    humanoid:TakeDamage(damage)

    if humanoid.Health <= 0 then
        local leaderstats = player:FindFirstChild("leaderstats")
        local coins = leaderstats and leaderstats:FindFirstChild("Coins")
        local reward = targetModel:GetAttribute("KillReward") or 0

        if coins then
            coins.Value += reward
        end

        notify:FireClient(player, {
            Type = "KillReward",
            Message = string.format("+%d Coins (%s)", reward, targetModel:GetAttribute("Rarity") or "Unknown"),
        })

        targetModel:Destroy()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    playerState[player] = nil
end)
