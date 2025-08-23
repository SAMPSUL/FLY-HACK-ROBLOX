local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local flying = true 
local speed = 60 
local keys = {W=false,A=false,S=false,D=false,Up=false,Down=false}

local function getHRP()
    local char = player.Character or player.CharacterAdded:Wait()
    return char:WaitForChild("HumanoidRootPart"), char:WaitForChild("Humanoid")
end

local function setKey(input, down)
    if input.KeyCode == Enum.KeyCode.W then keys.W = down
    elseif input.KeyCode == Enum.KeyCode.A then keys.A = down
    elseif input.KeyCode == Enum.KeyCode.S then keys.S = down
    elseif input.KeyCode == Enum.KeyCode.D then keys.D = down
    elseif input.KeyCode == Enum.KeyCode.Space then keys.Up = down
    elseif input.KeyCode == Enum.KeyCode.Q then keys.Down = down
    end
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
        
    if input.KeyCode == Enum.KeyCode.F then
        flying = not flying
        local hrp, hum = getHRP()
        if flying then
            hum:ChangeState(Enum.HumanoidStateType.Physics)
            hum.PlatformStand = true
            hrp.AssemblyLinearVelocity = Vector3.zero
            print("[Fly] ON  | Speed:", speed)
        else
            hum.PlatformStand = false
            hrp.AssemblyLinearVelocity = Vector3.zero
            print("[Fly] OFF")
        end

    elseif input.KeyCode == Enum.KeyCode.Equals or input.KeyCode == Enum.KeyCode.KeypadPlus then
        speed = math.clamp(speed + 10, 10, 300)
        if flying then print("[Fly] Speed:", speed) end
    elseif input.KeyCode == Enum.KeyCode.Minus or input.KeyCode == Enum.KeyCode.KeypadMinus then
        speed = math.clamp(speed - 10, 10, 300)
        if flying then print("[Fly] Speed:", speed) end

    else
        setKey(input, true)
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    setKey(input, false)
end)

RunService.RenderStepped:Connect(function(dt)
    if flying then
        local hrp, hum = getHRP()
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector

        look = Vector3.new(look.X, 0, look.Z).Unit
        right = Vector3.new(right.X, 0, right.Z).Unit

        local dir = Vector3.zero
        if keys.W then dir += look end
        if keys.S then dir -= look end
        if keys.A then dir -= right end
        if keys.D then dir += right end
        if keys.Up then dir += Vector3.yAxis end
        if keys.Down then dir -= Vector3.yAxis end

        if dir.Magnitude > 0 then
            dir = dir.Unit
        end 

        hrp.AssemblyLinearVelocity = dir * speed

        local camCF = camera.CFrame
        local _, yaw, _ = camCF:ToEulerAnglesYXZ()
        local pos = hrp.CFrame.Position
        hrp.CFrame = CFrame.new(pos) * CFrame.Angles(0, yaw, 0)
    end
end)

player.CharacterAdded:Connect(function(char)
    local hrp, hum = getHRP()
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    hum.PlatformStand = true
end)

