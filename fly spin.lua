
local Players = game:GetService("Players")

local targetPlayerName = "HAMPURILAINEN14"

local flyingPlayers = {}

local function startFlying(player)
    if player.Name ~= targetPlayerName then return end
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
    bodyVelocity.Velocity = Vector3.new(0,0,0)
    bodyVelocity.Parent = humanoidRootPart

    flyingPlayers[player] = bodyVelocity
end

local function stopFlying(player)
    local bodyVelocity = flyingPlayers[player]
    if bodyVelocity then
        bodyVelocity:Destroy()
        flyingPlayers[player] = nil
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if player.Name == targetPlayerName then
            startFlying(player)
        end
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    if player.Character and player.Name == targetPlayerName then
        startFlying(player)
    end
end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService") 

RunService.Heartbeat:Connect(function()
    for player, bodyVelocity in pairs(flyingPlayers) do
        
        bodyVelocity.Velocity = player.Character.HumanoidRootPart.CFrame.LookVector * 50
    end
end)

