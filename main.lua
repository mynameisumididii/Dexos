
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

-- Anime Background
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
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DEXOS HUB  //  UNIVERSAL v3"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = TitleBar

-- --- OPEN EYE ICON (Sadece menü kapalıyken sol ortada görünecek)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 60, 0, 35)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -17)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
OpenBtn.BackgroundTransparency = 0.3
OpenBtn.Text = "Dexos"
OpenBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
OpenBtn.TextSize = 12
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.ZIndex = 5
OpenBtn.Parent = SGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 6)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(180, 0, 255)
OpenStroke.Thickness = 1
OpenStroke.Parent = OpenBtn

-- --- CLOSE BUTTON (Title Bar'ın sağ köşesindeki X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 4
CloseBtn.Parent = TitleBar

CloseBtn.Activated:Connect(function()
    Panel.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.Activated:Connect(function()
    Panel.Visible = true
    OpenBtn.Visible = false
end)

-- Scrolling Content Frame
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -55)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.CanvasSize = UDim2.new(0, 0, 0, 480)
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

-- ==========================================
--         ⚙️ ENGINE CORE UTILITIES
-- ==========================================
_G.StepSpeed = 0
_G.CustomJumpBoost = 0
_G.InfJump = false

-- Physical Core Loop
RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
        -- WalkSpeed Multiplier
        if root and hum and hum.MoveDirection.Magnitude > 0 and _G.StepSpeed > 0 then
            root.CFrame = root.CFrame + (hum.MoveDirection * (_G.StepSpeed * 0.05))
        end
        
        -- Custom Jump Power Multiplier
        if _G.CustomJumpBoost > 0 and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            root.Velocity = Vector3.new(root.Velocity.X, 50 + _G.CustomJumpBoost, root.Velocity.Z)
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
Indicator.Text = "Speed Level: 0  ||  Jump Level: 0"
Indicator.TextColor3 = Color3.fromRGB(200, 180, 220)
Indicator.TextSize = 11
Indicator.Font = Enum.Font.Gotham
Indicator.ZIndex = 3
Indicator.Parent = Content

local function UpdateStats()
    Indicator.Text = "Speed Level: " .. tostring(_G.StepSpeed) .. "  ||  Jump Level: " .. tostring(_G.CustomJumpBoost)
end

-- --- FEATURES CONFIG ---

-- 1. SPEED UP (+5)
CreateButton("🏃 WalkSpeed +5", function()
    _G.StepSpeed = _G.StepSpeed + 1
    UpdateStats()
end)

-- 2. SPEED DOWN (-5)
CreateButton("🚶 WalkSpeed -5", function()
    if _G.StepSpeed > 0 then _G.StepSpeed = _G.StepSpeed - 1 else _G.StepSpeed = 0 end
    UpdateStats()
end)

-- 3. JUMP UP (+5)
CreateButton("🚀 Jump Power +5", function()
    _G.CustomJumpBoost = _G.CustomJumpBoost + 5
    UpdateStats()
end)

-- 4. JUMP DOWN (-5)
CreateButton("📉 Jump Power -5", function()
    if _G.CustomJumpBoost > 0 then _G.CustomJumpBoost = _G.CustomJumpBoost - 5 else _G.CustomJumpBoost = 0 end
    UpdateStats()
end)

-- 5. RESET ALL STATS
CreateButton("↩️ Reset Stats to Normal", function()
    _G.StepSpeed = 0
    _G.CustomJumpBoost = 0
    UpdateStats()
end)

-- 6. INFINITE JUMP
CreateButton("♾️ Infinite Jump: Toggle", function(btn)
    _G.InfJump = not _G.InfJump
    if _G.InfJump then btn.Text = "♾️ Infinite Jump: ON" else btn.Text = "♾️ Infinite Jump: Toggle" end
end)

-- 7. SMOOTH FLY SYSTEM
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

-- 8. NOCLIP
local noclip = false
CreateButton("🧱 Noclip: Toggle", function(btn)
    noclip = not noclip
    if noclip then btn.Text = "🧱 Noclip: ON" else btn.Text = "🧱 Noclip: Toggle" end
    local nc
    nc = RunService.Stepped:Connect(function()
        if not noclip then nc:Disconnect() return end
        if LP.Character then
