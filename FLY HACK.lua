local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- ===== Fly settings =====
local flying = false
local speed = 60 -- studs/sec (säädä +- näppäimillä)
local keys = {W=false,A=false,S=false,D=false,Up=false,Down=false}

-- ===== Slow walk settings =====
local slowWalkEnabled = false
local normalSpeed = 16
local slowSpeed = 2

-- ===== Helper functions =====
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
    elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.Down = down
    end
end

local function updateWalk(char)
    local hum = char:WaitForChild("Humanoid")
    if slowWalkEnabled then
        hum.WalkSpeed = slowSpeed
        print("[SlowWalk] PÄÄLLÄ (nopeus = " .. slowSpeed .. ")")
    else
        hum.WalkSpeed = normalSpeed
        print("[SlowWalk] POIS (nopeus = " .. normalSpeed .. ")")
    end
end

-- ===== Input events =====
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    -- Fly toggle
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

    -- Fly speed adjustment
    elseif input.KeyCode == Enum.KeyCode.Equals or input.KeyCode == Enum.KeyCode.KeypadPlus then
        speed = math.clamp(speed + 10, 10, 300)
        if flying then print("[Fly] Speed:", speed) end
    elseif input.KeyCode == Enum.KeyCode.Minus or input.KeyCode == Enum.KeyCode.KeypadMinus then
        speed = math.clamp(speed - 10, 10, 300)
        if flying then print("[Fly] Speed:", speed) end

    -- Slow walk toggle (H)
    elseif input.KeyCode == Enum.KeyCode.H then
        slowWalkEnabled = not slowWalkEnabled
        if player.Character then
            updateWalk(player.Character)
        end

    else
        setKey(input, true)
    end
end)

UserInputService.InputEnded:Connect(function(input, gpe)
    if gpe then return end
    setKey(input, false)
end)

-- ===== Fly movement =====
RunService.RenderStepped:Connect(function(dt)
    if not flying then return end
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
end)

-- ===== Character events =====
player.CharacterAdded:Connect(function(char)
    flying = false
    updateWalk(char)
end)

if player.Character then
    updateWalk(player.Character)
end
