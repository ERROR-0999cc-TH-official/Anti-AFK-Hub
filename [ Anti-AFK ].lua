local Players = game:GetService("Players") 
local VirtualUser = game:GetService("VirtualUser")  
local RunService = game:GetService("RunService")  
local Lighting = game:GetService("Lighting")  
local player = Players.LocalPlayer  
local PlayerGui = player:WaitForChild("PlayerGui")  

-- ฟังก์ชันเพิ่มมุมโค้ง  
local function addCorner(parent, radius)  
	local corner = Instance.new("UICorner")  
	corner.CornerRadius = UDim.new(0, radius or 8)  
	corner.Parent = parent  
end  

local function optimizeClient()  
	Lighting.GlobalShadows = false  
	pcall(function()  
		Lighting.Technology = Enum.Technology.Compatibility  
	end)  
	Lighting.Brightness = 0.5  
	Lighting.ClockTime = 12  
	Lighting.FogStart = 0  
	Lighting.FogEnd = 1e6  
	Lighting.FogColor = Color3.new(1, 1, 1)  

	for _, v in pairs(Lighting:GetChildren()) do  
		if v:IsA("PostEffect") then  
			v:Destroy()  
		end  
	end  
end  

local notifications = {    
	{text = "กำลังโหลด script", delay = 2},  
	{text = "โหลด script เสร็จสิ้น", delay = 1},   
	{text = "Anti-AFK-Hub V.1.4", delay = 3},  
}  

local changelogGui  
local toggleButtonGui  
local toggleButton  

for index, notif in ipairs(notifications) do  
	task.wait(notif.delay)  
	pcall(function()  
		game.StarterGui:SetCore("SendNotification", {  
			Title = "[ Anti-AFK-Hud ]",  
			Text = notif.text,  
			Duration = 8
		})  
	end)  

	if index == 1 then    
		task.delay(2, function()    
			changelogGui = Instance.new("ScreenGui", PlayerGui)    
			changelogGui.Name = "ChangelogGui"    
			changelogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling    
			changelogGui.ResetOnSpawn = false    
			changelogGui.Enabled = true -- แสดงทันที  

			local frame = Instance.new("Frame", changelogGui)    
			frame.Size = UDim2.new(0, 400, 0, 300)    
			frame.Position = UDim2.new(0.5, -200, 0.5, -150)    
			frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)    
			frame.BorderSizePixel = 0    
			frame.Active = true    
			frame.Draggable = true    
			frame.ZIndex = 10    
			addCorner(frame)  

                        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0) -- สีดำ
        stroke.Thickness = 2
        stroke.Transparency = 0 -- ทึบ 100%
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = frame

			local closeButton = Instance.new("TextButton", frame)    
			closeButton.Text = "X"    
			closeButton.Size = UDim2.new(0, 30, 0, 30)    
			closeButton.Position = UDim2.new(1, -35, 0, 5)    
			closeButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)    
			closeButton.TextColor3 = Color3.new(1, 1, 1)    
			closeButton.ZIndex = 10    
			addCorner(closeButton)  
			closeButton.MouseButton1Click:Connect(function()
	if PlayerGui:FindFirstChild("ConfirmCloseGui") then return end

	local confirmGui = Instance.new("ScreenGui")
	confirmGui.Name = "ConfirmCloseGui"
	confirmGui.ResetOnSpawn = false
	confirmGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	confirmGui.Parent = PlayerGui

	-- กล่องหลัก
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 350, 0, 160)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	frame.BorderSizePixel = 0
	frame.Parent = confirmGui
	frame.Active = true
	frame.Draggable = true
	addCorner(frame, 16)
						
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0) -- สีดำ
        stroke.Thickness = 2
        stroke.Transparency = 0 -- ทึบ 100%
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = frame


	-- ข้อความ
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -40, 0, 100)
	label.Position = UDim2.new(0, 20, 0, 20)
	label.BackgroundTransparency = 1
	label.Text = "คุณต้องการที่จะปิดใช้งานใช่ไหม"
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 28
	label.TextWrapped = true
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Parent = frame

	-- ปุ่มตกลง
	local okBtn = Instance.new("TextButton")
	okBtn.Size = UDim2.new(0.48, -10, 0, 50)
	okBtn.Position = UDim2.new(0, 20, 1, -70)
	okBtn.Text = "ตกลง"
	okBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	okBtn.TextColor3 = Color3.new(1, 1, 1)
	okBtn.Font = Enum.Font.SourceSans
	okBtn.TextSize = 22
	okBtn.Parent = frame
	addCorner(okBtn, 10)

	-- ปุ่มยกเลิก
	local cancelBtn = Instance.new("TextButton")
	cancelBtn.Size = UDim2.new(0.48, -10, 0, 50)
	cancelBtn.Position = UDim2.new(0.52, 0, 1, -70)
	cancelBtn.Text = "ยกเลิก"
	cancelBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	cancelBtn.TextColor3 = Color3.new(1, 1, 1)
	cancelBtn.Font = Enum.Font.SourceSans
	cancelBtn.TextSize = 22
	cancelBtn.Parent = frame
	addCorner(cancelBtn, 10)

	-- การคลิกยกเลิก
	cancelBtn.MouseButton1Click:Connect(function()
		confirmGui:Destroy()
	end)

	-- การคลิกตกลง
	okBtn.MouseButton1Click:Connect(function()
		confirmGui:Destroy()

		if changelogGui and changelogGui.Parent then
			changelogGui:Destroy()
		end

		if toggleButtonGui and toggleButtonGui.Parent then
			toggleButtonGui:Destroy()
		end

		local AFKGui = PlayerGui:FindFirstChild("AFKGui")
		if AFKGui then
			AFKGui:Destroy()
		end

		Lighting.GlobalShadows = true
		pcall(function()
			Lighting.Technology = Enum.Technology.Default
		end)
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogStart = 0
		Lighting.FogEnd = 1000
		Lighting.FogColor = Color3.new(0.7, 0.7, 0.7)
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

			-- แสดงปุ่ม A หลังจาก changelog แสดงครบ 1 วิ  
			task.delay(1, function()
				toggleButtonGui = Instance.new("ScreenGui", PlayerGui)  
				toggleButtonGui.Name = "ToggleButtonGui"  
				toggleButtonGui.ResetOnSpawn = false  
				toggleButtonGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling  

				toggleButton = Instance.new("TextButton", toggleButtonGui)  
				toggleButton.Size = UDim2.new(0, 40, 0, 40)  
				toggleButton.Position = UDim2.new(0, 10, 0, 10)  
				toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  
				toggleButton.Text = "A"  
				toggleButton.TextColor3 = Color3.new(1, 1, 1)  
				toggleButton.Font = Enum.Font.SourceSansBold  
				toggleButton.TextSize = 24  
				toggleButton.ZIndex = 20  
				toggleButton.Active = true  
				toggleButton.Draggable = true  
				addCorner(toggleButton, 10)  

                                local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 0, 0) -- สีดำ
        stroke.Thickness = 2
        stroke.Transparency = 0 -- ทึบ 100%
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Parent = toggleButton
						
				toggleButton.MouseButton1Click:Connect(function()  
					if changelogGui then  
						changelogGui.Enabled = not changelogGui.Enabled  
					end  
				end)  
			end)
		end)    
	end  

	if index == 2 then  
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

	task.wait(1)  
end
