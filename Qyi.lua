-- ==========================================
-- Developer: ملوكي زقزوقي (Mlouki Zaqzoouqi)
-- Target Executor: Delta & Universal Games
-- Features: Fly, Wall Check Aimbot & Copy Button
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- حذف الواجهة القديمة إذا كانت موجودة لمنع التكرار
if CoreGui:FindFirstChild("MloukiProHub") then
    CoreGui.MloukiProHub:Destroy()
end

-- بناء الواجهة الرئيسية المتوافقة مع دلتا
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MloukiProHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 310, 0, 370)
MainFrame.Position = UDim2.new(0.5, -155, 0.4, -185)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- شريط العنوان
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
Title.Text = "⚡ Mlouki Hub | ملوكي زقزوقي ⚡"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- دالة لتوليد الأزرار بشكل أنيق
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 42)
    btn.Position = UDim2.new(0.06, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 15
    btn.Parent = MainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- المتغيرات للتحكم بالوظائف
local aimbotEnabled = false
local wallCheckEnabled = true
local flying = false
local flySpeed = 55

-- 1. زر تفعيل الإيم بوت
createButton("الإيم بوت: معطل ❌", 65, function(btn)
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        btn.Text = "الإيم بوت: شغال ✅"
        btn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
    else
        btn.Text = "الإيم بوت: معطل ❌"
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    end
end)

-- 2. زر فحص الجدران (Wall Check)
createButton("فحص الجدران (ضد الشبك): شغال ✅", 120, function(btn)
    wallCheckEnabled = not wallCheckEnabled
    if wallCheckEnabled then
        btn.Text = "فحص الجدران (ضد الشبك): شغال ✅"
        btn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
    else
        btn.Text = "فحص الجدران (ضد الشبك): معطل ❌"
        btn.BackgroundColor3 = Color3.fromRGB(178, 34, 34)
    end
end)

-- 3. زر الطيران (Fly)
createButton("الطيران السلس: معطل ❌", 175, function(btn)
    flying = not flying
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if flying then
        btn.Text = "الطيران السلس: شغال ✅"
        btn.BackgroundColor3 = Color3.fromRGB(46, 139, 87)
        local bv = Instance.new("BodyVelocity")
        bv.Name = "MloukiFlyEngine"
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp

        task.spawn(function()
            while flying and task.wait() do
                bv.Velocity = Camera.CFrame.LookVector * flySpeed
            end
            bv:Destroy()
        end)
    else
        btn.Text = "الطيران السلس: معطل ❌"
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
        if hrp:FindFirstChild("MloukiFlyEngine") then
            hrp.MloukiFlyEngine:Destroy()
        end
    end
end)

-- 4. زر نسخ السكربت (Copy Script Button)
createButton("📋 نسخ السكربت بالكامل للحافظة", 230, function(btn)
    if setclipboard then
        setclipboard(script.Source or "loadstring(game:HttpGet('https://raw.githubusercontent.com/fatmhalnzy586-jpg/Qqgqqg.lua/main/Mlokezqazoqe.lua'))()")
        btn.Text = "تم النسخ بنجاح! ✅"
        task.wait(1.5)
        btn.Text = "📋 نسخ السكربت بالكامل للحافظة"
    else
        btn.Text = "منفذ دلتا لا يدعم النسخ التلقائي"
    end
end)

-- الحقوق الرسمية في أسفل القائمة
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -35)
Credits.BackgroundTransparency = 1
Credits.Text = "صنع بكل وفتخر بواسطة: ملوكي زقزوقي"
Credits.TextColor3 = Color3.fromRGB(160, 160, 180)
Credits.TextSize = 13
Credits.Font = Enum.Font.SourceSansItalic
Credits.Parent = MainFrame

-- ==========================================
-- نظام كشف الرؤية والجدران (Raycasting Wall Check)
-- ==========================================
local function isVisible(targetPart)
    if not wallCheckEnabled then return true end
    local origin = Camera.CFrame.Position
    local destination = targetPart.Position
    local rayParams = RaycastParams.new()
    rayParams.FilterType = RaycastFilterType.Exclude

    local filterList = {Camera}
    if LocalPlayer.Character then
        table.insert(filterList, LocalPlayer.Character)
    end
    rayParams.FilterDescendantsInstances = filterList

    local result = Workspace:Raycast(origin, destination - origin, rayParams)
    if result and result.Instance then
        return result.Instance:IsDescendantOf(targetPart.Parent)
    end
    return true
end

-- البحث عن أقرب عدو داخل الماب
local function getClosestTarget()
    local closest = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local head = player.Character:FindFirstChild("Head") or player.Character:FindFirstChild("HumanoidRootPart")
            if head then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortestDistance and dist <= 250 then
                        if isVisible(head) then
                            closest = head
                            shortestDistance = dist
                        end
                    end
                end
            end
        end
    end
    return closest
end

-- تشغيل الإيم بوت بسلاسة تامة
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestTarget()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Position)
        end
    end
end)
