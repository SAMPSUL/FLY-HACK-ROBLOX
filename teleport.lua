local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Määritä pelaaja, joka halutaan teleportata
local targetName = "salsaaaaaaaa7" -- vaihda tähän haluamasi pelaajan nimi

local function teleportTarget()
    local targetPlayer = Players:FindFirstChild(targetName)
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        warn("Pelaajaa ei löytynyt tai hänellä ei ole hahmoa.")
        return
    end

    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local targetHRP = targetPlayer.Character.HumanoidRootPart

    targetHRP.CFrame = hrp.CFrame + Vector3.new(0,0,3) -- pieni offset ettei osu päälle
    print(targetPlayer.Name .. " teleportattu luoksesi!")
end

-- Näppäinpainalluksen kuuntelu
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.O then
        teleportTarget()
    end
end)
