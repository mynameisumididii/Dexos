-- Clean old instances if exists
local OldMenu = game:GetService("CoreGui"):FindFirstChild("DexosHubMenu")
if OldMenu then OldMenu:Destroy() end

-- Screen Layer
local SGui = Instance.new("ScreenGui")
SGui.Name = "DexosHubMenu"
SGui.Parent = game:GetService("CoreGui")

-- Main Panel (Simple Dark Frame - Size increased for more buttons)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 220, 0, 290)
Panel.Position = UDim2.new(0.5, -110, 0.4, -145)
Panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Panel.BorderSizePixel = 2
Panel.BorderColor3 = Color3.fromRGB(0, 255, 150) -- Neon Green
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SGui

-- Title Label (DEXOS HUB)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "⚡ DEXOS HUB (UNIVERSAL)"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Panel

-- --- SPEED SETTINGS ---

-- BUTTON 1: SPEED +10
local ButtonSpeedUp = Instance.new("TextButton")
ButtonSpeedUp.Size = UDim2.new(0, 180, 0, 35)
ButtonSpeedUp.Position = UDim2.new(0, 20, 0, 50)
ButtonSpeedUp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonSpeedUp.Text = "🏃 Speed +10"
ButtonSpeedUp.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonSpeedUp.TextSize = 14
ButtonSpeedUp.Font = Enum.Font.SourceSansSemibold
ButtonSpeedUp.Parent = Panel

ButtonSpeedUp.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.WalkSpeed = hum.WalkSpeed + 10
    end)
end)

-- BUTTON 2: SPEED -10
local ButtonSpeedDown = Instance.new("TextButton")
ButtonSpeedDown.Size = UDim2.new(0, 180, 0, 35)
ButtonSpeedDown.Position = UDim2.new(0, 20, 0, 95)
ButtonSpeedDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonSpeedDown.Text = "🚶 Speed -10"
ButtonSpeedDown.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonSpeedDown.TextSize = 14
ButtonSpeedDown.Font = Enum.Font.SourceSansSemibold
ButtonSpeedDown.Parent = Panel

ButtonSpeedDown.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        if hum.WalkSpeed > 10 then
            hum.WalkSpeed = hum.WalkSpeed - 10
        end
    end)
end)

-- --- JUMP SETTINGS ---

-- BUTTON 3: JUMP +20
local ButtonJumpUp = Instance.new("TextButton")
ButtonJumpUp.Size = UDim2.new(0, 180, 0, 35)
ButtonJumpUp.Position = UDim2.new(0, 20, 0, 150)
ButtonJumpUp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonJumpUp.Text = "🚀 Jump Power +20"
ButtonJumpUp.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonJumpUp.TextSize = 14
ButtonJumpUp.Font = Enum.Font.SourceSansSemibold
ButtonJumpUp.Parent = Panel

ButtonJumpUp.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        hum.JumpPower = hum.JumpPower + 20
    end)
end)

-- BUTTON 4: JUMP -20
local ButtonJumpDown = Instance.new("TextButton")
ButtonJumpDown.Size = UDim2.new(0, 180, 0, 35)
ButtonJumpDown.Position = UDim2.new(0, 20, 0, 195)
ButtonJumpDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonJumpDown.Text = "📉 Jump Power -20"
ButtonJumpDown.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonJumpDown.TextSize = 14
ButtonJumpDown.Font = Enum.Font.SourceSansSemibold
ButtonJumpDown.Parent = Panel

ButtonJumpDown.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.UseJumpPower = true
        if hum.JumpPower > 20 then
            hum.JumpPower = hum.JumpPower - 20
        end
    end)
end)

-- BUTTON 5: RESET ALL
local ButtonReset = Instance.new("TextButton")
ButtonReset.Size = UDim2.new(0, 180, 0, 35)
ButtonReset.Position = UDim2.new(0, 20, 0, 240)
ButtonReset.BackgroundColor3 = Color3.fromRGB(80, 20, 20) -- Red button for reset
ButtonReset.Text = "↩️ Reset to Normal"
ButtonReset.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonReset.TextSize = 14
ButtonReset.Font = Enum.Font.SourceSansBold
ButtonReset.Parent = Panel

ButtonReset.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end)
end)
