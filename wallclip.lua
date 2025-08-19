local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local speed = 0.5
local targetPosition = hrp.Position

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseLocation = UserInputService:GetMouseLocation()
        local camera = workspace.CurrentCamera
        local unitRay = camera:ScreenPointToRay(mouseLocation.X, mouseLocation.Y)
        targetPosition = unitRay.Origin + unitRay.Direction * 50
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    local direction = (targetPosition - hrp.Position)
    if direction.Magnitude > 0.1 then
        hrp.CanCollide = false
        hrp.CFrame = hrp.CFrame + direction.Unit * speed
        hrp.CanCollide = true
    end
end)
