local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local mouse = localPlayer:GetMouse()

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local attackRequest = remotes:WaitForChild("AttackRequest")
local notify = remotes:WaitForChild("Notify")

local function getTargetModel()
    local target = mouse.Target
    if not target then
        return nil
    end

    return target:FindFirstAncestorOfClass("Model")
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local targetModel = getTargetModel()
        if targetModel then
            attackRequest:FireServer(targetModel)
        end
    end
end)

notify.OnClientEvent:Connect(function(payload)
    if type(payload) ~= "table" then
        return
    end

    print(string.format("[%s] %s", payload.Type or "Info", payload.Message or ""))
    -- Replace with polished UI toasts in production.
end)
