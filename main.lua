-- Clean old instances if exists
local OldMenu = game:GetService("CoreGui"):FindFirstChild("DexosHubMenu")
if OldMenu then OldMenu:Destroy() end

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer

-- Screen Layer (Xeno Safe Layer)
local SGui = Instance.new("ScreenGui")
SGui.Name = "DexosHubMenu"
SGui.ResetOnSpawn = false
SGui.Parent = CoreGui

-- Main Panel (Simple Matte Grey Frame)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 440, 0, 310)
Panel.Position = UDim2.new(0.5, -220, 0.4, -155)
Panel.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
Panel.BorderSizePixel = 0
Panel.Active = true
Panel.Draggable = true
Panel.Visible = true -- Force open at start
Panel.Parent = SGui

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 8)
PanelCorner.Parent = Panel

local PanelStroke = Instance.new("UIStroke")
PanelStroke.Color = Color3.fromRGB(50, 50, 55)
PanelStroke.Thickness = 1.5
PanelStroke.Parent = Panel

-- Title Bar Frame
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
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
Title.Text = "DEXOS HUB  //  UNIVERSAL v4"
Title.TextColor3 = Color3.fromRGB(210, 210, 215)
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
OpenBtn.TextColor3 = Color3.fromRGB(200, 200, 205)
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
CloseBtn.TextColor3 = Color3.fromRGB(200, 80, 80)
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

-- Left Sidebar Navigation
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 110, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
Sidebar.ZIndex = 2
Sidebar.Parent = Panel

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 8)
SideCorner.Parent = Sidebar

local sll = Instance.new("UIListLayout")
sll.Parent = Sidebar
sll.Padding = UDim.new(0, 4)
sll.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Right Content Container
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -125, 1, -45)
MainContent.Position = UDim2.new(0, 120, 0, 40)
MainContent.BackgroundTransparency = 1
MainContent.ZIndex = 2
MainContent.Parent = Panel

local Pages = {}
local function CreatePage(name)
    local Scroller = Instance.new("ScrollingFrame")
    Scroller.Size = UDim2.new(1, 0, 1, 0)
    Scroller.BackgroundTransparency = 1
    Scroller.BorderSizePixel = 0
    Scroller.CanvasSize = UDim2.new(0, 0, 0, 420)
    Scroller.ScrollBarThickness = 2
    Scroller.ScrollBarImageColor3 = Color3.fromRGB(50, 50, 55)
    Scroller.Visible = false
    Scroller.ZIndex = 3
    Scroller.Parent = MainContent

    local ll = Instance.new("UIListLayout")
    ll.Parent = Scroller
    ll.Padding = UDim.new(0, 8)

    Pages[name] = Scroller

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0, 100, 0, 32)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 33)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(160, 160, 165)
    TabBtn.TextSize = 11
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.ZIndex = 3
    TabBtn.Parent = Sidebar

    local tbc = Instance.new("UICorner")
    tbc.CornerRadius = UDim.new(0, 4)
    tbc.Parent = TabBtn

    TabBtn.Activated:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do 
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(160, 160, 165) end 
        end
        Scroller.Visible = true 
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return Scroller
end

-- Generate Tabs
local HPage = CreatePage("Home") 
local MPage = CreatePage("Movement") 
local VPage = CreatePage("Visuals") 
Pages["Home"].Visible = true

-- Home Credit Info
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, -5, 0, 40)
Credit.BackgroundTransparency = 1
Credit.Text = "This script was made by umididii."
Credit.TextColor3 = Color3.fromRGB(200, 200, 205)
Credit.TextSize = 12
Credit.Font = Enum.Font.GothamSemibold
Credit.ZIndex = 4
Credit.Parent = HPage

local function CreateButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(38, 38, 42)
    Btn.BorderSizePixel = 0
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(200, 200, 205)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.GothamSemibold
    Btn.ZIndex = 4
    Btn.Parent = page

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
Indicator.TextColor3 = Color3.fromRGB(160, 160, 165)
Indicator.TextSize = 11
Indicator.Font = Enum.Font.Gotham
Indicator.ZIndex = 4
Indicator.Parent = MPage

local function UpdateStats()
    Indicator.Text = "Speed Level: " .. tostring(_G.StepSpeed) .. "  ||  Jump Level: " .. tostring(_G.CustomJumpBoost)
end

-- --- FEATURES CONFIG ---

CreateButton(MPage, "WalkSpeed +5", function()
    _G.StepSpeed = _G.StepSpeed + 1
    UpdateStats()
end)

CreateButton(MPage, "WalkSpeed -5", function()
    if _G.StepSpeed > 0 then _G.StepSpeed = _G.StepSpeed - 1 else _G.StepSpeed = 0 end
    UpdateStats()
end)

CreateButton(MPage, "Jump Power +5", function()
    _G.CustomJumpBoost = _G.CustomJumpBoost + 5
    UpdateStats()
end)

CreateButton(MPage, "Jump Power -5", function()
    if _G.CustomJumpBoost > 0 then _G.CustomJumpBoost = _G.CustomJumpBoost - 5 else _G.CustomJumpBoost = 0 end
    UpdateStats()
end)

CreateButton(MPage, "Reset Stats to Normal", function()
    _G.StepSpeed = 0
    _G.CustomJumpBoost = 0
    UpdateStats()
end)

CreateButton(MPage, "Infinite Jump: Toggle", function(btn)
    _G.InfJump = not _G.InfJump
    if _G.InfJump then btn.Text = "Infinite Jump: ON" else btn.Text = "Infinite Jump: Toggle" end
end)

local flying = false
local flySpeed = 60
local f_bv, f_bg
CreateButton(MPage, "Fly Mode: Toggle", function(btn)
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
