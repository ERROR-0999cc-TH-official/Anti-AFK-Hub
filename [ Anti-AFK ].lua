local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local AFKEnabled = true
local OptimizeEnabled = false

local function optimizeClient()
    -- ปิดแสงเงา
    Lighting.GlobalShadows = false
    pcall(function()
        Lighting.Technology = Enum.Technology.Compatibility
    end)
    Lighting.Brightness = 1
    Lighting.ClockTime = 14
    Lighting.FogStart = 0
    Lighting.FogEnd = 1e6
    Lighting.FogColor = Color3.new(1, 1, 1)

    -- ลบ PostEffects
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v:Destroy()
        end
    end
end

local function restoreLighting()
    -- คืนค่าที่เหมาะสม (ถ้าต้องการ) หรือรีสตาร์ทเกม
    -- ใส่โค้ดคืนค่าแสงตามที่คุณต้องการ
end

-- สร้าง GUI แผงควบคุมใหม่
local ControlGui = Instance.new("ScreenGui", PlayerGui)
ControlGui.Name = "ControlGui"
ControlGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ControlGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ControlGui)
MainFrame.Size = UDim2.new(0, 600, 0, 350)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 10
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundTransparency = 0
MainFrame.AutomaticSize = Enum.AutomaticSize.None
MainFrame.Name = "MainFrame"
MainFrame.Roundness = UDim.new(0, 12) -- ไม่ใช้จริงใน Roblox ต้องใช้ UICorner

-- มุมโค้ง
local UICornerMain = Instance.new("UICorner", MainFrame)
UICornerMain.CornerRadius = UDim.new(0, 12)

-- ฝั่งซ้ายเป็นปุ่ม Home กับ Mode เรียงลงมา
local ButtonsFrame = Instance.new("Frame", MainFrame)
ButtonsFrame.Size = UDim2.new(0, 100, 1, 0)
ButtonsFrame.Position = UDim2.new(0, 0, 0, 0)
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.ZIndex = 10

local UICornerButtons = Instance.new("UICorner", ButtonsFrame)
UICornerButtons.CornerRadius = UDim.new(0, 12)

local function createSideButton(text)
    local btn = Instance.new("TextButton", ButtonsFrame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = true
    btn.ZIndex = 10
    btn.AnchorPoint = Vector2.new(0, 0)
    btn.Position = UDim2.new(0, 10, 0, 0)
    btn.Name = text .. "Button"
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)
    return btn
end

local homeButton = createSideButton("Home")
homeButton.Position = UDim2.new(0, 10, 0, 10)

local modeButton = createSideButton("Mode")
modeButton.Position = UDim2.new(0, 10, 0, 60)

