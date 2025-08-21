
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function makeBig()
   
    local scale = 5 
    
    humanoid.BodyHeightScale.Value = scale
    humanoid.BodyWidthScale.Value = scale
    humanoid.BodyDepthScale.Value = scale
    humanoid.HeadScale.Value = scale
end

makeBig()
