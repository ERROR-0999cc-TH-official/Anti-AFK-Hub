local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- แสดงข้อความหลายรายการ
local notifications = {
    {text = "กำลังเริ่มระบบ", delay = 2},
    {text = "กำลังเปิดใช้งาน Anti-AFK", delay = 5},
    {text = "เปิดใช้งาน Anti-AFK เสร็จส้้น", delay = 1},
    {text = "ระบบ by [ERROR 0999cc] TH [official]", delay = 2}
}

for index, notif in ipairs(notifications) do
    task.wait(notif.delay)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "[ Anti-AFK-Hud ]",
            Text = notif.text,
            Duration = 8
        })
    end)

    -- เริ่มจับเวลา 2 วิ ทันทีหลัง "แสดง" ข้อความที่ 2
    if index == 2 then
        task.delay(4, function()
            -- เริ่มระบบ Anti-AFK
            Players.LocalPlayer.Idled:Connect(function()
                VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)

            --  GUI แสดงสถานะ + ตัวจับเวลา
            local AFKGui = Instance.new("ScreenGui")
            AFKGui.Name = "AFKGui"
            AFKGui.ResetOnSpawn = false
            AFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            AFKGui.Parent = PlayerGui

            local AFKLabel = Instance.new("TextLabel")
            AFKLabel.Text = "การป้องกันการ AFK ทำงานอยู่\n00:00:00"
            AFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            AFKLabel.BackgroundTransparency = 1
            AFKLabel.Size = UDim2.new(0, 300, 0, 40)
            AFKLabel.AnchorPoint = Vector2.new(0.5, 1)
            AFKLabel.Position = UDim2.new(0.5, 350, 1, -10)
            AFKLabel.TextScaled = true
            AFKLabel.TextYAlignment = Enum.TextYAlignment.Center
            AFKLabel.TextXAlignment = Enum.TextXAlignment.Center
            AFKLabel.ZIndex = 10
            AFKLabel.Parent = AFKGui

            -- ตัวจับเวลา
            local startTime = tick()
            RunService.RenderStepped:Connect(function()
                local elapsed = tick() - startTime
                local hours = math.floor(elapsed / 3600)
                local minutes = math.floor((elapsed % 3600) / 60)
                local seconds = math.floor(elapsed % 60)
                AFKLabel.Text = string.format("การป้องกันการ AFK ทำงานอยู่\n%02d:%02d:%02d\nby [ERROR 0999cc] TH [official]", hours, minutes, seconds)
            end)
        end)
    end

    task.wait(3) -- รอให้ข้อความแสดงครบก่อนแสดงอันถัดไป
end