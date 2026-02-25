local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local WeightedRandom = require(ReplicatedStorage.Modules.WeightedRandom)
local BrainrotFactory = require(ReplicatedStorage.Modules.BrainrotFactory)
local Rarities = require(ReplicatedStorage.Config.Rarities)
local Brainrots = require(ReplicatedStorage.Config.Brainrots)

local activeBrainrotsFolder = workspace:FindFirstChild("ActiveBrainrots") or Instance.new("Folder")
activeBrainrotsFolder.Name = "ActiveBrainrots"
activeBrainrotsFolder.Parent = workspace

local spawnFolder = workspace:WaitForChild("BrainrotSpawnPoints")

local threatLevel = 1
local maxActiveBase = 10

local function getScaledMaxActive()
    return maxActiveBase + math.floor(#Players:GetPlayers() * 2) + math.floor(threatLevel * 0.7)
end

local function chooseBrainrotType()
    local keys = {}
    for name in pairs(Brainrots) do
        table.insert(keys, name)
    end
    return keys[math.random(1, #keys)]
end

local function spawnOne()
    local points = spawnFolder:GetChildren()
    if #points == 0 then
        return
    end

    local spawnPoint = points[math.random(1, #points)]
    local rarity = WeightedRandom.pick(Rarities)
    local brainrotType = chooseBrainrotType()

    local npc = BrainrotFactory.create(brainrotType, rarity)
    if not npc then
        return
    end

    npc:PivotTo(spawnPoint.CFrame + Vector3.new(0, 3, 0))
    npc.Parent = activeBrainrotsFolder
end

task.spawn(function()
    while true do
        task.wait(45)
        threatLevel += 1
    end
end)

while true do
    local active = #activeBrainrotsFolder:GetChildren()
    local maxActive = getScaledMaxActive()

    if active < maxActive then
        spawnOne()
    end

    task.wait(math.max(0.35, 2.5 - (threatLevel * 0.04)))
end
