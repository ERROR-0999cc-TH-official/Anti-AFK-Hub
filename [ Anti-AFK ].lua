-- Anti-AFK Hub V.1.4 รวมระบบ GUI พร้อมข้อความและโหมด

local Players = game:GetService("Players") local VirtualUser = game:GetService("VirtualUser") local RunService = game:GetService("RunService") local Lighting = game:GetService("Lighting") local player = Players.LocalPlayer local PlayerGui = player:WaitForChild("PlayerGui")

-- ฟังก์ชันเพิ่มมุมโค้ง 
local function addCorner(parent, radius) local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, radius or 8) corner.Parent = parent end

-- ปิดแสงเงา local function optimizeClient() Lighting.GlobalShadows = false pcall(function() Lighting.Technology = Enum.Technology.Compatibility end) Lighting.Brightness = 1 Lighting.ClockTime = 14 Lighting.FogStart = 0 Lighting.FogEnd = 1e6 Lighting.FogColor = Color3.new(1, 1, 1) for _, v in pairs(Lighting:GetChildren()) do if v:IsA("PostEffect") then v:Destroy() end end end
-- GUI หลัก local mainGui = Instance.new("ScreenGui") mainGui.Name = "MainGui" mainGui.ResetOnSpawn = false mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling mainGui.Parent = PlayerGui

-- Frame แผงควบคุม local controlFrame = Instance.new("Frame") controlFrame.Size = UDim2.new(0, 400, 0, 300) controlFrame.Position = UDim2.new(0.5, -200, 0.5, -150) controlFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35) controlFrame.Parent = mainGui addCorner(controlFrame)

-- ปุ่มปิด GUI local closeButton = Instance.new("TextButton") closeButton.Size = UDim2.new(0, 30, 0, 30) closeButton.Position = UDim2.new(1, -35, 0, 5) closeButton.Text = "X" closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0) closeButton.TextColor3 = Color3.new(1, 1, 1) closeButton.Parent = controlFrame addCorner(closeButton)

-- Footer ด้านขวาล่าง (แสดงถาวรจนกว่าจะกดปุ่ม X) local footerLabel = Instance.new("TextLabel") footerLabel.Text = "by [ERROR 0999cc] TH [official]" footerLabel.Font = Enum.Font.SourceSansItalic footerLabel.TextSize = 14 footerLabel.TextColor3 = Color3.fromRGB(200, 200, 200) footerLabel.BackgroundTransparency = 1 footerLabel.AnchorPoint = Vector2.new(1, 1) footerLabel.Position = UDim2.new(1, -10, 1, -10) footerLabel.Size = UDim2.new(0, 250, 0, 20) footerLabel.TextXAlignment = Enum.TextXAlignment.Right footerLabel.ZIndex = 50 footerLabel.Parent = mainGui

-- สร้างปุ่มสำหรับสลับหน้า local homeButton = Instance.new("TextButton") homeButton.Size = UDim2.new(0, 80, 0, 30) homeButton.Position = UDim2.new(0, 10, 0, 10) homeButton.Text = "Home" homeButton.Parent = controlFrame addCorner(homeButton)

local modeButton = Instance.new("TextButton") modeButton.Size = UDim2.new(0, 80, 0, 30) modeButton.Position = UDim2.new(0, 100, 0, 10) modeButton.Text = "Mode" modeButton.Parent = controlFrame addCorner(modeButton)

-- หน้าต่าง Home (Changelog) local homeFrame = Instance.new("Frame") homeFrame.Size = UDim2.new(1, -20, 1, -50) homeFrame.Position = UDim2.new(0, 10, 0, 50) homeFrame.BackgroundTransparency = 1 homeFrame.Parent = controlFrame

local changelogText = Instance.new("TextLabel") changelogText.Size = UDim2.new(1, 0, 1, 0) changelogText.TextWrapped = true changelogText.TextYAlignment = Enum.TextYAlignment.Top changelogText.TextColor3 = Color3.fromRGB(255, 255, 255) changelogText.Text = "[ อัปเดต V.1.4 ]\n- ปรับปรุงระบบ GUI\n- เพิ่มข้อความมุมขวาล่างแบบถาวร\n- ปรับปรุงระบบแยกการทำงาน" changelogText.Font = Enum.Font.SourceSans changelogText.TextSize = 18 changelogText.BackgroundTransparency = 1 changelogText.Parent = homeFrame

