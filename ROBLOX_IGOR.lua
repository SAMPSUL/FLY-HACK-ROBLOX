
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local egorOn = true
local normalSpeed = 16
local normalJump = 50
local egorSpeed = 100
local egorJump = 150

humanoid.WalkSpeed = egorSpeed
humanoid.JumpPower = egorJump

local animator = humanoid:WaitForChild("Animator")
local walkAnim = Instance.new("Animation")
walkAnim.AnimationId = "rbxassetid://180426354" 
local walkTrack = animator:LoadAnimation(walkAnim)
walkTrack:Play()
walkTrack:AdjustSpeed(3)

local jumpAnim = Instance.new("Animation")
jumpAnim.AnimationId = "rbxassetid://125750702" 
local jumpTrack = animator:LoadAnimation(jumpAnim)

runService.RenderStepped:Connect(function()
    local direction = Vector3.new(0,0,0)
    if userInput:IsKeyDown(Enum.KeyCode.W) then
        direction = direction + camera.CFrame.LookVector
    end
    if userInput:IsKeyDown(Enum.KeyCode.S) then
        direction = direction - camera.CFrame.LookVector
    end
    if userInput:IsKeyDown(Enum.KeyCode.A) then
        direction = direction - camera.CFrame.RightVector
    end
    if userInput:IsKeyDown(Enum.KeyCode.D) then
        direction = direction + camera.CFrame.RightVector
    end

    local moveDir = Vector3.new(direction.X,0,direction.Z)
    if moveDir.Magnitude > 0 then
        moveDir = moveDir.Unit
        humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + moveDir)
    end

    humanoid:Move(moveDir * humanoid.WalkSpeed)
end)

userInput.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Space then
        humanoid.Jump = true
        jumpTrack:Play()
        jumpTrack:AdjustSpeed(2.5)
    end
end)
