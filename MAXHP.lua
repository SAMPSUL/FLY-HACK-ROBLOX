local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local maxHealth = 1000 
humanoid.MaxHealth = maxHealth
humanoid.Health = maxHealth

RunService.RenderStepped:Connect(function()
    if humanoid.Health < humanoid.MaxHealth then
        humanoid.Health = humanoid.Health + 10
        if humanoid.Health > humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)
