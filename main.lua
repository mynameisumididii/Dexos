-- ==========================================
--        KANKANIN EVRENSEL SCRIPTI (FPS BOOSTLU)
-- ==========================================

local EskiMenu = game:GetService("CoreGui"):FindFirstChild("KankaHubMenu")
if EskiMenu then EskiMenu:Destroy() end

local SGui = Instance.new("ScreenGui")
SGui.Name = "KankaHubMenu"
SGui.Parent = game:GetService("CoreGui")

-- ANA PANEL (Boyutları butonlar sığsın diye ayarladım kanka)
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 220, 0, 325)
Panel.Position = UDim2.new(0.5, -110, 0.4, -162)
Panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Panel.BorderSizePixel = 2
Panel.BorderColor3 = Color3.fromRGB(0, 255, 150) -- Neon Yeşil
Panel.Active = true
Panel.Draggable = true
Panel.Parent = SGui

-- BAŞLIK
local Baslik = Instance.new("TextLabel")
Baslik.Size = UDim2.new(1, 0, 0, 35)
Baslik.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Baslik.Text = "⚡ KANKA HUB (EVRENSEL)"
Baslik.TextColor3 = Color3.fromRGB(0, 255, 150)
Baslik.TextSize = 14
Baslik.Font = Enum.Font.SourceSansBold
Baslik.Parent = Panel

-- BUTON 1: HIZ HİLESİ
local ButtonHiz = Instance.new("TextButton")
ButtonHiz.Size = UDim2.new(0, 180, 0, 40)
ButtonHiz.Position = UDim2.new(0, 20, 0, 50)
ButtonHiz.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonHiz.Text = "⚡ Hızı 100 Yap"
ButtonHiz.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonHiz.Parent = Panel

ButtonHiz.MouseButton1Click:Connect(function()
    pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
end)

-- BUTON 2: ZIPLAMA HİLESİ
local ButtonZip = Instance.new("TextButton")
ButtonZip.Size = UDim2.new(0, 180, 0, 40)
ButtonZip.Position = UDim2.new(0, 20, 0, 105)
ButtonZip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonZip.Text = "🚀 Yüksek Zıplama"
ButtonZip.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonZip.Parent = Panel

ButtonZip.MouseButton1Click:Connect(function()
    pcall(function() 
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150 
        game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
    end)
end)

-- BUTON 3: UÇMA HİLESİ (FLY)
local ButtonFly = Instance.new("TextButton")
ButtonFly.Size = UDim2.new(0, 180, 0, 40)
ButtonFly.Position = UDim2.new(0, 20, 0, 160)
ButtonFly.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonFly.Text = "🦅 Uçmayı Aç/Kapat"
ButtonFly.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonFly.Parent = Panel

local flying = false
ButtonFly.MouseButton1Click:Connect(function()
    pcall(function()
        local lp = game.Players.LocalPlayer
        local mouse = lp:GetMouse()
        local char = lp.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        flying = not flying
        if flying then
            ButtonFly.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
            local bg = Instance.new("BodyGyro", char.HumanoidRootPart)
            bg.P = 9e4 bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) bg.cframe = char.HumanoidRootPart.CFrame
            local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
            bv.velocity = Vector3.new(0,0.1,0) bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            spawn(function()
                while flying and char and char:FindFirstChild("HumanoidRootPart") do
                    char.Humanoid.PlatformStand = true
                    bv.velocity = mouse.Hit.lookVector * 50
                    bg.cframe = CFrame.new(char.HumanoidRootPart.Position, mouse.Hit.p)
                    task.wait()
                end
                bv:Destroy() bg:Destroy()
                if char:FindFirstChild("Humanoid") then char.Humanoid.PlatformStand = false end
                ButtonFly.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end)
        end
    end)
end)

-- BUTON 4: DUVARLARDAN GEÇME (NOCLIP)
local ButtonNoClip = Instance.new("TextButton")
ButtonNoClip.Size = UDim2.new(0, 180, 0, 40)
ButtonNoClip.Position = UDim2.new(0, 20, 0, 215)
ButtonNoClip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonNoClip.Text = "🧱 Duvarlardan Geç"
ButtonNoClip.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonNoClip.Parent = Panel

local noclip = false
ButtonNoClip.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then ButtonNoClip.BackgroundColor3 = Color3.fromRGB(0, 100, 50) else ButtonNoClip.BackgroundColor3 = Color3.fromRGB(40, 40, 40) end
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- BUTON 5: FPS BOOST (Gereksiz detayları kapatıp FPS artırır)
local ButtonFPS = Instance.new("TextButton")
ButtonFPS.Size = UDim2.new(0, 180, 0, 40)
ButtonFPS.Position = UDim2.new(0, 20, 0, 270)
ButtonFPS.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ButtonFPS.Text = "🎮 FPS Boost Aktif Et"
ButtonFPS.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonFPS.Parent = Panel

ButtonFPS.MouseButton1Click:Connect(function()
    pcall(function()
        -- Sis ve gölge ayarlarını sıfırla
        game:GetService("Lighting").GlobalShadows = false
        game:GetService("Lighting").FogEnd = 9e9
        
        -- Oyundaki tüm gereksiz dokuları basitleştir (FPS uçuran kısım)
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            end
        end
        ButtonFPS.Text = "🎮 FPS Boosted! (Aktif)"
        ButtonFPS.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    end)
end)
