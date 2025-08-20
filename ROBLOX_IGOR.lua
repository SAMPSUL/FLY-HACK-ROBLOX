

local Players = game:GetService("Players")


local targetPlayerName = "HAMPURILAINEN14"

local function makeEgor(player)
    if player.Name ~= targetPlayerName then return end -- vain sinä
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:WaitForChild("Animator")

    
    humanoid.WalkSpeed = 50
    humanoid.JumpPower = 100


    local walkAnim = Instance.new("Animation")
    walkAnim.AnimationId = "rbxassetid://180426354" 
    local walkTrack = animator:LoadAnimation(walkAnim)
    walkTrack.Priority = Enum.AnimationPriority.Movement
    walkTrack:Play()
    walkTrack:AdjustSpeed(2) 

    local jumpAnim = Instance.new("Animation")
    jumpAnim.AnimationId = "rbxassetid://125750702" 
    local jumpTrack = animator:LoadAnimation(jumpAnim)
    jumpTrack.Priority = Enum.AnimationPriority.Action

    
    humanoid.Jumping:Connect(function(active)
        if active then
            jumpTrack:Play()
            jumpTrack:AdjustSpeed(2)
        end
    end)
end


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        makeEgor(player)
    end)
end)


for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        makeEgor(player)
    end
end
