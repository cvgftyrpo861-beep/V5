-- [[ GGEZ HUB V5 - UI LIBRARY (MONOCHROME EDITION) ]]
local Library = {}
Library.__index = Library

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Lighting         = game:GetService("Lighting")
local LocalPlayer      = Players.LocalPlayer
local Camera           = workspace.CurrentCamera
local PlayerGui        = LocalPlayer:WaitForChild("PlayerGui")

-- Theme Palette
local WHITE            = Color3.fromRGB(255, 255, 255)
local WHITE_DIM        = Color3.fromRGB(200, 200, 200)
local GRAY_LIGHT       = Color3.fromRGB(170, 170, 170)
local GRAY_MID         = Color3.fromRGB(100, 100, 100)
local GRAY_DARK        = Color3.fromRGB(45, 45, 45)
local GRAY_DARKER      = Color3.fromRGB(30, 30, 30)
local BLACK            = Color3.fromRGB(12, 12, 12)
local BLACK_SOFT       = Color3.fromRGB(18, 18, 18)
local BLACK_CARD       = Color3.fromRGB(22, 22, 22)

local function Tween(obj, props, dur)
	TweenService:Create(obj, TweenInfo.new(dur or 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), props):Play()
end

function Library:CreateWindow(config)
	local windowTitle = config.Title or "GGEZ HUB V5"
	local windowSub   = config.Subtitle or "RIVALS • PREMIUM MONOCHROME"
	
	-- Destroy old instance if exists
	if PlayerGui:FindFirstChild("GGEZ_Ultimate") then
		PlayerGui.GGEZ_Ultimate:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "GGEZ_Ultimate"
	ScreenGui.Parent = PlayerGui
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local BlurEffect = Lighting:FindFirstChild("GGEZ_Blur") or Instance.new("BlurEffect", Lighting)
	BlurEffect.Size = 0
	BlurEffect.Name = "GGEZ_Blur"

	-- Main Window Frame
	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(0, 400, 0, 540)
	MainFrame.Position = UDim2.new(0.5, -200, 0.5, -270)
	MainFrame.BackgroundColor3 = BLACK_SOFT
	MainFrame.BorderSizePixel = 0
	MainFrame.Active = true
	MainFrame.ClipsDescendants = false
	MainFrame.Visible = false
	MainFrame.ZIndex = 100
	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
	local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = GRAY_MID; MainStroke.Thickness = 1; MainStroke.Transparency = 0.5

	-- Header
	local Header = Instance.new("Frame", MainFrame)
	Header.Size = UDim2.new(1, 0, 0, 70); Header.BackgroundColor3 = BLACK; Header.BorderSizePixel = 0; Header.ZIndex = 101
	Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 20)

	local Logo = Instance.new("TextLabel", Header)
	Logo.Size = UDim2.new(0, 45, 0, 45); Logo.Position = UDim2.new(0, 15, 0.5, -22.5)
	Logo.Text = "◈"; Logo.TextColor3 = WHITE; Logo.Font = Enum.Font.GothamBold; Logo.TextSize = 28
	Logo.BackgroundColor3 = GRAY_DARKER; Logo.BackgroundTransparency = 0; Logo.ZIndex = 102
	Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 12)

	local Title = Instance.new("TextLabel", Header)
	Title.Size = UDim2.new(1,-130,0,28); Title.Position = UDim2.new(0,72,0,12)
	Title.Text = windowTitle; Title.TextColor3 = WHITE; Title.Font = Enum.Font.GothamBold; Title.TextSize = 22
	Title.TextXAlignment = Enum.TextXAlignment.Left; Title.BackgroundTransparency = 1; Title.ZIndex = 102

	local Subtitle = Instance.new("TextLabel", Header)
	Subtitle.Size = UDim2.new(1,-130,0,16); Subtitle.Position = UDim2.new(0,72,0,38)
	Subtitle.Text = windowSub; Subtitle.TextColor3 = GRAY_LIGHT
	Subtitle.Font = Enum.Font.Gotham; Subtitle.TextSize = 10; Subtitle.TextXAlignment = Enum.TextXAlignment.Left
	Subtitle.BackgroundTransparency = 1; Subtitle.ZIndex = 102

	local CloseBtn = Instance.new("TextButton", Header)
	CloseBtn.Size = UDim2.new(0,34,0,34); CloseBtn.Position = UDim2.new(1,-48,0.5,-17)
	CloseBtn.Text = "✕"; CloseBtn.TextColor3 = GRAY_LIGHT; CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 16
	CloseBtn.BackgroundColor3 = GRAY_DARKER; CloseBtn.BackgroundTransparency = 0.5; CloseBtn.BorderSizePixel = 0; CloseBtn.ZIndex = 102
	Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 10)
	CloseBtn.Activated:Connect(function()
		Tween(MainFrame,{Size=UDim2.new(0,0,0,0)}); Tween(BlurEffect,{Size=0}); task.wait(0.2); MainFrame.Visible=false
	end)

	-- Toggle Open/Close Floating Button
	local ToggleBtn = Instance.new("TextButton", ScreenGui)
	ToggleBtn.Size = UDim2.new(0,60,0,60); ToggleBtn.Position = UDim2.new(0.5,-30,0,30)
	ToggleBtn.Text = "◈"; ToggleBtn.TextColor3 = WHITE; ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextSize = 24
	ToggleBtn.BackgroundColor3 = BLACK; ToggleBtn.BorderSizePixel = 0; ToggleBtn.ZIndex = 200
	Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
	local TBS = Instance.new("UIStroke", ToggleBtn); TBS.Color = WHITE; TBS.Thickness = 2

	ToggleBtn.Activated:Connect(function()
		MainFrame.Visible = not MainFrame.Visible
		if MainFrame.Visible then
			MainFrame.Size = UDim2.new(0,0,0,0)
			Tween(MainFrame, {Size = UDim2.new(0,400,0,540)})
			Tween(BlurEffect, {Size = 5})
		else
			Tween(MainFrame, {Size = UDim2.new(0,0,0,0)})
			Tween(BlurEffect, {Size = 0})
		end
	end)

	-- Tab Bar Setup
	local TabBar = Instance.new("Frame", MainFrame)
	TabBar.Size = UDim2.new(1, 0, 0, 45); TabBar.Position = UDim2.new(0, 0, 0, 70)
	TabBar.BackgroundColor3 = BLACK; TabBar.BorderSizePixel = 0; TabBar.ZIndex = 101

	local tabUnderline = Instance.new("Frame", TabBar)
	tabUnderline.Size = UDim2.new(0.333, 0, 0, 2); tabUnderline.Position = UDim2.new(0, 0, 1, -2)
	tabUnderline.BackgroundColor3 = WHITE; tabUnderline.BorderSizePixel = 0; tabUnderline.ZIndex = 103

	local tabsObj = { ScreenGui = ScreenGui, MainFrame = MainFrame, Panels = {}, TabButtons = {}, TabCount = 0, Underline = tabUnderline }

	function tabsObj:CreateTab(tabName)
		tabsObj.TabCount = tabsObj.TabCount + 1
		local idx = tabsObj.TabCount

		local tBtn = Instance.new("TextButton", TabBar)
		tBtn.Size = UDim2.new(0.333, 0, 1, 0); tBtn.Position = UDim2.new((idx-1)*0.333, 0, 0, 0)
		tBtn.BackgroundColor3 = idx==1 and GRAY_DARKER or BLACK
		tBtn.BorderSizePixel = 0; tBtn.Text = tabName
		tBtn.TextColor3 = idx==1 and WHITE or GRAY_MID
		tBtn.Font = Enum.Font.GothamBold; tBtn.TextSize = 12; tBtn.ZIndex = 102

		local pFrame = Instance.new("Frame", MainFrame)
		pFrame.Size = UDim2.new(1, 0, 1, -115); pFrame.Position = UDim2.new(0, 0, 0, 115)
		pFrame.BackgroundTransparency = 1; pFrame.ClipsDescendants = false; pFrame.Visible = idx==1; pFrame.ZIndex = 101

		local scroll = Instance.new("ScrollingFrame", pFrame)
		scroll.Size = UDim2.new(1, 0, 1, 0); scroll.BackgroundTransparency = 1
		scroll.BorderSizePixel = 0; scroll.ScrollBarThickness = 3; scroll.ScrollBarImageColor3 = WHITE; scroll.ZIndex = 102
		scroll.ClipsDescendants = false

		local layout = Instance.new("UIListLayout", scroll)
		layout.Padding = UDim.new(0, 10); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
		end)
		local pad = Instance.new("UIPadding", scroll); pad.PaddingTop = UDim.new(0, 10)

		tabsObj.Panels[tabName] = scroll
		tabsObj.TabButtons[tabName] = tBtn

		tBtn.Activated:Connect(function()
			for name, btn in pairs(tabsObj.TabButtons) do
				local isActive = name == tabName
				btn.BackgroundColor3 = isActive and GRAY_DARKER or BLACK
				btn.TextColor3 = isActive and WHITE or GRAY_MID
				tabsObj.Panels[name].Parent.Visible = isActive
			end
			Tween(tabsObj.Underline, {Position = UDim2.new((idx-1)*0.333, 0, 1, -2)})
		end)

		-- Component Builders inside Tab
		local TabElements = {}

		function TabElements:AddCategory(name, icon)
			local cat = Instance.new("TextLabel", scroll)
			cat.Size = UDim2.new(0.95, 0, 0, 28); cat.Text = (icon or "◈").."  "..name
			cat.TextColor3 = GRAY_LIGHT; cat.Font = Enum.Font.GothamBold; cat.TextSize = 11
			cat.TextXAlignment = Enum.TextXAlignment.Left; cat.BackgroundTransparency = 1; cat.ZIndex = 103
			local ul = Instance.new("Frame", cat); ul.Size = UDim2.new(0, 3, 0, 12); ul.Position = UDim2.new(0, 0, 0.5, -6)
			ul.BackgroundColor3 = WHITE; ul.ZIndex = 104; Instance.new("UICorner", ul).CornerRadius = UDim.new(1, 0)
		end

		function TabElements:AddToggle(name, desc, icon, defaultState, callback)
			local state = defaultState or false
			local frame = Instance.new("Frame", scroll)
			frame.Size = UDim2.new(0.95, 0, 0, 62); frame.BackgroundColor3 = BLACK_CARD; frame.ZIndex = 103
			Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
			local fs = Instance.new("UIStroke", frame); fs.Color = state and WHITE or GRAY_DARK; fs.Thickness = 1; fs.Transparency = 0.7

			local il = Instance.new("TextLabel", frame)
			il.Size = UDim2.new(0, 36, 0, 36); il.Position = UDim2.new(0, 12, 0.5, -18)
			il.Text = icon or "⚙"; il.TextColor3 = state and WHITE or GRAY_MID
			il.Font = Enum.Font.GothamBold; il.TextSize = 16; il.BackgroundColor3 = GRAY_DARKER; il.ZIndex = 104
			Instance.new("UICorner", il).CornerRadius = UDim.new(0, 10)

			local lbl = Instance.new("TextLabel", frame)
			lbl.Size = UDim2.new(1,-120,0,20); lbl.Position = UDim2.new(0,60,0,10)
			lbl.Text = name; lbl.TextColor3 = WHITE_DIM; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 13
			lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.BackgroundTransparency = 1; lbl.ZIndex = 104

			local dl = Instance.new("TextLabel", frame)
			dl.Size = UDim2.new(1,-120,0,16); dl.Position = UDim2.new(0,60,0,34)
			dl.Text = desc or ""; dl.TextColor3 = GRAY_MID; dl.Font = Enum.Font.Gotham; dl.TextSize = 9
			dl.TextXAlignment = Enum.TextXAlignment.Left; dl.BackgroundTransparency = 1; dl.ZIndex = 104

			local sbg = Instance.new("Frame", frame)
			sbg.Size = UDim2.new(0, 46, 0, 24); sbg.Position = UDim2.new(1,-58,0.5,-12)
			sbg.BackgroundColor3 = state and WHITE or GRAY_DARK; sbg.ZIndex = 104
			Instance.new("UICorner", sbg).CornerRadius = UDim.new(1, 0)

			local sk = Instance.new("Frame", sbg)
			sk.Size = UDim2.new(0, 18, 0, 18); sk.Position = state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9)
			sk.BackgroundColor3 = state and BLACK_CARD or WHITE_DIM; sk.ZIndex = 105
			Instance.new("UICorner", sk).CornerRadius = UDim.new(1, 0)

			local btn = Instance.new("TextButton", frame); btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency=1; btn.Text=""; btn.ZIndex = 106
			btn.Activated:Connect(function()
				state = not state
				Tween(sbg,{BackgroundColor3=state and WHITE or GRAY_DARK})
				Tween(sk,{Position=state and UDim2.new(1,-21,0.5,-9) or UDim2.new(0,3,0.5,-9), BackgroundColor3=state and BLACK_CARD or WHITE_DIM})
				Tween(fs,{Color=state and WHITE or GRAY_DARK})
				Tween(il,{TextColor3=state and WHITE or GRAY_MID})
				if callback then callback(state) end
			end)
		end

		function TabElements:AddBigButton(name, desc, icon, callback)
			local frame = Instance.new("Frame", scroll)
			frame.Size = UDim2.new(0.95,0,0,62); frame.BackgroundColor3 = BLACK_CARD; frame.ZIndex = 103
			Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)
			local fs = Instance.new("UIStroke",frame); fs.Color=GRAY_DARK; fs.Thickness=1; fs.Transparency=0.7

			local il = Instance.new("TextLabel",frame)
			il.Size=UDim2.new(0,36,0,36); il.Position=UDim2.new(0,12,0.5,-18)
			il.Text=icon or "◈"; il.TextColor3=WHITE; il.Font=Enum.Font.GothamBold; il.TextSize=18; il.BackgroundColor3=GRAY_DARKER; il.ZIndex=104
			Instance.new("UICorner",il).CornerRadius=UDim.new(0,10)

			local lbl = Instance.new("TextLabel",frame)
			lbl.Size=UDim2.new(1,-130,0,20); lbl.Position=UDim2.new(0,60,0,10)
			lbl.Text=name; lbl.TextColor3=WHITE_DIM; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13
			lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.BackgroundTransparency=1; lbl.ZIndex=104

			local dl = Instance.new("TextLabel",frame)
			dl.Size=UDim2.new(1,-130,0,16); dl.Position=UDim2.new(0,60,0,34)
			dl.Text=desc or ""; dl.TextColor3=GRAY_MID; dl.Font=Enum.Font.Gotham; dl.TextSize=9
			dl.TextXAlignment=Enum.TextXAlignment.Left; dl.BackgroundTransparency=1; dl.ZIndex=104

			local onBtn = Instance.new("TextButton",frame)
			onBtn.Size=UDim2.new(0,48,0,26); onBtn.Position=UDim2.new(1,-112,0.5,-13)
			onBtn.Text="ON"; onBtn.Font=Enum.Font.GothamBold; onBtn.TextSize=11; onBtn.BackgroundColor3=GRAY_DARK; onBtn.TextColor3=GRAY_LIGHT; onBtn.BorderSizePixel=0; onBtn.ZIndex=105
			Instance.new("UICorner",onBtn).CornerRadius=UDim.new(0,8)

			local offBtn = Instance.new("TextButton",frame)
			offBtn.Size=UDim2.new(0,48,0,26); offBtn.Position=UDim2.new(1,-56,0.5,-13)
			offBtn.Text="OFF"; offBtn.Font=Enum.Font.GothamBold; offBtn.TextSize=11; offBtn.BackgroundColor3=GRAY_DARKER; offBtn.TextColor3=GRAY_LIGHT; offBtn.BorderSizePixel=0; offBtn.ZIndex=105
			Instance.new("UICorner",offBtn).CornerRadius=UDim.new(0,8)

			local function refresh(on)
				if on then
					onBtn.BackgroundColor3=WHITE; onBtn.TextColor3=BLACK
					offBtn.BackgroundColor3=GRAY_DARK; offBtn.TextColor3=GRAY_LIGHT
					Tween(fs,{Color=WHITE}); Tween(il,{TextColor3=WHITE})
				else
					onBtn.BackgroundColor3=GRAY_DARK; onBtn.TextColor3=GRAY_LIGHT
					offBtn.BackgroundColor3=GRAY_DARKER; offBtn.TextColor3=GRAY_LIGHT
					Tween(fs,{Color=GRAY_DARK}); Tween(il,{TextColor3=GRAY_MID})
				end
			end

			onBtn.Activated:Connect(function() refresh(true); if callback then callback(true) end end)
			offBtn.Activated:Connect(function() refresh(false); if callback then callback(false) end end)
		end

		function TabElements:AddSlider(name, desc, icon, minVal, maxVal, defaultVal, callback)
			local frame = Instance.new("Frame", scroll)
			frame.Size = UDim2.new(0.95,0,0,72); frame.BackgroundColor3 = BLACK_CARD; frame.ZIndex = 103
			Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)
			local fs = Instance.new("UIStroke",frame); fs.Color=GRAY_DARK; fs.Thickness=1; fs.Transparency=0.7

			local il = Instance.new("TextLabel",frame)
			il.Size=UDim2.new(0,34,0,34); il.Position=UDim2.new(0,12,0,8); il.Text=icon or "◈"; il.TextColor3=WHITE; il.Font=Enum.Font.GothamBold; il.TextSize=16; il.BackgroundColor3=GRAY_DARKER; il.ZIndex=104
			Instance.new("UICorner",il).CornerRadius=UDim.new(0,10)

			local lbl = Instance.new("TextLabel",frame)
			lbl.Size=UDim2.new(1,-115,0,18); lbl.Position=UDim2.new(0,58,0,10); lbl.Text=name; lbl.TextColor3=WHITE_DIM; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.BackgroundTransparency=1; lbl.ZIndex=104

			local dl = Instance.new("TextLabel",frame)
			dl.Size=UDim2.new(1,-115,0,14); dl.Position=UDim2.new(0,58,0,30); dl.Text=desc or ""; dl.TextColor3=GRAY_MID; dl.Font=Enum.Font.Gotham; dl.TextSize=9; dl.TextXAlignment=Enum.TextXAlignment.Left; dl.BackgroundTransparency=1; dl.ZIndex=104

			local valLbl = Instance.new("TextLabel",frame)
			valLbl.Size=UDim2.new(0,50,0,18); valLbl.Position=UDim2.new(1,-60,0,10); valLbl.Text=tostring(defaultVal); valLbl.TextColor3=WHITE; valLbl.Font=Enum.Font.GothamBold; valLbl.TextSize=12; valLbl.TextXAlignment=Enum.TextXAlignment.Right; valLbl.BackgroundTransparency=1; valLbl.ZIndex=104

			local trk = Instance.new("Frame",frame)
			trk.Size=UDim2.new(0.85,0,0,4); trk.Position=UDim2.new(0.075,0,1,-16); trk.BackgroundColor3=GRAY_DARK; trk.BorderSizePixel=0; trk.ZIndex=104
			Instance.new("UICorner",trk).CornerRadius=UDim.new(1,0)

			local fill = Instance.new("Frame",trk)
			local initT = (defaultVal-minVal)/(maxVal-minVal)
			fill.Size=UDim2.new(initT,0,1,0); fill.BackgroundColor3=WHITE; fill.BorderSizePixel=0; fill.ZIndex=105
			Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)

			local kn = Instance.new("Frame",trk)
			kn.Size=UDim2.new(0,16,0,16); kn.Position=UDim2.new(initT,-8,0.5,-8); kn.BackgroundColor3=WHITE; kn.ZIndex=106
			Instance.new("UICorner",kn).CornerRadius=UDim.new(1,0)

			local sBtn=Instance.new("TextButton",trk); sBtn.Size=UDim2.new(1,20,1,20); sBtn.Position=UDim2.new(0,-10,0,-10); sBtn.BackgroundTransparency=1; sBtn.Text=""; sBtn.ZIndex=107
			local dragging = false
			local function update()
				local rel=math.clamp((UserInputService:GetMouseLocation().X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X,0,1)
				local val=math.floor(minVal+(rel*(maxVal-minVal)))
				fill.Size=UDim2.new(rel,0,1,0); kn.Position=UDim2.new(rel,-8,0.5,-8)
				valLbl.Text=tostring(val)
				if callback then callback(val) end
			end
			sBtn.MouseButton1Down:Connect(function() dragging=true; update() end)
			RunService.RenderStepped:Connect(function() if dragging then update() end end)
			UserInputService.InputEnded:Connect(function(i)
				if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end
			end)
		end

		function TabElements:AddDropdown(name, desc, icon, options, defaultVal, callback)
			local frame = Instance.new("Frame", scroll)
			frame.Size = UDim2.new(0.95,0,0,72); frame.BackgroundColor3 = BLACK_CARD; frame.ZIndex = 103
			Instance.new("UICorner",frame).CornerRadius = UDim.new(0,12)
			local fs = Instance.new("UIStroke",frame); fs.Color=GRAY_DARK; fs.Thickness=1; fs.Transparency=0.7

			local il = Instance.new("TextLabel",frame)
			il.Size=UDim2.new(0,34,0,34); il.Position=UDim2.new(0,12,0,8); il.Text=icon or "◈"; il.TextColor3=WHITE; il.Font=Enum.Font.GothamBold; il.TextSize=16; il.BackgroundColor3=GRAY_DARKER; il.ZIndex=104
			Instance.new("UICorner",il).CornerRadius=UDim.new(0,10)

			local lbl = Instance.new("TextLabel",frame)
			lbl.Size=UDim2.new(1,-115,0,18); lbl.Position=UDim2.new(0,58,0,10); lbl.Text=name; lbl.TextColor3=WHITE_DIM; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.BackgroundTransparency=1; lbl.ZIndex=104

			local dl = Instance.new("TextLabel",frame)
			dl.Size=UDim2.new(1,-115,0,14); dl.Position=UDim2.new(0,58,0,30); dl.Text=desc or ""; dl.TextColor3=GRAY_MID; dl.Font=Enum.Font.Gotham; dl.TextSize=9; dl.TextXAlignment=Enum.TextXAlignment.Left; dl.BackgroundTransparency=1; dl.ZIndex=104

			local dropdownBtn = Instance.new("TextButton",frame)
			dropdownBtn.Size=UDim2.new(0,110,0,32); dropdownBtn.Position=UDim2.new(1,-122,0.5,-16)
			dropdownBtn.BackgroundColor3=GRAY_DARKER; dropdownBtn.BorderSizePixel=0; dropdownBtn.Font=Enum.Font.GothamBold; dropdownBtn.TextSize=11; dropdownBtn.TextColor3=WHITE; dropdownBtn.ZIndex=105
			Instance.new("UICorner",dropdownBtn).CornerRadius=UDim.new(0,8)

			local selected = defaultVal or options[1]
			dropdownBtn.Text = selected

			local dropdownList = Instance.new("Frame", ScreenGui)
			dropdownList.Size = UDim2.new(0,110,0,0)
			dropdownList.BackgroundColor3 = GRAY_DARKER
			dropdownList.BorderSizePixel = 0
			dropdownList.ClipsDescendants = true
			dropdownList.Visible = false
			dropdownList.ZIndex = 500
			Instance.new("UICorner", dropdownList).CornerRadius = UDim.new(0,8)

			local listLayout = Instance.new("UIListLayout", dropdownList)
			listLayout.Padding = UDim.new(0, 2)

			local function updateDropdownList()
				for _, child in ipairs(dropdownList:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
				for _, opt in ipairs(options) do
					local optBtn = Instance.new("TextButton", dropdownList)
					optBtn.Size = UDim2.new(1,0,0,30); optBtn.Text = opt; optBtn.BackgroundColor3 = GRAY_DARK; optBtn.BorderSizePixel = 0; optBtn.Font = Enum.Font.Gotham; optBtn.TextSize = 10; optBtn.TextColor3 = opt == selected and WHITE or GRAY_LIGHT; optBtn.ZIndex = 501
					optBtn.Activated:Connect(function()
						selected = opt
						dropdownBtn.Text = selected
						if callback then callback(selected) end
						dropdownList.Visible = false
					end)
				end
				dropdownList.Size = UDim2.new(0, 110, 0, #options * 32)
			end

			dropdownBtn.Activated:Connect(function()
				if dropdownList.Visible then
					dropdownList.Visible = false
				else
					updateDropdownList()
					local pos = dropdownBtn.AbsolutePosition
					dropdownList.Position = UDim2.new(0, pos.X, 0, pos.Y + 36)
					dropdownList.Visible = true
				end
			end)
		end

		return TabElements
	end

	return tabsObj
end

return Library
