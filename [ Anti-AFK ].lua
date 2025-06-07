-- ROBLOX ANTI-AFK HUB V.1.4 FULL SYSTEM WITH CONFIRM CLOSE

local Players = game:GetService("Players") local VirtualUser = game:GetService("VirtualUser") local RunService = game:GetService("RunService") local Lighting = game:GetService("Lighting") local player = Players.LocalPlayer local PlayerGui = player:WaitForChild("PlayerGui")

-- ฟังก์ชันเพิ่มมุมโค้ง local function addCorner(parent, radius) local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, radius or 8) corner.Parent = parent end

local function optimizeClient() Lighting.GlobalShadows = false pcall(function() Lighting.Technology = Enum.Technology.Compatibility end) Lighting.Brightness = 0.5 Lighting.ClockTime = 12 Lighting.FogStart = 0 Lighting.FogEnd = 1e6 Lighting.FogColor = Color3.new(1, 1, 1)

for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") then
        v:Destroy()
    end
end

end

local notifications = { {text = "กำลังเริ่มระบบ", delay = 2}, {text = "กำลังโหลด script", delay = 5}, {text = "โหลด script เสร็จสิ้น", delay = 1}, {text = "ระบบ by [ERROR 0999cc] TH [official]", delay = 2}, {text = "Anti-AFK-Hub V.1.4", delay = 3}, }

-- ปุ่ม E สำหรับเปิดปิด Changelog local openGui = Instance.new("ScreenGui", PlayerGui) openGui.Name = "OpenButtonGui" openGui.ResetOnSpawn = false openGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local openButton = Instance.new("TextButton", openGui) openButton.Size = UDim2.new(0, 50, 0, 50) openButton.Position = UDim2.new(0, 10, 0, 10) openButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30) openButton.Text = "E" openButton.TextColor3 = Color3.new(1, 1, 1) openButton.Font = Enum.Font.SourceSansBold openButton.TextSize = 24 openButton.Draggable = true openButton.Active = true addCorner(openButton)

local changelogGui

openButton.MouseButton1Click:Connect(function() if changelogGui then changelogGui.Enabled = not changelogGui.Enabled end end)

for index, notif in ipairs(notifications) do task.wait(notif.delay) pcall(function() game.StarterGui:SetCore("SendNotification", { Title = "[ Anti-AFK-Hud ]", Text = notif.text, Duration = 8 }) end)

