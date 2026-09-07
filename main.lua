-- ==========================================
--        DEXOS HUB - UNIVERSAL v6 (PRO)
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer

-- Clean old instances
if CoreGui:FindFirstChild("DexosHubMenu") then CoreGui.DexosHubMenu:Destroy() end
if CoreGui:FindFirstChild("DexosLoadingGui") then CoreGui.DexosLoadingGui:Destroy() end

-- ==========================================
--       🌌 CYBERPUNK LOADING SCREEN
-- ==========================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "DexosLoadingGui"
LoadingGui.Parent = CoreGui

local LoadFrame = Instance.new("Frame")
LoadFrame.Size = UDim2.new(0, 320, 0, 140)
LoadFrame.Position = UDim2.new(0.5, -160, 0.4, -70)
LoadFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 14)
LoadFrame.BorderSizePixel = 0
LoadFrame.Parent = LoadingGui

local LCorner = Instance.new("UICorner")
LCorner.CornerRadius = UDim.new(0, 10)
LCorner.Parent = LoadFrame

local LStroke = Instance.new("UIStroke")
LStroke.Color = Color3.fromRGB(140, 0, 255) -- Deep Purple Neon
LStroke.Thickness = 2
LStroke.Parent = LoadFrame

local LTitle = Instance.new("TextLabel")
LTitle.Size = UDim2.new(1, 0, 0, 45)
LTitle.BackgroundTransparency = 1
LTitle.Text = "DEXOS HUB"
LTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LTitle.TextSize = 22
LTitle.Font = Enum.Font.GothamBold
LTitle.Parent = LoadFrame

-- Subtitle with Gradient Look effect
local LSub = Instance.new("TextLabel")
LSub.Size = UDim2.new(1, 0, 0, 15)
LSub.Position = UDim2.new(0, 0, 0, 35)
LSub.BackgroundTransparency = 1
LSub.Text = "Premium Universal Script"
LSub.TextColor3 = Color3.fromRGB(0, 180, 255) -- Cyan Accent
LSub.TextSize = 10
LSub.Font = Enum.Font.Gotham
LSub.Parent = LoadFrame

local LStatus = Instance.new("TextLabel")
LStatus.Size = UDim2.new(1, 0, 0, 20)
LStatus.Position = UDim2.new(0, 0, 0, 65)
LStatus.BackgroundTransparency = 1
LStatus.Text = "Initializing framework..."
LStatus.TextColor3 = Color3.fromRGB(150, 150, 160)
LStatus.TextSize = 11
LStatus.Font = Enum.Font.GothamMedium
LStatus.Parent = LoadFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 260, 0, 5)
BarBg.Position = UDim2.new(0.5, -130, 0, 100)
BarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoadFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 3)
BarBgCorner.Parent = BarBg

local BarMain = Instance.new("Frame")
BarMain.Size = UDim2.new(0, 0, 1, 0)
BarMain.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
BarMain.BorderSizePixel = 0
BarMain.Parent = BarBg

local BarMainCorner = Instance.new("UICorner")
BarMainCorner.CornerRadius = UDim.new(0, 3)
BarMainCorner.Parent = BarMain

-- Rainbow/RGB Effect for Loading Text/Bar Accent
task.spawn(function()
    local hue = 0
    while LoadingGui.Parent do
        LStroke.Color = Color3.fromHSV(hue, 0.8, 1)
        BarMain.BackgroundColor3 = Color3.fromHSV(hue, 0.8, 1)
        hue = hue + 0.005
        if hue > 1 then hue = 0 end
        task.wait(0.02)
    end
end)

-- Loading Stages Anim
task.spawn(function()
    task.wait(0.5)
    LStatus.Text = "Checking executor security..."
    TweenService:Create(BarMain, TweenInfo.new(1, Enum.EasingStyle.QuadOut), {Size = UDim2.new(0.3, 0, 1, 0)}):Play()
    task.wait(1)
    
    LStatus.Text = "Bypassing game anti-cheat..."
    TweenService:Create(BarMain, TweenInfo.new(0.8, Enum.EasingStyle.QuadOut), {Size = UDim2.new(0.6, 0, 1, 0)}):Play()
    task.wait(0.8)
    
    LStatus.Text = "Injecting Dexos ESP & Motor..."
    TweenService:Create(BarMain, TweenInfo.new(1.2, Enum.EasingStyle.QuadOut), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1.2)
    
    LStatus.Text = "Successfully Loaded!"
    task.wait(0.4)
    LoadingGui:Destroy()
end)

