local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ฟังก์ชันลดโหลด CPU & GPU
local function optimizeClient()
    Lighting.GlobalShadows = false
    pcall(function()
        Lighting.Technology = Enum.Technology.Compatibility
    end)
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.FogStart = 0
    Lighting.FogEnd = 1e6
    Lighting.FogColor = Color3.new(1, 1, 1)

    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v:Destroy()
        end
    end

    local function disableEffectsInDescendants(parent)
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
    end

    disableEffectsInDescendants(workspace)

    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end)
end

-- ข้อความแจ้งเตือนหลายรายการ
local notifications = {
    {text = "กำลังเริ่มระบบ", delay = 2},
    {text = "กำลังโหลด script", delay = 5},
    {text = "โหลด script เสร็จสิ้น", delay = 1},
    {text = "ระบบ by [ERROR 0999cc] TH [official]", delay = 2},
    {text = "Anti-AFK-Hub V.1.4", delay = 3},
}

for index, notif in ipairs(notifications) do
    task.wait(notif.delay)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "[ Anti-AFK-Hub ]",
            Text = notif.text,
            Duration = 8
        })
    end)

    if index == 1 then
        task.delay(2, function()
            local changelogGui = Instance.new("ScreenGui", PlayerGui)
            changelogGui.Name = "ChangelogGui"
            changelogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            changelogGui.ResetOnSpawn = false

            local frame = Instance.new("Frame", changelogGui)
            frame.Size = UDim2.new(0, 400, 0, 300)
            frame.Position = UDim2.new(0.5, -200, 0.5, -150)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BorderSizePixel = 0
            frame.Active = true
            frame.Draggable = true
            frame.ZIndex = 10

            local closeButton = Instance.new("TextButton", frame)
            closeButton.Text = "X"
            closeButton.Size = UDim2.new(0, 30, 0, 30)
            closeButton.Position = UDim2.new(1, -35, 0, 5)
            closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            closeButton.TextColor3 = Color3.new(1, 1, 1)
            closeButton.ZIndex = 10
            closeButton.MouseButton1Click:Connect(function()
                changelogGui:Destroy()
            end)

            local line = Instance.new("Frame", frame)
            line.Size = UDim2.new(1, -20, 0, 2)
            line.Position = UDim2.new(0, 10, 0, 40)
            line.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            line.ZIndex = 10

            local scroll = Instance.new("ScrollingFrame", frame)
            scroll.Size = UDim2.new(1, -20, 1, -80)
            scroll.Position = UDim2.new(0, 10, 0, 50)
            scroll.CanvasSize = UDim2.new(0, 0, 0, 9000)
            scroll.ScrollBarThickness = 6
            scroll.BackgroundTransparency = 1
            scroll.ZIndex = 10

            local changelogText = Instance.new("TextLabel", scroll)
            changelogText.Size = UDim2.new(1, 0, 1000)
            changelogText.TextWrapped = true
            changelogText.TextYAlignment = Enum.TextYAlignment.Top
            changelogText.TextColor3 = Color3.fromRGB(255, 255, 255)
            changelogText.Text = [[
[ อัปเดท V.1.4 ]
- อัปเดตเวอร์ชั่นเป็น V.1.4
- เพิ่มการปิด เอฟเฟค และแสงเงาต่างๆ ภายในเกมเพื่อเพิ่มประสิทธิภาพการทำงาน และลดความร้อนจาก CPU , GPU ลง
- แก่ไขข้อผิดพลาดที่พบ

[ อัปเดท V.1.3 ]
- อัปเดตเวอร์ชั่นเป็น V.1.3
- ปรับปรุงการป้องกันการ AFK ให้แม่นยำยิ่งขึ้น
- เพิ่ม GUI การอัปเดต
- แก่ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดท V.1.2 ]
- อัปเดตเวอร์ชั่นเป็น V.1.2
- เพิ่มการขยับข้อความ AFK
- แก่ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดท V.1.1 ]
- อัปเดตเวอร์ชั่นเป็น V.1.1
- เพิ่มประสิทธิภาพการทำงาน
- แก่ไขข้อผิดพลาดที่พบ

[ อัปเดท V.1.0 ]
- เวอร์ชั่นต้นแบบ
- เพิ่มข้อความสถานะ เวลา
- เพิ่มระบบ Anti-AFK ต้นแบบ
- เพิ่มระบบควบคุมการทำงานต่างๆ
]]
            changelogText.Font = Enum.Font.SourceSans
            changelogText.TextSize = 18
            changelogText.BackgroundTransparency = 1
            changelogText.ZIndex = 10

            local topLeftText = Instance.new("TextLabel", frame)
            topLeftText.Text = "Anti-AFK-Hub V.1.4"
            topLeftText.Font = Enum.Font.SourceSans
            topLeftText.TextSize = 14
            topLeftText.TextColor3 = Color3.fromRGB(180, 180, 180)
            topLeftText.BackgroundTransparency = 1
            topLeftText.Position = UDim2.new(0, 10, 0, 10)
            topLeftText.Size = UDim2.new(0, 200, 0, 20)
            topLeftText.TextXAlignment = Enum.TextXAlignment.Left
            topLeftText.ZIndex = 10

            local bottomRightText = Instance.new("TextLabel", frame)
            bottomRightText.Text = "by [ERROR 0999cc] TH [official]"
            bottomRightText.Font = Enum.Font.SourceSansItalic
            bottomRightText.TextSize = 14
            bottomRightText.TextColor3 = Color3.fromRGB(200, 200, 200)
            bottomRightText.BackgroundTransparency = 1
            bottomRightText.Position = UDim2.new(1, -200, 1, -20)
            bottomRightText.Size = UDim2.new(0, 190, 0, 20)
            bottomRightText.TextXAlignment = Enum.TextXAlignment.Right
            bottomRightText.ZIndex = 10
        end)
    end

    if index == 3 then
        task.delay(1, function()
            optimizeClient()

            local AFKGui = Instance.new("ScreenGui")
            AFKGui.Name = "AFKGui"
            AFKGui.ResetOnSpawn = false
            AFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            AFKGui.Parent = PlayerGui

            local AFKLabel = Instance.new("TextLabel")
            AFKLabel.Text = "[ การป้องกันการ AFK ทำงานอยู่ ]\n00:00:00"
            AFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            AFKLabel.BackgroundTransparency = 1
            AFKLabel.Size = UDim2.new(0, 300, 0, 40)
            AFKLabel.AnchorPoint = Vector2.new(1, 0)
            AFKLabel.Position = UDim2.new(1, -10, 0, 10)
            AFKLabel.TextScaled = true
            AFKLabel.TextYAlignment = Enum.TextYAlignment.Center
            AFKLabel.TextXAlignment = Enum.TextXAlignment.Center
            AFKLabel.ZIndex = 10
            AFKLabel.Active = true
            AFKLabel.Draggable = true
            AFKLabel.Parent = AFKGui

            local startTime = tick()
            RunService.RenderStepped:Connect(function()
                local elapsed = tick() - startTime
                local hours = math.floor(elapsed / 3600)
                local minutes = math.floor((elapsed % 3600) / 60)
                local seconds = math.floor(elapsed % 60)
                AFKLabel.Text = string.format("[ การป้องกันการ AFK ทำงานอยู่ ]\n%02d:%02d:%02d", hours, minutes, seconds)
            end)

            Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end)
    end

    task.wait(3)
end
