-- Clean old instances if exists
local OldMenu = game:GetService("CoreGui"):FindFirstChild("DexosHubMenu")
if OldMenu then OldMenu:Destroy() end

-- Screen Layer
local SGui = Instance.new("ScreenGui")
SGui.Name = "DexosHubMenu"
SGui.Parent = game:GetService("CoreGui")

-- Main Panel (Simple Dark Frame)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 220, 0, 180)
Panel.Position = UDim2.new(0.5, -110, 0.4, -90)
Panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Panel.BorderSizePixel = 2
Panel.BorderColor3 = Color3.fromRGB(0, 255, 150) -- Neon Green
Panel.Active = true
Panel.Draggable = true -- You can drag it with mouse or finger
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

-- BUTTON 1: WALK SPEED
local ButtonSpeed = Instance.new("TextButton")
ButtonSpeed.Size = UDim2.new(0, 180, 0, 40)
ButtonSpeed.Position = UDim2.new(0, 20, 0, 50)
ButtonSpeed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonSpeed.Text = "Set Speed to 100"
ButtonSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonSpeed.TextSize = 16
ButtonSpeed.Font = Enum.Font.SourceSansSemibold
ButtonSpeed.Parent = Panel

ButtonSpeed.MouseButton1Click:Connect(function()
    pcall(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
        ButtonSpeed.Text = "Speed: 100 (Active)"
        ButtonSpeed.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    end)
end)

-- BUTTON 2: HIGH JUMP
local ButtonJump = Instance.new("TextButton")
ButtonJump.Size = UDim2.new(0, 180, 0, 40)
ButtonJump.Position = UDim2.new(0, 20, 0, 105)
ButtonJump.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonJump.Text = "High Jump"
ButtonJump.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonJump.TextSize = 16
ButtonJump.Font = Enum.Font.SourceSansSemibold
ButtonJump.Parent = Panel

ButtonJump.MouseButton1Click:Connect(function()
    pcall(function()
        local hum = game.Players.LocalPlayer.Character.Humanoid
        hum.JumpPower = 150
        hum.UseJumpPower = true
        ButtonJump.Text = "Jump: 150 (Active)"
        ButtonJump.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    end)
end)
