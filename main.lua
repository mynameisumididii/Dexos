
local OldMenu = game:GetService("CoreGui"):FindFirstChild("DexosHubMenu")
if OldMenu then OldMenu:Destroy() end

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer

-- Screen Layer
local SGui = Instance.new("ScreenGui")
SGui.Name = "DexosHubMenu"
SGui.Parent = CoreGui

-- Main Panel (Premium Translucent Anime Frame)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 420, 0, 310)
Panel.Position = UDim2.new(0.5, -210, 0.4, -155)
Panel.BackgroundColor3 = Color3.fromRGB(15, 12, 18)
Panel.BackgroundTransparency = 0.25
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SGui

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 10)
PanelCorner.Parent = Panel

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(180, 0, 255)
PanelStroke.Thickness = 1.5
PanelStroke.Parent = Panel

-- 🌌 ANIME BG IMAGE
local AnimeBG = Instance.new("ImageLabel")
AnimeBG.Size = UDim2.new(1, 0, 1, 0)
AnimeBG.BackgroundTransparency = 1
AnimeBG.Image = "rbxassetid://13962635905"
AnimeBG.ImageTransparency = 0.75
AnimeBG.ScaleType = Enum.ScaleType.Crop
AnimeBG.ZIndex = 0
AnimeBG.Parent = Panel

-- Title Bar Frame
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(10, 8, 12)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = Panel

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DEXOS HUB  //  UNIVERSAL v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = TitleBar

-- Scrolling Content Frame
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -55)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.CanvasSize = UDim2.new(0, 0, 0, 450)
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Color3.fromRGB(180, 0, 255)
Content.ZIndex = 2
Content.Parent = Panel

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Content
ListLayout.Padding = UDim.new(0, 8)

local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
    Btn.BackgroundTransparency = 0.4
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.ZIndex = 3
    Btn.Parent = Content

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(60, 40, 80)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn

    Btn.Activated:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(180, 0, 255)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.4, BackgroundColor3 = Color3.fromRGB(25, 20, 30)}):Play()
        callback(Btn)
    end)
    return Btn
end

_G.StepSpeed = 0
_G.InfJump = false

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if root and hum and hum.MoveDirection.Magnitude > 0 and _G.StepSpeed > 0 then
            root.CFrame = root.CFrame + (hum.MoveDirection * (_G.StepSpeed * 0.1))
        end
    end)
end)

UserInputService.JumpRequest:Connect(function()
    if _G.InfJump then
        pcall(function() LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end)
    end
end)

local Indicator = Instance.new("TextLabel")
Indicator.Size = UDim2.new(1, -5, 0, 20)
Indicator.BackgroundTransparency = 1
Indicator.Text = "Custom Speed Level: 0"
Indicator.TextColor3 = Color3.fromRGB(200, 180, 220)
Indicator.TextSize = 11
Indicator.Font = Enum.Font.Gotham
Indicator.ZIndex = 3
Indicator.Parent = Content

CreateButton("🏃 WalkSpeed +10", function()
    _G.StepSpeed = _G.StepSpeed + 2
    Indicator.Text = "Custom Speed Level: " .. tostring(_G.StepSpeed)
end)

CreateButton("🚶 WalkSpeed -10", function()
    if _G.StepSpeed > 0 then _G.StepSpeed = _G.StepSpeed - 2 else _G.StepSpeed = 0 end
    Indicator.Text = "Custom Speed Level: " .. tostring(_G.StepSpeed)
end)

CreateButton("♾️ Infinite Jump: Toggle", function(btn)
    _G.InfJump = not _G.InfJump
    if _G.InfJump then btn.Text = "♾️ Infinite Jump: ON" else btn.Text = "♾️ Infinite Jump: Toggle" end
end)

local flying = false
local flySpeed = 60
local f_bv, f_bg
CreateButton("🦅 Fly Mode: Toggle", function(btn)
    pcall(function()
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        flying = not flying
        if flying then
            btn.Text = "🦅 Fly Mode: ON"
            f_bg = Instance.new("BodyGyro") f_bg.P = 9e4 f_bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            f_bg.cframe = root.CFrame f_bg.Parent = root
            f_bv = Instance.new("BodyVelocity") f_bv.velocity = Vector3.new(0, 0.1, 0) f_bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            f_bv.Parent = root
            task.spawn(function()
                while flying and char and root.Parent do
                    char.Humanoid.PlatformStand = true
                    local camera = workspace.CurrentCamera
                    local moveDir = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                    f_bv.velocity = moveDir * flySpeed
                    f_bg.cframe = camera.CFrame
                    task.wait()
                end
                if f_bg then f_bg:Destroy() end
                if f_bv then f_bv:Destroy() end
                if char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
                btn.Text = "🦅 Fly Mode: Toggle"
            end)
        else flying = false end
    end)
end)

local noclip = false
CreateButton("🧱 Noclip: Toggle", function(btn)
    noclip = not noclip
    if noclip then btn.Text = "🧱 Noclip: ON" else btn.Text = "🧱 Noclip: Toggle" end
    local nc
    nc = RunService.Stepped:Connect(function()
        if not noclip then nc:Disconnect() return end
        if LP.Character then
            for _, v in pairs(LP.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

local espActive = false
CreateButton("👁️ Player ESP: Toggle", function(btn)
    espActive = not espActive
    if espActive then btn.Text = "👁️ ESP: ON" else btn.Text = "👁️ Player ESP: Toggle" end
    local function ApplyESP(player)
        if player ~= LP and player.Character then
            if espActive then
                if not player.Character:FindFirstChild("DexosESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "DexosESP"
                    highlight.FillColor = Color3.fromRGB(180, 0, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0.2
                    highlight.Parent = player.Character
                end
            else
                if player.Character:FindFirstChild("DexosESP") then player.Character.DexosESP:Destroy() end
            end
        end
    end
    for _, p in pairs(game.Players:GetPlayers()) do ApplyESP(p) end
    game.Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(1) if espActive then ApplyESP(p) end end) end)
end)

-- Sol Ctrl ile Kapatma/Açma Bindi (Düzeltildi)
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.LeftControl then
        Panel.Visible = not Panel.Visible
    end
end)