-- ฝั่งขวาแสดงเนื้อหาของหน้า Home หรือ Mode
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -110, 1, 0)
ContentFrame.Position = UDim2.new(0, 110, 0, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.BorderSizePixel = 0
ContentFrame.ZIndex = 10
local UICornerContent = Instance.new("UICorner", ContentFrame)
UICornerContent.CornerRadius = UDim.new(0, 12)

-- สร้างเนื้อหาสำหรับหน้า Home (Changelog)
local HomeContent = Instance.new("ScrollingFrame", ContentFrame)
HomeContent.Size = UDim2.new(1, -20, 1, -20)
HomeContent.Position = UDim2.new(0, 10, 0, 10)
HomeContent.CanvasSize = UDim2.new(0, 0, 0, 9000)
HomeContent.ScrollBarThickness = 6
HomeContent.BackgroundTransparency = 1
HomeContent.ZIndex = 10
HomeContent.Visible = true

local changelogText = Instance.new("TextLabel", HomeContent)
changelogText.Size = UDim2.new(1, 0, 1000, 0)
changelogText.TextWrapped = true
changelogText.TextYAlignment = Enum.TextYAlignment.Top
changelogText.TextColor3 = Color3.fromRGB(255, 255, 255)
changelogText.Text = [[
[ อัปเดท V.1.4 ]
- อัปเดตเวอร์ชั่นเป็น V.1.4
- เพิ่มการปิด เอฟเฟค และแสงเงาต่างๆ ภายในเกม
  เพื่อเพิ่มประสิทธิภาพการทำงาน และลดความร้อนจาก CPU , GPU ลง
- แก้ไขข้อผิดพลาดที่พบ

[ อัปเดต V.1.3 ]
- อัปเดตเวอร์ชั่นเป็น V.1.3
- ปรับปรุงการป้องกันการ AFK ให้แม่นยำยิ่งขึ้น
- เพิ่ม GUI การอัปเดต
- แก้ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดต V.1.2 ]
- อัปเดตเวอร์ชั่นเป็น V.1.2
- เพิ่มการขยับข้อความ AFK
- แก้ไขข้อผิดพลาดที่พบ
- เพิ่มประสิทธิภาพการทำงาน

[ อัปเดต V.1.1 ]
- อัปเดตเวอร์ชั่นเป็น V.1.1
- เพิ่มประสิทธิภาพการทำงาน
- แก้ไขข้อผิดพลาดที่พบ

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

-- สร้างเนื้อหาสำหรับหน้า Mode (ปุ่มเปิด/ปิด)
local ModeContent = Instance.new("Frame", ContentFrame)
ModeContent.Size = UDim2.new(1, -20, 1, -20)
ModeContent.Position = UDim2.new(0, 10, 0, 10)
ModeContent.BackgroundTransparency = 1
ModeContent.ZIndex = 10
ModeContent.Visible = false

local modeTitle = Instance.new("TextLabel", ModeContent)
modeTitle.Text = "ตั้งค่าระบบ"
modeTitle.Font = Enum.Font.SourceSansBold
modeTitle.TextSize = 22
modeTitle.TextColor3 = Color3.new(1,1,1)
modeTitle.BackgroundTransparency = 1
modeTitle.Position = UDim2.new(0, 0, 0, 0)
modeTitle.Size = UDim2.new(1, 0, 0, 30)
modeTitle.ZIndex = 10
modeTitle.TextXAlignment = Enum.TextXAlignment.Left

local afkToggle = Instance.new("TextButton", ModeContent)
afkToggle.Size = UDim2.new(0, 200, 0, 40)
afkToggle.Position = UDim2.new(0, 0, 0, 50)
afkToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
afkToggle.TextColor3 = Color3.new(1,1,1)
afkToggle.Font = Enum.Font.SourceSansBold
afkToggle.TextSize = 18
afkToggle.Text = "ปิดระบบ Anti-AFK"
afkToggle.AutoButtonColor = true
afkToggle.ZIndex = 10
local cornerAFK = Instance.new("UICorner", afkToggle)
cornerAFK.CornerRadius = UDim.new(0, 8)

local optimizeToggle = Instance.new("TextButton", ModeContent)
optimizeToggle.Size = UDim2.new(0, 200, 0, 40)
optimizeToggle.Position = UDim2.new(0, 0, 0, 110)
optimizeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
optimizeToggle.TextColor3 = Color3.new(1,1,1)
optimizeToggle.Font = Enum.Font.SourceSansBold
optimizeToggle.TextSize = 18
optimizeToggle.Text = "เปิดระบบ Optimize"
optimizeToggle.AutoButtonColor = true
optimizeToggle.ZIndex = 10
local cornerOpt = Instance.new("UICorner", optimizeToggle)
cornerOpt.CornerRadius = UDim.new(0, 8)

-- ฟังก์ชันสลับหน้าจอ
local function switchPage(page)
    if page == "Home" then
        HomeContent.Visible = true
        ModeContent.Visible = false
        homeButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
        modeButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    elseif page == "Mode" then
        HomeContent.Visible = false
        ModeContent.Visible = true
        homeButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
        modeButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
    end
end

homeButton.MouseButton1Click:Connect(function()
    switchPage("Home")
end)

modeButton.MouseButton1Click:Connect(function()
    switchPage("Mode")
end)

-- เริ่มที่หน้า Home
switchPage("Home")

-- ระบบ Anti-AFK + Optimize

local AFKGui
local AFKLabel
local startTime

local function createAFKGui()
    AFKGui = Instance.new("ScreenGui", PlayerGui)
    AFKGui.Name = "AFKGui"
    AFKGui.ResetOnSpawn = false
    AFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    AFKLabel = Instance.new("TextLabel", AFKGui)
    AFKLabel.Text = "[ การป้องกันการ AFK ทำงานอยู่ ]\n00:00:00"
    AFKLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    AFKLabel.BackgroundColor3 = Color3.new(0,0,0)
    AFKLabel.BackgroundTransparency = 0.4
    AFKLabel.Size = UDim2.new(0, 300, 0, 40)
    AFKLabel.AnchorPoint = Vector2.new(1, 0)
    AFKLabel.Position = UDim2.new(1, -10, 0, 10)
    AFKLabel.TextScaled = true
    AFKLabel.TextYAlignment = Enum.TextYAlignment.Center
    AFKLabel.TextXAlignment = Enum.TextXAlignment.Center
    AFKLabel.ZIndex = 10
    AFKLabel.Active = true
    AFKLabel.Draggable = true

    local UICornerAFK = Instance.new("UICorner", AFKLabel)
    UICornerAFK.CornerRadius = UDim.new(0, 12)

    startTime = tick()
    RunService.RenderStepped:Connect(function()
        if AFKEnabled then
            local elapsed = tick() - startTime
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = math.floor(elapsed % 60)
            AFKLabel.Text = string.format("[ การป้องกันการ AFK ทำงานอยู่ ]\n%02d:%02d:%02d", hours, minutes, seconds)
        else
            AFKLabel.Text = "[ ระบบ Anti-AFK ปิดอยู่ ]"
        end
    end)

    Players.LocalPlayer.Idled:Connect(function()
        if AFKEnabled then
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace
