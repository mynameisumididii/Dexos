-- Clean old instances if exists
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

-- Main Panel (Simple Matte Grey Frame)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 420, 0, 310)
Panel.Position = UDim2.new(0.5, -210, 0.4, -155)
Panel.BackgroundColor3 = Color3.fromRGB(30, 30, 33) -- Matte Grey Background
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
Panel.Visible = true -- Force open at start
Panel.Parent = SGui

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 8)
PanelCorner.Parent = Panel

-- Clean Grey Border
local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(50, 50, 55) -- Soft Grey Border
PanelStroke.Thickness = 1.5
PanelStroke.Parent = Panel

-- Title Bar Frame
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 26) -- Darker Grey for Title
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2
TitleBar.Parent = Panel

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "DEXOS HUB  //  UNIVERSAL v3"
Title.TextColor3 = Color3.fromRGB(210, 210, 215) -- Non-bright Soft White Text
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3
Title.Parent = TitleBar

-- --- SMALL "D" OPEN BUTTON
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 15, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 38)
OpenBtn.Text = "D"
OpenBtn.TextColor3 = Color3.fromRGB(200, 200, 205) -- Soft White
OpenBtn.TextSize = 18
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.Visible = false
OpenBtn.ZIndex = 5
OpenBtn.Parent = SGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(55, 55, 60)
OpenStroke.Thickness = 1.5
OpenStroke.Parent = OpenBtn

-- --- CLOSE BUTTON (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 80, 80) -- Soft Red
CloseBtn.TextSize = 14
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
Content.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 65)
Content.ZIndex = 2
Content.Parent = Panel

local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = Content
ListLayout.Padding = UDim.new(0, 8)

local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(38, 38, 42) -- Lighter Grey for buttons
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 205) -- Non-bright Soft White
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.ZIndex = 3
    Btn.Parent = Content

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 5)
    BtnCorner.Parent = Btn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(48, 48, 52)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn

    Btn.Activated:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(48, 48, 52)}):Play()
        task.wait(0.1)
        TweenService:Create(Btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(38, 38, 42)}):Play()
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
        
        if root and hum and hum.MoveDirection.Magnitude > 0 and _G.StepSpeed > 0 then
            root.CFrame = root.CFrame + (hum.MoveDirection * (_G.StepSpeed * 0.05))
        end
        
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
Indicator.TextColor3 = Color3.fromRGB(160, 160, 165) -- Soft Grey-White
Indicator.TextSize = 11
Indicator.Font = Enum.Font.Gotham
Indicator.ZIndex = 3
Indicator.Parent = Content

local function UpdateStats()
    Indicator.Text = "Speed Level: " .. tostring(_G.StepSpeed) .. "  ||  Jump Level: " .. tostring(_G.CustomJumpBoost)
end

-- --- FEATURES CONFIG ---

CreateButton("WalkSpeed +5", function()
    _G.StepSpeed = _G.StepSpeed + 1
    UpdateStats()
end)

CreateButton("WalkSpeed -5", function()
    if _G.StepSpeed > 0 then _G.StepSpeed = _G.StepSpeed - 1 else _G.StepSpeed = 0 end
    UpdateStats()
end)

CreateButton("Jump Power +5", function()
    _G.CustomJumpBoost = _G.CustomJumpBoost + 5
    UpdateStats()
end)

CreateButton("Jump Power -5", function()
    if _G.CustomJumpBoost > 0 then _G.CustomJumpBoost = _G.CustomJumpBoost - 5 else _G.CustomJumpBoost = 0 end
    UpdateStats()
end)

CreateButton("Reset Stats to Normal", function()
    _G.StepSpeed = 0
    _G.CustomJumpBoost = 0
    UpdateStats()
end)

CreateButton("Infinite Jump: Toggle", function(btn)
    _G.InfJump = not _G.InfJump
    if _G.InfJump then btn.Text = "Infinite Jump: ON" else btn.Text = "Infinite Jump: Toggle" end
end)

local flying = false
local flySpeed = 60
local f_bv, f_bg
CreateButton("Fly Mode: Toggle", function(btn)
    pcall(function()
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        flying = not flying
        if flying then
            btn.Text = "Fly Mode: ON"
            btn.BackgroundColor3 = Color3.fromRGB(48, 48, 52)
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
                btn.Text = "Fly Mode: Toggle"
                btn.BackgroundColor3 = Color3.fromRGB(38, 38, 42)
            end)
        else flying = false end
    end)
end)

local noclip = false
CreateButton("Noclip: Toggle", function(btn)
    noclip = not noclip
    if noclip then btn.Text = "Noclip: ON" else btn.Text = "Noclip: Toggle" end
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
CreateButton("Player ESP: Toggle", function(btn)
    espActive = not espActive
    if espActive then btn.Text = "ESP: ON" else btn.Text = "Player ESP: Toggle" end
    local function ApplyESP(player)
        if player ~= LP and player.Character then
