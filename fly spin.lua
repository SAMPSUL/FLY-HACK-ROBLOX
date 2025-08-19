local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 100
local rotationSpeed = 10

local keysDown = {}
local bodyVelocity

-- lennon päälle/pois
local function toggleFly()
	flying = not flying
	if flying then
		print("Lento päälle")
		-- luodaan BodyVelocity joka pitää hahmon ilmassa
		bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		bodyVelocity.Velocity = Vector3.new(0,0,0)
		bodyVelocity.Parent = humanoidRootPart
	else
		print("Lento pois")
		if bodyVelocity then
			bodyVelocity:Destroy()
			bodyVelocity = nil
		end
	end
end

-- näppäinten painallukset
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed then
		if input.KeyCode == Enum.KeyCode.F then
			toggleFly()
		else
			keysDown[input.KeyCode] = true
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	keysDown[input.KeyCode] = false
end)

-- ohjaus + pyöriminen
RunService.RenderStepped:Connect(function(deltaTime)
	if flying and humanoidRootPart and bodyVelocity then
		local camera = workspace.CurrentCamera
		local direction = Vector3.new()

		-- WASD
		if keysDown[Enum.KeyCode.W] then
			direction = direction + camera.CFrame.LookVector
		end
		if keysDown[Enum.KeyCode.S] then
			direction = direction - camera.CFrame.LookVector
		end
		if keysDown[Enum.KeyCode.A] then
			direction = direction - camera.CFrame.RightVector
		end
		if keysDown[Enum.KeyCode.D] then
			direction = direction + camera.CFrame.RightVector
		end
		-- Ylös/alas
		if keysDown[Enum.KeyCode.Space] then
			direction = direction + Vector3.new(0,1,0)
		end
		if keysDown[Enum.KeyCode.Q] then
			direction = direction + Vector3.new(0,-1,0)
		end

		if direction.Magnitude > 0 then
			direction = direction.Unit * speed
		end

		bodyVelocity.Velocity = direction

		-- kevyt pyöriminen
		humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(rotationSpeed), 0)
	end
end)