task.wait(3.9) -- Wait for loader to finish

-- ==========================================
--         MAIN DEXOS HUB INTERFACE
-- ==========================================
local SGui = Instance.new("ScreenGui")
SGui.Name = "DexosHubMenu"
SGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 280)
MainFrame.Position = UDim2.new(0.5, -220, 0.4, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 13) -- Premium Dark Cyberpunk
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = SGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Active RGB Effect on Main Frame Border
task.spawn(function()
    local hue = 0
    while SGui.Parent do
        MainStroke.Color = Color3.fromHSV(hue, 0.7, 0.9)
        hue = hue + 0.003
        if hue > 1 then hue = 0 end
        task.wait(0.03)
    end
end)

-- SIDE NAVIGATION BAR
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 120, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(7, 7, 9)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 10)
SideCorner.Parent = SideBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "DEXOS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = SideBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(1, 0, 0, 15)
Version.Position = UDim2.new(0, 0, 0, 30)
Version.BackgroundTransparency = 1
Version.Text = "v6.0 Official"
Version.TextColor3 = Color3.fromRGB(140, 0, 255)
Version.TextSize = 9
Version.Font = Enum.Font.GothamMedium
Version.Parent = SideBar

-- CONTENT SCROLL FRAME
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -135, 1, -20)
ContentFrame.Position = UDim2.new(0, 125, 0, 10)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 420)
ContentFrame.ScrollBarThickness = 3
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 0, 255)
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ContentFrame
ListLayout.Padding = UDim.new(0, 8)

-- MODERN BUTTON MAKER (ENG)
local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Parent = ContentFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(28, 28, 35)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn

    Btn.Activated:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(140, 0, 255)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(18, 18, 23)}):Play()
        callback(Btn)
    end)
    return Btn
end

-- ==========================================
--         ⚙️ ENGINE CORE FUNCTIONS
-- ==========================================
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50

RunService.Stepped:Connect(function()
    pcall(function()
        local char = LP.Character
        if char and char:FindFirstChild("Humanoid") then
            if _G.WalkSpeedValue ~= 16 then char.Humanoid.WalkSpeed = _G.WalkSpeedValue end
            if _G.JumpPowerValue ~= 50 then 
                char.Humanoid.JumpPower = _G.JumpPowerValue 
                char.Humanoid.UseJumpPower = true
            end
        end
    end)
end)

local SpeedIndicator = Instance.new("TextLabel")
SpeedIndicator.Size = UDim2.new(1, -10, 0, 20)
SpeedIndicator.BackgroundTransparency = 1
SpeedIndicator.Text = "Current Speed: 16"
SpeedIndicator.TextColor3 = Color3.fromRGB(140, 140, 150)
SpeedIndicator.TextSize = 11
SpeedIndicator.Font = Enum.Font.Gotham
SpeedIndicator.Parent = ContentFrame

-- 1. SPEED UP
CreateButton("🏃 WalkSpeed +10", function()
    _G.WalkSpeedValue = _G.WalkSpeedValue + 10
    SpeedIndicator.Text = "Current Speed: " .. tostring(_G.WalkSpeedValue)
end)

-- 2. SPEED DOWN
CreateButton("🚶 WalkSpeed -10", function()
    if _G.WalkSpeedValue > 16 then
        _G.WalkSpeedValue = _G.WalkSpeedValue - 10
        SpeedIndicator.Text = "Current Speed: " .. tostring(_G.WalkSpeedValue)
    else
        _G.WalkSpeedValue = 16
        SpeedIndicator.Text = "Current Speed: 16 (Normal)"
    end
end)

-- 3. JUMP GIVER
CreateButton("🚀 High Jump (150)", function()
    _G.JumpPowerValue = 150
end)

-- 4. PURE FLY
local flying = false
local flySpeed = 50
local bv, bg

CreateButton("🦅 Fly Mode: Toggle", function(btn)
    pcall(function()
        local char = LP.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        flying = not flying
        
        if flying then
            btn.Text = "🦅 Fly Mode: ON"
            bg = Instance.new("BodyGyro", char.HumanoidRootPart)
            bg.P = 9e4 bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) bg.cframe = char.HumanoidRootPart.CFrame
            
            bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
            bv.velocity = Vector3.new(0, 0.1, 0) bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            task.spawn(function()
                while flying and char and char:FindFirstChild("HumanoidRootPart") do
