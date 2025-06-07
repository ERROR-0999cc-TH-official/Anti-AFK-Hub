-- ฟังก์ชันสร้างหน้าต่าง Changelog GUI
local function createChangelogGui()
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
        changelogGui:Destroy()
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
- อัปเดตเวอร์ชั่นเป็น V.1.4
- เพิ่มระบบการปิด แสงเงาบางส่วน ภายในเกมเพื่อเพิ่มประสิทธิภาพการทำงาน และลดความร้อนจาก CPU , GPU 
- อัพเกรดความสวยงามของ GUI
- แก่ไขข้อผิดพลาดที่พบ

[ อัปเดต V.1.3 ]
- อัปเดตเวอร์ชั่นเป็น V.1.3
- ปรับปรุงการป้องกันการ AFK ให้แม่นยำยิ่งขึ้น
- เพิ่ม GUI การอัปเดต
- แก่ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดต V.1.2 ]
- อัปเดตเวอร์ชั่นเป็น V.1.2
- เพิ่มการขยับข้อความ AFK
- แก่ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดต V.1.1 ]
- อัปเดตเวอร์ชั่นเป็น V.1.1
- เพิ่มประสิทธิภาพการทำงาน
- แก่ไขข้อผิดพลาดที่พบ

[ อัปเดต V.1.0 ]
- เวอร์ชั่นต้นแบบ
- เพิ่มข้อความสถานะ เวลา
- เพิ่มระบบ Anti-AFK ต้นแบบ
- เพิ่มระบบควบคุมการทำงานต่างๆ
]]
    changelogText.Font = Enum.Font.SourceSans
    changelogText.TextSize = 18
    changelogText.BackgroundTransparency = 1
    changelogText.ZIndex = 10
    addCorner(changelogText)

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
end

-- ปุ่ม Toggle GUI ลอยหน้าจอ
local toggleButton = Instance.new("TextButton")
toggleButton.Text = "+"
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(0, 10, 0.5, -20)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.TextScaled = true
toggleButton.ZIndex = 100
toggleButton.Draggable = true
toggleButton.Active = true
addCorner(toggleButton)

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ToggleChangelogGui"
toggleGui.ResetOnSpawn = false
toggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
toggleGui.Parent = PlayerGui
toggleButton.Parent = toggleGui

toggleButton.MouseButton1Click:Connect(function()
    local existing = PlayerGui:FindFirstChild("ChangelogGui")
    if existing then
        existing:Destroy()
    else
        createChangelogGui()
    end
end)