-- หน้าต่าง Mode (เปิด/ปิด AFK กับ Optimize) local modeFrame = Instance.new("Frame") modeFrame.Size = homeFrame.Size modeFrame.Position = homeFrame.Position modeFrame.BackgroundTransparency = 1 modeFrame.Parent = controlFrame modeFrame.Visible = false

local optimizeButton = Instance.new("TextButton") optimizeButton.Size = UDim2.new(0, 200, 0, 40) optimizeButton.Position = UDim2.new(0.5, -100, 0, 10) optimizeButton.Text = "เปิดโหมด Optimize แสง" optimizeButton.Parent = modeFrame addCorner(optimizeButton)

local afkStatus = false local afkButton = Instance.new("TextButton") afkButton.Size = UDim2.new(0, 200, 0, 40) afkButton.Position = UDim2.new(0.5, -100, 0, 60) afkButton.Text = "เปิดระบบ Anti-AFK" afkButton.Parent = modeFrame addCorner(afkButton)

-- ปุ่มควบคุม homeButton.MouseButton1Click:Connect(function() homeFrame.Visible = true modeFrame.Visible = false end)

modeButton.MouseButton1Click:Connect(function() homeFrame.Visible = false modeFrame.Visible = true end)

closeButton.MouseButton1Click:Connect(function() mainGui.Enabled = false footerLabel.Visible = false end)

-- ปุ่ม Optimize optimizeButton.MouseButton1Click:Connect(function() optimizeClient() end)

-- ระบบ AFK local afkGui = Instance.new("ScreenGui") afkGui.Name = "AFKGui" afkGui.ResetOnSpawn = false afkGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling afkGui.Parent = PlayerGui

local afkLabel = Instance.new("TextLabel") afkLabel.Text = "" afkLabel.Size = UDim2.new(0, 300, 0, 40) afkLabel.Position = UDim2.new(1, -10, 0, 10) afkLabel.AnchorPoint = Vector2.new(1, 0) afkLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50) afkLabel.BackgroundTransparency = 0.3 afkLabel.TextColor3 = Color3.new(1, 1, 1) afkLabel.TextScaled = true afkLabel.Parent = afkGui addCorner(afkLabel)

afkLabel.Visible = false

local startTime = 0 RunService.RenderStepped:Connect(function() if afkStatus then local elapsed = tick() - startTime local h = math.floor(elapsed / 3600) local m = math.floor((elapsed % 3600) / 60) local s = math.floor(elapsed % 60) afkLabel.Text = string.format("[ การป้องกันการ AFK ทำงานอยู่ ]\n%02d:%02d:%02d", h, m, s) end end)

afkButton.MouseButton1Click:Connect(function() afkStatus = not afkStatus if afkStatus then startTime = tick() afkLabel.Visible = true afkButton.Text = "ปิดระบบ Anti-AFK" else afkLabel.Visible = false afkButton.Text = "เปิดระบบ Anti-AFK" end end)

-- ป้องกันถูกเตะ Players.LocalPlayer.Idled:Connect(function() if afkStatus then VirtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame) VirtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame) end end)

-- แสดงข้อความเริ่มต้น local notifications = { {text = "กำลังเริ่มระบบ", delay = 2}, {text = "กำลังโหลด script", delay = 5}, {text = "โหลด script เสร็จสิ้น", delay = 1}, {text = "ระบบ by [ERROR 0999cc] TH [official]", delay = 2}, {text = "Anti-AFK-Hub V.1.4", delay = 3}, }

for _, notif in ipairs(notifications) do task.wait(notif.delay) pcall(function() game.StarterGui:SetCore("SendNotification", { Title = "[ Anti-AFK-Hud ]", Text = notif.text, Duration = 8 }) end) end

