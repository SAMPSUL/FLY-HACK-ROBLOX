
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.BodyHeightScale.Value = 5    
humanoid.BodyWidthScale.Value = 5     
humanoid.BodyDepthScale.Value = 5     
humanoid.HeadScale.Value = 3          

