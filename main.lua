-- ==========================================
--    UMIDI HUB - %100 ÇALIŞAN BYPASS SÜRÜMÜ
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer

-- Eski menü varsa temizle
if CoreGui:FindFirstChild("UmidiHubMenu") then CoreGui.UmidiHubMenu:Destroy() end

-- Ekran Katmanı
local SGui = Instance.new("ScreenGui")
SGui.Name = "UmidiHubMenu"
SGui.Parent = CoreGui

-- ANA PANEL
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 260)
MainFrame.Position = UDim2.new(0.5, -210, 0.4, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = SGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 180, 255)
Stroke.Thickness = 1.5
Stroke.Parent = MainFrame

-- SOL DİKEY BAR
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 110, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 8)
SideCorner.Parent = SideBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "UMIDI HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = SideBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 15)
SubTitle.Position = UDim2.new(0, 0, 0, 30)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Universal v3"
SubTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = SideBar

-- SAĞ İÇERİK ALANI
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -120, 1, -20)
ContentFrame.Position = UDim2.new(0, 115, 0, 10)
ContentFrame.BackgroundTransparency = 1
ContentFrame.BorderSizePixel = 0
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 380)
ContentFrame.ScrollBarThickness = 4
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 180, 255)
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ContentFrame
ListLayout.Padding = UDim.new(0, 8)

-- MODERN BUTON YAPICI
local function CreateModernButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    Btn.TextSize = 13
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Parent = ContentFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(35, 35, 40)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(0, 120, 200)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22, 22, 26)}):Play()
        callback(Btn)
    end)
    return Btn
end

-- ==========================================
--        🔥 BYPASS VE ÖZELLİK KODLARI 🔥
-- ==========================================

_G.TargetSpeed = 16
_G.TargetJump = 50

-- Oyunun hileyi engellemesini önleyen arka plan döngüsü (Anti-Cheat Bypass)
RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LP.Character
        if char and char:FindFirstChild("Humanoid") then
            -- Oyun hızı sıfırlamaya çalışırsa bizim belirlediğimiz hıza geri zorlar
            if _G.TargetSpeed ~= 16 then
                char.Humanoid.WalkSpeed = _G.TargetSpeed
            end
            -- Zıplama gücü sabitleyici
            if _G.TargetJump ~= 50 then
                char.Humanoid.JumpPower = _G.TargetJump
                char.Humanoid.UseJumpPower = true
            end
        end
    end)
end)

local MevcutHizText = Instance.new("TextLabel")
MevcutHizText.Size = UDim2.new(1, -10, 0, 20)
MevcutHizText.BackgroundTransparency = 1
MevcutHizText.Text = "Mevcut Hız: 16"
MevcutHizText.TextColor3 = Color3.fromRGB(150, 150, 150)
MevcutHizText.TextSize = 12
MevcutHizText.Font = Enum.Font.Gotham
MevcutHizText.Parent = ContentFrame

-- 1. HIZ ARTIR
CreateModernButton("🏃 Hızı +10 Yükselt", function()
    _G.TargetSpeed = _G.TargetSpeed + 10
    MevcutHizText.Text = "Mevcut Hız: " .. tostring(_G.TargetSpeed)
end)

-- 2. HIZ AZALT
CreateModernButton("🚶 Hızı -10 Düşür", function()
    if _G.TargetSpeed > 16 then
        _G.TargetSpeed = _G.TargetSpeed - 10
        MevcutHizText.Text = "Mevcut Hız: " .. tostring(_G.TargetSpeed)
    else
        _G.TargetSpeed = 16
        MevcutHizText.Text = "Mevcut Hız: 16 (Normal)"
    end
end)

-- 3. SÜPER ZIPLAMA
CreateModernButton("🚀 Süper Zıplama (150)", function()
    _G.TargetJump = 150
end)

-- 4. ZIPLAMAYI SIFIRLA
CreateModernButton("↩️ Zıplamayı Normale Döndür", function()
    _G.TargetJump = 50
    pcall(function() LP.Character.Humanoid.JumpPower = 50 end)
end)

-- 5. KESİN ÇALIŞAN UÇMA (FLY)
local flying = false
local flySpeed = 60
local bv, bg

CreateModernButton("🦅 Uçuşu Aç/Kapat", function(btn)
    pcall(function()
        local char = LP.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        flying = not flying
        
        if flying then
            btn.Text = "🦅 Uçuş: AKTİF"
            btn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
            
            bg = Instance.new("BodyGyro")
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = char.HumanoidRootPart.CFrame
            bg.Parent = char.HumanoidRootPart
            
            bv = Instance.new("BodyVelocity")
            bv.velocity = Vector3.new(0, 0.1, 0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Parent = char.HumanoidRootPart
            
            task.spawn(function()
                while flying and char and char:FindFirstChild("HumanoidRootPart") do
                    char.Humanoid.PlatformStand = true
                    local camera = workspace.CurrentCamera
                    local moveDir = Vector3.new(0,0,0)
                    
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                    
                    bv.velocity = moveDir * flySpeed
                    bg.cframe = camera.CFrame
                    task.wait()
                end
                if bg then bg:Destroy() end
                if bv then bv:Destroy() end
                if char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
                btn.Text = "🦅 Uçuşu Aç/Kapat"
                btn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
            end)
        else
            flying = false
        end
    end)
end)

-- 6. DUVARLARDAN GECE (NOCLIP)
local noclip = false
CreateModernButton("🧱 Duvarlardan Geçme", function(btn)
    noclip = not noclip
    if noclip then 
        btn.Text = "🧱 Duvar Geçme: AKTİF" 
        btn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    else 
        btn.Text = "🧱 Duvarlardan Geçme"
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    end
    RunService.Stepped:Connect(function()
        if noclip and LP.Character then
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- 7. FPS BOOST
CreateModernButton("🎮 Gelişmiş FPS Boost", function(btn)
    pcall(function()
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Texture") or v:IsA("Decal") then v:Destroy() end
        end
        btn.Text = "🎮 FPS Tavan Yaptı!"
        btn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    end)
end)
