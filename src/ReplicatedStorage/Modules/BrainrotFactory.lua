local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Brainrots = require(ReplicatedStorage.Config.Brainrots)
local Rarities = require(ReplicatedStorage.Config.Rarities)

local BrainrotFactory = {}

local function createBrainrotModel(brainrotType)
    local model = Instance.new("Model")
    model.Name = brainrotType .. "NPC"

    local root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = Vector3.new(2, 2, 1)
    root.Anchored = false
    root.CanCollide = true
    root.Parent = model

    local humanoid = Instance.new("Humanoid")
    humanoid.Parent = model

    model.PrimaryPart = root
    return model
end

function BrainrotFactory.create(brainrotType, rarityName)
    local brainrotData = Brainrots[brainrotType]
    local rarityData = Rarities[rarityName]

    if not brainrotData or not rarityData then
        return nil
    end

    local model = createBrainrotModel(brainrotType)
    local humanoid = model:FindFirstChildOfClass("Humanoid")

    model:SetAttribute("BrainrotType", brainrotType)
    model:SetAttribute("Rarity", rarityName)
    model:SetAttribute("KillReward", rarityData.KillReward)
    model:SetAttribute("PassiveTickReward", rarityData.PassiveTickReward)
    model:SetAttribute("PassiveTicks", rarityData.PassiveTicks)

    humanoid.MaxHealth = brainrotData.BaseHealth * rarityData.HealthMultiplier
    humanoid.Health = humanoid.MaxHealth
    humanoid.WalkSpeed = brainrotData.BaseSpeed * rarityData.SpeedMultiplier

    return model
end

return BrainrotFactory
