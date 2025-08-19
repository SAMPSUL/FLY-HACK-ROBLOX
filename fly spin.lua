
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 150   
local rotationSpeed = 15 

local function fly()
	flying = not flying
	if flying then
		print("Lento päälle")
	else
		print("Lento pois")
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
		fly()
	end
end)

RunService.RenderStepped:Connect(function(deltaTime)
	if flying and character and humanoidRootPart then
      
		local camera = workspace.CurrentCamera
		local moveDirection = camera.CFrame.LookVector * speed * deltaTime
		humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection

		
		humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(rotationSpeed), 0)
	end
end)
