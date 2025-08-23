local Players = game:GetService("Players")
local player = Players.LocalPlayer

local PlayerGui = player:WaitForChild("PlayerGui")

local oldGui = PlayerGui:FindFirstChild("SampsulsModMenu")
if oldGui then
    oldGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SampsulsModMenu"
screenGui.ResetOnSpawn = false 
screenGui.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 500, 0, 300)
frame.Position = UDim2.new(0.5, -250, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "SAMPSULS MOD MENU"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(180, 100, 255)
title.Parent = frame

local buttonsInfo = {
    {name="ROBLOX_IGOR", url="https://raw.githubusercontent.com/SAMPSUL/SAMPSULS-MOD-MENU-ROBLOX/refs/heads/main/HACKS/ROBLOX_IGOR%20(NOT%20WORKING%20GOOD).LUA"},
    {name="FLY", url="https://raw.githubusercontent.com/SAMPSUL/SAMPSULS-MOD-MENU-ROBLOX/refs/heads/main/HACKS/FLY.lua"},
    {name="FLY + SPIN", url="https://raw.githubusercontent.com/SAMPSUL/SAMPSULS-MOD-MENU-ROBLOX/refs/heads/main/FLY%20SPIN.lua"},
    {name="NO CLIP", url="https://raw.githubusercontent.com/SAMPSUL/FLY-HACK-ROBLOX/refs/heads/main/NOCLIP.lua"},
    {name="MAX HP", url="https://raw.githubusercontent.com/SAMPSUL/FLY-HACK-ROBLOX/refs/heads/main/MAXHP.lua"},
    {name="NOT WORKING", url="https://raw.githubusercontent.com/USERNAME/REPO/main/script6.lua"},
    {name="NOT WORKING", url="https://raw.githubusercontent.com/USERNAME/REPO/main/script7.lua"},
    {name="NOT WORKING", url="https://raw.githubusercontent.com/USERNAME/REPO/main/script8.lua"},
}

for i, info in ipairs(buttonsInfo) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 30)
    button.Position = UDim2.new(0, 20 + ((i-1)%2)*240, 0, 50 + math.floor((i-1)/2)*40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(180, 100, 255)
    button.Text = info.name
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.Parent = frame
    button.AutoButtonColor = false
    button.BorderSizePixel = 0

    button.MouseButton1Click:Connect(function()
        local success, result = pcall(function()
            local source = game:HttpGet(info.url)
            local func = loadstring(source)
            if func then
                task.spawn(func)
            end
        end)
        if not success then
            warn("SCRIPT NOT LOADED: "..tostring(result))
        end
    end)
end

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 80, 0, 15)
versionLabel.Position = UDim2.new(0, 5, 1, -20)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "V1.0.2"
versionLabel.TextScaled = true
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextColor3 = Color3.fromRGB(200, 200, 200) 
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = frame

local versionShadow = versionLabel:Clone()
versionShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
versionShadow.Position = UDim2.new(0, 6, 1, -19) 
versionShadow.ZIndex = versionLabel.ZIndex - 1
versionShadow.Parent = frame

local madeByLabel = Instance.new("TextLabel")
madeByLabel.Size = UDim2.new(0, 200, 0, 15)
madeByLabel.Position = UDim2.new(1, -205, 1, -20)
madeByLabel.BackgroundTransparency = 1
madeByLabel.Text = "MADE BY: SAMPSUL"
madeByLabel.TextScaled = true
madeByLabel.Font = Enum.Font.Gotham
madeByLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
madeByLabel.TextXAlignment = Enum.TextXAlignment.Right
madeByLabel.Parent = frame

local madeByShadow = madeByLabel:Clone()
madeByShadow.TextColor3 = Color3.fromRGB(0, 0, 0)
madeByShadow.Position = UDim2.new(1, -204, 1, -19)
madeByShadow.ZIndex = madeByLabel.ZIndex - 1
madeByShadow.Parent = frame