if index == 1 then
    task.delay(2, function()
        changelogGui = Instance.new("ScreenGui", PlayerGui)
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
        addCorner(frame)

        local closeButton = Instance.new("TextButton", frame)
        closeButton.Text = "X"
        closeButton.Size = UDim2.new(0, 30, 0, 30)
        closeButton.Position = UDim2.new(1, -35, 0, 5)
        closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.ZIndex = 10
        addCorner(closeButton)

        closeButton.MouseButton1Click:Connect(function()
            local confirmFrame = Instance.new("Frame")
            confirmFrame.Size = UDim2.new(0, 150, 0, 100)
            confirmFrame.Position = UDim2.new(0.5, -75, 0.5, -50)
            confirmFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            confirmFrame.ZIndex = 20
            confirmFrame.Parent = changelogGui
            confirmFrame.Active = true
            confirmFrame.Draggable = true
            addCorner(confirmFrame)

            local confirmText = Instance.new("TextLabel", confirmFrame)
            confirmText.Size = UDim2.new(1, -10, 0, 40)
            confirmText.Position = UDim2.new(0, 5, 0, 5)
            confirmText.BackgroundTransparency = 1
            confirmText.Text = "คุณต้องการที่จะปิดใช้งานใช่ไหม"
            confirmText.TextColor3 = Color3.new(1, 1, 1)
            confirmText.Font = Enum.Font.SourceSans
            confirmText.TextSize = 14
            confirmText.ZIndex = 21

            local cancelButton = Instance.new("TextButton", confirmFrame)
            cancelButton.Size = UDim2.new(0.5, -10, 0, 30)
            cancelButton.Position = UDim2.new(0, 5, 1, -35)
            cancelButton.Text = "ยกเลิก"
            cancelButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            cancelButton.TextColor3 = Color3.new(1, 1, 1)
            cancelButton.Font = Enum.Font.SourceSans
            cancelButton.TextSize = 14
            cancelButton.ZIndex = 21
            addCorner(cancelButton)

            local okButton = Instance.new("TextButton", confirmFrame)
            okButton.Size = UDim2.new(0.5, -10, 0, 30)
            okButton.Position = UDim2.new(0.5, 5, 1, -35)
            okButton.Text = "ตกลง"
            okButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            okButton.TextColor3 = Color3.new(1, 1, 1)
            okButton.Font = Enum.Font.SourceSans
            okButton.TextSize = 14
            okButton.ZIndex = 21
            addCorner(okButton)

            cancelButton.MouseButton1Click:Connect(function()
                confirmFrame:Destroy()
            end)

            okButton.MouseButton1Click:Connect(function()
                if PlayerGui:FindFirstChild("ChangelogGui") then PlayerGui.ChangelogGui:Destroy() end
                if PlayerGui:FindFirstChild("AFKGui") then PlayerGui.AFKGui:Destroy() end
                if PlayerGui:FindFirstChild("OpenButtonGui") then PlayerGui.OpenButtonGui:Destroy() end
                script:Destroy()
            end)
        end)

        local line = Instance.new("Frame", frame)
        line.Size = UDim2.new(1, -20, 0, 2)
        line.Position = UDim2.new(0, 10, 0, 40)
        line.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        line.ZIndex = 10
        addCorner(line, 1)

        local scroll = Instance.new("ScrollingFrame", frame)
        scroll.Size = UDim2.new(1, -20, 1, -80)
        scroll.Position = UDim2.new(0, 10, 0, 50)
        scroll.CanvasSize = UDim2.new(0, 0, 0, 9000)
        scroll.ScrollBarThickness = 6
        scroll.BackgroundTransparency = 1
        scroll.ZIndex = 10
        addCorner(scroll)

        local changelogText = Instance.new("TextLabel", scroll)
        changelogText.Size = UDim2.new(1, 0, 1000)
        changelogText.TextWrapped = true
        changelogText.TextYAlignment = Enum.TextYAlignment.Top
        changelogText.TextColor3 = Color3.fromRGB(255, 255, 255)
        changelogText.Text = [[

[ อัปเดต V.1.4 ]

อัปเดตเวอร์ชั่นเป็น V.1.4

เพิ่มระบบการปิด แสงเงาบางส่วน ภายในเกมเพื่อเพิ่มประสิทธิภาพการทำงาน และลดความร้อนจาก CPU , GPU

อัพเกรดความสวยงามของ GUI

แก่ไขข้อผิดพลาดที่พบ


[ อัปเดต V.1.3 ]

อัปเดตเวอร์ชั่นเป็น V.1.3

ปรับปรุงการป้องกันการ AFK ให้แม่นยำยิ่งขึ้น

เพิ่ม GUI การอัปเดต

แก่ไขข้อผิดพลาดที่พบ

เพิ่มประสิทธิภาพการทำงาน


[ อัปเดต V.1.2 ]

อัปเดตเวอร์ชั่นเป็น V.1.2

เพิ่มการขยับข้อความ AFK

แก่ไขข้อผิดพลาดที่พบ

เพิ่มประสิทธิภาพการทำงาน


[ อัปเดต V.1.1 ]

อัปเดตเวอร์ชั่นเป็น V.1.1

เพิ่มประสิทธิภาพการทำงาน

แก่ไขข้อผิดพลาดที่พบ


[ อัปเดต V.1.0 ]

เวอร์ชั่นต้นแบบ

เพิ่มข้อความสถานะ เวลา

เพิ่มระบบ Anti-AFK ต้นแบบ

เพิ่มระบบควบคุมการทำงานต่างๆ ]] changelogText.Font = Enum.Font.SourceSans changelogText.TextSize = 18 changelogText.BackgroundTransparency = 1 changelogText.ZIndex = 10 addCorner(changelogText)

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
      addCorner(topLeftText)

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
      addCorner(bottomRightText)
  end)

end

if index == 3 then task.delay(1, function() optimizeClient()

local AFKGui = Instance.new("ScreenGui")
      AFKGui.Name = "AFKGui"
      AFKGui.ResetOnSpawn = false
      AFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
      AFKGui.Parent = PlayerGui

      local AFKLabel = Instance.new("TextLabel")
      AFKLabel.Text = "[ การป้องกันการ AFK ทำงานอยู่ ]\n00:00:00"
      AFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
      AFKLabel.BackgroundTransparency = 1
      AFKLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
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
      addCorner(AFKLabel)

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

task.wait(3) end
